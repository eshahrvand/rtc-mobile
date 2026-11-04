import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../generated/l10n.dart';
import '../../router/app_route.dart';
import '../../widget/rtc_image.dart';
import '../../widget/rtc_button.dart';
import '../workspace/bloc/workspace_cubit.dart';
import '../workspace/bloc/workspace_state.dart';
import 'branch_card.dart';

class BranchEmployees extends StatelessWidget {
  const BranchEmployees({super.key});
  @override
  Widget build(
    BuildContext context,
  ) => BlocBuilder<WorkspaceCubit, WorkspaceState>(
    builder: (context, state) {
      if (state.employeesStatus == WorkspaceStatus.loading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state.employeesStatus == WorkspaceStatus.error) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(state.errorMessage),
              RtcButton(
                fitTitle: true,
                title: S.current.retryWorkspace,
                onPressed: () => context.read<WorkspaceCubit>().selectBranch(
                  state.selectedBranch!,
                ),
              ),
            ],
          ),
        );
      }
      if (state.employees.isEmpty) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
            child: Column(
              children: [
                SizedBox(
                  width: 101,
                  height: 85,
                  child: Stack(
                    children: [
                      const Positioned.fill(
                        child: RtcImage(
                          image: 'assets/images/workspace_group.svg',
                          width: 101,
                          height: 85,
                          boxFit: BoxFit.contain,
                        ),
                      ),
                      const Positioned(
                        top: 9,
                        left: 16,
                        child: RtcImage(
                          image: 'assets/images/workspace_user_viewfinder1.svg',
                          width: 64,
                          height: 64,
                          boxFit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(S.current.noBranchUsers, textAlign: TextAlign.center),
              ],
            ),
          ),
        );
      }
      return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: state.employees.length,
        separatorBuilder: (_, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final employee = state.employees[index];
          return BranchCard(
            title: employee.fullName,
            subtitle: employee.position,
            active: employee.isActive,
            icon: 'assets/images/workspace_employee_user.svg',
            onTap: () =>
                context.push(AppRoutes.employeeDetail, extra: employee.id),
          );
        },
      );
    },
  );
}
