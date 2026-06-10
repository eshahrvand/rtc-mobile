import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/network_helper.dart';
import '../../../../data/models/wallet_model.dart';
import '../../../../locator.dart';
import '../../../../repository/wallet/wallet_repository.dart';
import 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  final _repository = sl<WalletRepository>();

  WalletCubit() : super(const WalletState());

  void init() {
    emit(state.copyWith(status: WalletRequestStatus.loading));

    _repository.getWallet()
        .then((summary) {
          emit(state.copyWith(
            status: WalletRequestStatus.success,
            walletSummary: summary,
          ));
        })
        .catchError(_handleError);
  }

  void selectPocket(PocketModel pocket) {
    emit(state.copyWith(
      selectedPocket: pocket,
      status: WalletRequestStatus.loading,
      selectedDateFrom: null,
      selectedDateTo: null,
      selectedTransactionType: null,
      selectedDateOptionId: null,
    ));

    _fetchTransactions();
  }

  void _fetchTransactions() {
    if (state.selectedPocket == null) return;
    
    emit(state.copyWith(status: WalletRequestStatus.loading));

    _repository.getTransactions(
      subPlanId: state.selectedPocket!.id,
      dateFrom: state.selectedDateFrom,
      dateTo: state.selectedDateTo,
      transactionType: state.selectedTransactionType,
    ).then((transactions) {
      emit(state.copyWith(
        status: WalletRequestStatus.success,
        transactions: transactions,
      ));
    }).catchError(_handleError);
  }

  void setTypeFilter(String? type) {
    if (state.selectedTransactionType == type) return;
    emit(state.copyWith(selectedTransactionType: type));
    _fetchTransactions();
  }

  void setDateFilter(String? from, String? to, {String? optionId}) {
    if (state.selectedDateFrom == from && 
        state.selectedDateTo == to && 
        state.selectedDateOptionId == optionId) return;

    emit(state.copyWith(
      selectedDateFrom: from,
      selectedDateTo: to,
      selectedDateOptionId: optionId,
    ));
    _fetchTransactions();
  }

  void selectTransaction(TransactionModel transaction) {
    emit(state.copyWith(selectedTransaction: transaction));
  }

  void _handleError(Object e) {
    if (isClosed) return;

    NetworkHelper.getNetworkErrorMessage().then((networkMessage) {
      if (isClosed) return;

      final finalMessage = networkMessage ?? e.toString();
      if (state.errorMessage == finalMessage) return;

      emit(state.copyWith(
        status: WalletRequestStatus.error,
        errorMessage: finalMessage,
      ));
    });
  }
}
