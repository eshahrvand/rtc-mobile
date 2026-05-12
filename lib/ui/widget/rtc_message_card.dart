import 'package:flutter/material.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'rtc_image.dart';

class RtcMessageCard extends StatelessWidget {
  final String message;
  final String iconPath;

  const RtcMessageCard({
    super.key,
    required this.message,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 18, 0, 18),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.warningPalette.shade25,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.warningPalette.shade100),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10 , 12 , 10 , 12),
          child: Row(
            spacing: 10,
            children: [
              RtcImage(image: iconPath, width: 16, height: 16),

              Expanded(
                child: Text(
                  message,
                  style: theme.bodyMedium!.copyWith(color: AppColors.warningPalette.shade600
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
