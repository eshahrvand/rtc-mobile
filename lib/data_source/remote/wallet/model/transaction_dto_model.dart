import 'package:freezed_annotation/freezed_annotation.dart';
import 'wallet_dto_model.dart';

part 'transaction_dto_model.freezed.dart';
part 'transaction_dto_model.g.dart';

@freezed
class TransactionResponseDtoModel with _$TransactionResponseDtoModel {
  const factory TransactionResponseDtoModel({
    required int count,
    String? next,
    String? previous,
    required List<TransactionDtoModel> results,
  }) = _TransactionResponseDtoModel;

  factory TransactionResponseDtoModel.fromJson(Map<String, dynamic> json) => _$TransactionResponseDtoModelFromJson(json);
}

@freezed
class TransactionDtoModel with _$TransactionDtoModel {
  const factory TransactionDtoModel({
    required String id,
    @JsonKey(name: 'order_id') String? orderId,
    required String amount,
    @JsonKey(name: 'transaction_type') required String transactionType,
    @JsonKey(name: 'sub_plan') WalletSubPlanDtoModel? subPlan,
    CustomerShortDtoModel? customer,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'pocket_balance_after') String? pocketBalanceAfter,
  }) = _TransactionDtoModel;

  factory TransactionDtoModel.fromJson(Map<String, dynamic> json) => _$TransactionDtoModelFromJson(json);
}

@freezed
class CustomerShortDtoModel with _$CustomerShortDtoModel {
  const factory CustomerShortDtoModel({
    required String id,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
  }) = _CustomerShortDtoModel;

  factory CustomerShortDtoModel.fromJson(Map<String, dynamic> json) => _$CustomerShortDtoModelFromJson(json);
}
