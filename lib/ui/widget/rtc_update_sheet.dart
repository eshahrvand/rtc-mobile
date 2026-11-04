import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/models/app_update_model.dart';
import '../../generated/l10n.dart';
import '../theme/colors.dart';
import 'rtc_button.dart';
import 'rtc_image.dart';

/// Displays the update bottom sheet.
///
/// If [update.isForce] is true:
/// - The sheet cannot be dismissed by tapping outside or dragging.
/// - The back button on Android is blocked.
/// - The skip / later button is hidden.
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
    final hasChanges = update.changeLog != null && update.changeLog!.trim().isNotEmpty;

    return Material(
      color: AppColors.grayPalette.shade50,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle & Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
              child: Column(
                children: [
                  Container(
                    width: 32,
                    height: 3,
                    decoration: BoxDecoration(
                      color: AppColors.grayPalette.shade300,
                      borderRadius: BorderRadius.circular(42),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.brandPalette.shade50,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: const RtcImage(
                          image: 'assets/images/trend-up.svg',
                          width: 20,
                          height: 20,
                          boxFit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          update.title ?? S.current.updateLabel,
                          style: textTheme.bodyLarge?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.workspaceTextStrong,
                          ),
                        ),
                      ),
                      if (!update.isForce)
                        InkWell(
                          onTap: () => _handleSkipPress(context),
                          borderRadius: BorderRadius.circular(20),
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: RtcImage(
                              image: 'assets/images/close.svg',
                              width: 14,
                              height: 14,
                              color: AppColors.grayPalette.shade600,
                              boxFit: BoxFit.contain,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              height: .5,
              thickness: .5,
              color: AppColors.grayPalette.shade300,
            ),

            // Scrollable Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Illustration Card
                    _UpdateIllustrationCard(version: update.version),
                    const SizedBox(height: 18),

                    // Version & Subtitle
                    Text(
                      'نسخه ${update.version}',
                      textAlign: TextAlign.center,
                      style: textTheme.titleLarge?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.workspaceTextStrong,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'نسخه جدید اپلیکیشن آماده دریافت و نصب است',
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium?.copyWith(
                        fontSize: 13,
                        color: AppColors.grayPalette.shade600,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Dashed Divider
                    const RtcDashSeparator(),
                    const SizedBox(height: 16),

                    // Changelog Section
                    if (hasChanges) ...[
                      Text(
                        'تغییرات نسخه جدید',
                        style: textTheme.titleMedium?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.workspaceTextStrong,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.grayPalette.shade200,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          update.changeLog!,
                          style: textTheme.bodyMedium?.copyWith(
                            fontSize: 13,
                            height: 1.7,
                            color: AppColors.grayPalette.shade700,
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
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: AppColors.primaryShadow,
                border: Border(
                  top: BorderSide(
                    color: AppColors.grayPalette.shade200,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  if (!update.isForce) ...[
                    Expanded(
                      child: RtcButton(
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
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: RtcButton(
                      fitTitle: true,
                      title: S.current.updateLabel,
                      backgroundColor: AppColors.brandPalette.shade600,
                      styleBtn: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      onPressed: () => _handleUpdatePress(context),
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

class _UpdateIllustrationCard extends StatelessWidget {
  const _UpdateIllustrationCard({required this.version});
  final String version;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.brandPalette.shade50,
            AppColors.brandPalette.shade100.withValues(alpha: .45),
          ],
        ),
        border: Border.all(
          color: AppColors.brandPalette.shade100,
          width: 1,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.brandPalette.shade100.withValues(alpha: .35),
            ),
          ),
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: AppColors.primaryShadow,
            ),
            padding: const EdgeInsets.all(14),
            child: Image.asset(
              'assets/images/rtc_logo.png',
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}

class RtcDashSeparator extends StatelessWidget {
  const RtcDashSeparator({
    super.key,
    this.height = 1,
    this.color,
    this.dashWidth = 5.0,
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
