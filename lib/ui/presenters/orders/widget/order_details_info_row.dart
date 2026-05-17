import 'package:flutter/material.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';

class OrderDetailsInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool isBold;

  const OrderDetailsInfoRow({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
    this.isBold = true,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.bodyMedium!.copyWith(
              color: AppColors.grayPalette.shade600,
            ),
          ),
          Text(
            value,
            style: theme.labelMedium!.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.grayPalette.shade900,
            ),
          ),
        ],
      ),
    );
  }
}
