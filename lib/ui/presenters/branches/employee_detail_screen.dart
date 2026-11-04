import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../generated/l10n.dart';
import '../../../config/snackbar.dart';
import '../../widget/rtc_appbar.dart';
import '../../widget/rtc_info_row.dart';
import '../../widget/rtc_active_badge.dart';
import '../../widget/rtc_image.dart';
import '../../theme/colors.dart';
import '../workspace/bloc/workspace_cubit.dart';
import '../workspace/bloc/workspace_state.dart';
import 'employee_editor_sheet.dart';

class EmployeeDetailScreen extends StatefulWidget {
  const EmployeeDetailScreen({super.key, required this.employeeId});
  final String employeeId;
  @override
  State<EmployeeDetailScreen> createState() => _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends State<EmployeeDetailScreen> {
  String get employeeId => widget.employeeId;
  @override
  void initState() {
    super.initState();
    context.read<WorkspaceCubit>().loadEmployeeDetails(employeeId);
  }

  @override
  Widget build(
    BuildContext context,
  ) => BlocConsumer<WorkspaceCubit, WorkspaceState>(
    listenWhen: (previous, current) =>
        previous.errorMessage != current.errorMessage &&
        current.errorMessage.isNotEmpty,
    listener: (context, state) => rtcSnackBar(
      context: context,
      type: SnackBarType.error,
      message: state.errorMessage,
    ),
    builder: (context, state) {
      final employee = state.employees
          .where((employee) => employee.id == employeeId)
          .firstOrNull;
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: RtcAppBar(
          toolbarHeight: 64,
          titleStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.grayPalette.shade800,
          ),
          title: S.current.branchUserInformation,
          onBack: () => context.pop(),
          backIconPath: 'assets/images/angle-right.svg',
          actions: [
            if (employee != null && state.canManageBranches)
              IconButton(
                tooltip: S.current.editBranchUserTitle,
                onPressed: () =>
                    EmployeeEditorSheet.show(context, employee: employee).then((
                      _,
                    ) {
                      if (context.mounted &&
                          !context.read<WorkspaceCubit>().state.employees.any(
                            (e) => e.id == employeeId,
                          )) {
                        context.pop();
                      }
                    }),
                icon: const RtcImage(
                  image: 'assets/images/workspace_edit.svg',
                  width: 24,
                  height: 24,
                  boxFit: BoxFit.contain,
                ),
              ),
            const SizedBox(width: 16),
          ],
        ),
        body: employee == null
            ? const SizedBox.shrink()
            : SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                        child: Container(
                          width: 96,
                          height: 96,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.grayPalette.shade50,
                            border: Border.all(color: Colors.white, width: 4),
                            boxShadow: AppColors.primaryShadow,
                          ),
                          child: ClipOval(
                            child: Padding(
                              padding: EdgeInsets.all(
                                employee.avatar == null ? 11.5 : 0,
                              ),
                              child: RtcImage(
                                image:
                                    employee.avatar ??
                                    'assets/images/workspace_user.svg',
                                width: 88,
                                height: 88,
                                boxFit: employee.avatar == null
                                    ? BoxFit.contain
                                    : BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      RtcInfoSection(
                        title: S.current.userInformation,
                        icon: 'assets/images/workspace_user_info.svg',
                        children: [
                          RtcInfoRow(
                            label: S.current.statusLabel,
                            child: RtcActiveBadge(isActive: employee.isActive),
                          ),
                          RtcInfoRow(
                            label: S.current.fullNameLabel,
                            value: employee.fullName,
                          ),
                          RtcInfoRow(
                            label: S.current.nationalId,
                            value: employee.nationalId,
                          ),
                          RtcInfoRow(
                            label: S.current.mobileLabel,
                            value: employee.mobile,
                          ),
                          RtcInfoRow(
                            label: S.current.employeePosition,
                            value: employee.position,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      );
    },
  );
}
