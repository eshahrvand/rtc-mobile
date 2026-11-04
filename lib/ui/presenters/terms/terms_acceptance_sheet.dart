import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/models/workspace_models.dart';
import '../../../generated/l10n.dart';
import '../../theme/colors.dart';
import '../../widget/rtc_action_sheet.dart';
import '../../widget/rtc_button.dart';
import '../../widget/rtc_image.dart';
import '../workspace/bloc/workspace_cubit.dart';
import '../workspace/bloc/workspace_state.dart';
import 'terms_scroll_pane.dart';

class TermsAcceptanceSheet extends StatelessWidget {
  const TermsAcceptanceSheet({super.key, required this.onLogout});
  final VoidCallback onLogout;

  @override
  Widget build(
    BuildContext context,
  ) => BlocBuilder<WorkspaceCubit, WorkspaceState>(
    builder: (context, state) {
      final cubit = context.read<WorkspaceCubit>();
      final employee = state.role == AccountRole.employee;
      final loading = state.termsStatus == WorkspaceStatus.loading;
      return RtcActionSheet(
        title: employee
            ? S.current.termsEmployeeTitle
            : S.current.termsUpdateTitle,
        leading: employee
            ? RtcImage(
                image: 'assets/images/waiting.svg',
                boxFit: BoxFit.contain,
                color: AppColors.grayPalette.shade600,
                width: 20,
                height: 20,
              )
            : null,
        trailing: !employee && state.terms != null
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.workspaceTextStrong,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  state.terms!.versionLabel,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              )
            : null,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              employee
                  ? S.current.termsEmployeeExplanation
                  : S.current.termsAgentDatedExplanation(
                      state.terms?.publishedAt ?? '—',
                    ),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 14,
                height: 24 / 14,
                fontWeight: employee ? FontWeight.w500 : FontWeight.w600,
                color: AppColors.grayPalette.shade700,
              ),
            ),
            if (!employee) ...[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.grayPalette.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: SizedBox(
                  height: (MediaQuery.sizeOf(context).height * .55).clamp(
                    0,
                    380,
                  ),
                  child: loading && state.terms == null
                      ? const Center(child: CircularProgressIndicator())
                      : TermsScrollPane(
                          markdown:
                              state.terms?.markdown ??
                              S.current.workspaceServicePending,
                        ),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: loading
                    ? null
                    : () => cubit.checkAgreement(!state.termsChecked),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: Checkbox(
                        value: state.termsChecked,
                        side: BorderSide(
                          color: AppColors.grayPalette.shade300,
                          width: 1,
                        ),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        activeColor: AppColors.brandPalette.shade600,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        onChanged: loading
                            ? null
                            : (value) => cubit.checkAgreement(value ?? false),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        S.current.termsAgreement,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 12,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (!employee && state.termsStatus == WorkspaceStatus.error) ...[
              const SizedBox(height: 12),
              RtcButton(
                title: S.current.retryWorkspace,
                onPressed: cubit.loadTerms,
              ),
            ],
            if (state.policyDownloadSaved) ...[
              const SizedBox(height: 12),
              Text(
                S.current.policyDownloadedSuccess,
                style: TextStyle(color: AppColors.successPalette.shade700),
              ),
            ],
            if (state.errorMessage.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                state.errorMessage,
                style: TextStyle(color: AppColors.errorPalette.shade600),
              ),
            ],
          ],
        ),
        actions: Row(
          children: [
            Expanded(
              flex: employee ? 1 : 0,
              child: RtcButton(
                fitTitle: true,
                width: employee ? double.infinity : 82,
                title: employee
                    ? S.current.exitWorkspace
                    : S.current.downloadTerms,
                backgroundColor: AppColors.grayPalette.shade50,
                borderColor: AppColors.grayPalette.shade300,
                isActive:
                    employee ||
                    state.terms?.id != null ||
                    state.terms?.downloadUrl != null,
                isLoading: !employee && state.policyDownloadLoading,
                styleBtn: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.grayPalette.shade700,
                ),
                onPressed: employee
                    ? onLogout
                    : state.terms?.id != null
                    ? cubit.downloadTerms
                    : () => launchUrl(
                        state.terms!.downloadUrl!,
                        mode: LaunchMode.externalApplication,
                      ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: RtcButton(
                fitTitle: true,
                title: employee
                    ? S.current.recheckTerms
                    : S.current.confirmNewTerms,
                isActive:
                    employee ||
                    (state.termsChecked &&
                        state.terms != null &&
                        !loading &&
                        state.termsStatus != WorkspaceStatus.error),
                isLoading: loading,
                styleBtn: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: employee || state.termsChecked
                      ? Colors.white
                      : AppColors.grayPalette.shade300,
                ),
                onPressed: employee ? cubit.recheckTerms : cubit.confirmTerms,
              ),
            ),
          ],
        ),
      );
    },
  );
}
