import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/models/workspace_models.dart';
import '../../../generated/l10n.dart';
import '../../theme/colors.dart';
import '../../widget/rtc_action_sheet.dart';
import '../../widget/rtc_confirm_sheet.dart';
import '../../widget/rtc_button.dart';
import '../../widget/rtc_image.dart';
import '../workspace/bloc/workspace_cubit.dart';
import '../workspace/bloc/workspace_state.dart';
import 'employee_form_cubit.dart';
import 'employee_editor_body.dart';

class EmployeeEditorSheet extends StatelessWidget {
  const EmployeeEditorSheet({super.key, this.employee});
  final BranchEmployee? employee;

  static Future<void> show(BuildContext context, {BranchEmployee? employee}) {
    context.read<WorkspaceCubit>().resetEmployeeAction();
    return RtcActionSheet.show<void>(
      context,
      child: BlocProvider(
        create: (_) => EmployeeFormCubit(employee),
        child: EmployeeEditorSheet(employee: employee),
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) => BlocConsumer<WorkspaceCubit, WorkspaceState>(
    listenWhen: (previous, current) =>
        previous.employeeSaveStatus != current.employeeSaveStatus,
    listener: (context, state) {
      if (state.employeeSaveStatus == WorkspaceStatus.success) context.pop();
    },
    builder: (context, workspace) =>
        BlocBuilder<EmployeeFormCubit, EmployeeFormState>(
          builder: (context, form) {
            final cubit = context.read<EmployeeFormCubit>();
            final loading =
                workspace.employeeSaveStatus == WorkspaceStatus.loading;
            return RtcActionSheet(
              title: employee == null
                  ? S.current.addBranchUserTitle
                  : S.current.editBranchUserTitle,
              trailing: employee == null
                  ? null
                  : IconButton(
                      padding: const EdgeInsets.only(right: 16),
                      tooltip: S.current.deleteBranchUser,
                      onPressed: loading
                          ? null
                          : () {
                              RtcActionSheet.show<bool>(
                                context,
                                child: RtcConfirmSheet(
                                  title: S.current.deleteBranchUser,
                                  message: S.current.deleteBranchUserMessage(
                                    employee!.fullName,
                                  ),
                                  confirmLabel:
                                      S.current.confirmDeleteBranchUser,
                                  cancelLabel: S.current.cancelWorkspace,
                                  destructive: true,
                                ),
                              ).then((confirmed) {
                                if (confirmed == true && context.mounted) {
                                  context.read<WorkspaceCubit>().deleteEmployee(
                                    employee!,
                                  );
                                }
                              });
                            },
                      icon: RtcImage(
                        image: 'assets/images/delete.svg',
                        width: 20,
                        height: 20,
                        color: AppColors.errorPalette.shade600,
                        boxFit: BoxFit.contain,
                      ),
                    ),
              body: EmployeeEditorBody(workspace: workspace, loading: loading),
              actions: Row(
                children: [
                  Expanded(
                    child: RtcButton(
                      fitTitle: true,
                      title: S.current.back,
                      isActive: !loading,
                      backgroundColor: AppColors.grayPalette.shade50,
                      borderColor: AppColors.grayPalette.shade300,
                      styleBtn: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.grayPalette.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                      onPressed: () => context.pop(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: RtcButton(
                      fitTitle: true,
                      title: employee == null
                          ? S.current.saveBranchUser
                          : S.current.saveBranchUserChanges,
                      isActive: cubit.isValid,
                      isLoading: loading,
                      styleBtn: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: cubit.isValid
                            ? Colors.white
                            : AppColors.grayPalette.shade300,
                      ),
                      onPressed: () =>
                          context.read<WorkspaceCubit>().saveEmployee(
                            cubit.buildEmployee(
                              branchId: workspace.selectedBranch!.id,
                              id: employee?.id,
                              avatar: employee?.avatar,
                            ),
                          ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
  );
}
