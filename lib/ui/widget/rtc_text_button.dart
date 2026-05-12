import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../theme/colors.dart';
import 'rtc_image.dart';

class RtcTextButton extends StatefulWidget {
  final String? title;
  final Function? onPressed;
  final TextStyle? styleBtn;
  final String? leftIcon;
  final Color? leftIconColor;
  final String? rightIcon;
  final Color? rightIconColor;
  final bool? isActive;
  final bool? isLoading;
  final EdgeInsets? padding;
  final double? height;
  final double? width;

  const RtcTextButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.styleBtn,
    this.leftIcon,
    this.rightIcon,
    this.isActive = true,
    this.isLoading = false,
    this.padding,
    this.height,
    this.width,
    this.leftIconColor,
    this.rightIconColor,
  });

  @override
  State<RtcTextButton> createState() => _RtcTextButtonState();
}

class _RtcTextButtonState extends State<RtcTextButton> {
  bool? isActive = true;
  bool? isLoading = false;

  @override
  void initState() {
    isActive = widget.isActive ?? true;
    isLoading = widget.isLoading ?? false;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant RtcTextButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    isActive = widget.isActive ?? true;
    isLoading = widget.isLoading ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Padding(
        padding: widget.padding ?? EdgeInsets.zero,
        child: GestureDetector(
          onTap: () {
            if (isActive! && !isLoading!) {
              widget.onPressed!();
            }
          },
          child: isLoading!
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.only(right: 40),
                    child: SizedBox(
                      height: 18,
                      width: 20,
                      child: LoadingIndicator(
                        indicatorType: Indicator.ballPulseSync,
                        colors: [Colors.black],
                        strokeWidth: 4.0,
                      ),
                    ),
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.leftIcon != null)
                      RtcImage(
                        image: widget.leftIcon ?? "",
                        color: widget.leftIconColor,
                      ),
                    if (widget.leftIcon != null) const SizedBox(width: 10),
                    Text(
                      widget.title ?? "",
                      style:
                          widget.styleBtn ??
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                            color: (widget.isActive ?? true)
                                ? AppColors.brandPalette.shade800
                                : AppColors.grayPalette.shade400,
                          ),
                    ),
                    if (widget.rightIcon != null) const SizedBox(width: 10),
                    if (widget.rightIcon != null)
                      RtcImage(
                        image: widget.rightIcon ?? "",
                        color: widget.rightIconColor,
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
