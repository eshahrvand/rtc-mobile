import 'package:flutter/material.dart';
import '../theme/colors.dart';
import 'rtc_image.dart';
import 'rtc_text_field.dart';

/// The project's standard text-field appearance, opening a selection sheet.
class RtcSelectionField extends StatefulWidget {
  const RtcSelectionField({
    super.key,
    required this.hint,
    required this.onTap,
    this.value,
    this.enabled = true,
  });
  final String hint;
  final String? value;
  final VoidCallback onTap;
  final bool enabled;
  @override
  State<RtcSelectionField> createState() => _RtcSelectionFieldState();
}

class _RtcSelectionFieldState extends State<RtcSelectionField> {
  late final _controller = TextEditingController(text: widget.value);
  @override
  void didUpdateWidget(covariant RtcSelectionField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) _controller.text = widget.value ?? '';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    enabled: widget.enabled,
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.enabled ? widget.onTap : null,
      child: IgnorePointer(
        child: RtcTextField(
          readOnly: true,
          controller: _controller,
          textStyle: Theme.of(context).textTheme.bodyLarge,
          hintText: widget.hint,
          hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: widget.value == null
                ? AppColors.grayPalette.shade400
                : AppColors.workspaceTextStrong,
            height: 20 / 14,
          ),
          suffix: const Padding(
            padding: EdgeInsetsDirectional.only(end: 12),
            child: RtcImage(
              image: 'assets/images/invoice_branch_chevron.svg',
              width: 20,
              height: 20,
              boxFit: BoxFit.contain,
            ),
          ),
        ),
      ),
    ),
  );
}
