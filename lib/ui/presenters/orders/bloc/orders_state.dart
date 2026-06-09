import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/enums/order_status.dart';
import '../../../../data/models/order_model.dart';
import '../../../../data_source/remote/plans/model/plan_dto_model.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

part 'orders_state.freezed.dart';

enum OrdersRequestStatus {
  initial,
  loading,
  success,
  error,
}

enum GatewayType {
  online,
  offline,
}

@freezed
class OrdersState with _$OrdersState {
  const factory OrdersState({
    @Default(OrdersRequestStatus.initial) OrdersRequestStatus status,
    @Default('') String errorMessage,
    @Default([]) List<OrderSummaryModel> allOrders,
    @Default([]) List<OrderSummaryModel> filteredOrders,
    @Default('') String searchQuery,
    @Default(false) bool isSearchActive,
    @Default([]) List<String> selectedBadges,
    OrderDetailModel? selectedOrder,
    @Default(0) int selectedTabIndex,
    @Default(true) bool isCreditPlanExpanded,
    @Default(true) bool isFinancialSectionExpanded,
    @Default(true) bool isProductsExpanded,
    @Default(true) bool isCustomerInfoExpanded,
    @Default(true) bool isDocumentsExpanded,
    @Default(true) bool isFinancialSummaryExpanded,
    @Default(true) bool isClearanceSectionExpanded,
    String? selectedStatusId,
    String? selectedSubPlanId,
    @Default([]) List<SubPlanDtoModel> subPlans,
    Jalali? startDate,
    Jalali? endDate,
    String? selectedDateOptionId,

    // Clearance Flow
    @Default(ClearanceStep.initial) ClearanceStep clearanceStep,
    @Default('') String clearanceAmount,
    OrderOperationModel? disburseOperation,
    String? excessAmount,
    GatewayType? gatewayType,
    String? walletName,
    String? uploadedClearanceDocPath,
    String? uploadedClearanceDocId,
    String? orderAmount,
    @Default(false) bool isOutOfTolerance,
    double? tolerance,

    // Settlement Flow
    @Default(SettlementStep.initial) SettlementStep settlementStep,
    OrderOperationModel? settlementOperation,
    @Default('link') String? settlementMethod,
    String? settlementRedirectUrl,
    double? settlementReservedAmount,
    String? settlementBankAccount,
    String? settlementBankName,
    String? settlementAccountHolder,
    String? settlementTrackingCode,
    @Default(true) bool isWalletBalanceSufficient,
    @Default(false) bool isSettlementCompleted,

    // Settlement Timer (for "Send Link" mode)
    @Default(60) int settlementCountdown,
    @Default(false) bool isSettlementTimerActive,

    // Settlement Extras
    String? settlementMobile,

    // Disbursement Extras
    String? disbursementMobile,
    String? disbursementRedirectUrl,
    String? disbursementGatewayType,
  }) = _OrdersState;
}

extension OrdersStateX on OrdersState {
  bool get isPreInvoice => selectedOrder?.orderStatus == OrderStatus.preInvoice;
  bool get isWaitingSettlement =>
      selectedOrder?.orderStatus == OrderStatus.awaitingSettlement;

  bool get isPartialClearance =>
      clearanceStep != ClearanceStep.success && clearanceAmount.isNotEmpty;

  String get resolvedClearanceAmount {
    if (selectedOrder == null) return clearanceAmount;

    final successRecords = selectedOrder!.disbursementRecords.where(
      (r) => r.status == 'موفق' || r.status == 'success',
    );

    if (successRecords.isNotEmpty) {
      return successRecords.first.amount;
    }
    if (clearanceAmount.isNotEmpty) {
      return clearanceAmount;
    }
    return selectedOrder!.financialSummary.finalAmount;
  }

  String? get resolvedExcessAmount {
    if (selectedOrder == null) return excessAmount;

    final successRecords = selectedOrder!.disbursementRecords.where(
      (r) => r.status == 'موفق' || r.status == 'success',
    );

    if (successRecords.isNotEmpty) {
      final disbursedVal =
          double.tryParse(successRecords.first.amount.replaceAll(',', '')) ?? 0;
      final orderVal =
          double.tryParse(
                selectedOrder!.financialSummary.finalAmount.replaceAll(',', ''),
              ) ??
              0;
      if (disbursedVal > orderVal) {
        return (disbursedVal - orderVal).toStringAsFixed(0);
      }
      return null;
    }
    return excessAmount;
  }

  bool get isOverDischarge {
    final clearanceAmountVal =
        double.tryParse(resolvedClearanceAmount.replaceAll(',', '')) ?? 0;
    final currentOrderAmount =
        orderAmount ?? selectedOrder?.financialSummary.finalAmount ?? '0';
    final orderAmountVal =
        double.tryParse(currentOrderAmount.replaceAll(',', '')) ?? 0;

    return resolvedClearanceAmount.isNotEmpty &&
        clearanceAmountVal >= orderAmountVal;
  }

  bool get shouldShowSettlement {
    if (selectedOrder == null) return false;

    return !isOverDischarge &&
        !isOutOfTolerance &&
        (isWaitingSettlement ||
            selectedOrder!.settlementRecords.isNotEmpty ||
            clearanceStep == ClearanceStep.success ||
            clearanceAmount.isNotEmpty);
  }

  bool get shouldShowDisbursement {
    if (selectedOrder == null || disburseOperation == null) return false;

    final status = selectedOrder!.orderStatus;
    return clearanceAmount.isNotEmpty ||
        status == OrderStatus.underReview ||
        status == OrderStatus.approved ||
        status == OrderStatus.awaitingSettlement ||
        status == OrderStatus.rejected;
  }

  double get settlementDifferenceValue {
    if (selectedOrder == null) return 0;

    final orderTotal = double.tryParse(
          selectedOrder!.financialSummary.finalAmount.replaceAll(',', ''),
        ) ??
        0;

    double totalCleared = 0;
    for (var record in selectedOrder!.disbursementRecords) {
      if (record.status == 'موفق' || record.status == 'success') {
        totalCleared += double.tryParse(record.amount.replaceAll(',', '')) ?? 0;
      }
    }

    double diffValue = orderTotal - totalCleared;

    if (isPartialClearance) {
      final pendingAmount =
          double.tryParse(clearanceAmount.replaceAll(',', '')) ?? 0;
      diffValue -= pendingAmount;
    }

    return diffValue < 0 ? 0 : diffValue;
  }

  double get settlementPayableValue {
    // Placeholder for cash discount (0 for now)
    const double cashDiscountValue = 0;
    final payableValue = settlementDifferenceValue - cashDiscountValue;
    return payableValue < 0 ? 0 : payableValue;
  }
}

enum ClearanceStep {
  initial,
  amountEntered,
  otpPending,
  documentsPending,
  success,
}

enum SettlementStep {
  initial,
  methodSelected,
  awaitingConfirmation,
  success,
}
