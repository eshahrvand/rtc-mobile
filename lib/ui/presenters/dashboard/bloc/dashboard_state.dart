import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/models/bar_chart_item_model.dart';
import '../../../../core/models/line_chart_data_model.dart';
import '../../../../core/models/order_model.dart';
import '../../../../core/models/pie_chart_item_model.dart';
import '../../../../core/models/quick_access_item_model.dart';
import '../../../../data_source/remote/dashboard/model/dashboard_dto_model.dart';
import '../../../../data_source/remote/profile/model/user_profile_dto_model.dart';

part 'dashboard_state.freezed.dart';

enum DashboardRequestStatus { initial, loading, success, error }

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
    @Default([]) List<OrderSummaryModel> recentOrders,

    // User Profile
    UserProfileDtoModel? userProfile,

    // Commission
    CommissionDtoModel? commission,

    // App Info
    @Default('') String appVersion,
    @Default('') String buildNumber,
  }) = _DashboardState;
}
