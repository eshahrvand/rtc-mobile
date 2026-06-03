import 'package:flutter/material.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import '../../config/config.dart';
import '../../generated/l10n.dart';
import 'rtc_image.dart';

class RtcStatusBadge extends StatelessWidget {
  final String status;
  final double fontSize;
  final double iconSize;
  final double borderRadius;
  final bool isPrimary;

  const RtcStatusBadge({
    super.key,
    required this.status,
    this.fontSize = 12,
    this.iconSize = 14,
    this.borderRadius = 8,
    this.isPrimary = true,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    String? iconPath;
    MaterialColor palette;

    if (status == 'پیش فاکتور' || status == S.current.preInvoice) {
      palette = AppColors.blueGrayPalette;
      iconPath = '$baseImage/document-list-badge.svg';
    } else if (status == 'در انتظار تسویه' ||
        status == S.current.statusWaitingSettlement) {
      palette = AppColors.indigoPalette;
      iconPath = '$baseImage/dollar_badge.svg';
    } else if (status == 'در انتظار تایید' ||
        status == S.current.statusPending) {
      palette = AppColors.warningPalette;
      iconPath = '$baseImage/waiting_badge.svg';
    } else if (status == 'تایید شده' ||
        status == S.current.statusApproved ||
        status == 'انجام شده' ||
        status == S.current.statusDone) {
      palette = AppColors.successPalette;
      iconPath = '$baseImage/check_badge.svg';
    } else if (status == 'بارگزاری شده' || status == S.current.uploaded) {
      palette = AppColors.successPalette;
      iconPath = '$baseImage/check_badge.svg';
    } else if (status == 'انجام شده' || status == "انجام شده") {
      palette = AppColors.successPalette;
      iconPath = '$baseImage/check_badge.svg';
    } else if (status == 'رد شده' || status == S.current.statusRejected) {
      palette = AppColors.errorPalette;
      iconPath = '$baseImage/close_badge.svg';
    } else if (status == 'منقضی شده' || status == S.current.statusExpired) {
      palette = AppColors.grayPalette;
      iconPath = '$baseImage/calendar_badge.svg';
    } else {
      palette = AppColors.grayPalette;
    }

    if (isPrimary) {
      bgColor = palette.shade500;
      textColor = Colors.white;
    } else {
      textColor = palette.shade700;
      bgColor = palette.shade50;
    }

    return Container(
      height: 22,

      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 8, left: 8, top: 2, bottom: 2),
        child: Row(
          spacing: 4,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (iconPath != null) ...[
              RtcImage(
                image: iconPath,
                width: 12,
                height: 12,
                color: textColor,
              ),
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
      ),
    );
  }
}
