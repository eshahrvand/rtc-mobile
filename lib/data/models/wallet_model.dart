import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_model.freezed.dart';
part 'wallet_model.g.dart';

@freezed
class WalletSummaryModel with _$WalletSummaryModel {
  const factory WalletSummaryModel({
    required String totalBalance,
    required String totalCredit,
    required String remainingCredit,
    required List<PocketModel> pockets,
  }) = _WalletSummaryModel;

  factory WalletSummaryModel.fromJson(Map<String, dynamic> json) => _$WalletSummaryModelFromJson(json);
}

@freezed
class PocketModel with _$PocketModel {
  const factory PocketModel({
    required String id,
    required String bankName,
    required String planName,
    required String balance,
    required String logoPath,
  }) = _PocketModel;

  factory PocketModel.fromJson(Map<String, dynamic> json) => _$PocketModelFromJson(json);
}

@freezed
class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    required String id,
    required String type, // e.g., 'واریز', 'برداشت'
    required String amount,
    required String date,
    required String time,
    required bool isCredit, // true for deposit, false for withdrawal
    required String fromAccount,
    required String toAccount,
    required String trackingNumber,
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, dynamic> json) => _$TransactionModelFromJson(json);
}
