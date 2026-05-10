import 'package:flutter/material.dart';
import 'package:rtc_mobile/widget/rtc_image.dart';

class AxinoIconButton extends StatelessWidget {
  final String icon;
  final double size;
  final VoidCallback? onPressed;
  final Color? color;

  const AxinoIconButton({
    super.key,
    required this.icon,
    this.size = 50.0,
    this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(size / 2),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: RtcImage(image: icon, color: color),
      ),
    );
  }
}
