import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../../../../data/models/bar_chart_item_model.dart';
import '../../../../data/models/line_chart_data_model.dart';
import '../../../../data/models/pie_chart_item_model.dart';
import '../../../../data/models/quick_access_item_model.dart';
import '../../../../data_source/remote/dashboard/model/dashboard_dto_model.dart';
import '../../../../core/enums/order_status.dart';
import '../../../../repository/dashboard/dashboard_repository.dart';
import '../../../../repository/orders/orders_repository.dart';
import '../../../../locator.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../theme/colors.dart';
import 'dashboard_state.dart';
import '../../../../data/models/order_model.dart';
import '../../../../core/utils/network_helper.dart';


class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({int initialIndex = 0})
    : super(DashboardState(selectedNavIndex: initialIndex));

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
          _handleError(e);
        });
  }


  void onNavItemSelected(int index) {
    emit(state.copyWith(selectedNavIndex: index));
  }


  void _loadDashboardData() {
    Future.wait([
          _dashboardRepo.getSummary(),
          _dashboardRepo.getDailyChart(),
          _dashboardRepo.getCategories(),
          _dashboardRepo.getSubPlanChart(),
          _ordersRepo.getOrders(page: 1, pageSize: 5),
          _dashboardRepo.getOrderStatus(),
          _dashboardRepo.getCommission(),
        ])
        .then<void>((results) {
          final summary = results[0] as DashboardSummaryDtoModel;
          final dailyChart = results[1] as List<DailyChartDtoModel>;
          final categories = results[2] as List<CategoryChartDtoModel>;
          final subplans = results[3] as List<SubPlanChartDtoModel>;
          final orders = results[4] as List<OrderSummaryModel>;
          final orderStatuses = results[5] as List<OrderStatusDtoModel>;
          final commission = results[6] as CommissionDtoModel;

          emit(
            state.copyWith(
              status: DashboardRequestStatus.success,
              quickAccessItems: _mapQuickAccessItems(summary, commission),
              lineChartData: [_mapLineChartData(dailyChart)],
              pieChart1Title: S.current.orderStatusChartTitle,
              pieChart1Data: _mapOrderStatusChart(orderStatuses),
              pieChart2Title: S.current.salesByCategoryChartTitle,
              pieChart2Data: _mapCategoryChart(categories),
              barChartTitle: S.current.plansSalesChartTitle,
              barChartData: _mapSubPlanChart(subplans),
              recentOrders: orders,
              commission: commission,
              messageText: _formatCommissionMessage(commission),
              messageIconPath: 'assets/images/alert.svg',
            ),
          );
        })
        .catchError((e) => _handleError(e));
  }


  List<QuickAccessItemModel> _mapQuickAccessItems(
    DashboardSummaryDtoModel s,
    CommissionDtoModel? c,
  ) {
    String formatDelta(double? deltaPct) {
      if (deltaPct == null) return '0%';
      final prefix = (deltaPct < 0) ? '\u200E' : '';
      return '$prefix${deltaPct.toStringAsFixed(0)}%';
    }

    double calculatePercentage(int current, int delta) {
      final previous = current - delta;
      if (previous <= 0) return delta > 0 ? 100.0 : 0.0;
      return (delta / previous) * 100;
    }

    return [
      QuickAccessItemModel(
        title: S.current.monthlySales,
        value: s.totalSalesAmount.toStringAsFixed(0),
        currency: "assets/images/toman.svg",
        iconPath: 'assets/images/dollar.svg',
        percentage: formatDelta(s.totalSalesDeltaPct),
      ),
      QuickAccessItemModel(
        title: S.current.approvedOrders,
        value: s.orderCount.toString(),
        currency: "",
        iconPath: 'assets/images/document-list-check.svg',
        percentage: formatDelta(
          calculatePercentage(s.orderCount, s.orderCountDelta),
        ),
      ),
      QuickAccessItemModel(
        title: S.current.walletBalance,
        value: s.walletBalance.toStringAsFixed(0).formatCurrency,
        currency: "assets/images/toman.svg",
        iconPath: 'assets/images/wallet.svg',
      ),
      QuickAccessItemModel(
        title: S.current.cashCommission,
        value: c?.commissionAmountCash.toStringAsFixed(0).formatCurrency ?? '0',
        currency: "assets/images/toman.svg",
        iconPath: 'assets/images/trend-up.svg',
      ),
    ];
  }


  LineChartDataModel _mapLineChartData(List<DailyChartDtoModel> dailyChart) {
    final now = Jalali.now();
    final List<FlSpot> currentMonthSpots = [];

    for (int i = 1; i <= now.day; i++) {
      final dailyData = dailyChart.where((d) {
        try {
          final localDateTime = DateTime.parse(d.date).toLocal();
          final dJalali = Jalali.fromDateTime(localDateTime);
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


    final orderWeights = {
      OrderStatus.approved: 1,
      OrderStatus.underReview: 2,
      OrderStatus.awaitingSettlement: 3,
      OrderStatus.preInvoice: 4,
      OrderStatus.rejected: 5,
      OrderStatus.expired: 6,
    };

    final sortedList = List<OrderStatusDtoModel>.from(list);
    sortedList.sort((a, b) {
      final weightA = orderWeights[a.orderStatus] ?? 99;
      final weightB = orderWeights[b.orderStatus] ?? 99;
      return weightA.compareTo(weightB);
    });

    return sortedList.map((s) {
      String label = s.status;
      Color color = AppColors.grayPalette.shade400;

      final orderStatus = s.orderStatus;

      if (orderStatus == OrderStatus.approved) {
        label = S.current.statusApproved;
        color = AppColors.successPalette.shade400;
      } else if (orderStatus == OrderStatus.rejected) {
        label = S.current.statusRejected;
        color = AppColors.errorPalette.shade400;
      } else if (orderStatus == OrderStatus.underReview) {
        label = S.current.statusPending;
        color = AppColors.warningPalette.shade400;
      } else if (orderStatus == OrderStatus.preInvoice) {
        label = S.current.preInvoice;
        color = AppColors.brandPalette.shade400;
      } else if (orderStatus == OrderStatus.expired) {
        label = S.current.statusExpired;
        color = AppColors.grayPalette.shade400;
      } else if (orderStatus == OrderStatus.awaitingSettlement) {
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

    final sortedList = List<CategoryChartDtoModel>.from(list);
    sortedList.sort((a, b) => b.totalOrders.compareTo(a.totalOrders));

    final List<Color> palette = [
      AppColors.brandPalette.shade400,
      AppColors.successPalette.shade400,
      AppColors.warningPalette.shade400,
      AppColors.errorPalette.shade400,
      AppColors.purplePalette.shade400,
      AppColors.orangePalette.shade400,
      AppColors.indigoPalette.shade400,
      AppColors.pinkPalette.shade400,
    ];

    return sortedList.asMap().entries.map((entry) {
      final index = entry.key;
      final c = entry.value;
      return PieChartItemModel(
        label: c.categoryName,
        value: c.totalOrders.toDouble(),
        color: palette[index % palette.length],
      );
    }).toList();
  }


  List<BarChartItemModel> _mapSubPlanChart(List<SubPlanChartDtoModel> list) {
    if (list.isEmpty) {
      return [BarChartItemModel(label: '...', value: 0)];
    }

    return list.map((s) {
      return BarChartItemModel(label: s.subPlanName, value: s.totalSalesAmount);
    }).toList();
  }


  String _formatCommissionMessage(CommissionDtoModel c) {
    final distance = c.distanceToNextTier.toStringAsFixed(0).formatCurrency;
    final nextRateCash = c.nextTierRateCash;
    final nextRateProduct = c.nextTierRateProduct;
    return "با فروش $distance تومان دیگر پورسانت شما به $nextRateCash٪ نقدی و یا $nextRateProduct٪ کالایی افزایش می‌یابد.";
  }


  void _handleError(Object e) {
    if (isClosed) return;

    NetworkHelper.getNetworkErrorMessage().then((networkMessage) {
      if (isClosed) return;

      final finalMessage = networkMessage ?? e.toString();

      emit(
        state.copyWith(
          status: DashboardRequestStatus.error,
          errorMessage: finalMessage,
        ),
      );
    });
  }
}
