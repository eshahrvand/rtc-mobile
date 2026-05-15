import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../data/models/order_model.dart';

part 'orders_state.freezed.dart';

enum OrdersRequestStatus {
  initial,
  loading,
  success,
  error,
}

@freezed
class OrdersState with _$OrdersState {
  const factory OrdersState({
    @Default(OrdersRequestStatus.initial) OrdersRequestStatus status,
    @Default('') String errorMessage,
    @Default([]) List<OrderItemModel> allOrders,
    @Default([]) List<OrderItemModel> filteredOrders,
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
  }) = _OrdersState;
}
