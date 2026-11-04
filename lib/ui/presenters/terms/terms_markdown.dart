import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import '../../theme/colors.dart';

class TermsMarkdown extends StatelessWidget {
  const TermsMarkdown({super.key, required this.data, this.compact = false});
  final String data;
  final bool compact;
  @override
  Widget build(BuildContext context) {
    final body = Theme.of(context).textTheme.bodyLarge!.copyWith(
      fontSize: 14,
      height: compact ? 20 / 14 : 24 / 14,
      color: AppColors.grayPalette.shade700,
    );
    return MarkdownBody(
      data: data,
      selectable: true,
      styleSheet: MarkdownStyleSheet(
        p: body,
        h1: body.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.workspaceTextStrong,
        ),
        h2: body.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.workspaceTextStrong,
        ),
        h3: body.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.workspaceTextStrong,
        ),
        horizontalRuleDecoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.grayPalette.shade200),
          ),
        ),
        blockSpacing: compact ? 8 : 12,
      ),
    );
  }
}
