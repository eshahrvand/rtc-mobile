import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:app_links/app_links.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/enums/order_status.dart';
import '../../../../data/models/order_model.dart';
import '../../../../locator.dart';
import '../../../../repository/orders/orders_repository.dart';
import '../../../../repository/plans/plans_repository.dart';
import '../../../../repository/media/media_repository.dart';
import '../../../../repository/dashboard/dashboard_repository.dart';
import '../../../../data_source/remote/wallet/wallet_service.dart';
import '../../../../data_source/remote/wallet/model/wallet_dto_model.dart';
import '../../../../data_source/remote/orders/model/order_dto_model.dart';
import '../../media_picker/media_picker.dart';
import 'orders_state.dart';

// ─── REFACTOR LOG ───────────────────────────────────────────────────
// [1] Extracted `_formatJalaliDate()` helper for consistent API date strings.
// [2] Extracted `_calculateRemainingSettlement()` to simplify settlement flow logic.
// [3] Extracted `_checkWalletBalance()` helper to handle complex pocket balance validation.
// [4] Extracted `_mapSettlementMethodToApi()` for cleaner method ID mapping.
// [5] Extracted `_handleError()` to remove duplication in API error handling.
// [6] Reordered methods: Public event handlers first, followed by feature-specific flows, then helpers.
// [7] Improved inline documentation and method grouping for better maintainability.
// ────────────────────────────────────────────────────────────────────

