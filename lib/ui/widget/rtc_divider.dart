import 'package:flutter/material.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';

class RtcDivider extends StatelessWidget {
  final Color? color;
  final double? height;
  final double? width;

  const RtcDivider({super.key, this.color, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 1,
      color: color ?? AppColors.grayPalette.shade200,
    );
  }
}
