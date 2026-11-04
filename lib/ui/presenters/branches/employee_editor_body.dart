import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../generated/l10n.dart';
import '../../theme/colors.dart';
import '../../widget/rtc_image.dart';
import '../../widget/rtc_selection_field.dart';
import '../../../core/models/filter_item.dart';
import '../../../repository/workspace/workspace_mapper.dart';
import '../products/widget/filter_bottom_sheet.dart';
import '../workspace/bloc/workspace_state.dart';
import '../workspace/bloc/workspace_cubit.dart';
import 'employee_form_cubit.dart';
import 'employee_form_field.dart';

class EmployeeEditorBody extends StatelessWidget {
  const EmployeeEditorBody({
    super.key,
    required this.workspace,
    required this.loading,
  });
  final WorkspaceState workspace;
  final bool loading;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EmployeeFormCubit>();
    final form = cubit.state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        EmployeeFormField(
          label: S.current.employeeFirstNameRequired,
          initialValue: form.firstName,
          hint: S.current.employeeFirstNameHint,
          onChanged: (v) => cubit.update('firstName', v),
          enabled: !loading,
        ),
        const SizedBox(height: 20),
        EmployeeFormField(
          label: S.current.employeeLastNameRequired,
          initialValue: form.lastName,
          hint: S.current.employeeLastNameHint,
          onChanged: (v) => cubit.update('lastName', v),
          enabled: !loading,
        ),
        const SizedBox(height: 20),
        EmployeeFormField(
          label: S.current.employeeNationalIdRequired,
          initialValue: form.nationalId,
          hint: S.current.employeeNationalIdHint,
          onChanged: (v) {
            cubit.update('nationalId', v);
            context.read<WorkspaceCubit>().clearEmployeeFieldError(
              'national_code',
            );
          },
          errorText:
              cubit.nationalIdError ??
              workspace.employeeFieldErrors['national_code']?.firstOrNull,
          maxLength: 10,
          numeric: true,
          enabled: !loading,
        ),
        const SizedBox(height: 20),
        EmployeeFormField(
          label: S.current.employeeMobileRequired,
          initialValue: form.mobile,
          hint: S.current.employeeMobileHint,
          onChanged: (v) {
            cubit.update('mobile', v);
            context.read<WorkspaceCubit>().clearEmployeeFieldError('mobile');
          },
          errorText:
              cubit.mobileError ??
              workspace.employeeFieldErrors['mobile']?.firstOrNull,
          maxLength: 11,
          numeric: true,
          enabled: !loading,
        ),
        const SizedBox(height: 20),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            S.current.employeePositionRequired,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 8),
        RtcSelectionField(
          hint: S.current.employeePositionHint,
          value: form.position.isEmpty ? null : form.position,
          enabled: !loading,
          onTap: () => FilterBottomSheet.show(
            context,
            showClearAction: false,
            applyButtonTitle: S.current.confirm,
            title: S.current.employeePosition,
            subtitle: S.current.employeePositionHint,
            items: WorkspaceMapper.positions.entries
                .map((entry) => FilterItem(id: entry.key, title: entry.value))
                .toList(),
            initialSelectedId: WorkspaceMapper.positions.entries
                .where((entry) => entry.value == form.position)
                .firstOrNull
                ?.key,
            onApply: (item) {
              if (item != null) cubit.update('position', item.title);
            },
            onClear: () => cubit.update('position', ''),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            GestureDetector(
              onTap: loading ? null : () => cubit.setActive(!form.isActive),
              child: RtcImage(
                image: form.isActive
                    ? 'assets/images/toggle_active.svg'
                    : 'assets/images/toggle_base.svg',
                width: 36,
                height: 20,
                boxFit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 8),
            Text(form.isActive ? S.current.active : S.current.inactive),
          ],
        ),
        if (workspace.employeeSaveStatus == WorkspaceStatus.error) ...[
          const SizedBox(height: 12),
          Text(
            workspace.errorMessage,
            style: TextStyle(color: AppColors.errorPalette.shade600),
          ),
        ],
      ],
    );
  }
}
