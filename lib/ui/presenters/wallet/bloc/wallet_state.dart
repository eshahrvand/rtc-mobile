import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../data/models/wallet_model.dart';

part 'wallet_state.freezed.dart';

enum WalletRequestStatus {
  initial,
  loading,
  success,
  error,
}

@freezed
class WalletState with _$WalletState {
  const factory WalletState({
    @Default(WalletRequestStatus.initial) WalletRequestStatus status,
    @Default('') String errorMessage,
    WalletSummaryModel? walletSummary,
    PocketModel? selectedPocket,
    @Default([]) List<TransactionModel> transactions,
    TransactionModel? selectedTransaction,
    
    // Filters
    String? selectedDateFrom,
    String? selectedDateTo,
    String? selectedTransactionType,
  }) = _WalletState;
}
