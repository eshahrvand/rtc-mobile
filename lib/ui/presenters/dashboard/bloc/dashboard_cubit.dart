import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/bar_chart_item_model.dart';
import '../../../../data/models/line_chart_data_model.dart';
import '../../../../data/models/order_item_model.dart';
import '../../../../data/models/pie_chart_item_model.dart';
import '../../../../data/models/quick_access_item_model.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(const DashboardState());

  void init() {
    emit(state.copyWith(status: DashboardRequestStatus.loading));

    // Simulate API call to fetch dashboard data
    Future.delayed(const Duration(seconds: 1))
        .then((_) {
          emit(state.copyWith(
            status: DashboardRequestStatus.success,
            quickAccessItems: [
              QuickAccessItemModel(
                title: 'فروش ماهانه',
                value: '۶۸,۰۰۰,۰۰۰',
                currency: 'تومان',
                iconPath: 'assets/images/dollar.svg',
                percentage: '۱۸.۵%',
              ),
              QuickAccessItemModel(
                title: 'سفارشات تایید شده',
                value: '۲۴',
                currency: 'تومان',
                iconPath: 'assets/images/trend-up.svg',
                percentage: '۱۸.۵%',
              ),
              QuickAccessItemModel(
                title: 'موجودی کیف پول',
                value: '۲,۰۰۰,۰۰۰',
                currency: 'تومان',
                iconPath: 'assets/images/wallet.svg',
              ),
              QuickAccessItemModel(
                title: 'پورسانت نقدی',
                value: '۲۲,۰۰۰,۰۰۰',
                currency: 'تومان',
                iconPath: 'assets/images/document-list-check.svg',
                percentage: '۱۸.۵%',
              ),
            ],
            messageText: 'با فروش ۲,۰۰۰,۰۰۰ تومان دیگر پورسانت شما به ۱۸٪ نقدی و یا ۲۰٪ کالا افزایش می‌یابد.',
            messageIconPath: 'assets/images/ic_info.svg',
            lineChartData: [
              LineChartDataModel(
                line1Data: const [
                  FlSpot(0, 3),
                  FlSpot(1, 4),
                  FlSpot(2, 3.5),
                  FlSpot(3, 5),
                  FlSpot(4, 4),
                  FlSpot(5, 6),
                ],
                line2Data: const [
                  FlSpot(0, 1),
                  FlSpot(1, 2),
                  FlSpot(2, 1.5),
                  FlSpot(3, 3),
                  FlSpot(4, 2.5),
                  FlSpot(5, 4),
                ],
              ),
            ],
            pieChart1Title: 'وضعیت سفارش‌ها',
            pieChart1Data: [
              PieChartItemModel(label: 'تایید شده', value: 70, color: Colors.green), // // TODO: replace with theme color
              PieChartItemModel(label: 'در انتظار تایید', value: 15, color: Colors.orange), // // TODO: replace with theme color
              PieChartItemModel(label: 'رد شده', value: 10, color: Colors.red), // // TODO: replace with theme color
              PieChartItemModel(label: 'پیش‌فاکتور', value: 5, color: Colors.blue), // // TODO: replace with theme color
            ],
            pieChart2Title: 'تعداد فروش بر اساس دسته‌بندی کالا',
            pieChart2Data: [
              PieChartItemModel(label: 'پذیرایی', value: 40, color: Colors.yellow), // // TODO: replace with theme color
              PieChartItemModel(label: 'شوینده', value: 30, color: Colors.greenAccent), // // TODO: replace with theme color
              PieChartItemModel(label: 'بهداشتی', value: 15, color: Colors.blueAccent), // // TODO: replace with theme color
              PieChartItemModel(label: 'سلولوزی', value: 10, color: Colors.purple), // // TODO: replace with theme color
              PieChartItemModel(label: 'سایر', value: 5, color: Colors.pink), // // TODO: replace with theme color
            ],
            barChartTitle: 'جمع فروش طرح‌ها در ماه جاری',
            barChartData: [
              BarChartItemModel(label: 'طرح ۱', value: 10),
              BarChartItemModel(label: 'طرح ۲', value: 15),
              BarChartItemModel(label: 'طرح ۳', value: 8),
              BarChartItemModel(label: 'طرح ۴', value: 20),
              BarChartItemModel(label: 'طرح ۵', value: 12),
            ],
            recentOrders: [
              OrderItemModel(
                orderId: 'PF-۱۴۰۲-۰۰۱۲۵',
                customerName: 'سامان راد',
                date: '۱۴۰۲/۰۶/۱۵',
                status: 'پیش‌فاکتور',
                amount: '۸,۲۰۰,۰۰۰ ریال',
              ),
              OrderItemModel(
                orderId: 'PF-۱۴۰۲-۰۰۱۲۶',
                customerName: 'علی محمدی',
                date: '۱۴۰۲/۰۶/۱۶',
                status: 'تایید شده',
                amount: '۱۲,۵۰۰,۰۰۰ ریال',
              ),
            ],
          ));
        })
        .catchError((Object e) {
          emit(state.copyWith(
            status: DashboardRequestStatus.error,
            errorMessage: e.toString(),
          ));
        });
  }

  void onNavItemSelected(int index) {
    emit(state.copyWith(selectedNavIndex: index));
  }
}
