import 'package:freezed_annotation/freezed_annotation.dart';
import '../../plans/model/plan_dto_model.dart';

part 'wallet_dto_model.freezed.dart';
part 'wallet_dto_model.g.dart';

@freezed
class WalletDtoModel with _$WalletDtoModel {
  const factory WalletDtoModel({
    required String id,
    @JsonKey(fromJson: _parseStringToDouble) required double balance,
    @JsonKey(name: 'credit_limit', fromJson: _parseStringToDouble) required double creditLimit,
    @JsonKey(name: 'remaining_credit', fromJson: _parseStringToDouble) required double remainingCredit,
    required List<PocketDtoModel> pockets,
  }) = _WalletDtoModel;

  factory WalletDtoModel.fromJson(Map<String, dynamic> json) => _$WalletDtoModelFromJson(json);
}

@freezed
class PocketDtoModel with _$PocketDtoModel {
  const factory PocketDtoModel({
    required String id,
    @JsonKey(name: 'sub_plan') required WalletSubPlanDtoModel subPlan,
    @JsonKey(fromJson: _parseStringToDouble) required double balance,
    @JsonKey(name: 'created_at') required String createdAt,
  }) = _PocketDtoModel;

  factory PocketDtoModel.fromJson(Map<String, dynamic> json) => _$PocketDtoModelFromJson(json);
}

@freezed
class WalletSubPlanDtoModel with _$WalletSubPlanDtoModel {
  const factory WalletSubPlanDtoModel({
    required String id,
    required String name,
    @JsonKey(name: 'repayment_duration_months') required int repaymentDurationMonths,
    @JsonKey(name: 'credit_plan') CreditPlanSummaryDtoModel? creditPlan,
  }) = _WalletSubPlanDtoModel;

  factory WalletSubPlanDtoModel.fromJson(Map<String, dynamic> json) => _$WalletSubPlanDtoModelFromJson(json);
}

double _parseStringToDouble(dynamic value) {
  if (value == null) return 0.0;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0.0;
  return 0.0;
}
