import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:app_links/app_links.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/enums/order_status.dart';
import '../../../../core/models/order_model.dart';
import '../../../../generated/l10n.dart';
import '../../../../locator.dart';
import '../../../../repository/orders/orders_repository.dart';
import '../../../../repository/plans/plans_repository.dart';
import '../../../../repository/media/media_repository.dart';
import '../../../../repository/dashboard/dashboard_repository.dart';
import '../../../../data_source/remote/orders/model/order_dto_model.dart';
import '../../../../core/utils/network_helper.dart';
import '../../media_picker/media_picker.dart';
import '../mapper/order_mapper.dart';
import 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final _ordersRepo = sl<OrdersRepository>();
  final _plansRepo = sl<PlansRepository>();
  final _mediaRepo = sl<MediaRepository>();
  final _dashboardRepo = sl<DashboardRepository>();

  static Future<double>? _cachedToleranceFuture;
  Timer? _searchTimer;
  Timer? _settlementTimer;
  final _appLinks = AppLinks();
  StreamSubscription? _linkSubscription;

  OrdersCubit() : super(const OrdersState());

  // ─── Initialization & Fetching ─────────────────────────────────────

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
            _handleError(e, prefix: S.current.fetchUserSettingsError);
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
          final orders = response.results.map((dto) => OrderMapper.mapToSummary(dto)).toList();
          emit(
            state.copyWith(
              status: OrdersRequestStatus.success,
              allOrders: orders,
              filteredOrders: orders,
            ),
          );
        })
        .catchError((e) {
          _handleError(e, rollbackState: rollbackState);
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
          _handleError(e, prefix: S.current.fetchOrderDetailsError);
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

  // ─── Clearance Flow ───────────────────────────────────────────────

  Future<void> initiateClearance(String amountStr) {
    if (state.selectedOrder == null) return Future.value();

    if (state.tolerance == null) {
      _handleError(S.current.toleranceSettingNotFoundError);
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
                  ? ClearanceStep
                        .amountEntered
                  : ClearanceStep.documentsPending,
              clearanceAmount: amountStr,
              orderAmount: state.selectedOrder!.financialSummary.finalAmount,
              excessAmount: excess,
              walletName: wallet,
              isOutOfTolerance: false,
            ),
          );

          if (type == 'redirect' && redirectUrl != null) {
            launchUrl(
              Uri.parse(redirectUrl),
              mode: LaunchMode.externalApplication,
            );
          }
        })
        .catchError((e) {
          _handleError(e, prefix: S.current.initiateClearanceError);
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
          _handleError(e, prefix: S.current.documentUploadOrFinalizeError);
          throw e;
        });
  }

  Future<void> confirmClearanceOtp(String otp) {
    if (state.selectedOrder == null) return Future.value();
    emit(state.copyWith(status: OrdersRequestStatus.loading));

    return _ordersRepo
        .disburse(state.selectedOrder!.id, {'otp': otp})
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
          _handleError(e, prefix: S.current.otpVerifyOrFinalizeError);
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

  void clearClearanceDocument() {
    emit(
      state.copyWith(
        uploadedClearanceDocPath: null,
        uploadedClearanceDocId: null,
      ),
    );
  }

  // ─── Settlement Flow ───────────────────────────────────────────────

  void initiateSettlement(
    String method, {
    double? amount,
    String? trackingCode,
  }) {
    if (state.selectedOrder == null) return;
    if (method == 'wallet' && state.tolerance == null) {
      _handleError(S.current.toleranceSettingNotFoundError);
      return;
    }
    emit(state.copyWith(status: OrdersRequestStatus.loading));

    final apiMethod = _mapSettlementMethodToApi(method);
    final finalAmount =
        amount ?? _calculateRemainingSettlement(state.selectedOrder!);

    _ordersRepo
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
              confirmSettlement();
            }

            if (method == 'link') {
              _startSettlementTimer();
              confirmSettlement();
            }

            if (method == 'card_to_card' || method == 'offline') {
              confirmSettlement(trackingCode: trackingCode);
            }
          }
        })
        .catchError((e) {
          if (method == 'wallet_debit' || method == 'wallet') {
            bool isBalanceError = false;
            if (e is DioException) {
              if (e.response?.statusCode == 400) {
                isBalanceError = true;
              }
            }
            if (isBalanceError) {
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
          _handleError(e, prefix: S.current.initiateSettlementError);
          return null;
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

  void resendSettlementLink() {
    if (state.selectedOrder == null || state.settlementMethod != 'link') return;
    initiateSettlement('link');
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

  void confirmSettlement({String? trackingCode, String? imagePath}) {
    if (state.selectedOrder == null || state.settlementMethod == null) return;
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
                status: OrdersRequestStatus.success,
                settlementStep: SettlementStep.success,
              ),
            );
            fetchOrderDetail(state.selectedOrder!.id);
          });
    }

    if (state.settlementMethod == 'card_to_card' && imagePath != null) {
      _mediaRepo
          .uploadOrderDocument(File(imagePath))
          .then((media) {
            return _ordersRepo.addOrderDocument(
              state.selectedOrder!.id,
              OrderDocumentRequest(
                documentType: 'deposit_receipt',
                fileId: media.id,
              ),
            );
          })
          .then((_) => performSettle())
          .catchError((e) {
            _handleError(e, prefix: S.current.receiptUploadError);
            return null;
          });
    } else {
      performSettle().catchError(
        (e) => _handleError(e, prefix: S.current.settlementConfirmError),
      );
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
        return 'link';
      case 'wallet':
        return 'wallet_debit';
      case 'offline':
        return 'card_to_card';
      default:
        return method;
    }
  }

  void _handleError(
    Object e, {
    String prefix = '',
    OrdersState? rollbackState,
  }) {
    if (isClosed) {
      return;
    }

    NetworkHelper.getNetworkErrorMessage().then<void>((networkMessage) {
      if (isClosed) {
        return;
      }

      final finalMessage = networkMessage ?? '$prefix${e.toString()}';

      final baseState = rollbackState ?? state;

      emit(baseState.copyWith(status: OrdersRequestStatus.initial));

      emit(
        baseState.copyWith(
          status: OrdersRequestStatus.error,
          errorMessage: finalMessage,
        ),
      );
    });
  }

  @override
  Future<void> close() {
    _searchTimer?.cancel();
    _settlementTimer?.cancel();
    _linkSubscription?.cancel();
    return super.close();
  }
}
