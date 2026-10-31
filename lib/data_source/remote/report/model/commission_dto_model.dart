// Freezed copies these constructor annotations to the generated fields.
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'commission_dto_model.freezed.dart';
part 'commission_dto_model.g.dart';

@freezed
class CommissionReportResponse with _$CommissionReportResponse {
  const factory CommissionReportResponse({
    required int count,
    String? next,
    String? previous,
    required List<CommissionEntryDtoModel> results,
  }) = _CommissionReportResponse;

  factory CommissionReportResponse.fromJson(Map<String, dynamic> json) =>
      _$CommissionReportResponseFromJson(json);
}

@freezed
class CommissionEntryDtoModel with _$CommissionEntryDtoModel {
  const factory CommissionEntryDtoModel({
    required String id,
    @JsonKey(name: 'order_total') required double orderTotal,
    @JsonKey(name: 'approved_at') String? approvedAt,
    @JsonKey(name: 'disbursed_at') String? disbursedAt,
    @JsonKey(name: 'customer_first_name') String? customerFirstName,
    @JsonKey(name: 'customer_last_name') String? customerLastName,
    @JsonKey(name: 'plan_name') String? planName,
    @JsonKey(name: 'sub_plan_duration') int? subPlanDuration,
  }) = _CommissionEntryDtoModel;

  factory CommissionEntryDtoModel.fromJson(Map<String, dynamic> json) =>
      _$CommissionEntryDtoModelFromJson(json);
}

@freezed
class CommissionSummaryDtoModel with _$CommissionSummaryDtoModel {
  const factory CommissionSummaryDtoModel({
    required int year,
    required int month,
    @JsonKey(name: 'monthly_sales_total') required double monthlySalesTotal,
    @JsonKey(name: 'commission_rate_cash') required double commissionRateCash,
    @JsonKey(name: 'commission_rate_product')
    required double commissionRateProduct,
    @JsonKey(name: 'commission_amount_cash')
    required double commissionAmountCash,
    @JsonKey(name: 'commission_amount_product')
    required double commissionAmountProduct,
    @JsonKey(name: 'next_tier_rate_cash') required double nextTierRateCash,
    @JsonKey(name: 'next_tier_rate_product')
    required double nextTierRateProduct,
    @JsonKey(name: 'distance_to_next_tier') required double distanceToNextTier,
  }) = _CommissionSummaryDtoModel;

  factory CommissionSummaryDtoModel.fromJson(Map<String, dynamic> json) =>
      _$CommissionSummaryDtoModelFromJson(json);
}
