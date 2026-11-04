import '../../theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../generated/l10n.dart';
import '../../router/app_route.dart';
import '../../widget/rtc_search_appbar.dart';
import '../../widget/rtc_button.dart';
import '../workspace/bloc/workspace_cubit.dart';
import '../workspace/bloc/workspace_state.dart';
import 'branch_card.dart';

class BranchesScreen extends StatefulWidget {
  const BranchesScreen({super.key});
  @override
  State<BranchesScreen> createState() => _BranchesScreenState();
}

class _BranchesScreenState extends State<BranchesScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<WorkspaceCubit>().loadBranches();
    });
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<WorkspaceCubit, WorkspaceState>(
        builder: (context, state) {
          final cubit = context.read<WorkspaceCubit>();
          return Scaffold(
            key: _scaffoldKey,
            appBar: RtcSearchAppBar(
              toolbarHeight: 64,
              isSearchActive: state.branchSearchActive,
              title: S.current.branchManagement,
              titleStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.grayPalette.shade800,
              ),
              searchHint: S.current.searchBranchHint,
              showDrawerIcon: false,
              scaffoldKey: _scaffoldKey,
              onBack: () => context.pop(),
              onSearchChanged: cubit.searchBranches,
              onSearchActivated: cubit.toggleBranchSearch,
              onSearchDeactivated: () {
                FocusScope.of(context).unfocus();
                cubit.toggleBranchSearch();
              },
            ),
            body: !state.canManageBranches
                ? Center(child: Text(S.current.branchAccessDenied))
                : state.branchesStatus == WorkspaceStatus.loading
                ? const Center(child: CircularProgressIndicator())
                : state.branchesStatus == WorkspaceStatus.error
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(state.errorMessage, textAlign: TextAlign.center),
                          const SizedBox(height: 16),
                          RtcButton(
                            fitTitle: true,
                            title: S.current.retryWorkspace,
                            onPressed: cubit.loadBranches,
                          ),
                        ],
                      ),
                    ),
                  )
                : state.filteredBranches.isEmpty
                ? Center(child: Text(S.current.noBranchesFound))
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.filteredBranches.length,
                    separatorBuilder: (_, index) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final branch = state.filteredBranches[index];
                      return BranchCard(
                        title: branch.name,
                        subtitle: '${branch.province} | ${branch.city}',
                        active: branch.isActive,
                        icon: 'assets/images/workspace_store.svg',
                        onTap: () {
                          cubit.openBranch(branch);
                          context.push(AppRoutes.branchDetail);
                        },
                      );
                    },
                  ),
          );
        },
      );
}
