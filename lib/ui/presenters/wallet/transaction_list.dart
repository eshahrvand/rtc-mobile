import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_appbar.dart';
import 'package:rtc_mobile/ui/widget/rtc_divider.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';
import 'bloc/wallet_cubit.dart';
import 'bloc/wallet_state.dart';
import 'widget/transaction_details_sheet.dart';

class TransactionListScreen extends StatelessWidget {
  const TransactionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        final pocket = state.selectedPocket;
        if (pocket == null) return const Scaffold();

        return Scaffold(
          appBar: RtcAppBar(
            title: S.current.pocketName(pocket.bankName),
            onBack: () => context.pop(),
            backIconPath: '$baseImage/angle-right.svg',
          ),
          body: Column(
            children: [
              _buildFilters(context),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  itemCount: state.transactions.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final transaction = state.transactions[index];
                    return _TransactionCard(
                      transaction: transaction,
                      onTap: () {
                        context.read<WalletCubit>().selectTransaction(transaction);
                        TransactionDetailsSheet.show(context, context.read<WalletCubit>());
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilters(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _FilterChip(label: S.current.transactionType),
          const SizedBox(width: 8),
          _FilterChip(label: S.current.registrationDate),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;

  const _FilterChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.grayPalette.shade50,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppColors.grayPalette.shade200),
      ),
      child: Row(
        spacing: 4,
        children: [
          RtcImage(
            image: '$baseImage/angle-down_tab.svg',
            width: 16,
            height: 16,
            color: AppColors.grayPalette.shade600,
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.grayPalette.shade700,
                ),
          ),
        ],
      ),
    );
  }
}

class _TransactionCard extends StatelessWidget {
  final dynamic transaction;
  final VoidCallback onTap;

  const _TransactionCard({required this.transaction, required this.onTap});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    final isDeposit = transaction.type == 'واریز';

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.grayPalette.shade25,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 4,
                  children: [
                    Text(
                      transaction.amount,
                      style: theme.titleMedium!.copyWith(
                        color: AppColors.grayPalette.shade900,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      S.current.toman,
                      style: theme.bodySmall!.copyWith(color: AppColors.grayPalette.shade600),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '...',
                  style: theme.bodyMedium!.copyWith(color: AppColors.grayPalette.shade400),
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  transaction.type,
                  style: theme.titleMedium!.copyWith(
                    color: AppColors.grayPalette.shade900,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  spacing: 4,
                  children: [
                    Text(
                      '${transaction.date}  |  ${transaction.time}',
                      style: theme.bodySmall!.copyWith(color: AppColors.grayPalette.shade500),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(width: 12),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isDeposit ? AppColors.brandPalette.shade100 : AppColors.errorPalette.shade100,
                ),
              ),
              child: Center(
                child: Icon(
                  isDeposit ? Icons.arrow_downward : Icons.arrow_upward,
                  color: isDeposit ? AppColors.brandPalette.shade600 : AppColors.errorPalette.shade600,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
