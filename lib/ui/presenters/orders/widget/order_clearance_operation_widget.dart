import 'package:flutter/material.dart';
import '../../../../config/config.dart';
import '../../../../generated/l10n.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_button.dart';
import '../../../widget/rtc_divider.dart';
import '../../../widget/rtc_image.dart';

class OrderClearanceOperationWidget extends StatelessWidget {
  final String amount;
  final String? excessAmount;
  final String? walletName;
  final VoidCallback onAction;
  final bool isOnline;

  const OrderClearanceOperationWidget({
    super.key,
    required this.amount,
    this.excessAmount,
    this.walletName,
    required this.onAction,
    this.isOnline = false,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Divider
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: RtcDivider(height: 0.5, color: AppColors.grayPalette.shade300),
        ),

        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Amount Box
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: AppColors.grayPalette.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    // Clearance Amount Row
                    Row(
                      children: [
                        Text(
                          S.current.clearanceAmountLabel,
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

                    // Excess Amount Row (if exists)
                    if (excessAmount != null) ...[
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            S.current.differenceAmount,
                            style: theme.bodyMedium!.copyWith(
                              color: AppColors.grayPalette.shade700,
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Text(
                                excessAmount!,
                                style: theme.titleSmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.successPalette.shade600,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                S.current.toman,
                                style: theme.bodySmall!.copyWith(
                                  color: AppColors.successPalette.shade600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              if (isOnline && excessAmount != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.successPalette.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.successPalette.shade100,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          S.current.walletBalanceSufficient,
                          style: theme.labelMedium!.copyWith(
                            color: AppColors.successPalette.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      RtcImage(
                        image: "$baseImage/wallet.svg",
                        width: 20,
                        height: 20,
                        color: AppColors.successPalette.shade600,
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 16),
              RtcDivider(color: AppColors.grayPalette.shade300, height: 1),
              const SizedBox(height: 16),

              // Instruction Text
              Text(
                isOnline
                    ? S.current.clearanceRequestInstruction
                    : S.current.uploadClearanceInstruction,
                textAlign: TextAlign.right,
                style: theme.labelMedium!.copyWith(
                  color: AppColors.grayPalette.shade900,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 24),

              // Action Button
              Align(
                alignment: Alignment.centerLeft,
                child: RtcButton(
                  title: isOnline
                      ? S.current.requestCodeButton
                      : S.current.uploadClearanceDocuments,
                  styleBtn: theme.labelLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  width: isOnline ? 147 : 172,
                  onPressed: onAction,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
