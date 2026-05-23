import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/wallet_model.dart';
import 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit() : super(const WalletState());

  void init() {
    emit(state.copyWith(status: WalletRequestStatus.loading));

    // Simulate API call to fetch wallet data
    Future.delayed(const Duration(milliseconds: 500))
        .then((_) {
          emit(state.copyWith(
            status: WalletRequestStatus.success,
            walletSummary: const WalletSummaryModel(
              totalBalance: '۱۲۴,۰۰۰,۰۰۰',
              totalCredit: '۱۰۰,۰۰۰,۰۰۰',
              remainingCredit: '۱۲۴,۰۰۰,۰۰۰',
              pockets: [
                PocketModel(
                  id: '1',
                  bankName: 'بانک ملی',
                  planName: 'طرح ۱۲ ماهه',
                  balance: '۱۲۴,۰۰۰,۰۰۰',
                  logoPath: 'assets/images/melli.png',
                ),
                PocketModel(
                  id: '2',
                  bankName: 'اسنپ‌پی',
                  planName: 'طرح ۱۲ ماهه',
                  balance: '۱۲۴,۰۰۰,۰۰۰',
                  logoPath: 'assets/images/snapp.png',
                ),
                PocketModel(
                  id: '3',
                  bankName: 'بانک تجارت',
                  planName: 'طرح ۶ ماهه',
                  balance: '۱۲۴,۰۰۰,۰۰۰',
                  logoPath: 'assets/images/tejarat.png',
                ),
                PocketModel(
                  id: '4',
                  bankName: 'تارا',
                  planName: 'طرح ۱۲ ماهه',
                  balance: '۱۲۴,۰۰۰,۰۰۰',
                  logoPath: 'assets/images/tara.png',
                ),
              ],
            ),
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
    ));

    // Simulate fetching transactions for the pocket
    Future.delayed(const Duration(milliseconds: 300))
        .then((_) {
          emit(state.copyWith(
            status: WalletRequestStatus.success,
            transactions: [
              const TransactionModel(
                id: '1',
                type: 'واریز',
                amount: '۱,۲۰۰,۰۰۰',
                date: '۱۴۰۳/۱۱/۱۳',
                time: '۰۸:۱۲',
                isCredit: true,
                fromAccount: 'IR۱۰۰۵۷۰۰۸۷۵۲۳۹۸۹۸۳۰۳۴۵۰۶',
                toAccount: 'IR۱۰۰۵۷۰۰۸۷۵۲۳۹۸۹۸۳۰۳۴۵۰۶',
                trackingNumber: '۹۸۳۰۳۴۵۰۶',
              ),
              const TransactionModel(
                id: '2',
                type: 'واریز',
                amount: '۱,۲۰۰,۰۰۰',
                date: '۱۴۰۳/۱۱/۱۳',
                time: '۰۸:۱۲',
                isCredit: true,
                fromAccount: 'IR۱۰۰۵۷۰۰۸۷۵۲۳۹۸۹۸۳۰۳۴۵۰۶',
                toAccount: 'IR۱۰۰۵۷۰۰۸۷۵۲۳۹۸۹۸۳۰۳۴۵۰۶',
                trackingNumber: '۹۸۳۰۳۴۵۰۶',
              ),
              const TransactionModel(
                id: '3',
                type: 'برداشت',
                amount: '۱,۲۰۰,۰۰۰',
                date: '۱۴۰۳/۱۱/۱۳',
                time: '۰۸:۱۲',
                isCredit: false,
                fromAccount: 'IR۱۰۰۵۷۰۰۸۷۵۲۳۹۸۹۸۳۰۳۴۵۰۶',
                toAccount: 'IR۱۰۰۵۷۰۰۸۷۵۲۳۹۸۹۸۳۰۳۴۵۰۶',
                trackingNumber: '۹۸۳۰۳۴۵۰۶',
              ),
            ],
          ));
        })
        .catchError((Object e) {
          emit(state.copyWith(
            status: WalletRequestStatus.error,
            errorMessage: e.toString(),
          ));
        });
  }

  void selectTransaction(TransactionModel transaction) {
    emit(state.copyWith(selectedTransaction: transaction));
  }
}
