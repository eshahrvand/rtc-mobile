import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/config.dart';
import '../../../../data/models/order_model.dart';
import 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(const OrdersState());

  void init() {
    emit(state.copyWith(status: OrdersRequestStatus.loading));

    // Simulated fetch
    Future.delayed(const Duration(milliseconds: 500))
        .then((_) {
          final mockOrders = [
            OrderItemModel(
              id: '1',
              orderId: 'PF-۱۴۰۴-۰۰۱۲۵',
              customerName: 'سامان راد',
              itemCount: '۳ کالا',
              status: 'در انتظار تسویه',
              dateTime: '۱۴۰۵/۰۱/۲۵ | ۱۲:۱۵',
              amount: '۸۰,۲۰۰,۰۰۰',
            ),
            OrderItemModel(
              id: '2',
              orderId: 'PF-۱۴۰۴-۰۰۱۲۵',
              customerName: 'آرش مهبان',
              itemCount: '۳ کالا',
              status: 'در انتظار تایید',
              dateTime: '۱۴۰۵/۰۱/۲۵ | ۱۲:۱۵',
              amount: '۸۰,۲۰۰,۰۰۰',
            ),
            OrderItemModel(
              id: '3',
              orderId: 'PF-۱۴۰۴-۰۰۱۲۵',
              customerName: 'سارا قریشی',
              itemCount: '۳ کالا',
              status: 'تایید شده',
              dateTime: '۱۴۰۵/۰۱/۲۵ | ۱۲:۱۵',
              amount: '۸۰,۲۰۰,۰۰۰',
            ),
          ];
          emit(state.copyWith(
            status: OrdersRequestStatus.success,
            allOrders: mockOrders,
            filteredOrders: mockOrders,
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
    _filterOrders();
  }

  void onBadgeSelected(String badge) {
    final updatedBadges = List<String>.from(state.selectedBadges);
    if (updatedBadges.contains(badge)) {
      updatedBadges.remove(badge);
    } else {
      updatedBadges.add(badge);
    }
    emit(state.copyWith(selectedBadges: updatedBadges));
    _filterOrders();
  }

  void _filterOrders() {
    var filtered = state.allOrders;
    if (state.searchQuery.isNotEmpty) {
      filtered = filtered
          .where((o) => o.customerName.contains(state.searchQuery) || o.orderId.contains(state.searchQuery))
          .toList();
    }
    if (state.selectedBadges.isNotEmpty) {
      filtered = filtered.where((o) => state.selectedBadges.contains(o.status)).toList();
    }
    emit(state.copyWith(filteredOrders: filtered));
  }

  void onOrderTapped(OrderItemModel order) {
    emit(state.copyWith(status: OrdersRequestStatus.loading));

    // Simulated detail fetch
    Future.delayed(const Duration(milliseconds: 300))
        .then((_) {
          final detail = OrderDetailModel(
            id: order.id,
            status: order.status,
            remainingTime: '۴ ساعت',
            creditPlan: CreditPlanModel(
              provider: 'آپ',
              planName: 'آپ - ۱۲ ماهه',
              priceIncrease: '۱۵ +',
              validityPeriod: '۴۸ ساعت',
            ),
            products: [
              OrderProductModel(
                name: 'یخچال فریزر RTC مدل X۵۰۰ - ظرفیت ۵۰۰ لیتر',
                price: '۱۷,۲۵۰,۰۰۰',
                discount: '۲۰٪',
                oldPrice: '۱۸,۴۵۰,۰۰۰',
                quantity: '۱',
                imageUrl: '$baseImage/frame1.png',
              ),
              OrderProductModel(
                name: 'فرگاز RTC ظرفیت ۵۰۰ لیتر مدل X۵۰۰ - ظرفیت ۵۰۰ لیتر',
                price: '۱۷,۲۵۰,۰۰۰',
                quantity: '۲',
                imageUrl: '$baseImage/frame2.png',
              ),
              OrderProductModel(
                name: 'هواپز RTC ۵۰۰ لیتر مدل X۵۰۰ - ظرفیت ۵۰۰ لیتر',
                price: '۱۷,۲۵۰,۰۰۰',
                quantity: '۱',
                imageUrl: '$baseImage/frame3.png',
              ),
            ],
            customer: OrderCustomerModel(
              name: 'سامان راد',
              phone: '۰۹۱۲۶۰۷۷۴۵۶',
              nationalCode: '۰۰۸۱۲۳۴۵۶۷',
              postalCode: '۱۹۳۳۹۴۳۱۱۱',
              address: 'تجریش، ابتدای شریعتی، کوچه پروین، پلاک ۲۸، زنگ ۳',
            ),
            documents: [
              OrderDocumentModel(
                title: 'کارت ملی - روی',
                fileName: 'national_card_front',
                fileSize: '۶ MB',
                iconPath: '$baseImage/alert.svg',
              ),
              OrderDocumentModel(
                title: 'سایر مدارک ۱',
                fileName: 'national_card_front',
                fileSize: '۶ MB',
                iconPath: '$baseImage/alert.svg',
              ),
              OrderDocumentModel(
                title: 'سایر مدارک ۲',
                fileName: 'national_card_front',
                fileSize: '۶ MB',
                iconPath: '$baseImage/alert.svg',
              ),
            ],
            financialSummary: FinancialSummaryModel(
              basePrice: '۱۳۰,۰۰۰,۰۰۰',
              totalDiscount: '۶,۰۰۰,۰۰۰',
              finalAmount: '۱۲۴,۰۰۰,۰۰۰',
            ),
            operations: [
              OrderOperationModel(step: 1, title: 'عملیات تخلیه', status: 'انجام شده', isCompleted: true),
              OrderOperationModel(step: 2, title: 'عملیات تسویه', status: 'انجام شده', isCompleted: true),
            ],
            history: [
              OrderHistoryModel(label: 'تاریخ ثبت:', value: '۱۴۰۴/۱۲/۰۹ - ۱۲:۵۰'),
              OrderHistoryModel(label: 'تاریخ تخلیه:', value: '۱۴۰۴/۱۲/۰۹ - ۱۲:۵۰'),
              OrderHistoryModel(label: 'تاریخ تسویه:', value: '۱۴۰۴/۱۲/۰۹ - ۱۲:۵۰'),
              OrderHistoryModel(label: 'تاریخ تایید:', value: '۱۴۰۴/۱۲/۰۹ - ۱۲:۵۰'),
              OrderHistoryModel(label: 'نام پشتیبان:', value: 'آرمان برزگر'),
              OrderHistoryModel(label: 'نام سرپرست مالی:', value: 'سینا ایرانی'),
            ],
          );
          emit(state.copyWith(
            status: OrdersRequestStatus.success,
            selectedOrder: detail,
            selectedTabIndex: 0,
          ));
        })
        .catchError((e) {
          emit(state.copyWith(
            status: OrdersRequestStatus.error,
            errorMessage: e.toString(),
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
