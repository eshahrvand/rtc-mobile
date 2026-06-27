import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:rtc_mobile/core/enums/order_status.dart';
import 'package:rtc_mobile/core/models/bar_chart_item_model.dart';
import 'package:rtc_mobile/core/models/line_chart_data_model.dart';
import 'package:rtc_mobile/core/models/pie_chart_item_model.dart';
import 'package:rtc_mobile/core/models/quick_access_item_model.dart';
import 'package:rtc_mobile/core/utils/currency_formatter.dart';
import 'package:rtc_mobile/data_source/remote/dashboard/model/dashboard_dto_model.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';

class DashboardMapper {
  static List<QuickAccessItemModel> mapQuickAccessItems(
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
        currency: "assets/images/rial.svg",
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
        value: s.walletBalance.formatCurrency,
        currency: "assets/images/rial.svg",
        iconPath: 'assets/images/wallet.svg',
      ),
      QuickAccessItemModel(
        title: S.current.cashCommission,
        value: c?.commissionAmountCash.formatCurrency ?? '0',
        currency: "assets/images/rial.svg",
        iconPath: 'assets/images/trend-up.svg',
      ),
    ];
  }

  static LineChartDataModel mapLineChartData(
    List<DailyChartDtoModel> dailyChart,
  ) {
    final now = Jalali.now();
    final List<FlSpot> previousMonthSpots = [];
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

      if (dailyData.isNotEmpty) {
        final item = dailyData.first;
        currentMonthSpots.add(FlSpot(i.toDouble(), item.totalSalesAmount));
        previousMonthSpots.add(
          FlSpot(i.toDouble(), item.previousTotalSalesAmount),
        );
      } else {
        currentMonthSpots.add(FlSpot(i.toDouble(), 0));
        previousMonthSpots.add(FlSpot(i.toDouble(), 0));
      }
    }

    return LineChartDataModel(
      line1Data: previousMonthSpots,
      line2Data: currentMonthSpots,
    );
  }

  static List<PieChartItemModel> mapOrderStatusChart(
    List<OrderStatusDtoModel> list,
  ) {
    if (list.isEmpty) return [];

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

      switch (s.orderStatus) {
        case OrderStatus.approved:
          label = S.current.statusApproved;
          color = AppColors.successPalette.shade400;
        case OrderStatus.rejected:
          label = S.current.statusRejected;
          color = AppColors.errorPalette.shade400;
        case OrderStatus.underReview:
          label = S.current.statusPending;
          color = AppColors.warningPalette.shade400;
        case OrderStatus.preInvoice:
          label = S.current.preInvoice;
          color = AppColors.brandPalette.shade400;
        case OrderStatus.expired:
          label = S.current.statusExpired;
          color = AppColors.grayPalette.shade400;
        case OrderStatus.awaitingSettlement:
          label = S.current.statusWaitingSettlement;
          color = AppColors.blueGrayPalette.shade400;
        case OrderStatus.unknown:
          break;
      }

      return PieChartItemModel(
        label: label,
        value: s.count.toDouble(),
        color: color,
      );
    }).toList();
  }

  static List<PieChartItemModel> mapCategoryChart(
    List<CategoryChartDtoModel> list,
  ) {
    if (list.isEmpty) return [];

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

  static List<BarChartItemModel> mapSubPlanChart(
    List<SubPlanChartDtoModel> list,
  ) {
    if (list.isEmpty) return [];

    return list.map((s) {
      return BarChartItemModel(label: s.subPlanName, value: s.totalSalesAmount);
    }).toList();
  }

  static String formatCommissionMessage(CommissionDtoModel c) {
    final distance = c.distanceToNextTier.formatCurrency;
    final nextRateCash = c.nextTierRateCash.toString();
    final nextRateProduct = c.nextTierRateProduct.toString();
    return S.current.commissionMessage(distance, nextRateCash, nextRateProduct);
  }
}
