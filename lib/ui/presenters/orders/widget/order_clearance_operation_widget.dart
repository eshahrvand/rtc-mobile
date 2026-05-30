import 'package:flutter/material.dart';
import 'package:rtc_mobile/core/utils/currency_formatter.dart';
import '../../../../config/config.dart';
import '../../../../generated/l10n.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_button.dart';
import '../../../widget/rtc_divider.dart';
import '../../../widget/rtc_image.dart';

class OrderClearanceOperationWidget extends StatelessWidget {
  final String amount;
  final String? orderAmount;
  final String? excessAmount;
  final String? walletName;
  final VoidCallback onAction;
  final VoidCallback? onEdit;
  final bool isOnline;
  final bool isOutOfTolerance;

  const OrderClearanceOperationWidget({
    super.key,
    required this.amount,
    this.orderAmount,
    this.excessAmount,
    this.walletName,
    required this.onAction,
    this.onEdit,
    this.isOnline = false,
    this.isOutOfTolerance = false,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Header with Edit Icon
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.current.clearanceOperation,
                style: theme.labelLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.grayPalette.shade900,
                ),
              ),

              if (onEdit != null)
                GestureDetector(
                  onTap: () {
                    debugPrint('>> OrderClearanceOperationWidget: Edit clicked');
                    onEdit!();
                  },
                  child: RtcImage(
                    image: "$baseImage/edit.svg",
                    width: 24,
                    height: 24,
                    color: AppColors.brandPalette.shade600,
                  ),
                ),
            ],
          ),
        ),

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
                    // Order Amount Row (only in Out of Tolerance)
                    if (isOutOfTolerance && orderAmount != null) ...[
                      Row(
                        children: [
                          Text(
                            S.current.orderAmountLabel,
                            style: theme.bodyMedium!.copyWith(
                              color: AppColors.grayPalette.shade700,
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Text(
                                orderAmount!.formatCurrency,
                                style: theme.titleSmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.grayPalette.shade900,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                S.current.toman,
                                style: theme.bodySmall!.copyWith(
                                  color: AppColors.grayPalette.shade900,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],

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
                              amount.formatCurrency,
                              style: theme.titleSmall!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: isOutOfTolerance
                                    ? AppColors.brandPalette.shade600
                                    : AppColors.brandPalette.shade600,
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
                                excessAmount!.formatCurrency,
                                style: theme.titleSmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: isOutOfTolerance
                                      ? AppColors.errorPalette.shade600
                                      : AppColors.successPalette.shade600,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                S.current.toman,
                                style: theme.bodySmall!.copyWith(
                                  color: isOutOfTolerance
                                      ? AppColors.errorPalette.shade600
                                      : AppColors.successPalette.shade600,
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

              const SizedBox(height: 12),

              // Status Message Box
              if (isOutOfTolerance)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.errorPalette.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.errorPalette.shade100),
                  ),
                  child: Row(
                    children: [
                      RtcImage(
                        image: "$baseImage/warning.svg",
                        width: 20,
                        height: 20,
                        color: AppColors.errorPalette.shade600,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          S.current.excessAmountOutOfTolerance,
                          style: theme.labelMedium!.copyWith(
                            color: AppColors.errorPalette.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else if (excessAmount != null)
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
                      RtcImage(
                        image: "$baseImage/wallet.svg",
                        width: 20,
                        height: 20,
                        color: AppColors.successPalette.shade600,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          S.current.excessAmountAddedToWallet(walletName ?? ""),
                          style: theme.labelMedium!.copyWith(
                            color: AppColors.successPalette.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              if (!isOutOfTolerance) ...[
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
            ],
          ),
        ),
      ],
    );
  }
}
