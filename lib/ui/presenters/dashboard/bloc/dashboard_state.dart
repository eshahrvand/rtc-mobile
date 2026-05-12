import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../data/models/quick_access_item_model.dart';
import '../../../../data/models/pie_chart_item_model.dart';
import '../../../../data/models/line_chart_data_model.dart';
import '../../../../data/models/bar_chart_item_model.dart';
import '../../../../data/models/order_item_model.dart';

part 'dashboard_state.freezed.dart';

enum DashboardRequestStatus {
  initial,
  loading,
  success,
  error,
}

@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState({
    @Default(DashboardRequestStatus.initial) DashboardRequestStatus status,
    @Default('') String errorMessage,
    @Default(0) int selectedNavIndex,

    // Quick access data
    @Default([]) List<QuickAccessItemModel> quickAccessItems,

    // Message card
    @Default('') String messageText,
    @Default('') String messageIconPath,

    // Line chart
    @Default([]) List<LineChartDataModel> lineChartData,

    // Pie charts
    @Default([]) List<PieChartItemModel> pieChart1Data,
    @Default('') String pieChart1Title,
    @Default([]) List<PieChartItemModel> pieChart2Data,
    @Default('') String pieChart2Title,

    // Bar chart
    @Default([]) List<BarChartItemModel> barChartData,
    @Default('') String barChartTitle,

    // Recent orders
    @Default([]) List<OrderItemModel> recentOrders,
  }) = _DashboardState;
}
