import 'package:flutter/material.dart';
import '../theme/colors.dart';

class RtcCreditLimitField extends StatelessWidget {
  final String? labelText;
  final String? value;
  final Widget? helper;

  const RtcCreditLimitField({
    super.key,
    this.labelText,
    this.value,
    this.helper,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Column(
      children: [
        if (labelText != null)
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              labelText ?? "",
              style: theme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.grayPalette.shade700,
              ),
            ),
          ),
        if (labelText != null) const SizedBox(height: 8),
        Container(
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white, // TODO: replace with theme color
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.grayPalette.shade200,
              // TODO: replace with theme color
              width: 1,
            ),
            boxShadow: AppColors.fieldShadow,
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    value ?? '',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors
                          .grayPalette
                          .shade900, // TODO: replace with theme color
                    ),
                  ),
                ),
              ),
              // Badge "تومان"
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.brandPalette.shade600,
                  // TODO: replace with theme color
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  'تومان',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.white, // TODO: replace with theme color
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (helper != null) const SizedBox(height: 8),
        if (helper != null) helper!,
      ],
    );
  }
}
