import 'package:cross_file/cross_file.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/enums/order_status.dart';
import '../../../../core/models/order_model.dart';
import '../../../../data_source/remote/plans/model/plan_dto_model.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../../../../generated/l10n.dart';

part 'orders_state.freezed.dart';

enum OrdersRequestStatus { initial, loading, success, error, settlementSuccess }

enum PrintStatus { initial, loading, success, error }

enum GatewayType { online, offline }

enum PaymentOutcome { initial, success, failed }

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

    // Deep Link Flow
    @Default(PaymentOutcome.initial) PaymentOutcome deepLinkPaymentOutcome,
    Map<String, dynamic>? pendingNavigation,

    // Clearance Flow
    @Default(ClearanceStep.initial) ClearanceStep clearanceStep,
    @Default('') String clearanceAmount,
    OrderOperationModel? disburseOperation,
    String? excessAmount,
    GatewayType? gatewayType,
    String? walletName,
    XFile? uploadedClearanceDoc,
    String? uploadedClearanceDocId,
    String? orderAmount,
    @Default(false) bool isOutOfTolerance,
    double? tolerance,
    @Default(true) bool toleranceCheckEnabled,

    // Settlement Flow
    @Default(SettlementStep.initial) SettlementStep settlementStep,
    OrderOperationModel? settlementOperation,
    @Default('ipg_sms') String? settlementMethod,
    String? settlementRedirectUrl,
    double? settlementReservedAmount,
    String? settlementBankAccount,
    String? settlementBankName,
    String? settlementAccountHolder,
    String? settlementTrackingCode,
    @Default([]) List<XFile> settlementDocs,
    @Default(true) bool isWalletBalanceSufficient,
    @Default(false) bool isSettlementCompleted,

    // Settlement Timer (for "Send Link" mode)
    @Default(60) int settlementCountdown,
    @Default(false) bool isSettlementTimerActive,

    // Clearance OTP Timer
    @Default(120) int clearanceOtpCountdown,
    @Default(false) bool isClearanceOtpTimerActive,

    // Settlement Extras
    String? settlementMobile,

    // Disbursement Extras
    String? disbursementMobile,
    String? disbursementRedirectUrl,
    String? disbursementGatewayType,

    // Printing
    @Default(false) bool isPrinting,
    @Default(PrintStatus.initial) PrintStatus printStatus,
    String? lastPrintedFilePath,

    // Pagination
    @Default(1) int currentPage,
    @Default(0) int totalCount,
    @Default(false) bool isPaginationLoading,
    @Default(true) bool hasMoreData,
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

    if (selectedOrder!.disbursementRecords.isNotEmpty) {
      final last = selectedOrder!.disbursementRecords.last;
      if (last.status == 'موفق' || last.status == 'success') {
        return last.amount;
      }
    }

    if (clearanceAmount.isNotEmpty) {
      return clearanceAmount;
    }
    return selectedOrder!.financialSummary.finalAmount;
  }

  String? get resolvedExcessAmount {
    if (selectedOrder == null) return excessAmount;

    if (selectedOrder!.disbursementRecords.isNotEmpty) {
      final last = selectedOrder!.disbursementRecords.last;
      if (last.status == 'موفق' || last.status == 'success') {
        final disbursedVal =
            double.tryParse(last.amount.replaceAll(',', '')) ?? 0;
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
    }
    return excessAmount;
  }

  String? get lastDisbursementStatusDisplay {
    if (selectedOrder == null || selectedOrder!.disbursementRecords.isEmpty) {
      return null;
    }
    final last = selectedOrder!.disbursementRecords.last;
    if (last.status == 'success' || last.status == 'موفق') {
      if (last.gateway == 'offline') {
        return S.current.uploaded;
      }
      return S.current.statusDone;
    }
    return null;
  }

  String? get lastSettlementStatusDisplay {
    if (selectedOrder == null || selectedOrder!.settlementRecords.isEmpty) {
      return null;
    }
    final last = selectedOrder!.settlementRecords.last;
    if (last.status == 'success' || last.status == 'موفق') {
      if (last.paymentType == 'card_to_card' || last.paymentType == 'offline') {
        return S.current.uploaded;
      }
      return S.current.statusDone;
    } else if (last.status == 'failed' || last.status == 'ناموفق') {
      return S.current.statusFailed;
    }
    return last.status;
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

    final orderTotal =
        double.tryParse(
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

enum SettlementStep { initial, methodSelected, awaitingConfirmation, success }
