import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../generated/l10n.dart';
import '../../widget/rtc_appbar.dart';
import '../../widget/rtc_button.dart';
import '../../theme/colors.dart';
import '../workspace/bloc/workspace_cubit.dart';
import '../workspace/bloc/workspace_state.dart';
import 'terms_markdown.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});
  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<WorkspaceCubit>().loadTerms();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: RtcAppBar(
      toolbarHeight: 64,
      titleStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.grayPalette.shade800,
      ),
      title: S.current.termsTitle,
      backIconPath: 'assets/images/angle-right.svg',
      onBack: () => context.pop(),
    ),
    body: BlocBuilder<WorkspaceCubit, WorkspaceState>(
      builder: (context, state) {
        if (state.termsStatus == WorkspaceStatus.loading &&
            state.terms == null) {
          return const Center(child: CircularProgressIndicator());
        }
        final document = state.terms;
        if (document == null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    state.errorMessage.isEmpty
                        ? S.current.noPublishedPolicies
                        : state.errorMessage,
                    textAlign: TextAlign.center,
                  ),
                  if (state.termsStatus == WorkspaceStatus.error) ...[
                    const SizedBox(height: 16),
                    RtcButton(
                      fitTitle: true,
                      title: S.current.retryWorkspace,
                      onPressed: context.read<WorkspaceCubit>().loadTerms,
                    ),
                  ],
                ],
              ),
            ),
          );
        }
        return Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${S.current.termsPublishedAt}: ${document.publishedAt}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 12,
                    color: AppColors.grayPalette.shade300,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '${S.current.termsAcceptedAt}: ${document.acceptedAt ?? '—'}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: TermsMarkdown(data: document.markdown),
              ),
            ),
          ],
        );
      },
    ),
  );
}
