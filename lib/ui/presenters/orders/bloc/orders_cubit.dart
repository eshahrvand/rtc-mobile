import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../../../../config/config.dart';
import '../../../../data/models/order_model.dart';
import '../../../../locator.dart';
import '../../../../repository/orders/orders_repository.dart';
import '../../../../repository/plans/plans_repository.dart';
import 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final _ordersRepo = sl<OrdersRepository>();
  final _plansRepo = sl<PlansRepository>();

  OrdersCubit() : super(const OrdersState());

  void init() {
    _plansRepo.getSubPlans().then((response) {
      emit(state.copyWith(subPlans: response.results));
    }).catchError((_) {});
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
          status: state.selectedStatusId != null ? [state.selectedStatusId!] : null,
          subPlanId: state.selectedSubPlanId,
          createdAfter: createdAfter,
          createdBefore: createdBefore,
          search: state.searchQuery.trim().isEmpty ? null : state.searchQuery,
        )
        .then((orders) {
          emit(state.copyWith(
            status: OrdersRequestStatus.success,
            allOrders: orders,
            filteredOrders: orders,
          ));
        })
        .catchError((e) {
          emit(state.copyWith(
            status: OrdersRequestStatus.error,
            errorMessage: e.toString(),
          ));
        });
  }

  void onSearchChanged(String query) {
    emit(state.copyWith(searchQuery: query));
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
    emit(state.copyWith(
      startDate: start,
      endDate: end,
      selectedDateOptionId: optionId,
    ));
    fetchOrders();
  }

  void clearDateFilter() {
    emit(state.copyWith(
      startDate: null,
      endDate: null,
      selectedDateOptionId: null,
    ));
    fetchOrders();
  }

  void onBadgeSelected(String badge) {
    // Keeping this for compatibility with existing UI if any, 
    // but the 3 main filters will use the specific methods above.
  }

  void onOrderTapped(OrderSummaryModel order) {
    emit(state.copyWith(status: OrdersRequestStatus.loading));

    _ordersRepo
        .getOrderDetails(order.id)
        .then((detail) {
          emit(state.copyWith(
            status: OrdersRequestStatus.success,
            selectedOrder: detail,
            selectedTabIndex: 0,
          ));
        })
        .catchError((e) {
          emit(state.copyWith(
            status: OrdersRequestStatus.error,
            errorMessage: 'خطا در بارگذاری جزئیات سفارش: ${e.toString()}',
          ));
        });
  }

  void onTabChanged(int index) {
    emit(state.copyWith(selectedTabIndex: index));
  }

  void toggleCreditPlan() {
    emit(state.copyWith(isCreditPlanExpanded: !state.isCreditPlanExpanded));
  }

  void toggleFinancialSection() {
    emit(state.copyWith(isFinancialSectionExpanded: !state.isFinancialSectionExpanded));
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

  void toggleFinancialSummary() {
    emit(state.copyWith(isFinancialSummaryExpanded: !state.isFinancialSummaryExpanded));
  }
}
