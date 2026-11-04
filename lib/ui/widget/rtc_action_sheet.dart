import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/colors.dart';

class RtcActionSheet extends StatelessWidget {
  const RtcActionSheet({
    super.key,
    required this.title,
    required this.body,
    required this.actions,
    this.trailing,
    this.leading,
  });
  final String title;
  final Widget body, actions;
  final Widget? trailing, leading;

  static Future<T?> show<T>(BuildContext context, {required Widget child}) =>
      showModalBottomSheet<T>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        backgroundColor: Colors.transparent,
        barrierColor: AppColors.grayPalette.shade700.withValues(alpha: .55),
        builder: (sheetContext) => BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.viewInsetsOf(sheetContext).bottom,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(sheetContext).height * .92,
              ),
              child: child,
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => Material(
    color: AppColors.grayPalette.shade50,
    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
    clipBehavior: Clip.antiAlias,
    child: SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
            child: Column(
              children: [
                Container(
                  width: 31,
                  height: 2,
                  decoration: BoxDecoration(
                    color: AppColors.brandPalette.shade600,
                    borderRadius: BorderRadius.circular(42),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    if (leading != null) ...[
                      leading!,
                      const SizedBox(width: 8),
                    ],
                    Expanded(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 14,
                          height: 20 / 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.workspaceTextStrong,
                        ),
                      ),
                    ),
                    if (trailing != null) ...[
                      const SizedBox(width: 8),
                      trailing!,
                    ],
                  ],
                ),
              ],
            ),
          ),
          Divider(
            height: .5,
            thickness: .5,
            color: AppColors.grayPalette.shade300,
          ),
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
              child: body,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: actions,
          ),
        ],
      ),
    ),
  );
}
