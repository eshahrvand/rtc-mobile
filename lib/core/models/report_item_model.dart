import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_item_model.freezed.dart';
part 'report_item_model.g.dart';

@freezed
class ReportItemModel with _$ReportItemModel {
  const factory ReportItemModel({
    required String id,
    required String title,
    String? subtitle,
    String? sku,
    String? tagLabel,
    String? secondaryLabel,
    String? amount,
    String? secondaryAmount,
    String? date,
    String? time,
    String? quantity,
    String? status,
    String? imageUrl,
    @Default({}) Map<String, dynamic> extra,
  }) = _ReportItemModel;

  factory ReportItemModel.fromJson(Map<String, dynamic> json) =>
      _$ReportItemModelFromJson(json);
}

@freezed
class ReportSummaryMetric with _$ReportSummaryMetric {
  const factory ReportSummaryMetric({
    required String label,
    required String value,
    String? iconPath,
    @Default(false) bool isCurrency,
  }) = _ReportSummaryMetric;

  factory ReportSummaryMetric.fromJson(Map<String, dynamic> json) =>
      _$ReportSummaryMetricFromJson(json);
}
