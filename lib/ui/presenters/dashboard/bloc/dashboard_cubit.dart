import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/bar_chart_item_model.dart';
import '../../../../data/models/line_chart_data_model.dart';
import '../../../../data/models/pie_chart_item_model.dart';
import '../../../../data/models/quick_access_item_model.dart';
import '../../../../data_source/remote/dashboard/model/dashboard_dto_model.dart';
import '../../../../repository/dashboard/dashboard_repository.dart';
import '../../../../locator.dart';
import '../../../../generated/l10n.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(const DashboardState());

  final _dashboardRepo = sl<DashboardRepository>();

  void init() {
    emit(state.copyWith(status: DashboardRequestStatus.loading));

    _dashboardRepo
        .getMyProfile()
        .then((profile) {
          emit(state.copyWith(userProfile: profile));
          _loadDashboardData();
        })
        .catchError((Object e) {
          emit(
            state.copyWith(
              status: DashboardRequestStatus.error,
              errorMessage: e.toString(),
            ),
          );
          _loadDashboardData();
        });
  }

  void _loadDashboardData() {
    Future.wait([
      _dashboardRepo.getSummary(),
      _dashboardRepo.getDailyChart(),
      _dashboardRepo.getCategories(),
      _dashboardRepo.getSubPlanChart(),
    ]).then((results) {
      final summary = results[0] as DashboardSummaryDtoModel;
      final dailyChart = results[1] as List<DailyChartDtoModel>;
      final categories = results[2] as List<CategoryChartDtoModel>;
      final subplans = results[3] as List<SubPlanChartDtoModel>;

      emit(
        state.copyWith(
          status: DashboardRequestStatus.success,
          quickAccessItems: [
            QuickAccessItemModel(
              title: S.current.monthlySales,
              value: summary.totalSalesAmount.toStringAsFixed(0),
              currency: S.current.toman,
              iconPath: 'assets/images/dollar.svg',
              percentage: '${summary.totalSalesDeltaPct}%',
            ),
            QuickAccessItemModel(
              title: S.current.approvedOrders,
              value: summary.activeAgents.toString(),
              currency: S.current.toman,
              iconPath: 'assets/images/trend-up.svg',
              percentage: '${summary.activeAgentsDelta}%',
            ),
            QuickAccessItemModel(
              title: S.current.walletBalance,
              value: summary.avgOrderAmount.toStringAsFixed(0),
              currency: S.current.toman,
              iconPath: 'assets/images/wallet.svg',
              percentage: '${summary.avgOrderDeltaPct}%',
            ),
            QuickAccessItemModel(
              title: S.current.cashCommission,
              value: summary.totalCustomers.toString(),
              currency: S.current.toman,
              iconPath: 'assets/images/document-list-check.svg',
              percentage: '${summary.totalCustomersDelta}%',
            ),
          ],
          lineChartData: [
            LineChartDataModel(
              line1Data: dailyChart
                  .asMap()
                  .entries
                  .map(
                    (e) => FlSpot(
                      e.key.toDouble(),
                      e.value.totalSalesAmount,
                    ),
                  )
                  .toList(),
              line2Data: const [], // TODO: mapping second line if available
            ),
          ],
          pieChart1Title: S.current.orderStatusChartTitle,
          pieChart1Data: categories
              .map(
                (c) => PieChartItemModel(
                  label: c.categoryName,
                  value: c.totalOrders.toDouble(),
                  color: Colors.blue, // TODO: map properly
                ),
              )
              .toList(),
          pieChart2Title: S.current.salesByCategoryChartTitle,
          pieChart2Data: categories
              .map(
                (c) => PieChartItemModel(
                  label: c.categoryName,
                  value: c.totalSalesAmount,
                  color: Colors.green, // TODO: map properly
                ),
              )
              .toList(),
          barChartTitle: S.current.plansSalesChartTitle,
          barChartData: subplans
              .map(
                (s) => BarChartItemModel(
                  label: s.planName,
                  value: s.totalSalesAmount,
                ),
              )
              .toList(),
          recentOrders: state.recentOrders, // Keep existing if any
        ),
      );
    }).catchError((Object e) {
      emit(
        state.copyWith(
          status: DashboardRequestStatus.error,
          errorMessage: e.toString(),
        ),
      );
    });
  }

  void onNavItemSelected(int index) {
    emit(state.copyWith(selectedNavIndex: index));
  }

  Map<String, dynamic> getUserProfileData() {
    return {
      'fullName': 'آرش فرداد',
      'role': 'نماینده فروش',
      'phoneNumber': '۰۹۱۲۶۰۲۴۱۷۹',
      'nationalId': '۰۰۸۱۲۳۴۵۶۷',
      'email': 'Arash.fardad@gmail.com',
      'agencyCode': 'AG-TEH-011',
      'workshopCode': '۱۲۳۴۵۶۷۸۹۰',
      'province': 'تهران',
      'city': 'تهران',
      'address':
          'خ ولیعصر، خ پسیان، ک طلوعی، پ ۱۵۸، واحد ۱۲ خ ولیعصر، خ پسیان، ک طلوعی، پ ۱۵۸، واحد ۱۲',
      'creditLimit': '۱۰۰,۰۰۰,۰۰۰',
      'regionalManager': 'پاشا نیکچی',
      'avatarUrl': 'assets/images/Avatar.png',
    };
  }
}
