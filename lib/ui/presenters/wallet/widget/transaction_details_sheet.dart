import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_button.dart';
import 'package:rtc_mobile/ui/widget/rtc_divider.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import '../bloc/wallet_cubit.dart';
import '../bloc/wallet_state.dart';

class TransactionDetailsSheet extends StatelessWidget {
  final WalletCubit cubit;
  final ScreenshotController _screenshotController = ScreenshotController();

  TransactionDetailsSheet({super.key, required this.cubit});

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
                    child: Screenshot(
                      controller: _screenshotController,
                      child: Container(
                        color: Colors.white,
                        child: _buildDetailsList(context, transaction),
                      ),
                    ),
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
      mainAxisSize: MainAxisSize.min,
      children: [
        _DetailRow(label: S.current.transactionType, value: transaction.type),
        const RtcDivider(),
        _DetailRow(
          label: S.current.registrationDate,
          value: '${transaction.time} - ${transaction.date}',
        ),
        const RtcDivider(),
        _DetailRow(
          label: S.current.amount,
          value: transaction.amount,
          unit: RtcImage(image: "$baseImage/toman.svg", width: 24, height: 24),
          isBold: true,
        ),
        RtcDivider(color: AppColors.grayPalette.shade300, height: 1),
        _DetailRow(
          label: S.current.withdrawalFrom,
          value: transaction.fromAccount,
        ),
        const RtcDivider(),
        _DetailRow(label: S.current.depositTo, value: transaction.toAccount),
        // const RtcDivider(),
        // _DetailRow(
        //   label: S.current.trackingNumber,
        //   value: transaction.trackingNumber,
        // ),
      ],
    );
  }

  Widget _buildDetailsShareList(BuildContext context, dynamic transaction) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 12),
          child: RtcImage(
            image: "$baseImage/rtc_logo.png",
            width: 80,
            height: 42,
          ),
        ),
        Text(
          S.current.walletReceiptTitle,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: AppColors.grayPalette.shade900,
          ),
        ),
        SizedBox(height: 12),
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
          unit: RtcImage(image: "$baseImage/toman.svg", width: 24, height: 24),
          isBold: true,
        ),
        RtcDivider(color: AppColors.grayPalette.shade300, height: 1),
        _DetailRow(
          label: S.current.withdrawalFrom,
          value: transaction.fromAccount,
        ),
        const RtcDivider(),
        _DetailRow(label: S.current.depositTo, value: transaction.toAccount),
        // const RtcDivider(),
        // _DetailRow(
        //   label: S.current.trackingNumber,
        //   value: transaction.trackingNumber,
        // ),
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
            onPressed: () => _share(context),
            styleBtn: theme.labelLarge!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _share(BuildContext context) async {
    try {
      final state = cubit.state;
      final transaction = state.selectedTransaction;
      if (transaction == null) return;

      // Use captureFromWidget to create a dedicated widget for the screenshot
      // with white background and 20px padding
      final bytes = await _screenshotController.captureFromWidget(
        Directionality(
          textDirection: TextDirection.rtl,
          child: Material(
            child: Container(
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: _buildDetailsShareList(context, transaction),
            ),
          ),
        ),
        pixelRatio: 3.0,
        context: context,
      );

      final tempDir = await getTemporaryDirectory();
      final file = await File(
        '${tempDir.path}/transaction_details.png',
      ).create();
      await file.writeAsBytes(bytes);

      await Share.shareXFiles([
        XFile(file.path),
      ], text: S.current.transactionDetails);
    } catch (e) {
      if (kDebugMode) {
        print('Error sharing: $e');
      }
    }
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final dynamic unit;
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
            spacing: 2,
            children: [
              Text(
                value,
                style: theme.bodyLarge!.copyWith(
                  color: AppColors.grayPalette.shade900,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (unit != null)
                if (unit is String)
                  Text(
                    unit!,
                    style: theme.bodyLarge!.copyWith(
                      color: AppColors.grayPalette.shade900,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                else if (unit is Widget)
                  unit!,
            ],
          ),
        ],
      ),
    );
  }
}
