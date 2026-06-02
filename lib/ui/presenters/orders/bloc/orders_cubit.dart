import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../../../../data/models/order_model.dart';
import '../../../../locator.dart';
import '../../../../repository/orders/orders_repository.dart';
import '../../../../repository/plans/plans_repository.dart';
import '../../../../repository/media/media_repository.dart';
import '../../../../data_source/remote/orders/model/order_dto_model.dart';
import '../../media_picker/media_picker.dart';
import 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final _ordersRepo = sl<OrdersRepository>();
  final _plansRepo = sl<PlansRepository>();
  final _mediaRepo = sl<MediaRepository>();

  Timer? _searchTimer;

  OrdersCubit() : super(const OrdersState());

  void init() {
    _plansRepo
        .getSubPlans()
        .then((response) {
          emit(state.copyWith(subPlans: response.results));
        })
        .catchError((_) {});
    fetchOrders();
  }

  void fetchOrders() {
    emit(state.copyWith(status: OrdersRequestStatus.loading));

    String? createdAfter;
    if (state.startDate != null) {
      createdAfter =
          '${state.startDate!.year}-${state.startDate!.month.toString().padLeft(2, '0')}-${state.startDate!.day.toString().padLeft(2, '0')}';
    }

    String? createdBefore;
    if (state.endDate != null) {
      createdBefore =
          '${state.endDate!.year}-${state.endDate!.month.toString().padLeft(2, '0')}-${state.endDate!.day.toString().padLeft(2, '0')}';
    }

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
        .catchError((e) {
          emit(
            state.copyWith(
              status: OrdersRequestStatus.error,
              errorMessage: e.toString(),
            ),
          );
        });
  }

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

  void onBadgeSelected(String badge) {
    // Keeping this for compatibility with existing UI if any,
    // but the 3 main filters will use the specific methods above.
  }

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

  void fetchOrderDetail(String orderId) {
    emit(state.copyWith(status: OrdersRequestStatus.loading));

    _ordersRepo
        .getOrderDetails(orderId)
        .then((detail) {
          emit(
            state.copyWith(
              status: OrdersRequestStatus.success,
              selectedOrder: detail,
              disburseOperation: _createDisburseOp(detail),
              settlementOperation: _createSettlementOp(detail),
              selectedTabIndex: 0,
            ),
          );
        })
        .catchError((e) {
          emit(
            state.copyWith(
              status: OrdersRequestStatus.error,
              errorMessage: 'خطا در بارگذاری جزئیات سفارش: ${e.toString()}',
            ),
          );
        });
  }

  OrderOperationModel? _createDisburseOp(OrderDetailModel detail) {
    final isDone =
        detail.status == 'در انتظار تسویه' ||
        detail.status == 'تایید شده' ||
        detail.status == 'در انتظار تایید' ||
        state.clearanceStep == ClearanceStep.success;

    final statusesToShowDisburse = [
      'پیش فاکتور',
      'در انتظار تایید',
      'تایید شده',
      'رد شده',
      'در انتظار تسویه',
    ];

    if (statusesToShowDisburse.contains(detail.status)) {
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
    final isDone = detail.status == 'تایید شده' ||
        detail.status == 'در انتظار تایید' ||
        state.settlementStep == SettlementStep.success;

    final statusesToShowSettlement = [
      'در انتظار تسویه',
      'در انتظار تایید',
      'تایید شده',
    ];

    if (statusesToShowSettlement.contains(detail.status)) {
      return OrderOperationModel(
        step: 2,
        title: 'عملیات تسویه',
        status: isDone ? 'انجام شده' : '',
        isCompleted: isDone,
      );
    }
    return null;
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

  // --- Clearance Flow Methods ---

  void initiateClearance(String amountStr) {
    if (state.selectedOrder == null) return;
    emit(state.copyWith(status: OrdersRequestStatus.loading));

    final amount = double.tryParse(amountStr.replaceAll(',', '')) ?? 0;
    final orderAmount =
        double.tryParse(
          state.selectedOrder!.financialSummary.finalAmount.replaceAll(',', ''),
        ) ??
        0;

    // Keep tolerance check (20%)
    const tolerancePercent = 0.2;
    final minAllowed = orderAmount * (1 - tolerancePercent);
    final maxAllowed = orderAmount * (1 + tolerancePercent);

    if (amount < minAllowed || amount > maxAllowed) {
      emit(
        state.copyWith(
          status: OrdersRequestStatus.success,
          clearanceStep: ClearanceStep.amountEntered,
          clearanceAmount: amountStr,
          orderAmount: state.selectedOrder!.financialSummary.finalAmount,
          excessAmount: (amount - orderAmount).abs().toStringAsFixed(0),
          isOutOfTolerance: true,
        ),
      );
      return;
    }

    _ordersRepo
        .disburseInitiate(state.selectedOrder!.id, amount)
        .then((response) {
          final isOnline =
              response != null &&
              (response is Map) &&
              (response['gateway_type'] == 'online' ||
                  response['type'] == 'online');

          emit(
            state.copyWith(
              status: OrdersRequestStatus.success,
              gatewayType: isOnline ? GatewayType.online : GatewayType.offline,
              clearanceStep: isOnline
                  ? ClearanceStep.otpPending
                  : ClearanceStep.documentsPending,
              clearanceAmount: amountStr,
              orderAmount: state.selectedOrder!.financialSummary.finalAmount,
              // If amount < orderAmount, it will lead to awaiting_settlement path in flow
              isOutOfTolerance: false,
            ),
          );
        })
        .catchError((e) {
          emit(
            state.copyWith(
              status: OrdersRequestStatus.error,
              errorMessage: 'خطا در شروع عملیات تخلیه: ${e.toString()}',
            ),
          );
        });
  }

  Future<void> pickClearanceDocument(dynamic context) async {
    final result = await MediaPickerBottomSheet.show(
      context,
      isMultiSelection: false,
    );
    if (result != null && result.isNotEmpty) {
      final filePath = result.first.file.path;
      // Emit a "null" value first to ensure the listener triggers if the path is the same
      emit(state.copyWith(uploadedClearanceDocPath: null));
      emit(state.copyWith(uploadedClearanceDocPath: filePath));
    }
  }

  void confirmClearanceDocument() {
    if (state.selectedOrder == null || state.uploadedClearanceDocPath == null) {
      return;
    }
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
          // Refresh order detail to show updated status and documents
          if (state.selectedOrder != null) {
            fetchOrderDetail(state.selectedOrder!.id);
          }
        })
        .catchError((e) {
          emit(
            state.copyWith(
              status: OrdersRequestStatus.error,
              errorMessage:
                  'خطا در بارگذاری مدارک یا نهایی‌سازی: ${e.toString()}',
            ),
          );
        });
  }

  void confirmClearanceOtp() {
    if (state.selectedOrder == null) return;
    emit(state.copyWith(status: OrdersRequestStatus.loading));

    // TODO: Call verify OTP API if available
    _ordersRepo
        .disburse(state.selectedOrder!.id)
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
              errorMessage: 'خطا در تایید کد و نهایی‌سازی: ${e.toString()}',
            ),
          );
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

  // --- Settlement Flow Methods ---

  void initiateSettlement(String method, {double? amount}) {
    if (state.selectedOrder == null) return;
    emit(state.copyWith(status: OrdersRequestStatus.loading));

    _ordersRepo
        .settleInitiate(state.selectedOrder!.id, method, amount: amount)
        .then((response) {
          final type = response['type'];
          emit(
            state.copyWith(
              status: OrdersRequestStatus.success,
              settlementStep: SettlementStep.methodSelected,
              settlementMethod: method,
              settlementRedirectUrl: type == 'redirect' ? response['redirect_url'] : null,
              settlementReservedAmount: type == 'wallet' ? response['reserved_amount']?.toDouble() : null,
              settlementBankAccount: type == 'offline' ? response['bank_account'] : null,
              settlementBankName: type == 'offline' ? response['bank_name'] : null,
              settlementAccountHolder: type == 'offline' ? response['account_holder'] : null,
            ),
          );
        })
        .catchError((e) {
          emit(
            state.copyWith(
              status: OrdersRequestStatus.error,
              errorMessage: 'خطا در شروع عملیات تسویه: ${e.toString()}',
            ),
          );
        });
  }

  void confirmSettlement({String? trackingCode}) {
    if (state.selectedOrder == null || state.settlementMethod == null) return;
    emit(state.copyWith(status: OrdersRequestStatus.loading));

    _ordersRepo
        .settle(
          state.selectedOrder!.id,
          state.settlementMethod!,
          trackingCode: trackingCode,
        )
        .then((_) {
          emit(
            state.copyWith(
              status: OrdersRequestStatus.success,
              settlementStep: SettlementStep.success,
            ),
          );
          // Refresh order detail to show updated status
          fetchOrderDetail(state.selectedOrder!.id);
        })
        .catchError((e) {
          emit(
            state.copyWith(
              status: OrdersRequestStatus.error,
              errorMessage: 'خطا در تایید تسویه: ${e.toString()}',
            ),
          );
        });
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

  @override
  Future<void> close() {
    _searchTimer?.cancel();
    return super.close();
  }
}
