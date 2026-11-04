import 'package:flutter/material.dart';
import '../theme/colors.dart';
import 'rtc_image.dart';

/// Read-only key/value presentation shared by profiles and branch details.
class RtcInfoRow extends StatelessWidget {
  const RtcInfoRow({
    super.key,
    required this.label,
    this.value = '',
    this.child,
    this.multiline = false,
    this.backgroundColor,
  });
  final String label, value;
  final Widget? child;
  final bool multiline;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final labelWidget = Text(
      label,
      style: text.bodyMedium?.copyWith(
        fontSize: 12,
        height: 1.5,
        fontWeight: FontWeight.w500,
        color: AppColors.grayPalette.shade700,
      ),
    );
    final valueWidget =
        child ??
        Text(
          value,
          textAlign: TextAlign.start,
          style: text.bodyLarge?.copyWith(
            fontSize: 14,
            height: 24 / 14,
            fontWeight: FontWeight.w500,
            color: AppColors.workspaceTextStrong,
          ),
        );
    return Container(
      constraints: const BoxConstraints(minHeight: 44),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.grayPalette.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: multiline
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [labelWidget, const SizedBox(height: 8), valueWidget],
            )
          : Row(
              children: [
                labelWidget,
                const SizedBox(width: 12),
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: valueWidget,
                  ),
                ),
              ],
            ),
    );
  }
}

class RtcInfoSection extends StatelessWidget {
  const RtcInfoSection({
    super.key,
    required this.title,
    required this.icon,
    required this.children,
  });
  final String title, icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            RtcImage(
              image: icon,
              width: 22,
              height: 22,
              boxFit: BoxFit.contain,
            ),
            const SizedBox(width: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.workspaceTextStrong,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Divider(height: 1, thickness: 1, color: AppColors.grayPalette.shade200),
        for (final child in children) ...[const SizedBox(height: 12), child],
      ],
    ),
  );
}
