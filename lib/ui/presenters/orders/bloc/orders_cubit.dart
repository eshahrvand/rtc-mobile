import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../../../../config/config.dart';
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
    fetchOrderDetail(order.id);
  }

  void fetchOrderDetail(String orderId) {
    emit(state.copyWith(status: OrdersRequestStatus.loading));

    _ordersRepo
        .getOrderDetails(orderId)
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
    emit(state.copyWith(
      isFinancialSummaryExpanded: !state.isFinancialSummaryExpanded,
    ));
  }

  // --- Clearance Flow Methods ---

  void initiateClearance(String amountStr) {
    if (state.selectedOrder == null) return;
    emit(state.copyWith(status: OrdersRequestStatus.loading));

    final amount = double.tryParse(amountStr.replaceAll(',', '')) ?? 0;

    _ordersRepo
        .disburseInitiate(state.selectedOrder!.id, amount)
        .then((response) {
          // For now focusing on offline case
          emit(state.copyWith(
            status: OrdersRequestStatus.success,
            clearanceStep: ClearanceStep.documentsPending,
            clearanceAmount: amountStr,
          ));
        })
        .catchError((e) {
          emit(state.copyWith(
            status: OrdersRequestStatus.error,
            errorMessage: 'خطا در شروع عملیات تخلیه: ${e.toString()}',
          ));
        });
  }

  Future<void> pickClearanceDocument(dynamic context) async {
    final result = await MediaPickerBottomSheet.show(
      context,
      isMultiSelection: false,
    );
    if (result != null && result.isNotEmpty) {
      final filePath = result.first.file.path;
      emit(state.copyWith(uploadedClearanceDocPath: filePath));
    }
  }

  void confirmClearanceDocument() {
    if (state.selectedOrder == null || state.uploadedClearanceDocPath == null)
      return;
    emit(state.copyWith(status: OrdersRequestStatus.loading));

    // 1. Upload the file to media service
    _mediaRepo
        .uploadOrderDocument(File(state.uploadedClearanceDocPath!))
        .then((media) {
          // 2. Link the document to the order
          return _ordersRepo.addOrderDocument(
            state.selectedOrder!.id,
            OrderDocumentRequest(documentType: 'supporting', fileId: media.id),
          );
        })
        .then((_) {
          // 3. Finalize disburse
          return _ordersRepo.disburse(state.selectedOrder!.id);
        })
        .then((_) {
          emit(state.copyWith(
            status: OrdersRequestStatus.success,
            clearanceStep: ClearanceStep.success,
          ));
        })
        .catchError((e) {
          emit(state.copyWith(
            status: OrdersRequestStatus.error,
            errorMessage: 'خطا در بارگذاری مدارک یا نهایی‌سازی: ${e.toString()}',
          ));
        });
  }

  void resetClearance() {
    emit(state.copyWith(
      clearanceStep: ClearanceStep.initial,
      uploadedClearanceDocPath: null,
      uploadedClearanceDocId: null,
    ));
  }
}
