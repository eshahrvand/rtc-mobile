import 'package:flutter/material.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_button.dart';
import '../../../widget/rtc_divider.dart';
import '../../../widget/rtc_text_field.dart';

class OrderClearanceAmountSheet extends StatelessWidget {
  final String totalAmount;
  final TextEditingController amountController;
  final VoidCallback onCheckPressed;

  const OrderClearanceAmountSheet({
    super.key,
    required this.totalAmount,
    required this.amountController,
    required this.onCheckPressed,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 33,
              height: 2,
              decoration: BoxDecoration(color: AppColors.brandPalette.shade600),
            ),
          ),
          const SizedBox(height: 40),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'مبلغ نهایی فاکتور:',
                style: theme.bodyMedium!.copyWith(
                  color: AppColors.grayPalette.shade700,
                ),
              ),
              Row(
                children: [
                  Text(
                    totalAmount,
                    style: theme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grayPalette.shade900,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    S.current.toman,
                    style: theme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grayPalette.shade900,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          const RtcDivider(isDashed: true),
          const SizedBox(height: 12),

          // Input label
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'مبلغ تخلیه کارت را وارد کنید',
              style: theme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.grayPalette.shade900,
              ),
            ),
          ),
          const SizedBox(height: 12),

          Row(
            spacing: 16,

            children: [
              Expanded(
                child: RtcTextField(
                  controller: amountController,
                  textAlign: TextAlign.left,
                  keyboardType: TextInputType.number,
                  suffix: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 12, 0, 12),
                    child: Text(
                      S.current.toman,
                      style: theme.bodySmall!.copyWith(
                        color: AppColors.grayPalette.shade800,
                      ),
                    ),
                  ),
                  textStyle: theme.bodyLarge!.copyWith(
                    color: AppColors.grayPalette.shade900,
                  ),
                ),
              ),

              RtcButton(
                title: 'بررسی',
                onPressed: onCheckPressed,
                height: 44,
                width: 88,
                styleBtn: theme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
