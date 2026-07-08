import 'dart:async';
import 'dart:io';
import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_html_to_pdf/flutter_native_html_to_pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:app_links/app_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import '../../../../config/errorhandler.dart';
import '../../../../core/enums/order_status.dart';
import '../../../../core/models/order_model.dart';
import '../../../../generated/l10n.dart';
import '../../../../locator.dart';
import '../../../../repository/orders/orders_repository.dart';
import '../../../../repository/plans/plans_repository.dart';
import '../../../../repository/media/media_repository.dart';
import '../../../../repository/dashboard/dashboard_repository.dart';
import '../../../../data_source/remote/orders/model/order_dto_model.dart';
import '../../media_picker/media_picker.dart';
import '../mapper/order_mapper.dart';
import 'orders_state.dart';

const _downloadsChannel = MethodChannel('com.rtc_mobile/downloads');

Future<String?> _saveToDownloads(String fileName, Uint8List bytes) async {
  try {
    final path = await _downloadsChannel.invokeMethod<String>(
      'saveToDownloads',
      {'fileName': fileName, 'bytes': bytes},
    );
    return path;
  } on PlatformException catch (e) {
    debugPrint('>> [PDF] MethodChannel error: ${e.message}');
    return null;
  }
}

class OrdersCubit extends Cubit<OrdersState> {
  final _ordersRepo = sl<OrdersRepository>();
  final _plansRepo = sl<PlansRepository>();
  final _mediaRepo = sl<MediaRepository>();
  final _dashboardRepo = sl<DashboardRepository>();

  static Future<double>? _cachedToleranceFuture;
  Timer? _searchTimer;
  Timer? _settlementTimer;
  Timer? _clearanceOtpTimer;
  final _appLinks = AppLinks();
  StreamSubscription? _linkSubscription;

  OrdersCubit() : super(const OrdersState());

  void init() {
    _plansRepo
        .getSubPlans()
        .then((response) {
          emit(state.copyWith(subPlans: response.results));
        })
        .catchError((_) {});

    _initTolerance();
    fetchOrders();
    _initDeepLinks();
  }

