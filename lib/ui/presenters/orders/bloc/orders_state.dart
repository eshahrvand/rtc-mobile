import 'package:freezed_annotation/freezed_annotation.dart';
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
    String? settlementMethod,
    String? settlementRedirectUrl,
    double? settlementReservedAmount,
    String? settlementBankAccount,
    String? settlementBankName,
    String? settlementAccountHolder,
    String? settlementTrackingCode,
    @Default(true) bool isWalletBalanceSufficient,
    @Default(false) bool isSettlementCompleted,

    // Disbursement Extras
    String? disbursementMobile,
    String? disbursementRedirectUrl,
    String? disbursementGatewayType,
  }) = _OrdersState;
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
