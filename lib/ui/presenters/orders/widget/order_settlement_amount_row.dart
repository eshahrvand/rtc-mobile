import 'package:flutter/material.dart';
import '../../../../config/constants.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_image.dart';

class OrderSettlementAmountRow extends StatelessWidget {
  final String label;
  final String amount;
  final Color amountColor;
  final bool warningItem;
  final bool isBold;

  const OrderSettlementAmountRow({
    super.key,
    required this.label,
    required this.amount,
    required this.amountColor,
    required this.warningItem,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.bodyMedium!.copyWith(
            color: AppColors.grayPalette.shade700,
          ),
        ),
        Row(
          spacing: 2.0,
          children: [
            Text(
              amount,
              style: theme.labelLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: amountColor,
              ),
            ),
            RtcImage(
              image: "$baseImage/rial.svg",
              color: warningItem ? AppColors.warningPalette.shade600 : null,
              width: 20,
              height: 20,
              boxFit: BoxFit.contain,
            ),
          ],
        ),
      ],
    );
  }
}
