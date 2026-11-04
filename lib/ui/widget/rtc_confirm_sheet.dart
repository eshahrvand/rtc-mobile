import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/colors.dart';
import 'rtc_action_sheet.dart';
import 'rtc_button.dart';

class RtcConfirmSheet extends StatelessWidget {
  const RtcConfirmSheet({
    super.key,
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.cancelLabel,
    this.destructive = false,
  });
  final String title, message, confirmLabel, cancelLabel;
  final bool destructive;
  @override
  Widget build(BuildContext context) => RtcActionSheet(
    title: title,
    body: Text(
      message,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontSize: 14,
        height: 24 / 14,
        fontWeight: FontWeight.w500,
        color: AppColors.workspaceTextStrong,
      ),
    ),
    actions: Row(
      children: [
        Expanded(
          child: RtcButton(
            fitTitle: true,
            title: cancelLabel,
            onPressed: () => context.pop(false),
            backgroundColor: AppColors.grayPalette.shade50,
            borderColor: AppColors.grayPalette.shade300,
            styleBtn: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.grayPalette.shade700,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: RtcButton(
            fitTitle: true,
            title: confirmLabel,
            onPressed: () => context.pop(true),
            backgroundColor: destructive
                ? AppColors.errorPalette.shade600
                : AppColors.brandPalette.shade600,
            styleBtn: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}