  void _initDeepLinks() {
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      if (uri.path.contains('callback') ||
          uri.host.contains('callback') ||
          uri.path.contains('disbursement') ||
          uri.path.contains('settlement')) {
        if (state.selectedOrder != null) {
          fetchOrderDetail(state.selectedOrder!.id);
        } else {
          fetchOrders();
        }
      }
    });
  }

  void _initTolerance() {
    _cachedToleranceFuture ??= _dashboardRepo
        .getMyProfile()
        .then((profile) {
          final tol = profile?.tolerance;
          if (tol == null) {
            _cachedToleranceFuture = null;
            throw S.current.toleranceSettingNotFoundError;
          }

          return tol;
        })
        .catchError((e) {
          _cachedToleranceFuture = null;
          throw e;
        });

    _cachedToleranceFuture!
        .then((tol) {
          if (!isClosed) emit(state.copyWith(tolerance: tol));
        })
        .catchError((e) {
          if (!isClosed) {
            emit(
              state.copyWith(
                status: OrdersRequestStatus.error,
                errorMessage: ErrorHandler.getMessage(e),
              ),
            );
          }
        });
  }

  void fetchOrders({OrdersState? rollbackState}) {
    emit(state.copyWith(status: OrdersRequestStatus.loading));

    final createdAfter = _formatGregorianDate(state.startDate);
    final createdBefore = _formatGregorianDate(state.endDate);

    _ordersRepo
        .getOrders(
          status: state.selectedStatusId != null
              ? [state.selectedStatusId!]
              : null,
          subPlanId: state.selectedSubPlanId,
          createdAfter: createdAfter,
          createdBefore: createdBefore,
          search: state.searchQuery.trim().isEmpty ? null : state.searchQuery,
        )
        .then((response) {
          final orders = response.results
              .map((dto) => OrderMapper.mapToSummary(dto))
              .toList();
          emit(
            state.copyWith(
              status: OrdersRequestStatus.success,
              allOrders: orders,
              filteredOrders: orders,
            ),
          );
        })
        .catchError((e) {
          final orders = state.allOrders;
          emit(
            state.copyWith(
              status: OrdersRequestStatus.error,
              errorMessage: ErrorHandler.getMessage(e),
              allOrders: orders,
              filteredOrders: orders,
            ),
          );
          return null;
        });
  }

  void fetchOrderDetail(String orderId) {
    emit(state.copyWith(status: OrdersRequestStatus.loading));
    _initTolerance();

    _ordersRepo
        .getOrderDetails(orderId)
        .then((dto) {
          final detail = OrderMapper.mapToDetail(dto);
          final isSettled = detail.settlementRecords.any(
            (r) => r.status == 'موفق' || r.status == 'success',
          );

          // If status is "Pre-Invoice" or "Awaiting Settlement", default to Financial Tab (index 1)
          final initialTab =
              (detail.orderStatus == OrderStatus.preInvoice ||
                  detail.orderStatus == OrderStatus.awaitingSettlement)
              ? 1
              : 0;

          emit(
            state.copyWith(
              status: OrdersRequestStatus.success,
              selectedOrder: detail,
              selectedTabIndex: initialTab,
              disburseOperation: _createDisburseOp(detail),
              settlementOperation: _createSettlementOp(detail),
              isSettlementCompleted: isSettled,
              walletName: detail.creditPlan?.planName,
            ),
          );
        })
        .catchError((e) {
          emit(
            state.copyWith(
              status: OrdersRequestStatus.error,
              errorMessage: ErrorHandler.getMessage(e),
            ),
          );
          return null;
        });
  }

  // ─── Search & Filters ─────────────────────────────────────────────

  void onSearchChanged(String query) {
    emit(state.copyWith(searchQuery: query));

    _searchTimer?.cancel();
    _searchTimer = Timer(const Duration(seconds: 1), () {
      fetchOrders();
    });
  }

  void activateSearch() {
    emit(state.copyWith(isSearchActive: true));
  }

  void deactivateSearch() {
    _searchTimer?.cancel();
    final rollbackState = state;
    emit(state.copyWith(isSearchActive: false, searchQuery: ''));
    fetchOrders(rollbackState: rollbackState);
  }

  void onStatusFilterChanged(String? statusId) {
    final rollbackState = state;
    emit(state.copyWith(selectedStatusId: statusId));
    fetchOrders(rollbackState: rollbackState);
  }

  void onSubPlanFilterChanged(String? subPlanId) {
    final rollbackState = state;
    emit(state.copyWith(selectedSubPlanId: subPlanId));
    fetchOrders(rollbackState: rollbackState);
  }

  void onDateFilterChanged(Jalali? start, Jalali? end, String? optionId) {
    final rollbackState = state;
    emit(
      state.copyWith(
        startDate: start,
        endDate: end,
        selectedDateOptionId: optionId,
      ),
    );
    fetchOrders(rollbackState: rollbackState);
  }

  void clearDateFilter() {
    final rollbackState = state;
    emit(
      state.copyWith(
        startDate: null,
        endDate: null,
        selectedDateOptionId: null,
      ),
    );
    fetchOrders(rollbackState: rollbackState);
  }

  void resetSearchAndFilters() {
    _searchTimer?.cancel();
    final rollbackState = state;
    emit(
      state.copyWith(
        searchQuery: '',
        isSearchActive: false,
        selectedStatusId: null,
        selectedSubPlanId: null,
        startDate: null,
        endDate: null,
        selectedDateOptionId: null,
      ),
    );
    fetchOrders(rollbackState: rollbackState);
  }

  // ─── UI Toggles ───────────────────────────────────────────────────

  void onOrderTapped(OrderSummaryModel order) {
    fetchOrderDetail(order.id);
  }

  void toggleFinancialSummary() {
    emit(
      state.copyWith(
        isFinancialSummaryExpanded: !state.isFinancialSummaryExpanded,
      ),
    );
  }

  void onTabChanged(int index) {
    emit(state.copyWith(selectedTabIndex: index));
  }

  void toggleCreditPlan() {
    emit(state.copyWith(isCreditPlanExpanded: !state.isCreditPlanExpanded));
  }

  void toggleFinancialSection() {
    emit(
      state.copyWith(
        isFinancialSectionExpanded: !state.isFinancialSectionExpanded,
      ),
    );
  }

  void toggleProducts() {
    emit(state.copyWith(isProductsExpanded: !state.isProductsExpanded));
  }

  void toggleCustomerInfo() {
    emit(state.copyWith(isCustomerInfoExpanded: !state.isCustomerInfoExpanded));
  }

  void toggleDocuments() {
    emit(state.copyWith(isDocumentsExpanded: !state.isDocumentsExpanded));
  }

  void toggleClearanceSection() {
    emit(
      state.copyWith(
        isClearanceSectionExpanded: !state.isClearanceSectionExpanded,
      ),
    );
  }

  // ─── PDF Printing ──────────────────────────────────────────────────

  Future<void> printPreInvoice(String orderId) {
    emit(
      state.copyWith(
        isPrinting: true,
        printStatus: PrintStatus.loading,
        lastPrintedFilePath: null,
      ),
    );

    return _ordersRepo
        .getPreInvoiceHtml(orderId)
        .then((html) async {
          final tempDir = await getTemporaryDirectory();
          final displayId = OrderMapper.formatDisplayId(orderId);
          final targetName = 'pre_invoice_$displayId';

          debugPrint('>> [PDF] Starting generation for Order: $orderId');
          dev.log('Starting PDF generation', name: 'PDF_DEBUG');

          final converter = HtmlToPdfConverter();
          final generatedFile = await converter.convertHtmlToPdf(
            html: html,
            targetDirectory: tempDir.path,
            targetName: targetName,
          );

          if (generatedFile != null) {
            final bytes = await generatedFile.readAsBytes();
            debugPrint('>> [PDF] Generated bytes length: ${bytes.length}');
            debugPrint('>> [PDF] Temp file path: ${generatedFile.path}');

            // Saves directly to public Downloads folder:
            // - Android < 10  → Environment.DIRECTORY_DOWNLOADS (direct write)
            // - Android 10+   → MediaStore.Downloads (no storage permission needed)
            // No picker dialog is shown.
            final savedPath = await _saveToDownloads(targetName, bytes);

            debugPrint('>> [PDF] saveToDownloads result: $savedPath');
            dev.log('File saved at: $savedPath', name: 'PDF_DEBUG');

            if (savedPath != null && savedPath.isNotEmpty) {
              emit(
                state.copyWith(
                  isPrinting: false,
                  printStatus: PrintStatus.success,
                  lastPrintedFilePath: generatedFile.path,
                ),
              );
            } else {
              emit(
                state.copyWith(
                  isPrinting: false,
                  printStatus: PrintStatus.error,
                  errorMessage: 'Failed to save file to Downloads.',
                ),
              );
            }
          } else {
            debugPrint('>> [PDF] ERROR: generatedFile was null');
            dev.log(
              'PDF generation failed',
              name: 'PDF_DEBUG',
              error: 'generatedFile is null',
            );
          }

          Future.delayed(const Duration(seconds: 1), () {
            if (!isClosed)
              emit(state.copyWith(printStatus: PrintStatus.initial));
          });
        })
        .catchError((e) {
          emit(
            state.copyWith(
              isPrinting: false,
              printStatus: PrintStatus.error,
              errorMessage: e.toString(),
            ),
          );
          Future.delayed(const Duration(seconds: 1), () {
            if (!isClosed)
              emit(state.copyWith(printStatus: PrintStatus.initial));
          });
        });
  }

  // ─── Clearance Flow ───────────────────────────────────────────────

  Future<void> initiateClearance(String amountStr) {
    if (state.selectedOrder == null) return Future.value();

    if (state.tolerance == null) {
      emit(
        state.copyWith(
          status: OrdersRequestStatus.error,
          errorMessage: S.current.toleranceSettingNotFoundError,
        ),
      );
      return Future.value();
    }

    final rawAmountStr = amountStr.replaceAll(',', '');
    final amount = double.tryParse(rawAmountStr) ?? 0;

    final rawOrderAmountStr = state.selectedOrder!.financialSummary.finalAmount
        .replaceAll(',', '');
    final orderAmountVal = double.tryParse(rawOrderAmountStr) ?? 0;

    final tolerancePercent = state.tolerance! / 100;
    final minAllowed = orderAmountVal * (1 - tolerancePercent);
    final maxAllowed = orderAmountVal * (1 + tolerancePercent);

    if (amount < minAllowed || amount > maxAllowed) {
      emit(
        state.copyWith(
          status: OrdersRequestStatus.success,
          clearanceStep: ClearanceStep.amountEntered,
          clearanceAmount: amountStr,
          orderAmount: state.selectedOrder!.financialSummary.finalAmount,
          excessAmount: (amount - orderAmountVal).abs().toStringAsFixed(0),
          isOutOfTolerance: true,
        ),
      );
      return Future.value();
    }

    emit(state.copyWith(status: OrdersRequestStatus.loading));

    return _ordersRepo
        .disburseInitiate(state.selectedOrder!.id, amount)
        .then((response) {
          final type = (response is Map) ? response['type'] : 'offline';
          final mobile = (response is Map) ? response['mobile'] : null;
          final redirectUrl = (response is Map)
              ? response['redirect_url']
              : null;

          final isOnline = type == 'otp' || type == 'redirect';

          final diff = amount - orderAmountVal;
          final excess = diff > 0 ? diff.toStringAsFixed(0) : null;
          final wallet = (response is Map) ? response['wallet_name'] : null;

          emit(
            state.copyWith(
              status: OrdersRequestStatus.success,
              gatewayType: isOnline ? GatewayType.online : GatewayType.offline,
              disbursementGatewayType: type,
              disbursementMobile: mobile,
              disbursementRedirectUrl: redirectUrl,
              clearanceStep: type == 'otp'
                  ? ClearanceStep.otpPending
                  : type == 'redirect'
                  ? ClearanceStep.amountEntered
                  : ClearanceStep.documentsPending,
              clearanceAmount: amountStr,
              orderAmount: state.selectedOrder!.financialSummary.finalAmount,
              excessAmount: excess,
              walletName: wallet,
              isOutOfTolerance: false,
            ),
          );

          if (type == 'otp') {
            _startClearanceOtpTimer();
          }

          if (type == 'redirect' && redirectUrl != null) {
            launchUrl(
              Uri.parse(redirectUrl),
              mode: LaunchMode.externalApplication,
            );
          }
        })
        .catchError((e) {
          emit(
            state.copyWith(
              status: OrdersRequestStatus.error,
              errorMessage: ErrorHandler.getMessage(e),
            ),
          );
          throw e;
        });
  }

  Future<void> pickClearanceDocument(dynamic context) async {
    final result = await MediaPickerBottomSheet.show(
      context,
      isMultiSelection: false,
      showCameraOverlay: false,
    );
    if (result != null && result.isNotEmpty) {
      final filePath = result.first.file.path;
      emit(state.copyWith(uploadedClearanceDocPath: null));
      emit(state.copyWith(uploadedClearanceDocPath: filePath));
    }
  }

  Future<void> confirmClearanceDocument() {
    if (state.selectedOrder == null || state.uploadedClearanceDocPath == null) {
      return Future.value();
    }
    emit(state.copyWith(status: OrdersRequestStatus.loading));

    return _mediaRepo
        .uploadOrderDocument(File(state.uploadedClearanceDocPath!))
        .then((media) {
          return _ordersRepo.addOrderDocument(
            state.selectedOrder!.id,
            OrderDocumentRequest(
              documentType: 'disbursement_proof',
              fileId: media.id,
            ),
          );
        })
        .then((_) {
          return _ordersRepo.disburse(state.selectedOrder!.id);
        })
        .then((_) {
          emit(
            state.copyWith(
              status: OrdersRequestStatus.success,
              clearanceStep: ClearanceStep.success,
            ),
          );
          if (state.selectedOrder != null) {
            fetchOrderDetail(state.selectedOrder!.id);
          }
        })
        .catchError((e) {
          emit(
            state.copyWith(
              status: OrdersRequestStatus.error,
              errorMessage: ErrorHandler.getMessage(e),
            ),
          );
          throw e;
        });
  }

  Future<void> confirmClearanceOtp(String otp) {
    if (state.selectedOrder == null) return Future.value();
    emit(state.copyWith(status: OrdersRequestStatus.loading));

    return _ordersRepo
        .disburse(state.selectedOrder!.id, {
          'payload': {'otp': otp}
        })
        .then((_) {
          emit(
            state.copyWith(
              status: OrdersRequestStatus.success,
              clearanceStep: ClearanceStep.success,
            ),
          );
          if (state.selectedOrder != null) {
            fetchOrderDetail(state.selectedOrder!.id);
          }
        })
        .catchError((e) {
          emit(
            state.copyWith(
              status: OrdersRequestStatus.error,
              errorMessage: ErrorHandler.getMessage(e),
            ),
          );
          throw e;
        });
  }

  void resetClearance() {
    emit(
      state.copyWith(
        clearanceStep: ClearanceStep.initial,
        uploadedClearanceDocPath: null,
        uploadedClearanceDocId: null,
        clearanceAmount: '',
        excessAmount: null,
        isOutOfTolerance: false,
      ),
    );
    if (state.selectedOrder != null) {
      emit(
        state.copyWith(
          disburseOperation: _createDisburseOp(state.selectedOrder!),
        ),
      );
    }
  }

  Future<void> clearClearanceDocument() {
    emit(
      state.copyWith(
        uploadedClearanceDocPath: null,
        uploadedClearanceDocId: null,
      ),
    );
    return Future.value();
  }

  // ─── Settlement Flow ───────────────────────────────────────────────

  Future<void> pickSettlementDoc(dynamic context) async {
    final result = await MediaPickerBottomSheet.show(
      context,
      isMultiSelection: true,
      showCameraOverlay: false,
    );
    if (result != null && result.isNotEmpty) {
      final paths = result.map((m) => m.file.path).toList();
      emit(
        state.copyWith(
          settlementDocPaths: [...state.settlementDocPaths, ...paths],
        ),
      );
    }
  }

  void removeSettlementDoc(int index) {
    final updated = List<String>.from(state.settlementDocPaths)..removeAt(index);
    emit(state.copyWith(settlementDocPaths: updated));
  }

  Future<void> initiateSettlement(
    String method, {
    double? amount,
    String? trackingCode,
  }) {
    if (state.selectedOrder == null) return Future.value();
    if (method == 'wallet' && state.tolerance == null) {
      emit(
        state.copyWith(
          status: OrdersRequestStatus.error,
          errorMessage: S.current.toleranceSettingNotFoundError,
        ),
      );
      return Future.value();
    }
    emit(state.copyWith(status: OrdersRequestStatus.loading));

    final apiMethod = _mapSettlementMethodToApi(method);
    final finalAmount =
        amount ?? _calculateRemainingSettlement(state.selectedOrder!);

    return _ordersRepo
        .settleInitiate(state.selectedOrder!.id, apiMethod, amount: finalAmount)
        .then((response) {
          final type = response['type'];
          final walletName =
              (type == 'wallet' && response['wallet_name'] != null)
              ? response['wallet_name']
              : state.walletName;
          final mobile = response['mobile'];

          if (type == 'wallet') {
            final requiredAmount = response['reserved_amount']?.toDouble() ?? 0;
            emit(
              state.copyWith(
                status: OrdersRequestStatus.success,
                settlementStep: SettlementStep.methodSelected,
                settlementMethod: method,
                settlementReservedAmount: requiredAmount,
                walletName: walletName,
                isWalletBalanceSufficient: true,
              ),
            );
          } else {
            final redirectUrl = type == 'redirect'
                ? response['redirect_url']
                : null;

            emit(
              state.copyWith(
                status: OrdersRequestStatus.success,
                settlementStep: SettlementStep.methodSelected,
                settlementMethod: method,
                settlementRedirectUrl: redirectUrl,
                settlementMobile: mobile,
                settlementBankAccount: type == 'offline'
                    ? response['bank_account']
                    : null,
                settlementBankName: type == 'offline'
                    ? response['bank_name']
                    : null,
                settlementAccountHolder: type == 'offline'
                    ? response['account_holder']
                    : null,
              ),
            );

            if (method == 'ipg' && redirectUrl != null) {
              launchUrl(
                Uri.parse(redirectUrl),
                mode: LaunchMode.externalApplication,
              );
            }

            if (method == 'ipg_sms') {
              _startSettlementTimer();
            }

            if (method == 'card_to_card' || method == 'offline') {
              return confirmSettlement(trackingCode: trackingCode);
            }
          }
        })
        .catchError((e) {
          if (method == 'wallet_debit' || method == 'wallet') {
            final apiError = ErrorHandler.getApiError(e);
            if (apiError?.statusCode == 400) {
              emit(
                state.copyWith(
                  status: OrdersRequestStatus.success,
                  isWalletBalanceSufficient: false,
                  settlementMethod: method,
                  settlementStep: SettlementStep.methodSelected,
                ),
              );
              return null;
            }
          }
          emit(
            state.copyWith(
              status: OrdersRequestStatus.error,
              errorMessage: ErrorHandler.getMessage(e),
            ),
          );
          throw e;
        });
  }

  void _startSettlementTimer() {
    _settlementTimer?.cancel();
    emit(
      state.copyWith(settlementCountdown: 60, isSettlementTimerActive: true),
    );

    _settlementTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.settlementCountdown > 0) {
        emit(
          state.copyWith(settlementCountdown: state.settlementCountdown - 1),
        );
      } else {
        _settlementTimer?.cancel();
        emit(state.copyWith(isSettlementTimerActive: false));
      }
    });
  }

  void _startClearanceOtpTimer() {
    _clearanceOtpTimer?.cancel();
    emit(
      state.copyWith(
        clearanceOtpCountdown: 120,
        isClearanceOtpTimerActive: true,
      ),
    );

    _clearanceOtpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.clearanceOtpCountdown > 0) {
        emit(
          state.copyWith(
            clearanceOtpCountdown: state.clearanceOtpCountdown - 1,
          ),
        );
      } else {
        _clearanceOtpTimer?.cancel();
        emit(state.copyWith(isClearanceOtpTimerActive: false));
      }
    });
  }

  void resendSettlementLink() {
    if (state.selectedOrder == null || state.settlementMethod != 'ipg_sms') return;
    initiateSettlement('ipg_sms');
  }

  void selectSettlementMethod(String method) {
    emit(
      state.copyWith(
        settlementMethod: method,
        settlementStep: SettlementStep.initial,
      ),
    );
    if (method == 'wallet_debit' || method == 'wallet') {
      initiateSettlement(method);
    }
  }

  Future<void> confirmSettlement({String? trackingCode, String? imagePath}) {
    if (state.selectedOrder == null || state.settlementMethod == null) {
      return Future.value();
    }
    emit(state.copyWith(status: OrdersRequestStatus.loading));

    final apiMethod = _mapSettlementMethodToApi(state.settlementMethod!);

    Future<void> performSettle() {
      return _ordersRepo
          .settle(
            state.selectedOrder!.id,
            apiMethod,
            trackingCode: trackingCode,
          )
          .then((_) {
            emit(
              state.copyWith(
                status: OrdersRequestStatus.settlementSuccess,
                settlementStep: SettlementStep.success,
              ),
            );
            fetchOrderDetail(state.selectedOrder!.id);
          });
    }

    final docsToUpload =
        imagePath != null
            ? [imagePath]
            : (state.settlementMethod == 'card_to_card'
                ? state.settlementDocPaths
                : []);

    if (docsToUpload.isNotEmpty) {
      return Future.wait(
        docsToUpload.map((path) => _mediaRepo.uploadOrderDocument(File(path))),
      )
          .then((mediaList) {
            return Future.wait(
              mediaList.map(
                (media) => _ordersRepo.addOrderDocument(
                  state.selectedOrder!.id,
                  OrderDocumentRequest(
                    documentType: 'deposit_receipt',
                    fileId: media.id,
                  ),
                ),
              ),
            );
          })
          .then((_) => performSettle())
          .catchError((e) {
            emit(
              state.copyWith(
                status: OrdersRequestStatus.error,
                errorMessage: ErrorHandler.getMessage(e),
              ),
            );
            throw e;
          });
    } else {
      return performSettle().catchError((e) {
        emit(
          state.copyWith(
            status: OrdersRequestStatus.error,
            errorMessage: ErrorHandler.getMessage(e),
          ),
        );
        throw e;
      });
    }
  }

  void resetSettlement() {
    emit(
      state.copyWith(
        settlementStep: SettlementStep.initial,
        settlementMethod: null,
        settlementRedirectUrl: null,
        settlementReservedAmount: null,
        settlementBankAccount: null,
        settlementBankName: null,
        settlementAccountHolder: null,
        settlementTrackingCode: null,
        settlementDocPaths: [],
      ),
    );
  }

  // ─── Operation Model Creators ──────────────────────────────────────

  OrderOperationModel? _createDisburseOp(OrderDetailModel detail) {
    final isDone =
        detail.orderStatus == OrderStatus.awaitingSettlement ||
        detail.orderStatus == OrderStatus.approved ||
        detail.orderStatus == OrderStatus.underReview ||
        state.clearanceStep == ClearanceStep.success;

    final statusesToShow = [
      OrderStatus.preInvoice,
      OrderStatus.underReview,
      OrderStatus.approved,
      OrderStatus.rejected,
      OrderStatus.awaitingSettlement,
    ];

    if (statusesToShow.contains(detail.orderStatus)) {
      return OrderOperationModel(
        step: 1,
        title: 'عملیات تخلیه',
        status: isDone ? S.current.statusDone : '',
        isCompleted: isDone,
      );
    }
    return null;
  }

  OrderOperationModel? _createSettlementOp(OrderDetailModel detail) {
    final isDone =
        detail.orderStatus == OrderStatus.approved ||
        detail.orderStatus == OrderStatus.underReview ||
        state.settlementStep == SettlementStep.success;

    final statusesToShow = [
      OrderStatus.awaitingSettlement,
      OrderStatus.underReview,
      OrderStatus.approved,
    ];

    if (statusesToShow.contains(detail.orderStatus)) {
      return OrderOperationModel(
        step: 2,
        title: 'عملیات تسویه',
        status: isDone ? S.current.statusDone : '',
        isCompleted: isDone,
      );
    }
    return null;
  }

  // ─── Private Helpers ───────────────────────────────────────────────

  String? _formatGregorianDate(Jalali? date) {
    if (date == null) return null;
    final dateTime = date.toDateTime();
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
  }

  double _calculateRemainingSettlement(OrderDetailModel detail) {
    final orderTotal =
        double.tryParse(
          detail.financialSummary.finalAmount.replaceAll(',', ''),
        ) ??
        0;
    double totalCleared = 0;
    for (var record in detail.disbursementRecords) {
      if (record.status == 'موفق' || record.status == 'success') {
        totalCleared += double.tryParse(record.amount.replaceAll(',', '')) ?? 0;
      }
    }
    final remaining = orderTotal - totalCleared;
    return remaining < 0 ? 0 : remaining;
  }

  String _mapSettlementMethodToApi(String method) {
    switch (method) {
      case 'online':
        return 'ipg';
      case 'cash':
        return 'ipg_sms';
      case 'wallet':
        return 'wallet_debit';
      case 'offline':
        return 'card_to_card';
      default:
        return method;
    }
  }

  @override
  Future<void> close() {
    _searchTimer?.cancel();
    _settlementTimer?.cancel();
    _clearanceOtpTimer?.cancel();
    _linkSubscription?.cancel();
    return super.close();
  }
}
