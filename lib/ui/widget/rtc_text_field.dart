import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/colors.dart';

class RtcTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final TextStyle? labelStyle;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final TextInputType? keyboardType;
  final Alignment? alignment;
  final Widget? suffix;
  final Widget? prefix;
  final Widget? helper;
  final bool? readOnly;
  final bool? isSetReadOnlyColor;
  final bool? isError;
  final double? height;
  final double? width;
  final Color? borderColor;
  final EdgeInsets? contentPadding;
  final List<BoxShadow>? bowShadow;
  final TextAlign? textAlign;
  final bool? autoFocus;
  final FocusNode? focusNode;
  final Function? onChanged;
  final int? maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final String? error;
  final TextStyle? errorStyle;
  final bool? obscureText;

  const RtcTextField({
    super.key,
    this.controller,
    this.labelText,
    this.labelStyle,
    this.hintText,
    this.hintStyle,
    this.textStyle,
    this.keyboardType,
    this.alignment,
    this.suffix,
    this.prefix,
    this.helper,
    this.readOnly,
    this.isSetReadOnlyColor,
    this.height,
    this.width,
    this.borderColor,
    this.contentPadding,
    this.bowShadow,
    this.textAlign,
    this.autoFocus,
    this.focusNode,
    this.onChanged,
    this.maxLines = 1,
    this.maxLength,
    this.inputFormatters,
    this.error,
    this.errorStyle,
    this.obscureText,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (labelText != null)
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              labelText ?? "",
              style:
                  labelStyle ??
                  Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: AppColors.grayPalette.shade700,
                  ),
            ),
          ),
        if (labelText != null) const SizedBox(height: 8),
        Container(
          height: height ?? 44,
          width: width,
          decoration: BoxDecoration(
            // boxShadow: bowShadow ?? mediumShadow,
            color: (readOnly ?? false) && (isSetReadOnlyColor ?? false)
                ? AppColors.grayPalette.shade50
                : Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            obscureText: obscureText ?? false,
            controller: controller,
            focusNode: focusNode,
            style: textStyle != null
                ? textStyle!.copyWith(color: null)
                : textStyle,
            maxLines: maxLines,
            autofocus: autoFocus ?? false,
            readOnly: readOnly ?? false,
            keyboardType: keyboardType,
            maxLength: maxLength,
            inputFormatters: inputFormatters,
            onChanged: (value) {
              if (onChanged != null) onChanged!(value);
            },
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle:
                  hintStyle ??
                  Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: AppColors.grayPalette.shade400,
                  ),
              filled: true,
              fillColor: (readOnly ?? false) && (isSetReadOnlyColor ?? false)
                  ? AppColors.grayPalette.shade50
                  : Colors.white,
              contentPadding:
                  contentPadding ??
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: borderColor ?? Colors.transparent,
                  width: borderColor != null ? 1 : 0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: (isError ?? false)
                      ? AppColors.warningPalette.shade600
                      : borderColor ?? AppColors.grayPalette.shade200,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: (isError ?? false)
                      ? AppColors.warningPalette.shade600
                      : borderColor ?? Theme.of(context).primaryColor,
                  width: 1,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                // borderSide: BorderSide(
                //   color: borderColor ?? AppColors.warningPalette.shade600,
                //   width: 1,
                // ),
              ),
              prefixIcon: prefix != null
                  ? Padding(
                      padding: const EdgeInsets.only(right: 14, left: 8),
                      child: prefix,
                    )
                  : null,
              suffixIcon: SizedBox(
                width: 20,
                child: Align(alignment: Alignment.centerLeft, child: suffix),
              ),
              counterText: '',
              error: error != null
                  ? Container(
                      color: Colors.transparent,
                      child: Text(error ?? "", style: errorStyle),
                    )
                  : null,
            ),
          ),
        ),
        if (helper != null) const SizedBox(height: 8),
        if (helper != null) helper!,
      ],
    );
  }
}
