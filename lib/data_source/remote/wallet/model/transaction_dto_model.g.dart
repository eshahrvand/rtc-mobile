// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_dto_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionResponseDtoModelImpl _$$TransactionResponseDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$TransactionResponseDtoModelImpl(
  count: (json['count'] as num).toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>)
      .map((e) => TransactionDtoModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$TransactionResponseDtoModelImplToJson(
  _$TransactionResponseDtoModelImpl instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results,
};

_$TransactionDtoModelImpl _$$TransactionDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$TransactionDtoModelImpl(
  id: json['id'] as String,
  orderId: json['order_id'] as String?,
  amount: json['amount'] as String,
  transactionType: json['transaction_type'] as String,
  subPlan: json['sub_plan'] == null
      ? null
      : WalletSubPlanDtoModel.fromJson(
          json['sub_plan'] as Map<String, dynamic>,
        ),
  customer: json['customer'] == null
      ? null
      : CustomerShortDtoModel.fromJson(
          json['customer'] as Map<String, dynamic>,
        ),
  createdAt: json['created_at'] as String,
  pocketBalanceAfter: json['pocket_balance_after'] as String?,
);

Map<String, dynamic> _$$TransactionDtoModelImplToJson(
  _$TransactionDtoModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'order_id': instance.orderId,
  'amount': instance.amount,
  'transaction_type': instance.transactionType,
  'sub_plan': instance.subPlan,
  'customer': instance.customer,
  'created_at': instance.createdAt,
  'pocket_balance_after': instance.pocketBalanceAfter,
};

_$CustomerShortDtoModelImpl _$$CustomerShortDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$CustomerShortDtoModelImpl(
  id: json['id'] as String,
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String,
);

Map<String, dynamic> _$$CustomerShortDtoModelImplToJson(
  _$CustomerShortDtoModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
};
