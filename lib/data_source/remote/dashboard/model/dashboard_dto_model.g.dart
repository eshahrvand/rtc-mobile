// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_dto_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DashboardSummaryDtoModelImpl _$$DashboardSummaryDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$DashboardSummaryDtoModelImpl(
  walletBalance: _parseStringToDouble(json['wallet_balance']),
  orderCount: (json['order_count'] as num).toInt(),
  orderCountDelta: (json['order_count_delta'] as num).toInt(),
  totalSalesAmount: (json['total_sales_amount'] as num).toDouble(),
  totalSalesDeltaPct: (json['total_sales_delta_pct'] as num?)?.toDouble(),
  activeOrders: (json['active_orders'] as num).toInt(),
);

Map<String, dynamic> _$$DashboardSummaryDtoModelImplToJson(
  _$DashboardSummaryDtoModelImpl instance,
) => <String, dynamic>{
  'wallet_balance': instance.walletBalance,
  'order_count': instance.orderCount,
  'order_count_delta': instance.orderCountDelta,
  'total_sales_amount': instance.totalSalesAmount,
  'total_sales_delta_pct': instance.totalSalesDeltaPct,
  'active_orders': instance.activeOrders,
};

_$WalletStatusDtoModelImpl _$$WalletStatusDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$WalletStatusDtoModelImpl(
  bucket: json['bucket'] as String,
  count: (json['count'] as num).toInt(),
  percentage: (json['percentage'] as num).toDouble(),
);

Map<String, dynamic> _$$WalletStatusDtoModelImplToJson(
  _$WalletStatusDtoModelImpl instance,
) => <String, dynamic>{
  'bucket': instance.bucket,
  'count': instance.count,
  'percentage': instance.percentage,
};

_$DailyChartDtoModelImpl _$$DailyChartDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$DailyChartDtoModelImpl(
  date: json['date'] as String,
  totalSalesAmount: (json['total_sales_amount'] as num).toDouble(),
  previousTotalSalesAmount: (json['previous_total_sales_amount'] as num)
      .toDouble(),
);

Map<String, dynamic> _$$DailyChartDtoModelImplToJson(
  _$DailyChartDtoModelImpl instance,
) => <String, dynamic>{
  'date': instance.date,
  'total_sales_amount': instance.totalSalesAmount,
  'previous_total_sales_amount': instance.previousTotalSalesAmount,
};

_$CategoryChartDtoModelImpl _$$CategoryChartDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$CategoryChartDtoModelImpl(
  categoryId: json['category_id'] as String,
  categoryName: json['category_name'] as String,
  totalOrders: (json['total_orders'] as num).toInt(),
  totalSalesAmount: (json['total_sales_amount'] as num).toDouble(),
  percentage: (json['percentage'] as num).toDouble(),
);

Map<String, dynamic> _$$CategoryChartDtoModelImplToJson(
  _$CategoryChartDtoModelImpl instance,
) => <String, dynamic>{
  'category_id': instance.categoryId,
  'category_name': instance.categoryName,
  'total_orders': instance.totalOrders,
  'total_sales_amount': instance.totalSalesAmount,
  'percentage': instance.percentage,
};

_$OrderStatusDtoModelImpl _$$OrderStatusDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$OrderStatusDtoModelImpl(
  status: json['status'] as String,
  count: (json['count'] as num).toInt(),
);

Map<String, dynamic> _$$OrderStatusDtoModelImplToJson(
  _$OrderStatusDtoModelImpl instance,
) => <String, dynamic>{'status': instance.status, 'count': instance.count};

_$SubPlanChartDtoModelImpl _$$SubPlanChartDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$SubPlanChartDtoModelImpl(
  subPlanId: json['sub_plan_id'] as String,
  planName: json['plan_name'] as String,
  subPlanName: json['sub_plan_name'] as String,
  subPlanDuration: (json['sub_plan_duration'] as num).toInt(),
  orderCount: (json['order_count'] as num).toInt(),
  totalSalesAmount: (json['total_sales_amount'] as num).toDouble(),
);

Map<String, dynamic> _$$SubPlanChartDtoModelImplToJson(
  _$SubPlanChartDtoModelImpl instance,
) => <String, dynamic>{
  'sub_plan_id': instance.subPlanId,
  'plan_name': instance.planName,
  'sub_plan_name': instance.subPlanName,
  'sub_plan_duration': instance.subPlanDuration,
  'order_count': instance.orderCount,
  'total_sales_amount': instance.totalSalesAmount,
};

_$CommissionDtoModelImpl _$$CommissionDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$CommissionDtoModelImpl(
  monthlySalesTotal: (json['monthly_sales_total'] as num).toDouble(),
  commissionRateCash: (json['commission_rate_cash'] as num).toInt(),
  commissionRateProduct: (json['commission_rate_product'] as num).toInt(),
  commissionAmountCash: (json['commission_amount_cash'] as num).toDouble(),
  commissionAmountProduct: (json['commission_amount_product'] as num)
      .toDouble(),
  nextTierRateCash: (json['next_tier_rate_cash'] as num).toInt(),
  nextTierRateProduct: (json['next_tier_rate_product'] as num).toInt(),
  distanceToNextTier: (json['distance_to_next_tier'] as num).toDouble(),
);

Map<String, dynamic> _$$CommissionDtoModelImplToJson(
  _$CommissionDtoModelImpl instance,
) => <String, dynamic>{
  'monthly_sales_total': instance.monthlySalesTotal,
  'commission_rate_cash': instance.commissionRateCash,
  'commission_rate_product': instance.commissionRateProduct,
  'commission_amount_cash': instance.commissionAmountCash,
  'commission_amount_product': instance.commissionAmountProduct,
  'next_tier_rate_cash': instance.nextTierRateCash,
  'next_tier_rate_product': instance.nextTierRateProduct,
  'distance_to_next_tier': instance.distanceToNextTier,
};
