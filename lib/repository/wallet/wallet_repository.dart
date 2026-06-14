import 'package:intl/intl.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../../core/utils/date_time_utils.dart';
import '../../data/models/wallet_model.dart';
import '../../data_source/remote/wallet/wallet_service.dart';
import '../../generated/l10n.dart';

class WalletRepository {
  final WalletService _service;

  WalletRepository(this._service);

  Future<WalletSummaryModel> getWallet() {
    return _service.getWallet().then(
      (dto) => WalletSummaryModel(
        totalBalance: _formatCurrency(dto.balance),
        totalBalanceRaw: dto.balance,
        totalCredit: _formatCurrency(dto.creditLimit),
        remainingCredit: _formatCurrency(dto.remainingCredit),
        pockets: dto.pockets
            .map(
              (p) => PocketModel(
                id: p.id,
                bankName: p.subPlan.creditPlan?.name ?? S.current.unknown,
                planName: p.subPlan.name,
                balance: _formatCurrency(p.balance),
                balanceRaw: p.balance,
                logoPath:
                    p.subPlan.creditPlan?.image?.file ??
                    'assets/images/wallet.svg',
              ),
            )
            .toList(),
      ),
    );
  }

  Future<List<TransactionModel>> getTransactions({
    String? dateFrom,
    String? dateTo,
    String? transactionType,
    String? subPlanId,
  }) {
    return _service
        .getTransactions(
          dateFrom: dateFrom,
          dateTo: dateTo,
          transactionType: transactionType,
          subPlanId: subPlanId,
        )
        .then(
          (response) => response.results.map((dto) {
            final localDateTime = DateTimeUtils.parseToLocal(dto.createdAt);

            final jalali = Jalali.fromDateTime(localDateTime!);
            final dateStr =
                '${jalali.year}/${jalali.month.toString().padLeft(2, '0')}/${jalali.day.toString().padLeft(2, '0')}';
            final timeStr =
                '${localDateTime.hour.toString().padLeft(2, '0')}:${localDateTime.minute.toString().padLeft(2, '0')}';

            return TransactionModel(
              id: dto.id,
              type: dto.transactionType == 'credit' ? 'واریز' : 'برداشت',
              amount: _formatCurrency(double.tryParse(dto.amount) ?? 0.0),
              date: dateStr,
              time: timeStr,
              isCredit: dto.transactionType == 'credit',
              fromAccount: dto.customer != null
                  ? '${dto.customer!.firstName} ${dto.customer!.lastName}'
                  : 'نامشخص',
              toAccount: dto.subPlan?.name ?? 'نامشخص',
              trackingNumber: dto.orderId ?? '-',
            );
          }).toList(),
        );
  }

  String _formatCurrency(double value) {
    final formatter = NumberFormat('#,###', 'en_US');
    String formatted = formatter.format(value.abs().toInt());
    return value < 0 ? '\u200E-$formatted' : formatted;
  }
}
