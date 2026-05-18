import 'package:flutter/material.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_divider.dart';

class PreInvoiceSectionWidget extends StatelessWidget {
  final String title;
  final Widget icon;
  final Widget child;
  final Widget? trailing;
  final bool showDivider;

  const PreInvoiceSectionWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
    this.trailing,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            spacing: 4,
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
              if (trailing != null) trailing!,
            ],
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
        child,
      ],
    );
  }
}
