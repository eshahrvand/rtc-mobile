import 'package:flutter/material.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_divider.dart';

class RtcCollapsibleSection extends StatelessWidget {
  final String title;
  final Widget icon;
  final bool isExpanded;
  final VoidCallback onToggle;
  final Widget child;
  final Widget? trailing;
  final bool showDivider;
  final EdgeInsets? padding;
  final double? headerSpacing;

  const RtcCollapsibleSection({
    super.key,
    required this.title,
    required this.icon,
    required this.isExpanded,
    required this.onToggle,
    required this.child,
    this.trailing,
    this.showDivider = true,
    this.padding,
    this.headerSpacing,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Column(
      children: [
        InkWell(
          onTap: onToggle,
          child: Padding(
            padding: padding ?? const EdgeInsets.all(16.0),
            child: Row(
              spacing: headerSpacing ?? 4,
              children: [
                icon,
                Text(
                  title,
                  style: theme.labelLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.grayPalette.shade900,
                  ),
                ),
                const Spacer(),
                trailing ?? const SizedBox.shrink(),
              ],
            ),
          ),
        ),
        if (showDivider)
          Padding(
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 8,
              right: 16,
              left: 16,
            ),
            child: RtcDivider(
              color: AppColors.grayPalette.shade900,
              height: 0.5,
            ),
          ),
        if (isExpanded) child,
      ],
    );
  }
}
