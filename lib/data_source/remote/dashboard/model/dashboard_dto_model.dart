import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/enums/order_status.dart';

part 'dashboard_dto_model.freezed.dart';
part 'dashboard_dto_model.g.dart';

@freezed
class DashboardSummaryDtoModel with _$DashboardSummaryDtoModel {
  const factory DashboardSummaryDtoModel({
    @JsonKey(name: 'wallet_balance', fromJson: _parseStringToDouble) required double walletBalance,
    @JsonKey(name: 'order_count') required int orderCount,
    @JsonKey(name: 'order_count_delta') required int orderCountDelta,
    @JsonKey(name: 'total_sales_amount') required double totalSalesAmount,
    @JsonKey(name: 'total_sales_delta_pct') double? totalSalesDeltaPct,
    @JsonKey(name: 'active_orders') required int activeOrders,
  }) = _DashboardSummaryDtoModel;

  factory DashboardSummaryDtoModel.fromJson(Map<String, dynamic> json) => _$DashboardSummaryDtoModelFromJson(json);
}

double _parseStringToDouble(dynamic value) {
  if (value == null) return 0.0;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0.0;
  return 0.0;
}

@freezed
class WalletStatusDtoModel with _$WalletStatusDtoModel {
  const factory WalletStatusDtoModel({
    required String bucket,
    required int count,
    required double percentage,
  }) = _WalletStatusDtoModel;

  factory WalletStatusDtoModel.fromJson(Map<String, dynamic> json) => _$WalletStatusDtoModelFromJson(json);
}

@freezed
class DailyChartDtoModel with _$DailyChartDtoModel {
  const factory DailyChartDtoModel({
    required String date,
    @JsonKey(name: 'total_sales_amount') required double totalSalesAmount,
  }) = _DailyChartDtoModel;

  factory DailyChartDtoModel.fromJson(Map<String, dynamic> json) => _$DailyChartDtoModelFromJson(json);
}

@freezed
class CategoryChartDtoModel with _$CategoryChartDtoModel {
  const factory CategoryChartDtoModel({
    @JsonKey(name: 'category_id') required String categoryId,
    @JsonKey(name: 'category_name') required String categoryName,
    @JsonKey(name: 'total_orders') required int totalOrders,
    @JsonKey(name: 'total_sales_amount') required double totalSalesAmount,
    required double percentage,
  }) = _CategoryChartDtoModel;

  factory CategoryChartDtoModel.fromJson(Map<String, dynamic> json) => _$CategoryChartDtoModelFromJson(json);
}

@freezed
class OrderStatusDtoModel with _$OrderStatusDtoModel {
  const OrderStatusDtoModel._();
  const factory OrderStatusDtoModel({
    required String status,
    required int count,
  }) = _OrderStatusDtoModel;

  OrderStatus get orderStatus => OrderStatus.fromString(status);

  factory OrderStatusDtoModel.fromJson(Map<String, dynamic> json) => _$OrderStatusDtoModelFromJson(json);
}

@freezed
class SubPlanChartDtoModel with _$SubPlanChartDtoModel {
  const factory SubPlanChartDtoModel({
    @JsonKey(name: 'sub_plan_id') required String subPlanId,
    @JsonKey(name: 'plan_name') required String planName,
    @JsonKey(name: 'sub_plan_duration') required int subPlanDuration,
    @JsonKey(name: 'order_count') required int orderCount,
    @JsonKey(name: 'total_sales_amount') required double totalSalesAmount,
  }) = _SubPlanChartDtoModel;

  factory SubPlanChartDtoModel.fromJson(Map<String, dynamic> json) => _$SubPlanChartDtoModelFromJson(json);
}

@freezed
class CommissionDtoModel with _$CommissionDtoModel {
  const factory CommissionDtoModel({
    @JsonKey(name: 'monthly_sales_total') required double monthlySalesTotal,
    @JsonKey(name: 'commission_rate') required int commissionRate,
    @JsonKey(name: 'commission_amount') required double commissionAmount,
    @JsonKey(name: 'next_tier_rate') required int nextTierRate,
    @JsonKey(name: 'distance_to_next_tier') required double distanceToNextTier,
  }) = _CommissionDtoModel;

  factory CommissionDtoModel.fromJson(Map<String, dynamic> json) => _$CommissionDtoModelFromJson(json);
}
