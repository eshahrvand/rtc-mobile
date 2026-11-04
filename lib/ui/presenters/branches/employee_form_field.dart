import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/colors.dart';
import '../../widget/rtc_text_field.dart';

class EmployeeFormField extends StatefulWidget {
  const EmployeeFormField({
    super.key,
    required this.label,
    required this.initialValue,
    required this.hint,
    required this.onChanged,
    this.numeric = false,
    this.maxLength,
    this.enabled = true,
    this.errorText,
  });
  final String label, initialValue, hint;
  final ValueChanged<String> onChanged;
  final bool numeric, enabled;
  final int? maxLength;
  final String? errorText;
  @override
  State<EmployeeFormField> createState() => _EmployeeFormFieldState();
}

class _EmployeeFormFieldState extends State<EmployeeFormField> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.initialValue,
  );
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => RtcTextField(
    controller: _controller,
    labelText: widget.label,
    hintText: widget.hint,
    readOnly: !widget.enabled,
    labelStyle: Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
    hintStyle: Theme.of(
      context,
    ).textTheme.bodyLarge?.copyWith(color: AppColors.grayPalette.shade400),
    keyboardType: widget.numeric ? TextInputType.number : TextInputType.text,
    inputFormatters: widget.numeric
        ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9۰-۹٠-٩]'))]
        : null,
    maxLength: widget.maxLength,
    textStyle: Theme.of(context).textTheme.bodyLarge,
    isError: widget.errorText != null,
    helper: widget.errorText == null
        ? null
        : Align(
            alignment: Alignment.centerRight,
            child: Text(
              widget.errorText!,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.errorPalette.shade600,
              ),
            ),
          ),
    onChanged: widget.onChanged,
  );
}
