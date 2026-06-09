import 'package:flutter/material.dart';
import '../theme/colors.dart';

class RtcDiscountBadge extends StatelessWidget {
  final String discount;
  final EdgeInsets? padding;
  final double? borderRadius;
  final TextStyle? textStyle;
  final Color? backgroundColor;

  const RtcDiscountBadge({
    super.key,
    required this.discount,
    this.padding,
    this.borderRadius,
    this.textStyle,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Container(
      width: 34,
      padding: padding ?? const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ??  AppColors.errorPalette.shade500,
        borderRadius: BorderRadius.circular(borderRadius ?? 100),
      ),
      child: Center(
        child: Text(
          discount,
          style: textStyle ?? theme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
