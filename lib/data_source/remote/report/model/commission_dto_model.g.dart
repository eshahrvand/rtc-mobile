// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commission_dto_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommissionReportResponseImpl _$$CommissionReportResponseImplFromJson(
  Map<String, dynamic> json,
) => _$CommissionReportResponseImpl(
  count: (json['count'] as num).toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>)
      .map((e) => CommissionEntryDtoModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$CommissionReportResponseImplToJson(
  _$CommissionReportResponseImpl instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results,
};

_$CommissionEntryDtoModelImpl _$$CommissionEntryDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$CommissionEntryDtoModelImpl(
  id: json['id'] as String,
  orderTotal: (json['order_total'] as num).toDouble(),
  approvedAt: json['approved_at'] as String?,
  disbursedAt: json['disbursed_at'] as String?,
  customerFirstName: json['customer_first_name'] as String?,
  customerLastName: json['customer_last_name'] as String?,
  planName: json['plan_name'] as String?,
  subPlanDuration: (json['sub_plan_duration'] as num?)?.toInt(),
);

Map<String, dynamic> _$$CommissionEntryDtoModelImplToJson(
  _$CommissionEntryDtoModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'order_total': instance.orderTotal,
  'approved_at': instance.approvedAt,
  'disbursed_at': instance.disbursedAt,
  'customer_first_name': instance.customerFirstName,
  'customer_last_name': instance.customerLastName,
  'plan_name': instance.planName,
  'sub_plan_duration': instance.subPlanDuration,
};

_$CommissionSummaryDtoModelImpl _$$CommissionSummaryDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$CommissionSummaryDtoModelImpl(
  year: (json['year'] as num).toInt(),
  month: (json['month'] as num).toInt(),
  monthlySalesTotal: (json['monthly_sales_total'] as num).toDouble(),
  commissionRateCash: (json['commission_rate_cash'] as num).toDouble(),
  commissionRateProduct: (json['commission_rate_product'] as num).toDouble(),
  commissionAmountCash: (json['commission_amount_cash'] as num).toDouble(),
  commissionAmountProduct: (json['commission_amount_product'] as num)
      .toDouble(),
  nextTierRateCash: (json['next_tier_rate_cash'] as num).toDouble(),
  nextTierRateProduct: (json['next_tier_rate_product'] as num).toDouble(),
  distanceToNextTier: (json['distance_to_next_tier'] as num).toDouble(),
);

Map<String, dynamic> _$$CommissionSummaryDtoModelImplToJson(
  _$CommissionSummaryDtoModelImpl instance,
) => <String, dynamic>{
  'year': instance.year,
  'month': instance.month,
  'monthly_sales_total': instance.monthlySalesTotal,
  'commission_rate_cash': instance.commissionRateCash,
  'commission_rate_product': instance.commissionRateProduct,
  'commission_amount_cash': instance.commissionAmountCash,
  'commission_amount_product': instance.commissionAmountProduct,
  'next_tier_rate_cash': instance.nextTierRateCash,
  'next_tier_rate_product': instance.nextTierRateProduct,
  'distance_to_next_tier': instance.distanceToNextTier,
};
