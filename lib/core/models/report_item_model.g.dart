// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReportItemModelImpl _$$ReportItemModelImplFromJson(
  Map<String, dynamic> json,
) => _$ReportItemModelImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  subtitle: json['subtitle'] as String?,
  sku: json['sku'] as String?,
  tagLabel: json['tagLabel'] as String?,
  secondaryLabel: json['secondaryLabel'] as String?,
  amount: json['amount'] as String?,
  secondaryAmount: json['secondaryAmount'] as String?,
  date: json['date'] as String?,
  time: json['time'] as String?,
  quantity: json['quantity'] as String?,
  status: json['status'] as String?,
  imageUrl: json['imageUrl'] as String?,
  extra: json['extra'] as Map<String, dynamic>? ?? const {},
);

Map<String, dynamic> _$$ReportItemModelImplToJson(
  _$ReportItemModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'subtitle': instance.subtitle,
  'sku': instance.sku,
  'tagLabel': instance.tagLabel,
  'secondaryLabel': instance.secondaryLabel,
  'amount': instance.amount,
  'secondaryAmount': instance.secondaryAmount,
  'date': instance.date,
  'time': instance.time,
  'quantity': instance.quantity,
  'status': instance.status,
  'imageUrl': instance.imageUrl,
  'extra': instance.extra,
};

_$ReportSummaryMetricImpl _$$ReportSummaryMetricImplFromJson(
  Map<String, dynamic> json,
) => _$ReportSummaryMetricImpl(
  label: json['label'] as String,
  value: json['value'] as String,
  iconPath: json['iconPath'] as String?,
  isCurrency: json['isCurrency'] as bool? ?? false,
);

Map<String, dynamic> _$$ReportSummaryMetricImplToJson(
  _$ReportSummaryMetricImpl instance,
) => <String, dynamic>{
  'label': instance.label,
  'value': instance.value,
  'iconPath': instance.iconPath,
  'isCurrency': instance.isCurrency,
};
