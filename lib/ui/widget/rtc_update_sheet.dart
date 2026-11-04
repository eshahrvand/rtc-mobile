import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/models/app_update_model.dart';
import '../../generated/l10n.dart';
import '../theme/colors.dart';
import 'rtc_button.dart';
import 'rtc_image.dart';

/// Displays the update bottom sheet matching the Figma designs:
/// - Force update inactive (two buttons: 'بروزرسانی برنامه' & 'بعداً')
/// - Force update active (single button: 'بروزرسانی برنامه', non-dismissible)
Future<void> showRtcUpdateSheet({
  required BuildContext context,
  required AppUpdateModel update,
  VoidCallback? onUpdate,
  VoidCallback? onSkip,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    enableDrag: !update.isForce,
    isDismissible: !update.isForce,
    barrierColor: AppColors.grayPalette.shade700.withValues(alpha: .55),
    builder: (sheetContext) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: PopScope(
        canPop: !update.isForce,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(sheetContext).bottom,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(sheetContext).height * .90,
            ),
            child: RtcUpdateSheet(
              update: update,
              onUpdate: onUpdate,
              onSkip: onSkip,
            ),
          ),
        ),
      ),
    ),
  );
}

class RtcUpdateSheet extends StatelessWidget {
  const RtcUpdateSheet({
    super.key,
    required this.update,
    this.onUpdate,
    this.onSkip,
  });

  final AppUpdateModel update;
  final VoidCallback? onUpdate;
  final VoidCallback? onSkip;

  void _safePop(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      try {
        context.pop();
      } catch (_) {}
    }
  }

  Future<void> _handleUpdatePress(BuildContext context) async {
    if (onUpdate != null) {
      onUpdate!();
      return;
    }

    final urlString = update.downloadUrl;
    if (urlString != null && urlString.isNotEmpty) {
      final uri = Uri.tryParse(urlString);
      if (uri != null) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    }

    if (!update.isForce && context.mounted) {
      _safePop(context);
    }
  }

  void _handleSkipPress(BuildContext context) {
    if (!update.isForce) {
      _safePop(context);
      onSkip?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final hasChanges =
        update.changeLog != null && update.changeLog!.trim().isNotEmpty;

    return Material(
      color: AppColors.grayPalette.shade50,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header (Handle + Title Row)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
              child: Column(
                children: [
                  // Blue drag handle matching Figma (Rectangle 36, 31x2, radius 42)
                  Container(
                    width: 31,
                    height: 2,
                    decoration: BoxDecoration(
                      color: AppColors.brandPalette.shade600,
                      borderRadius: BorderRadius.circular(42),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Title row with rocket icon
                  Row(
                    children: [
                      const RtcImage(
                        image: 'assets/images/ic_rocket.svg',
                        width: 20,
                        height: 20,
                        boxFit: BoxFit.contain,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        update.title ?? S.current.updateLabel,
                        style: textTheme.bodyLarge?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.grayPalette.shade900,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: AppColors.grayPalette.shade200,
            ),

            // Scrollable Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Illustration - no box, no border, pure centered graphic (120x122)
                    Container(
                      height: 122,
                      alignment: Alignment.center,
                      child: const RtcImage(
                        image: 'assets/images/app_update_illustration.svg',
                        width: 120,
                        height: 122,
                        boxFit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Version Title & Subtitle
                    Text(
                      'نسخه ${update.version}',
                      style: textTheme.titleMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grayPalette.shade900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'نسخه جدید برنامه آماده دریافت و نصب است.',
                      style: textTheme.bodyMedium?.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.grayPalette.shade700,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Dashed Divider matching Figma (Vector 666, strokeDashes=[4.0, 4.0])
                    const RtcDashSeparator(
                      height: 1,
                      dashWidth: 4,
                      dashSpace: 4,
                    ),
                    const SizedBox(height: 12),

                    // Changelog Section
                    if (hasChanges) ...[
                      Text(
                        'تغییرات نسخه جدید:',
                        style: textTheme.bodyMedium?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.grayPalette.shade900,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        constraints: const BoxConstraints(maxHeight: 220),
                        child: SingleChildScrollView(
                          child: Text(
                            update.changeLog!,
                            style: textTheme.bodyMedium?.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              height: 1.8,
                              color: AppColors.grayPalette.shade700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // Action Buttons
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.grayPalette.shade50,
                border: Border(
                  top: BorderSide(
                    color: AppColors.grayPalette.shade200,
                    width: 1,
                  ),
                ),
              ),
              child: update.isForce
                  ? RtcButton(
                      height: 44,
                      fitTitle: true,
                      title: 'بروزرسانی برنامه',
                      backgroundColor: AppColors.brandPalette.shade600,
                      styleBtn: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      onPressed: () => _handleUpdatePress(context),
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: RtcButton(
                            height: 44,
                            fitTitle: true,
                            title: 'بروزرسانی برنامه',
                            backgroundColor: AppColors.brandPalette.shade600,
                            styleBtn: textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                            onPressed: () => _handleUpdatePress(context),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: RtcButton(
                            height: 44,
                            fitTitle: true,
                            title: 'بعداً',
                            backgroundColor: AppColors.grayPalette.shade50,
                            borderColor: AppColors.grayPalette.shade300,
                            styleBtn: textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: AppColors.grayPalette.shade700,
                            ),
                            onPressed: () => _handleSkipPress(context),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class RtcDashSeparator extends StatelessWidget {
  const RtcDashSeparator({
    super.key,
    this.height = 1,
    this.color,
    this.dashWidth = 4.0,
    this.dashSpace = 4.0,
  });

  final double height;
  final Color? color;
  final double dashWidth;
  final double dashSpace;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(
            dashCount,
            (_) => SizedBox(
              width: dashWidth,
              height: height,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: color ?? AppColors.grayPalette.shade300,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
