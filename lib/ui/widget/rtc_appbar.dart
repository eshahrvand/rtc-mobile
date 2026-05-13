import 'package:flutter/material.dart';
import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'rtc_image.dart';

class RtcAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final VoidCallback? onBack;
  final String? backIconPath;
  final double? elevation;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  const RtcAppBar({
    super.key,
    this.title,
    this.onBack,
    this.backIconPath,
    this.elevation,
    this.actions,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: AppColors.primaryShadow,
      ),
      child: AppBar(
        centerTitle: true,
        elevation: elevation ?? 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,

        leading: onBack != null
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
            : const SizedBox.shrink(),
        title: Text(
          title ?? '',
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: AppColors.grayPalette.shade600,
          ),
        ),
        actions: actions ?? [],
        bottom: bottom,
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));
}
