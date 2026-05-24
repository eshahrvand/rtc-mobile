import 'package:flutter_bloc/flutter_bloc.dart';
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
        .catchError((Object e) {
          emit(state.copyWith(
            status: WalletRequestStatus.error,
            errorMessage: e.toString(),
          ));
        });
  }

  void selectPocket(PocketModel pocket) {
    emit(state.copyWith(
      selectedPocket: pocket,
      status: WalletRequestStatus.loading,
      selectedDateFrom: null,
      selectedDateTo: null,
      selectedTransactionType: null,
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
    }).catchError((Object e) {
      emit(state.copyWith(
        status: WalletRequestStatus.error,
        errorMessage: e.toString(),
      ));
    });
  }

  void setTypeFilter(String? type) {
    if (state.selectedTransactionType == type) return;
    emit(state.copyWith(selectedTransactionType: type));
    _fetchTransactions();
  }

  void setDateFilter(String? from, String? to) {
    if (state.selectedDateFrom == from && state.selectedDateTo == to) return;
    emit(state.copyWith(
      selectedDateFrom: from,
      selectedDateTo: to,
    ));
    _fetchTransactions();
  }

  void selectTransaction(TransactionModel transaction) {
    emit(state.copyWith(selectedTransaction: transaction));
  }
}
