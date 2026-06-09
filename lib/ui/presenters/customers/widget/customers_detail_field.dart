import 'package:flutter/material.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_text_field.dart';

class CustomersDetailField extends StatelessWidget {
  final String label;
  final String value;
  final int? minLines;
  final int? maxLines;
  final double? lineHeight;
  final bool? isAddress;

  const CustomersDetailField({
    super.key,
    required this.label,
    required this.value,
    this.minLines,
    this.maxLines,
    this.lineHeight,
    this.isAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: RtcTextField(
        isAddress: isAddress,
        readOnly: true,
        isSetReadOnlyColor: true,
        labelText: label,
        labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.grayPalette.shade700,
            ),
        suffix: lineHeight != null ? const SizedBox(height: 0, width: 0) : null,
        minLines: minLines,
        maxLines: maxLines,
        controller: TextEditingController(text: value),
        textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppColors.grayPalette.shade700,
              height: lineHeight,
            ),
      ),
    );
  }
}
