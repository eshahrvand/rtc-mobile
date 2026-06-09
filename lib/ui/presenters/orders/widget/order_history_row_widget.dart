import 'package:flutter/material.dart';
import '../../../theme/colors.dart';

class OrderHistoryRowWidget extends StatelessWidget {
  final String label;
  final String value;

  const OrderHistoryRowWidget({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 15.0),
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
            style: theme.labelLarge!.copyWith(
              color: AppColors.grayPalette.shade900,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
