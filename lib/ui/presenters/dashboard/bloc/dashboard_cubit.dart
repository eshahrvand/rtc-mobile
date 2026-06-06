import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
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

// ─── REFACTOR LOG ───────────────────────────────────────────────────
// [1] Extracted `_mapQuickAccessItems()` to simplify summary data processing.
// [2] Extracted `_mapLineChartData()` to isolate Jalali-based sales calculation.
// [3] Extracted `_mapOrderStatusChart()` and `_mapCategoryChart()` for cleaner UI mapping.
// [4] Extracted `_mapSubPlanChart()` to handle bar chart item generation.
// [5] Grouped private mapping helpers at the bottom for better readability.
// [6] Added documentation to clarify the dashboard initialization and data fetching.
// ────────────────────────────────────────────────────────────────────

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({int initialIndex = 0})
    : super(DashboardState(selectedNavIndex: initialIndex));

  final _dashboardRepo = sl<DashboardRepository>();
  final _ordersRepo = sl<OrdersRepository>();

  // ─── Event Handlers ────────────────────────────────────────────────

  /// Initializes the dashboard by fetching user profile and then loading overview data.
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
          _handleError(e);
        });
  }

  /// Updates the selected navigation index.
  void onNavItemSelected(int index) {
    emit(state.copyWith(selectedNavIndex: index));
  }

  // ─── Private Data Loaders ──────────────────────────────────────────

  /// Fetches all dashboard components in parallel and updates the state.
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
              quickAccessItems: _mapQuickAccessItems(summary),
              lineChartData: [_mapLineChartData(dailyChart)],
              pieChart1Title: S.current.orderStatusChartTitle,
              pieChart1Data: _mapOrderStatusChart(orderStatuses),
              pieChart2Title: S.current.salesByCategoryChartTitle,
              pieChart2Data: _mapCategoryChart(categories),
              barChartTitle: S.current.plansSalesChartTitle,
              barChartData: _mapSubPlanChart(subplans),
              recentOrders: orders,
            ),
          );
        })
        .catchError(_handleError);
  }

  // ─── Mapping Helpers ───────────────────────────────────────────────

  /// Maps summary DTO to quick access UI models.
  List<QuickAccessItemModel> _mapQuickAccessItems(DashboardSummaryDtoModel s) {
    return [
      QuickAccessItemModel(
        title: S.current.monthlySales,
        value: s.totalSalesAmount.toStringAsFixed(0),
        currency: "assets/images/toman.svg",
        iconPath: 'assets/images/dollar.svg',
        percentage: '${(s.totalSalesDeltaPct ?? 0).toStringAsFixed(0)}%',
      ),
      QuickAccessItemModel(
        title: S.current.approvedOrders,
        value: s.orderCount.toString(),
        currency: "",
        iconPath: 'assets/images/document-list-check.svg',
        percentage: '${s.orderCountDelta}%',
      ),
      QuickAccessItemModel(
        title: S.current.walletBalance,
        value: s.walletBalance.toStringAsFixed(0),
        currency: "assets/images/toman.svg",
        iconPath: 'assets/images/wallet.svg',
      ),
      QuickAccessItemModel(
        title: S.current.cashCommission,
        value: s.activeOrders.toString(),
        currency: "assets/images/toman.svg",
        iconPath: 'assets/images/trend-up.svg',
      ),
    ];
  }

  /// Generates Jalali-based sales spots for the line chart.
  LineChartDataModel _mapLineChartData(List<DailyChartDtoModel> dailyChart) {
    final now = Jalali.now();
    final List<FlSpot> currentMonthSpots = [];

    for (int i = 1; i <= now.day; i++) {
      final dailyData = dailyChart.where((d) {
        try {
          final dJalali = Jalali.fromDateTime(DateTime.parse(d.date));
          return dJalali.year == now.year &&
              dJalali.month == now.month &&
              dJalali.day == i;
        } catch (_) {
          return false;
        }
      });

      final amount = dailyData.isNotEmpty
          ? dailyData.first.totalSalesAmount
          : 0.0;
      currentMonthSpots.add(FlSpot(i.toDouble(), amount));
    }

    return LineChartDataModel(
      line1Data: const [],
      line2Data: currentMonthSpots,
    );
  }

  /// Maps order statuses to localized pie chart items with semantic colors.
  List<PieChartItemModel> _mapOrderStatusChart(List<OrderStatusDtoModel> list) {
    if (list.isEmpty) {
      return [
        PieChartItemModel(
          label: '...',
          value: 1,
          color: AppColors.grayPalette.shade200,
        ),
      ];
    }

    return list.map((s) {
      String label = s.status;
      Color color = AppColors.grayPalette.shade400;

      if (s.status == 'approved') {
        label = S.current.statusApproved;
        color = AppColors.successPalette.shade400;
      } else if (s.status == 'reject' || s.status == 'rejected') {
        label = S.current.statusRejected;
        color = AppColors.errorPalette.shade400;
      } else if (s.status == 'under_review') {
        label = S.current.statusPending;
        color = AppColors.warningPalette.shade400;
      } else if (s.status == 'pre_invoice') {
        label = S.current.preInvoice;
        color = AppColors.brandPalette.shade400;
      } else if (s.status == 'expired') {
        label = S.current.statusExpired;
        color = AppColors.grayPalette.shade400;
      } else if (s.status == 'awaiting_settlement') {
        label = S.current.statusWaitingSettlement;
        color = AppColors.blueGrayPalette.shade400;
      }

      return PieChartItemModel(
        label: label,
        value: s.count.toDouble(),
        color: color,
      );
    }).toList();
  }

  /// Maps categories to pie chart segments.
  List<PieChartItemModel> _mapCategoryChart(List<CategoryChartDtoModel> list) {
    if (list.isEmpty) {
      return [
        PieChartItemModel(
          label: '...',
          value: 1,
          color: AppColors.grayPalette.shade200,
        ),
      ];
    }

    return list.map((c) {
      return PieChartItemModel(
        label: c.categoryName,
        value: c.totalOrders.toDouble(),
        color: AppColors.successPalette.shade400,
      );
    }).toList();
  }

  /// Maps sub-plans to bar chart bars.
  List<BarChartItemModel> _mapSubPlanChart(List<SubPlanChartDtoModel> list) {
    if (list.isEmpty) {
      return [BarChartItemModel(label: '...', value: 0)];
    }

    return list.map((s) {
      return BarChartItemModel(label: s.planName, value: s.totalSalesAmount);
    }).toList();
  }

  /// Centralized handler for repository errors.
  void _handleError(Object e) {
    emit(
      state.copyWith(
        status: DashboardRequestStatus.error,
        errorMessage: e.toString(),
      ),
    );
  }
}
