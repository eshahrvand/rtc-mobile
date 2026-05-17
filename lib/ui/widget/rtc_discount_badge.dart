import 'package:flutter/material.dart';
import '../theme/colors.dart';

class RtcDiscountBadge extends StatelessWidget {
  final String discount;
  final EdgeInsets? padding;
  final double? borderRadius;
  final TextStyle? textStyle;

  const RtcDiscountBadge({
    super.key,
    required this.discount,
    this.padding,
    this.borderRadius,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.errorPalette.shade500,
        borderRadius: BorderRadius.circular(borderRadius ?? 100),
      ),
      child: Text(
        discount,
        style: textStyle ?? theme.bodyMedium!.copyWith(
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}
