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
    @Default([]) List<String> selectedBadges,
    OrderDetailModel? selectedOrder,
    @Default(0) int selectedTabIndex,
    @Default(true) bool isCreditPlanExpanded,
    @Default(true) bool isFinancialSectionExpanded,
    @Default(true) bool isProductsExpanded,
    @Default(true) bool isCustomerInfoExpanded,
    @Default(true) bool isDocumentsExpanded,
    @Default(true) bool isFinancialSummaryExpanded,
    String? selectedStatusId,
    String? selectedSubPlanId,
    @Default([]) List<SubPlanDtoModel> subPlans,
    Jalali? startDate,
    Jalali? endDate,
    String? selectedDateOptionId,

    // Clearance Flow
    @Default(ClearanceStep.initial) ClearanceStep clearanceStep,
    @Default('') String clearanceAmount,
    String? excessAmount,
    GatewayType? gatewayType,
    String? walletName,
    String? uploadedClearanceDocPath,
    String? uploadedClearanceDocId,
  }) = _OrdersState;
}

enum ClearanceStep {
  initial,
  amountSelected,
  documentsPending,
  success,
}