class OrdersCubit extends Cubit<OrdersState> {
  final _ordersRepo = sl<OrdersRepository>();
  final _plansRepo = sl<PlansRepository>();
  final _mediaRepo = sl<MediaRepository>();
  final _walletService = sl<WalletService>();
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
      print("DeepLinkReceived>>:: $uri");
      // Check if this is a disbursement or settlement callback
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
            _cachedToleranceFuture =
                null; // Reset to allow retry on next attempt
            throw 'مقدار تولرانس در تنظیمات یافت نشد';
          }
          print("tlorance>>:: fetched from profile: $tol");
          return tol;
        })
        .catchError((e) {
          _cachedToleranceFuture = null; // Reset to allow retry
          throw e;
        });

    _cachedToleranceFuture!
        .then((tol) {
          if (!isClosed) emit(state.copyWith(tolerance: tol));
        })
        .catchError((e) {
          if (!isClosed) {
            _handleError(e, prefix: 'خطا در دریافت تنظیمات کاربری: ');
          }
        });
  }

  void fetchOrders() {
    emit(state.copyWith(status: OrdersRequestStatus.loading));

    final createdAfter = _formatJalaliDate(state.startDate);
    final createdBefore = _formatJalaliDate(state.endDate);

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
        .then((orders) {
          emit(
            state.copyWith(
              status: OrdersRequestStatus.success,
              allOrders: orders,
              filteredOrders: orders,
            ),
          );
        })
        .catchError((e) => _handleError(e));
  }

  void fetchOrderDetail(String orderId) {
    emit(state.copyWith(status: OrdersRequestStatus.loading));
    _initTolerance();

    _ordersRepo
        .getOrderDetails(orderId)
        .then((detail) {
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

          // Pre-fetch wallet to check balance early
          _walletService
              .getWallet()
              .then((walletDto) {
                final remainingAmount = _calculateRemainingSettlement(detail);
                final isSufficient = _checkWalletBalance(
                  walletDto,
                  detail.creditPlan?.planName,
                  remainingAmount,
                );
                emit(state.copyWith(isWalletBalanceSufficient: isSufficient));
              })
              .catchError((_) {});
        })
        .catchError(
          (e) => _handleError(e, prefix: 'خطا در بارگذاری جزئیات سفارش: '),
        );
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
    emit(state.copyWith(isSearchActive: false, searchQuery: ''));
    fetchOrders();
  }

  void onStatusFilterChanged(String? statusId) {
    emit(state.copyWith(selectedStatusId: statusId));
    fetchOrders();
  }

  void onSubPlanFilterChanged(String? subPlanId) {
    emit(state.copyWith(selectedSubPlanId: subPlanId));
    fetchOrders();
  }

  void onDateFilterChanged(Jalali? start, Jalali? end, String? optionId) {
    emit(
      state.copyWith(
        startDate: start,
        endDate: end,
        selectedDateOptionId: optionId,
      ),
    );
    fetchOrders();
  }

  void clearDateFilter() {
    emit(
      state.copyWith(
        startDate: null,
        endDate: null,
        selectedDateOptionId: null,
      ),
    );
    fetchOrders();
  }

  void resetSearchAndFilters() {
    _searchTimer?.cancel();
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
    fetchOrders();
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

  void initiateClearance(String amountStr) {
    print("tlorance>>:: initiateClearance CALLED with input: '$amountStr'");

    if (state.selectedOrder == null) {
      print("tlorance>>:: ERROR: selectedOrder is NULL");
      return;
    }

    if (state.tolerance == null) {
      print("tlorance>>:: ERROR: tolerance is NULL in state");
      _handleError('تنظیمات تولرانس بارگذاری نشده است');
      return;
    }

    final rawAmountStr = amountStr.replaceAll(',', '');
    final amount = double.tryParse(rawAmountStr) ?? 0;

    final rawOrderAmountStr = state.selectedOrder!.financialSummary.finalAmount
        .replaceAll(',', '');
    final orderAmountVal = double.tryParse(rawOrderAmountStr) ?? 0;

    print("tlorance>>:: Parsed Input Amount: $amount (from '$rawAmountStr')");
    print(
      "tlorance>>:: Parsed Order Amount: $orderAmountVal (from '$rawOrderAmountStr')",
    );

    // ─── Range Calculation (Before API Call) ───
    // Server returns percentage as a whole number (e.g. 12.0 for 12%), convert to decimal
    final tolerancePercent = state.tolerance! / 100;
    final minAllowed = orderAmountVal * (1 - tolerancePercent);
    final maxAllowed = orderAmountVal * (1 + tolerancePercent);

    print("tlorance>>:: Tolerance Percent: $tolerancePercent");
    print("tlorance>>:: Allowed Range: [$minAllowed to $maxAllowed]");

    if (amount < minAllowed || amount > maxAllowed) {
      print("tlorance>>:: RESULT: OUT OF RANGE (TOO LOW or TOO HIGH)");
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
      return;
    }

    // ─── If in range, proceed with loading and API ───
    print("tlorance>>:: RESULT: WITHIN RANGE. Proceeding to API...");
    emit(state.copyWith(status: OrdersRequestStatus.loading));

    // FIXME: Faking OTP response for disbursement to test bottom sheet
    // final bool useFakeOtp = true; // Set to true for testing
    // if (useFakeOtp) {
    //   final diff = amount - orderAmountVal;
    //   final excess = diff > 0 ? diff.toStringAsFixed(0) : null;
    //
    //   emit(
    //     state.copyWith(
    //       status: OrdersRequestStatus.success,
    //       gatewayType: GatewayType.online,
    //       disbursementGatewayType: 'otp',
    //       disbursementMobile: state.selectedOrder?.customer.phone,
    //       clearanceStep: ClearanceStep.otpPending,
    //       clearanceAmount: amountStr,
    //       orderAmount: state.selectedOrder!.financialSummary.finalAmount,
    //       excessAmount: excess,
    //       isOutOfTolerance: false,
    //     ),
    //   );
    //   return;
    // }

    _ordersRepo
        .disburseInitiate(state.selectedOrder!.id, amount)
        .then((response) {
          print("tlorance>>:: API SUCCESS: disburseInitiate responded");
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
                        .amountEntered // Show redirect button
                  : ClearanceStep.documentsPending,
              clearanceAmount: amountStr,
              orderAmount: state.selectedOrder!.financialSummary.finalAmount,
              excessAmount: excess,
              walletName: wallet,
              isOutOfTolerance: false,
            ),
          );

          // Auto-launch browser if redirect
          if (type == 'redirect' && redirectUrl != null) {
            launchUrl(
              Uri.parse(redirectUrl),
              mode: LaunchMode.externalApplication,
            );
          }
        })
        .catchError(
          (e) => _handleError(e, prefix: 'خطا در شروع عملیات تخلیه: '),
        );
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

  void confirmClearanceDocument() {
    if (state.selectedOrder == null || state.uploadedClearanceDocPath == null)
      return;
    emit(state.copyWith(status: OrdersRequestStatus.loading));

    _mediaRepo
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
        .catchError(
          (e) =>
              _handleError(e, prefix: 'خطا در بارگذاری مدارک یا نهایی‌سازی: '),
        );
  }

  void confirmClearanceOtp(String otp) {
    if (state.selectedOrder == null) return;
    emit(state.copyWith(status: OrdersRequestStatus.loading));

    _ordersRepo
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
        .catchError(
          (e) => _handleError(e, prefix: 'خطا در تایید کد و نهایی‌سازی: '),
        );
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
      _handleError('تنظیمات تولرانس برای پرداخت با کیف پول بارگذاری نشده است');
      return;
    }
    emit(state.copyWith(status: OrdersRequestStatus.loading));

    final apiMethod = _mapSettlementMethodToApi(method);
    final finalAmount =
        amount ?? _calculateRemainingSettlement(state.selectedOrder!);

    // FIXME: Faking API success for 'link' method due to backend issues as requested by user.
    // if (method == 'link' || method == 'cash') {
    //   emit(
    //     state.copyWith(
    //       status: OrdersRequestStatus.success,
    //       settlementStep: SettlementStep.methodSelected,
    //       settlementMethod: 'link',
    //       settlementMobile: state.selectedOrder?.customer.phone,
    //     ),
    //   );
    //   _startSettlementTimer();
    //   // Auto-confirm for link mode to trigger success UI
    //   confirmSettlement();
    //   return;
    // }

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
            _walletService
                .getWallet()
                .then((walletDto) {
                  final requiredAmount =
                      response['reserved_amount']?.toDouble() ?? 0;
                  final isSufficient = _checkWalletBalance(
                    walletDto,
                    walletName,
                    requiredAmount,
                  );

                  emit(
                    state.copyWith(
                      status: OrdersRequestStatus.success,
                      settlementStep: SettlementStep.methodSelected,
                      settlementMethod: method,
                      settlementReservedAmount: requiredAmount,
                      walletName: walletName,
                      isWalletBalanceSufficient: isSufficient,
                    ),
                  );

                  if (isSufficient) {
                    confirmSettlement();
                  }
                })
                .catchError((_) {
                  emit(
                    state.copyWith(
                      status: OrdersRequestStatus.success,
                      settlementStep: SettlementStep.methodSelected,
                      settlementMethod: method,
                      settlementReservedAmount: response['reserved_amount']
                          ?.toDouble(),
                      walletName: walletName,
                    ),
                  );
                });
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
        .catchError(
          (e) => _handleError(e, prefix: 'خطا در شروع عملیات تسویه: '),
        );
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
          .catchError((e) => _handleError(e, prefix: 'خطا در بارگذاری فیش: '));
    } else {
      performSettle().catchError(
        (e) => _handleError(e, prefix: 'خطا در تایید تسویه: '),
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
        status: isDone ? 'انجام شده' : '',
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
        status: isDone ? 'انجام شده' : '',
        isCompleted: isDone,
      );
    }
    return null;
  }

  // ─── Private Helpers ───────────────────────────────────────────────

  String? _formatJalaliDate(Jalali? date) {
    if (date == null) return null;
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
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

  bool _checkWalletBalance(
    WalletDtoModel walletDto,
    String? walletName,
    double requiredAmount,
  ) {
    if (walletName == null) return false;
    double pocketBalance = 0;
    final targetName = walletName.trim();

    for (var pocket in walletDto.pockets) {
      if (pocket.subPlan.name.trim() == targetName) {
        pocketBalance = pocket.balance;
        break;
      }
    }
    // Use dynamic tolerance from profile
    // Server returns percentage as a whole number (e.g. 12.0 for 12%), convert to decimal
    final tolerancePercent = state.tolerance! / 100;
    print("tlorance>>:: used in _checkWalletBalance: $tolerancePercent");
    final amountWithTolerance = requiredAmount * (1 - tolerancePercent);
    return pocketBalance >= amountWithTolerance;
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

  void _handleError(Object e, {String prefix = ''}) {
    emit(
      state.copyWith(
        status: OrdersRequestStatus.error,
        errorMessage: '$prefix${e.toString()}',
      ),
    );
  }

  @override
  Future<void> close() {
    _searchTimer?.cancel();
    _settlementTimer?.cancel();
    _linkSubscription?.cancel();
    return super.close();
  }
}
