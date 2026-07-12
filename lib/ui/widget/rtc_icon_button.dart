import 'package:flutter/material.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';

import '../../../locator.dart';
import '../../../core/service/analytics_service.dart';

class RtcIconButton extends StatelessWidget {
  final String icon;
  final double size;
  final VoidCallback? onPressed;
  final Color? color;
  final String? analyticsId;

  const RtcIconButton({
    super.key,
    required this.icon,
    this.size = 50.0,
    this.onPressed,
    this.color,
    this.analyticsId,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onPressed != null) {
          sl<AnalyticsService>().logButtonTap(analyticsId ?? icon);
          onPressed!();
        }
      },
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
