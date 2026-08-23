// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WalletSummaryModelImpl _$$WalletSummaryModelImplFromJson(
  Map<String, dynamic> json,
) => _$WalletSummaryModelImpl(
  totalBalance: json['totalBalance'] as String,
  totalBalanceRaw: (json['totalBalanceRaw'] as num?)?.toDouble() ?? 0.0,
  totalCredit: json['totalCredit'] as String,
  remainingCredit: json['remainingCredit'] as String,
  pockets: (json['pockets'] as List<dynamic>)
      .map((e) => PocketModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$WalletSummaryModelImplToJson(
  _$WalletSummaryModelImpl instance,
) => <String, dynamic>{
  'totalBalance': instance.totalBalance,
  'totalBalanceRaw': instance.totalBalanceRaw,
  'totalCredit': instance.totalCredit,
  'remainingCredit': instance.remainingCredit,
  'pockets': instance.pockets,
};

_$PocketModelImpl _$$PocketModelImplFromJson(Map<String, dynamic> json) =>
    _$PocketModelImpl(
      id: json['id'] as String,
      bankName: json['bankName'] as String,
      planName: json['planName'] as String,
      balance: json['balance'] as String,
      balanceRaw: (json['balanceRaw'] as num?)?.toDouble() ?? 0.0,
      logoPath: json['logoPath'] as String,
    );

Map<String, dynamic> _$$PocketModelImplToJson(_$PocketModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bankName': instance.bankName,
      'planName': instance.planName,
      'balance': instance.balance,
      'balanceRaw': instance.balanceRaw,
      'logoPath': instance.logoPath,
    };

_$TransactionModelImpl _$$TransactionModelImplFromJson(
  Map<String, dynamic> json,
) => _$TransactionModelImpl(
  id: json['id'] as String,
  type: json['type'] as String,
  amount: json['amount'] as String,
  date: json['date'] as String,
  time: json['time'] as String,
  isCredit: json['isCredit'] as bool,
  fromAccount: json['fromAccount'] as String,
  toAccount: json['toAccount'] as String,
);

Map<String, dynamic> _$$TransactionModelImplToJson(
  _$TransactionModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'amount': instance.amount,
  'date': instance.date,
  'time': instance.time,
  'isCredit': instance.isCredit,
  'fromAccount': instance.fromAccount,
  'toAccount': instance.toAccount,
};
