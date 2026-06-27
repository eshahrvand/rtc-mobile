import 'package:flutter/material.dart';

import '../ui/theme/colors.dart';
import '../ui/widget/rtc_image.dart';
import 'constants.dart';

//
enum SnackBarType { success, warning, error }

void rtcSnackBar({
  required BuildContext context,
  required SnackBarType type,
  required String message,
  Duration duration = const Duration(seconds: 3),
}) {
  final overlay = Overlay.of(context);
  final theme = Theme.of(context);

  late OverlayEntry entry;

  entry = OverlayEntry(
    builder: (context) {
      return Positioned(
        top: 50,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: type == SnackBarType.success
                  ? AppColors.successPalette.shade50
                  : AppColors.errorPalette.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: type == SnackBarType.success
                    ? AppColors.successPalette.shade100
                    : AppColors.errorPalette.shade100,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                RtcImage(
                  image: type == SnackBarType.success
                      ? '$baseImage/done.svg'
                      : type == SnackBarType.error
                      ? '$baseImage/warning.svg'
                      : '$baseImage/warning-orange.svg',
                  width: 16,
                  height: 16,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    message,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: type == SnackBarType.success
                          ? AppColors.successPalette.shade600
                          : type == SnackBarType.error
                          ? AppColors.errorPalette.shade600
                          : AppColors.warningPalette.shade600,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  child: RtcImage(
                    image: "$baseImage/close.svg",
                    width: 10,
                    height: 10,
                    color: type == SnackBarType.success
                        ? AppColors.successPalette.shade600
                        : type == SnackBarType.error
                        ? AppColors.errorPalette.shade600
                        : AppColors.warningPalette.shade600,
                  ),

                  onTap: () {
                    entry.remove();
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );

  overlay.insert(entry);

  Future.delayed(duration, () {
    if (entry.mounted) {
      entry.remove();
    }
  });
}

void rtcBottomSnackBar({
  required BuildContext context,
  required SnackBarType type,
  required String message,
  Duration duration = const Duration(seconds: 3),
}) {
  // Clear any existing snackbars
  ScaffoldMessenger.of(context).clearSnackBars();

  final theme = Theme.of(context);

  final snackBar = SnackBar(
    content: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: type == SnackBarType.success
            ? AppColors.successPalette.shade25
            : AppColors.errorPalette.shade25,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: type == SnackBarType.success
              ? AppColors.successPalette.shade100
              : AppColors.errorPalette.shade100,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          RtcImage(
            image: type == SnackBarType.success
                ? '$baseImage/done.svg'
                : '$baseImage/warning.svg',
            width: 14,
            height: 14,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w500,
                color: type == SnackBarType.success
                    ? AppColors.successPalette.shade600
                    : AppColors.errorPalette.shade600,
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            child: RtcImage(
              image: "$baseImage/close.svg",
              width: 10,
              height: 10,
              color: type == SnackBarType.success
                  ? AppColors.successPalette.shade600
                  : AppColors.errorPalette.shade600,
            ),
            onTap: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ],
      ),
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    duration: duration,
    padding: EdgeInsets.zero,
    margin: const EdgeInsets.only(bottom: 80, left: 16, right: 16),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
