import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/bar_chart_item_model.dart';
import '../../../../data/models/line_chart_data_model.dart';
import '../../../../data/models/pie_chart_item_model.dart';
import '../../../../data/models/quick_access_item_model.dart';
import '../../../../data_source/remote/dashboard/model/dashboard_dto_model.dart';
import '../../../../repository/dashboard/dashboard_repository.dart';
import '../../../../repository/orders/orders_repository.dart';
import '../../../../locator.dart';
import '../../../../generated/l10n.dart';
import '../../../theme/colors.dart';
import 'dashboard_state.dart';
import '../../../../data/models/order_model.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(const DashboardState());

  final _dashboardRepo = sl<DashboardRepository>();
  final _ordersRepo = sl<OrdersRepository>();

  void init() {
    emit(state.copyWith(status: DashboardRequestStatus.loading));

    _dashboardRepo
        .getMyProfile()
        .then((profile) {
          emit(state.copyWith(userProfile: profile));
          _loadDashboardData();
        })
        .catchError((Object e) {
          _loadDashboardData();
          emit(
            state.copyWith(
              status: DashboardRequestStatus.error,
              errorMessage: e.toString(),
            ),
          );
        });
  }

  void _loadDashboardData() {
    Future.wait([
          _dashboardRepo.getSummary(),
          _dashboardRepo.getDailyChart(),
          _dashboardRepo.getCategories(),
          _dashboardRepo.getSubPlanChart(),
          _ordersRepo.getOrders(page: 1, pageSize: 5),
          _dashboardRepo.getOrderStatus(),
        ])
        .then((results) {
          final summary = results[0] as DashboardSummaryDtoModel;
          final dailyChart = results[1] as List<DailyChartDtoModel>;
          final categories = results[2] as List<CategoryChartDtoModel>;
          final subplans = results[3] as List<SubPlanChartDtoModel>;
          final orders = results[4] as List<OrderSummaryModel>;
          final orderStatuses = results[5] as List<OrderStatusDtoModel>;

          emit(
            state.copyWith(
              status: DashboardRequestStatus.success,
              quickAccessItems: [
                QuickAccessItemModel(
                  title: S.current.monthlySales,
                  value: summary.totalSalesAmount.toStringAsFixed(0),
                  currency: S.current.toman,
                  iconPath: 'assets/images/dollar.svg',
                  percentage:
                      '${(summary.totalSalesDeltaPct ?? 0).toStringAsFixed(0)}%',
                ),
                QuickAccessItemModel(
                  title: S.current.approvedOrders,
                  value: summary.orderCount.toString(),
                  currency: S.current.toman,
                  iconPath: 'assets/images/trend-up.svg',
                  percentage: '${summary.orderCountDelta}%',
                ),
                QuickAccessItemModel(
                  title: S.current.walletBalance,
                  value: summary.walletBalance.toStringAsFixed(0),
                  currency: S.current.toman,
                  iconPath: 'assets/images/wallet.svg',
                ),
                QuickAccessItemModel(
                  title: S.current.cashCommission,
                  value: summary.activeOrders.toString(),
                  currency: S.current.toman,
                  iconPath: 'assets/images/document-list-check.svg',
                ),
              ],
              lineChartData: [
                LineChartDataModel(
                  line1Data: dailyChart.isEmpty
                      ? const [FlSpot(0, 0)]
                      : dailyChart
                            .asMap()
                            .entries
                            .map(
                              (e) => FlSpot(
                                e.key.toDouble(),
                                e.value.totalSalesAmount,
                              ),
                            )
                            .toList(),
                  line2Data: const [],
                ),
              ],
              pieChart1Title: S.current.orderStatusChartTitle,
              pieChart1Data: orderStatuses.isEmpty
                  ? [
                      PieChartItemModel(
                        label: '...',
                        value: 1,
                        color: AppColors.grayPalette.shade200,
                      ),
                    ]
                  : orderStatuses.map((s) {
                      String label = s.status;
                      Color color = AppColors.grayPalette.shade400;

                      if (s.status == 'approved') {
                        label = S.current.statusApproved;
                        color = AppColors.successPalette.shade400;
                      } else if (s.status == 'reject' ||
                          s.status == 'rejected') {
                        label = S.current.statusRejected;
                        color = AppColors.errorPalette.shade400;
                      } else if (s.status == 'under_review') {
                        label = S.current.statusPending;
                        color = AppColors.warningPalette.shade400;
                      } else if (s.status == 'pre_invoice') {
                        label = S.current.preInvoice;
                        color = AppColors.brandPalette.shade400;
                      }

                      return PieChartItemModel(
                        label: label,
                        value: s.count.toDouble(),
                        color: color,
                      );
                    }).toList(),
              pieChart2Title: S.current.salesByCategoryChartTitle,
              pieChart2Data: categories.isEmpty
                  ? [
                      PieChartItemModel(
                        label: '...',
                        value: 1,
                        color: AppColors.grayPalette.shade200,
                      ),
                    ]
                  : categories
                        .map(
                          (c) => PieChartItemModel(
                            label: c.categoryName,
                            value: c.totalOrders.toDouble(),
                            color: AppColors.successPalette.shade400,
                          ),
                        )
                        .toList(),
              barChartTitle: S.current.plansSalesChartTitle,
              barChartData: subplans.isEmpty
                  ? [BarChartItemModel(label: '...', value: 0)]
                  : subplans
                        .map(
                          (s) => BarChartItemModel(
                            label: s.planName,
                            value: s.totalSalesAmount,
                          ),
                        )
                        .toList(),
              recentOrders: orders,
            ),
          );
        })
        .catchError((Object e) {
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
}
