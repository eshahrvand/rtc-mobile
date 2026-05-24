import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_appbar.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';
import '../../../../data/models/product_chip_model.dart';
import '../../widget/rtc_chip_list.dart';
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
              const SizedBox(height: 16),
              _buildFilters(context),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  itemCount: state.transactions.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final transaction = state.transactions[index];
                    return _TransactionCard(
                      transaction: transaction,
                      onTap: () {
                        context.read<WalletCubit>().selectTransaction(
                          transaction,
                        );
                        TransactionDetailsSheet.show(
                          context,
                          context.read<WalletCubit>(),
                        );
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
    final chips = [
      ProductChipModel(
        id: 1,
        label: S.current.transactionType,
        opensBottomSheet: true,
      ),
      ProductChipModel(
        id: 2,
        label: S.current.registrationDate,
        opensBottomSheet: true,
      ),
    ];
    return RtcChipList(
      chips: chips,
      isChipSelected: (index, chip) => false,
      onChipTap: (index, chip) {
        // TODO: Implement filter logic
      },
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

      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.brandPalette.shade25,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: RtcImage(
                    image: isDeposit
                        ? '$baseImage/received.svg'
                        : '$baseImage/send.svg',
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.type,
                    style: theme.bodyLarge!.copyWith(
                      color: AppColors.grayPalette.shade900,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${transaction.date}  |  ${transaction.time}',
                    style: theme.bodyMedium!.copyWith(
                      color: AppColors.grayPalette.shade700,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    spacing: 4,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        transaction.amount,
                        style: theme.bodyLarge!.copyWith(
                          color: AppColors.grayPalette.shade900,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        S.current.toman,
                        style: theme.bodySmall!.copyWith(
                          color: AppColors.grayPalette.shade600,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '...',
                    style: theme.bodyMedium!.copyWith(
                      color: AppColors.grayPalette.shade400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
