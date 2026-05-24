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
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
                    child: _buildDragHandle(),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                    child: _buildHeader(context),
                  ),
                  RtcDivider(),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
                    child: _buildDetailsList(context, transaction),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    child: _buildActions(context),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDragHandle() {
    return Center(
      child: Container(
        width: 31,
        height: 2,
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
          Text(
            S.current.transactionDetails,
            style: theme.labelLarge!.copyWith(
              color: AppColors.grayPalette.shade900,
              fontWeight: FontWeight.w600,
            ),
          ),

          const Spacer(),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: RtcImage(
              image: '$baseImage/close.svg',
              width: 20,
              height: 20,
              color: AppColors.grayPalette.shade800,
              boxFit: BoxFit.fill,
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
        _DetailRow(
          label: S.current.registrationDate,
          value: '${transaction.date} - ${transaction.time}',
        ),
        const RtcDivider(),
        _DetailRow(
          label: S.current.amount,
          value: transaction.amount,
          unit: S.current.toman,
          isBold: true,
        ),
        RtcDivider(color: AppColors.grayPalette.shade300, height: 1),
        _DetailRow(
          label: S.current.withdrawalFrom,
          value: transaction.fromAccount,
        ),
        const RtcDivider(),
        _DetailRow(label: S.current.depositTo, value: transaction.toAccount),
        const RtcDivider(),
        _DetailRow(
          label: S.current.trackingNumber,
          value: transaction.trackingNumber,
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Row(
      spacing: 12,
      children: [
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
        Expanded(
          child: RtcButton(
            title: S.current.share,
            onPressed: () {},
            styleBtn: theme.labelLarge!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
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
            style: theme.bodyLarge!.copyWith(
              color: AppColors.grayPalette.shade700,
            ),
          ),
          Row(
            spacing: 4,
            children: [
              Text(
                value,
                style: theme.bodyLarge!.copyWith(
                  color: AppColors.grayPalette.shade900,
                  fontWeight: FontWeight.w500,
                ),
              ),

              if (unit != null)
                Text(
                  unit!,
                  style: theme.bodyLarge!.copyWith(
                    color: AppColors.grayPalette.shade900,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
