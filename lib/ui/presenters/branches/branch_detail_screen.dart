import '../../theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../generated/l10n.dart';
import '../../router/app_route.dart';
import '../../widget/rtc_appbar.dart';
import '../../widget/rtc_tab_bar.dart';
import '../../widget/rtc_info_row.dart';
import '../../widget/rtc_active_badge.dart';
import '../../widget/rtc_button.dart';
import '../workspace/bloc/workspace_cubit.dart';
import '../workspace/bloc/workspace_state.dart';
import 'branch_employees.dart';
import 'employee_editor_sheet.dart';

class BranchDetailScreen extends StatefulWidget {
  const BranchDetailScreen({super.key});
  @override
  State<BranchDetailScreen> createState() => _BranchDetailScreenState();
}

class _BranchDetailScreenState extends State<BranchDetailScreen> {
  late final PageController _pages;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final cubit = context.read<WorkspaceCubit>();
      final branch = cubit.state.selectedBranch;
      if (branch != null) cubit.selectBranch(branch);
    });
    _pages = PageController(
      initialPage: context.read<WorkspaceCubit>().state.branchTab,
    );
  }

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) => BlocConsumer<WorkspaceCubit, WorkspaceState>(
    listenWhen: (previous, current) => previous.branchTab != current.branchTab,
    listener: (context, state) {
      if (_pages.hasClients && _pages.page?.round() != state.branchTab) {
        _pages.animateToPage(
          state.branchTab,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
        );
      }
    },
    builder: (context, state) {
      final branch = state.selectedBranch;
      if (branch == null) {
        return Scaffold(
          appBar: RtcAppBar(
            toolbarHeight: 64,
            titleStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.grayPalette.shade800,
            ),
            onBack: () => context.go(AppRoutes.branches),
          ),
          body: Center(child: Text(S.current.noBranchesFound)),
        );
      }
      return Scaffold(
        appBar: RtcAppBar(
          toolbarHeight: 64,
          titleStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.grayPalette.shade800,
          ),
          title: branch.name,
          backIconPath: 'assets/images/angle-right.svg',
          onBack: () => context.pop(),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: RtcTabBar(
                  verticalPadding: 7,
                  tabs: [S.current.branchInformation, S.current.branchUsers],
                  selectedIndex: state.branchTab,
                  onTabChanged: context.read<WorkspaceCubit>().selectBranchTab,
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _pages,
                  onPageChanged: context.read<WorkspaceCubit>().selectBranchTab,
                  children: [
                    ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        RtcInfoRow(
                          label: S.current.statusLabel,
                          backgroundColor: Colors.white,
                          child: RtcActiveBadge(isActive: branch.isActive),
                        ),
                        const SizedBox(height: 8),
                        RtcInfoRow(
                          label: S.current.branchStoreName,
                          value: branch.name,
                          backgroundColor: Colors.white,
                        ),
                        const SizedBox(height: 8),
                        RtcInfoRow(
                          label: S.current.province,
                          value: branch.province,
                          backgroundColor: Colors.white,
                        ),
                        const SizedBox(height: 8),
                        RtcInfoRow(
                          label: S.current.city,
                          value: branch.city,
                          backgroundColor: Colors.white,
                        ),
                        const SizedBox(height: 8),
                        RtcInfoRow(
                          label: S.current.postalCodeLabel,
                          value: branch.postalCode,
                          backgroundColor: Colors.white,
                        ),
                        const SizedBox(height: 8),
                        RtcInfoRow(
                          label: S.current.address,
                          value: branch.address,
                          multiline: true,
                          backgroundColor: Colors.white,
                        ),
                      ],
                    ),
                    const BranchEmployees(),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: state.branchTab == 1 && state.canManageBranches
            ? SafeArea(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: RtcButton(
                    fitTitle: true,
                    title: S.current.addBranchUser,
                    styleBtn: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    onPressed: () => EmployeeEditorSheet.show(context),
                  ),
                ),
              )
            : null,
      );
    },
  );
}
