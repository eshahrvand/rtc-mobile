import 'package:flutter/material.dart';
import 'rtc_appbar.dart';
import 'rtc_image.dart';
import 'rtc_text_field.dart';
import 'package:rtc_mobile/config/config.dart';

class RtcSearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isSearchActive;
  final String title;
  final TextStyle? titleStyle;
  final String? searchHint;
  final String? searchLabel;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onSearchActivated;
  final VoidCallback onSearchDeactivated;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Widget? searchPrefix;
  final Widget? searchSuffix;
  final bool showShadow;

  const RtcSearchAppBar({
    super.key,
    required this.isSearchActive,
    required this.title,
    this.titleStyle,
    this.searchHint,
    this.searchLabel,
    required this.onSearchChanged,
    required this.onSearchActivated,
    required this.onSearchDeactivated,
    required this.scaffoldKey,
    this.searchPrefix,
    this.searchSuffix,
    this.showShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    if (isSearchActive) {
      return RtcAppBar(
        showShadow: showShadow,
        actions: [
          GestureDetector(
            onTap: onSearchDeactivated,
            child: RtcImage(
              image: '$baseImage/close.svg',
              width: 24,
              height: 24,
            ),
          ),
        ],
        titleWidget: RtcTextField(
          autoFocus: true,
          hintText: searchHint,
          labelText: searchLabel,
          onChanged: onSearchChanged,
          prefix: searchPrefix,
          suffix: searchSuffix,
        ),
      );
    }

    return RtcAppBar(
      showShadow: showShadow,
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: GestureDetector(
          onTap: () => scaffoldKey.currentState?.openDrawer(),
          child: RtcImage(
            image: '$baseImage/drawer_menu.svg',
            width: 24,
            height: 24,
          ),
        ),
      ),
      title: title,
      titleStyle: titleStyle,
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: GestureDetector(
            onTap: onSearchActivated,
            child: RtcImage(
              image: '$baseImage/search-product.svg',
              width: 24,
              height: 24,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
