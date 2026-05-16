import 'package:flutter/material.dart';
import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'rtc_image.dart';

class RtcAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final TextStyle? titleStyle;
  final VoidCallback? onBack;
  final Widget? leading;
  final String? backIconPath;
  final double? elevation;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final bool centerTitle;
  final bool showShadow;
  final Color backgroundColor;

  const RtcAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.titleStyle,
    this.onBack,
    this.leading,
    this.backIconPath,
    this.elevation,
    this.actions,
    this.bottom,
    this.centerTitle = true,
    this.showShadow = true,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final Widget appBar = AppBar(
      centerTitle: centerTitle,
      elevation: elevation ?? 0,
      scrolledUnderElevation: 0,
      backgroundColor: backgroundColor,
      surfaceTintColor: Colors.transparent,
      leading: leading ??
          (onBack != null
              ? GestureDetector(
                  onTap: onBack,
                  child: Container(
                    padding: const EdgeInsets.only(
                      right: 16,
                      top: 12,
                      bottom: 12,
                    ),
                    alignment: Alignment.center,
                    child: RtcImage(
                      image: backIconPath ?? '$baseImage/close.svg',
                      width: 40,
                      height: 40,
                    ),
                  ),
                )
              : const SizedBox.shrink()),
      title: titleWidget ??
          Text(
            title ?? '',
            style: titleStyle ??
                Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: AppColors.grayPalette.shade600,
                    ),
          ),
      actions: actions ?? [],
      bottom: bottom,
    );

    if (!showShadow) return appBar;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: AppColors.primaryShadow,
      ),
      child: appBar,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));
}
