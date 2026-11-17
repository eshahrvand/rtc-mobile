import 'package:flutter/material.dart';
import '../../config/constants.dart';
import '../theme/colors.dart';
import 'rtc_image.dart';

class RtcEmptyState extends StatelessWidget {
  final String? message;
  final String? image;
  final double imageWidth;
  final double imageHeight;
  final Alignment alignment;

  const RtcEmptyState({
    super.key,
    this.message,
    this.image,
    this.imageWidth = 143,
    this.imageHeight = 124,
    this.alignment = const Alignment(0, -0.2),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final imagePath = image ?? '$baseImage/no-sell.svg';

    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RtcImage(
            image: imagePath,
            width: imageWidth,
            height: imageHeight,
            boxFit: BoxFit.contain,
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: theme.bodyMedium?.copyWith(
                color: AppColors.grayPalette.shade600,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
