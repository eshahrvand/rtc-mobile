import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import 'terms_markdown.dart';

class TermsScrollPane extends StatefulWidget {
  const TermsScrollPane({super.key, required this.markdown});
  final String markdown;
  @override
  State<TermsScrollPane> createState() => _TermsScrollPaneState();
}

class _TermsScrollPaneState extends State<TermsScrollPane> {
  final _scroll = ScrollController();
  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => RawScrollbar(
    controller: _scroll,
    thumbVisibility: true,
    thickness: 8,
    radius: const Radius.circular(4),
    crossAxisMargin: 4,
    thumbColor: AppColors.grayPalette.shade200,
    scrollbarOrientation: ScrollbarOrientation.left,
    child: SingleChildScrollView(
      controller: _scroll,
      padding: const EdgeInsets.only(left: 28),
      child: TermsMarkdown(data: widget.markdown, compact: true),
    ),
  );
}
