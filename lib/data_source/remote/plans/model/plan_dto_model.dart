import 'package:freezed_annotation/freezed_annotation.dart';
import '../../catalog/model/product_dto_model.dart'; // Reusing ImageDtoModel

part 'plan_dto_model.freezed.dart';
part 'plan_dto_model.g.dart';

@freezed
class SubPlanListResponse with _$SubPlanListResponse {
  const factory SubPlanListResponse({
    required int count,
    String? next,
    String? previous,
    required List<SubPlanDtoModel> results,
  }) = _SubPlanListResponse;

  factory SubPlanListResponse.fromJson(Map<String, dynamic> json) => _$SubPlanListResponseFromJson(json);
}

@freezed
class SubPlanDtoModel with _$SubPlanDtoModel {
  const factory SubPlanDtoModel({
    required String id,
    @JsonKey(name: 'credit_plan') required CreditPlanSummaryDtoModel creditPlan,
    required String name,
    @JsonKey(name: 'repayment_duration_months') required int repaymentDurationMonths,
    @JsonKey(name: 'is_active') required bool isActive,
  }) = _SubPlanDtoModel;

  factory SubPlanDtoModel.fromJson(Map<String, dynamic> json) => _$SubPlanDtoModelFromJson(json);
}

@freezed
class CreditPlanSummaryDtoModel with _$CreditPlanSummaryDtoModel {
  const factory CreditPlanSummaryDtoModel({
    required String id,
    required String name,
     int? validity_window_days,
    ImageDtoModel? image,
  }) = _CreditPlanSummaryDtoModel;

  factory CreditPlanSummaryDtoModel.fromJson(Map<String, dynamic> json) => _$CreditPlanSummaryDtoModelFromJson(json);
}
