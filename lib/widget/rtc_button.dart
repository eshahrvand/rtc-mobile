import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../ui/theme/colors.dart';
import 'rtc_image.dart';

enum RtcButtonSize { small, medium, large }

class RtcButton extends StatefulWidget {
  final String? title;
  final Function? onPressed;
  final TextStyle? styleBtn;
  final Color? backgroundColor;
  final String? leftIcon;
  final Color? leftIconColor;
  final String? rightIcon;
  final Color? rightIconColor;
  final bool? isActive;
  final bool? isLoading;
  final bool? isLoadingBtm;
  final EdgeInsets? padding;
  final double? height;
  final double? width;
  final RtcButtonSize size;
  final Color? borderColor;

  const RtcButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.backgroundColor,
    this.styleBtn,
    this.leftIcon,
    this.rightIcon,
    this.isActive = true,
    this.isLoading = false,
    this.isLoadingBtm = false,
    this.padding,
    this.height,
    this.width,
    this.leftIconColor,
    this.rightIconColor,
    this.size = RtcButtonSize.medium,
    this.borderColor,
  });

  @override
  State<RtcButton> createState() => _RtcButtonState();
}

class _RtcButtonState extends State<RtcButton> {
  bool? isActive = true;
  bool? isLoading = false;
  bool? isLoadingBtm = false;

  @override
  void initState() {
    isActive = widget.isActive ?? true;
    isLoading = widget.isLoading ?? false;
    isLoadingBtm = widget.isLoadingBtm ?? false;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant RtcButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    isActive = widget.isActive ?? true;
    isLoading = widget.isLoading ?? false;
    isLoadingBtm = widget.isLoadingBtm ?? false;
  }

  double _getButtonHeight() {
    if (widget.height != null) return widget.height!;

    // According to Figma, active style height is 70 (likely including bar padding)
    // and deactive (disabled) lg style is 44.
    if (isActive ?? true) {
      return 70;
    }

    switch (widget.size) {
      case RtcButtonSize.small:
        return 40;
      case RtcButtonSize.medium:
        return 44;
      case RtcButtonSize.large:
        return 44;
    }
  }

  TextStyle _getTextStyle(BuildContext context) {
    final bool active = isActive ?? true;
    // Default text colors based on state and background
    Color textColor = active
        ? (widget.backgroundColor == null ||
                  widget.backgroundColor == Colors.white
              ? AppColors.brandPalette.shade600
              : Colors.white)
        : AppColors.grayPalette.shade400;

    switch (widget.size) {
      case RtcButtonSize.small:
      case RtcButtonSize.medium:
        return Theme.of(
          context,
        ).textTheme.titleMedium!.copyWith(color: textColor);

      case RtcButtonSize.large:
        return Theme.of(
          context,
        ).textTheme.titleLarge!.copyWith(color: textColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool active = isActive ?? true;

    // Figma Shadows
    final List<BoxShadow> shadows = active
        ? [
            const BoxShadow(
              color: Color(0x0F0A0D12),
              offset: Offset(1, 0),
              blurRadius: 2,
              spreadRadius: 0,
            ),
            const BoxShadow(
              color: Color(0x1A0A0D12),
              offset: Offset(1, 0),
              blurRadius: 3,
              spreadRadius: 0,
            ),
          ]
        : [
            const BoxShadow(
              color: Color(0x0D0A0D12),
              offset: Offset(0, 1),
              blurRadius: 2,
              spreadRadius: 0,
            ),
          ];

    final Color bgColor = active
        ? (widget.backgroundColor ?? Colors.white)
        : const Color(0xFFF5F5F5);

    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: Container(
        width: widget.width ?? (active ? 375 : 355),
        height: _getButtonHeight(),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: shadows,
          // Border is removed by default as per Figma spec, but kept if explicitly provided.
          border: widget.borderColor != null
              ? Border.all(color: widget.borderColor!, width: 1)
              : null,
        ),
        child: ElevatedButton(
          onPressed: () {
            if (active && !isLoading!) {
              widget.onPressed!();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: active
                ? AppColors.brandPalette.shade600
                : AppColors.grayPalette.shade400,
            elevation: 0,
            padding: active
                ? const EdgeInsets.fromLTRB(10, 10, 10, 16)
                : const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: isLoading!
              ? Center(
                  child: CircularProgressIndicator(
                    color: active
                        ? AppColors.brandPalette.shade600
                        : AppColors.grayPalette.shade400,
                  ),
                )
              : isLoadingBtm!
              ? SizedBox(
                  height: 18,
                  width: 20,
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballPulseSync,
                    colors: [
                      active
                          ? AppColors.brandPalette.shade600
                          : AppColors.grayPalette.shade400,
                    ],
                    strokeWidth: 4.0,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.leftIcon != null)
                      RtcImage(
                        image: widget.leftIcon ?? "",
                        color:
                            widget.leftIconColor ??
                            (active
                                ? AppColors.brandPalette.shade600
                                : AppColors.grayPalette.shade400),
                      ),
                    if (widget.leftIcon != null)
                      SizedBox(width: active ? 10 : 8),
                    Text(
                      widget.title ?? "",
                      style: widget.styleBtn ?? _getTextStyle(context),
                    ),
                    if (widget.rightIcon != null)
                      SizedBox(width: active ? 10 : 8),
                    if (widget.rightIcon != null)
                      RtcImage(
                        image: widget.rightIcon ?? "",
                        color:
                            widget.rightIconColor ??
                            (active
                                ? AppColors.brandPalette.shade600
                                : AppColors.grayPalette.shade400),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
