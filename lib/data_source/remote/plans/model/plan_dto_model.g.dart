// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_dto_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubPlanListResponseImpl _$$SubPlanListResponseImplFromJson(
  Map<String, dynamic> json,
) => _$SubPlanListResponseImpl(
  count: (json['count'] as num).toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>)
      .map((e) => SubPlanDtoModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$SubPlanListResponseImplToJson(
  _$SubPlanListResponseImpl instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results,
};

_$SubPlanDtoModelImpl _$$SubPlanDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$SubPlanDtoModelImpl(
  id: json['id'] as String,
  creditPlan: CreditPlanSummaryDtoModel.fromJson(
    json['credit_plan'] as Map<String, dynamic>,
  ),
  name: json['name'] as String,
  repaymentDurationMonths: (json['repayment_duration_months'] as num).toInt(),
  isActive: json['is_active'] as bool,
);

Map<String, dynamic> _$$SubPlanDtoModelImplToJson(
  _$SubPlanDtoModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'credit_plan': instance.creditPlan,
  'name': instance.name,
  'repayment_duration_months': instance.repaymentDurationMonths,
  'is_active': instance.isActive,
};

_$CreditPlanSummaryDtoModelImpl _$$CreditPlanSummaryDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$CreditPlanSummaryDtoModelImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  validity_window_days: (json['validity_window_days'] as num?)?.toInt(),
  image: json['image'] == null
      ? null
      : ImageDtoModel.fromJson(json['image'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$CreditPlanSummaryDtoModelImplToJson(
  _$CreditPlanSummaryDtoModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'validity_window_days': instance.validity_window_days,
  'image': instance.image,
};
