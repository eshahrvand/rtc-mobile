// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_dto_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WalletDtoModelImpl _$$WalletDtoModelImplFromJson(Map<String, dynamic> json) =>
    _$WalletDtoModelImpl(
      id: json['id'] as String,
      balance: _parseStringToDouble(json['balance']),
      creditLimit: _parseStringToDouble(json['credit_limit']),
      remainingCredit: _parseStringToDouble(json['remaining_credit']),
      pockets: (json['pockets'] as List<dynamic>)
          .map((e) => PocketDtoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$WalletDtoModelImplToJson(
  _$WalletDtoModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'balance': instance.balance,
  'credit_limit': instance.creditLimit,
  'remaining_credit': instance.remainingCredit,
  'pockets': instance.pockets,
};

_$PocketDtoModelImpl _$$PocketDtoModelImplFromJson(Map<String, dynamic> json) =>
    _$PocketDtoModelImpl(
      id: json['id'] as String,
      subPlan: WalletSubPlanDtoModel.fromJson(
        json['sub_plan'] as Map<String, dynamic>,
      ),
      balance: _parseStringToDouble(json['balance']),
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$$PocketDtoModelImplToJson(
  _$PocketDtoModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'sub_plan': instance.subPlan,
  'balance': instance.balance,
  'created_at': instance.createdAt,
};

_$WalletSubPlanDtoModelImpl _$$WalletSubPlanDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$WalletSubPlanDtoModelImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  repaymentDurationMonths: (json['repayment_duration_months'] as num).toInt(),
  creditPlan: json['credit_plan'] == null
      ? null
      : CreditPlanSummaryDtoModel.fromJson(
          json['credit_plan'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$$WalletSubPlanDtoModelImplToJson(
  _$WalletSubPlanDtoModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'repayment_duration_months': instance.repaymentDurationMonths,
  'credit_plan': instance.creditPlan,
};
