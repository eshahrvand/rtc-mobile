import 'package:flutter/material.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'rtc_appbar.dart';
import 'rtc_image.dart';
import 'rtc_text_field.dart';
import 'package:rtc_mobile/config/config.dart';

class RtcSearchAppBar extends StatefulWidget implements PreferredSizeWidget {
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
  State<RtcSearchAppBar> createState() => _RtcSearchAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _RtcSearchAppBarState extends State<RtcSearchAppBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant RtcSearchAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Clear field when search is deactivated
    if (oldWidget.isSearchActive && !widget.isSearchActive) {
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isSearchActive) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: widget.showShadow ? AppColors.primaryShadow : null,
        ),
        child: SafeArea(
          bottom: false,
          child: Container(
            height: kToolbarHeight,
            padding: const EdgeInsets.only(left: 16, right: 16, top: 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: RtcTextField(
                    controller: _controller,
                    autoFocus: true,
                    hintText: widget.searchHint,
                    labelText: widget.searchLabel,
                    hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.grayPalette.shade400,
                    ),
                    onChanged: (value) {
                      widget.onSearchChanged(value);
                      setState(() {}); // Show/hide clear icon
                    },
                    prefix:
                        widget.searchPrefix ??
                        RtcImage(
                          image: '$baseImage/search.svg',
                          width: 20,
                          height: 20,
                          color: AppColors.grayPalette.shade400,
                        ),
                    suffix:
                        widget.searchSuffix ??
                        (_controller.text.isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  _controller.clear();
                                  widget.onSearchChanged('');
                                  setState(() {});
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: RtcImage(
                                    image: '$baseImage/close.svg',
                                    width: 20,
                                    height: 20,
                                    color: AppColors.grayPalette.shade700,
                                    boxFit: BoxFit.fill,
                                  ),
                                ),
                              )
                            : null),
                    bowShadow: const [],
                  ),
                ),
                const SizedBox(width: 15),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: GestureDetector(
                    onTap: widget.onSearchDeactivated,
                    child: Text(
                      "لغو",
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: AppColors.brandPalette.shade600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // NORMAL UI: Keep the high-fidelity RtcAppBar
    return RtcAppBar(
      showShadow: widget.showShadow,
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: GestureDetector(
          onTap: () => widget.scaffoldKey.currentState?.openDrawer(),
          child: RtcImage(
            image: '$baseImage/drawer_menu.svg',
            width: 24,
            height: 24,
          ),
        ),
      ),
      title: widget.title,
      titleStyle: widget.titleStyle,
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: GestureDetector(
            onTap: widget.onSearchActivated,
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
}
