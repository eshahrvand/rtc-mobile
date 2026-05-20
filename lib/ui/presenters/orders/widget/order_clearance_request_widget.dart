import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_button.dart';
import '../../../widget/rtc_divider.dart';

class OrderClearanceRequestWidget extends StatelessWidget {
  final String amount;
  final VoidCallback onRequestCode;

  const OrderClearanceRequestWidget({
    super.key,
    required this.amount,
    required this.onRequestCode,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          child: RtcDivider(height: 0.5, color: AppColors.grayPalette.shade700),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: AppColors.grayPalette.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Text(
                      'مبلغ تخلیه',
                      style: theme.bodyMedium!.copyWith(
                        color: AppColors.grayPalette.shade700,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          amount,
                          style: theme.titleSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.brandPalette.shade600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          S.current.toman,
                          style: theme.bodySmall!.copyWith(
                            color: AppColors.brandPalette.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              RtcDivider(color: AppColors.grayPalette.shade700, height: 1),
              const SizedBox(height: 16),
              Text(
                'در صورت تایید اطلاعات پس از زدن گزینه درخواست کد تخلیه، کد فرستاده شده به شماره مشتری را وارد و تایید کنید.',
                textAlign: TextAlign.right,
                style: theme.labelMedium!.copyWith(
                  color: AppColors.grayPalette.shade900,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: RtcButton(
                  title: 'درخواست کد تخلیه',
                  styleBtn: theme.labelLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  width: 147,
                  onPressed: onRequestCode,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
