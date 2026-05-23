import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_button.dart';
import 'package:rtc_mobile/ui/widget/rtc_divider.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';
import '../bloc/wallet_cubit.dart';
import '../bloc/wallet_state.dart';

class TransactionDetailsSheet extends StatelessWidget {
  final WalletCubit cubit;

  const TransactionDetailsSheet({super.key, required this.cubit});

  static Future<void> show(BuildContext context, WalletCubit cubit) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: TransactionDetailsSheet(cubit: cubit),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        final transaction = state.selectedTransaction;
        if (transaction == null) return const SizedBox.shrink();

        return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDragHandle(),
                _buildHeader(context),
                const SizedBox(height: 24),
                _buildDetailsList(context, transaction),
                const SizedBox(height: 32),
                _buildActions(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDragHandle() {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: AppColors.brandPalette.shade600,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: RtcImage(
              image: '$baseImage/close.svg',
              width: 20,
              height: 20,
              color: AppColors.grayPalette.shade600,
            ),
          ),
          const Spacer(),
          Text(
            S.current.transactionDetails,
            style: theme.titleMedium!.copyWith(
              color: AppColors.grayPalette.shade900,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsList(BuildContext context, dynamic transaction) {
    return Column(
      children: [
        _DetailRow(label: S.current.transactionType, value: transaction.type),
        const RtcDivider(),
        _DetailRow(label: S.current.registrationDate, value: '${transaction.date} - ${transaction.time}'),
        const RtcDivider(),
        _DetailRow(
          label: S.current.amount,
          value: transaction.amount,
          unit: S.current.toman,
          isBold: true,
        ),
        const RtcDivider(),
        _DetailRow(label: S.current.withdrawalFrom, value: transaction.fromAccount),
        const RtcDivider(),
        _DetailRow(label: S.current.depositTo, value: transaction.toAccount),
        const RtcDivider(),
        _DetailRow(label: S.current.trackingNumber, value: transaction.trackingNumber),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Row(
      children: [
        Expanded(
          child: RtcButton(
            title: S.current.share,
            onPressed: () {},
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: RtcButton(
            title: S.current.back,
            backgroundColor: Colors.white,
            borderColor: AppColors.grayPalette.shade300,
            styleBtn: theme.labelLarge!.copyWith(
              color: AppColors.grayPalette.shade700,
              fontWeight: FontWeight.w600,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final String? unit;
  final bool isBold;

  const _DetailRow({
    required this.label,
    required this.value,
    this.unit,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.bodyMedium!.copyWith(color: AppColors.grayPalette.shade600),
          ),
          Row(
            spacing: 4,
            children: [
              if (unit != null)
                Text(
                  unit!,
                  style: theme.bodySmall!.copyWith(color: AppColors.grayPalette.shade600),
                ),
              Text(
                value,
                style: theme.bodyLarge!.copyWith(
                  color: AppColors.grayPalette.shade900,
                  fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
