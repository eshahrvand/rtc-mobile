import 'package:flutter/material.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import '../../config/config.dart';
import '../../generated/l10n.dart';
import 'rtc_image.dart';

class RtcStatusBadge extends StatelessWidget {
  final String status;
  final double fontSize;
  final double iconSize;
  final EdgeInsets padding;
  final double borderRadius;

  const RtcStatusBadge({
    super.key,
    required this.status,
    this.fontSize = 12,
    this.iconSize = 14,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    String? iconPath;

    if (status == 'پیش فاکتور' || status == S.current.preInvoice) {
      bgColor = Colors.blueGrey.shade50;
      textColor = Colors.blueGrey.shade700;
      iconPath = '$baseImage/document-list-badge.svg';
    } else if (status == 'در انتظار تسویه') {
      bgColor = Colors.indigo.shade50;
      textColor = Colors.indigo.shade700;
      iconPath = '$baseImage/dollar_badge.svg';
    } else if (status == 'در انتظار تایید' ||
        status == S.current.statusPending) {
      bgColor = AppColors.warningPalette.shade50;
      textColor = AppColors.warningPalette.shade700;
      iconPath = '$baseImage/waiting_badge.svg';
    } else if (status == 'تایید شده' || status == S.current.statusApproved) {
      bgColor = AppColors.successPalette.shade50;
      textColor = AppColors.successPalette.shade700;
      iconPath = '$baseImage/check_badge.svg';
    } else if (status == 'رد شده' || status == S.current.statusRejected) {
      bgColor = AppColors.errorPalette.shade50;
      textColor = AppColors.errorPalette.shade700;
      iconPath = '$baseImage/close_badge.svg';
    } else if (status == 'منقضی شده') {
      bgColor = AppColors.grayPalette.shade50;
      textColor = AppColors.grayPalette.shade700;
      iconPath = '$baseImage/calendar_badge.svg';
    } else {
      bgColor = Colors.grey.withOpacity(0.1);
      textColor = Colors.grey;
    }

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        spacing: 4,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (iconPath != null) ...[
            RtcImage(image: iconPath, width: 20, height: 20, color: textColor),
          ],
          Text(
            status,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
