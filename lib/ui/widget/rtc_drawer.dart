import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../generated/l10n.dart';
import '../../../core/models/workspace_models.dart';
import '../../config/constants.dart';
import '../router/app_route.dart';
import '../theme/colors.dart';
import 'rtc_divider.dart';
import 'rtc_image.dart';
import '../presenters/dashboard/widget/log_out_botttom_sheet.dart';
import '../presenters/report/bloc/report_step.dart';
import '../presenters/workspace/bloc/workspace_cubit.dart';
import '../presenters/workspace/bloc/workspace_state.dart';

class RtcDrawer extends StatelessWidget {
  const RtcDrawer({
    super.key,
    required this.scaffoldKey,
    this.onDashboardTabSelected,
    this.userName,
    this.userRole,
    this.userAvatar,
  });
  final GlobalKey<ScaffoldState> scaffoldKey;
  final ValueChanged<int>? onDashboardTabSelected;
  final String? userName, userRole, userAvatar;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<WorkspaceCubit, WorkspaceState>(
        builder: (context, state) {
          void navigate(String path, {Object? extra}) {
            scaffoldKey.currentState?.closeDrawer();
            context.push(path, extra: extra);
          }

          final items = <Widget>[
            _DrawerMenuItem(
              title: S.current.viewProducts,
              iconPath: '$baseImage/package-check.svg',
              onTap: () {
                scaffoldKey.currentState?.closeDrawer();
                if (onDashboardTabSelected != null) {
                  onDashboardTabSelected!(1);
                } else {
                  context.go('${AppRoutes.dashboard}?index=1');
                }
              },
            ),
            if (state.canManageBranches)
              _DrawerMenuItem(
                title: S.current.branchManagement,
                iconPath: '$baseImage/workspace_store.svg',
                onTap: () => navigate(AppRoutes.branches),
              ),
            _DrawerMenuItem(
              title: S.current.myCustomers,
              iconPath: '$baseImage/family.svg',
              onTap: () => navigate(AppRoutes.customers),
            ),
            _DrawerMenuItem(
              title: S.current.myOrders,
              iconPath: '$baseImage/shopping-cart-check.svg',
              onTap: () {
                scaffoldKey.currentState?.closeDrawer();
                if (onDashboardTabSelected != null) {
                  onDashboardTabSelected!(2);
                } else {
                  context.go(AppRoutes.orders);
                }
              },
            ),
            _DrawerMenuItem(
              title: S.current.releaseFactor,
              iconPath: '$baseImage/invoice.svg',
              onTap: () => navigate(AppRoutes.preInvoice),
            ),
            _DrawerMenuItem(
              title: S.current.wallet,
              iconPath: '$baseImage/wallet_drawer.svg',
              onTap: () => navigate(AppRoutes.wallet),
            ),
            _ExpandableDrawerMenuItem(
              title: S.current.workspaceReports,
              iconPath: '$baseImage/chart-pie.2.svg',
              subItems: [
                _DrawerSubItem(
                  title: S.current.workspaceSales,
                  onTap: () =>
                      navigate(AppRoutes.reports, extra: ReportStep.sales),
                ),
                _DrawerSubItem(
                  title: S.current.commissionDrawerTitle,
                  onTap: () => navigate(AppRoutes.commissionReport),
                ),
                _DrawerSubItem(
                  title: S.current.workspacePlans,
                  onTap: () =>
                      navigate(AppRoutes.reports, extra: ReportStep.plan),
                ),
                _DrawerSubItem(
                  title: S.current.workspaceCategories,
                  onTap: () =>
                      navigate(AppRoutes.reports, extra: ReportStep.category),
                ),
                _DrawerSubItem(
                  title: S.current.workspaceProducts,
                  onTap: () =>
                      navigate(AppRoutes.reports, extra: ReportStep.products),
                ),
              ],
            ),
            _DrawerMenuItem(
              title: S.current.termsTitle,
              iconPath: '$baseImage/workspace_security.svg',
              onTap: () => navigate(AppRoutes.terms),
            ),
          ];
          return Drawer(
            width: 295,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(),
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    height: 72,
                    color: AppColors.grayPalette.shade50,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        RtcImage(
                          image: '$baseImage/workspace_logo.png',
                          width: 80,
                          height: 42,
                          boxFit: BoxFit.contain,
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () =>
                              scaffoldKey.currentState?.closeDrawer(),
                          icon: RtcImage(
                            image: '$baseImage/workspace_close.svg',
                            width: 24,
                            height: 24,
                            boxFit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                      itemCount: items.length,
                      itemBuilder: (_, index) => items[index],
                      separatorBuilder: (_, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: RtcDivider(
                          height: .5,
                          color: AppColors.grayPalette.shade200,
                        ),
                      ),
                    ),
                  ),
                  RtcDrawerAccount(
                    state: state,
                    onProfile: () =>
                        navigate(AppRoutes.profile, extra: state.profile),
                  ),
                ],
              ),
            ),
          );
        },
      );
}

class RtcDrawerAccount extends StatelessWidget {
  const RtcDrawerAccount({
    super.key,
    required this.state,
    required this.onProfile,
  });
  final WorkspaceState state;
  final VoidCallback onProfile;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
    child: Column(
      children: [
        RtcDivider(height: 1, color: AppColors.grayPalette.shade200),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: onProfile,
                child: Row(
                  children: [
                    ClipOval(
                      child: state.avatarPreview != null
                          ? Image.memory(
                              state.avatarPreview!,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            )
                          : RtcImage(
                              image: state.avatar ?? '$baseImage/Avatar.png',
                              width: 40,
                              height: 40,
                              boxFit: BoxFit.cover,
                            ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${state.profile?.firstName ?? ''} ${state.profile?.lastName ?? ''}'
                                .trim(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            state.role == AccountRole.employee
                                ? state.position
                                : S.current.salesAgent,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: AppColors.grayPalette.shade600,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () => showLogOutBottomSheet(context: context),
              icon: RtcImage(
                image: '$baseImage/door_close.svg',
                width: 20,
                height: 20,
                boxFit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class _DrawerMenuItem extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback onTap;

  const _DrawerMenuItem({
    required this.title,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          spacing: 12,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RtcImage(
              image: iconPath,
              width: 20,
              height: 20,
              color: AppColors.grayPalette.shade600,
              boxFit: BoxFit.contain,
            ),
            Text(
              title,
              style: theme.bodyLarge!.copyWith(
                color: AppColors.grayPalette.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExpandableDrawerMenuItem extends StatefulWidget {
  final String title;
  final String iconPath;
  final List<_DrawerSubItem> subItems;

  const _ExpandableDrawerMenuItem({
    required this.title,
    required this.iconPath,
    required this.subItems,
  });

  @override
  State<_ExpandableDrawerMenuItem> createState() =>
      _ExpandableDrawerMenuItemState();
}

class _ExpandableDrawerMenuItemState extends State<_ExpandableDrawerMenuItem> {
  bool _isExpanded = false; // Default to expanded based on screenshot

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    final color = _isExpanded
        ? AppColors.brandPalette.shade600
        : AppColors.grayPalette.shade600;
    final iconColor = _isExpanded ? null : AppColors.grayPalette.shade600;
    final bgColor = _isExpanded
        ? AppColors.brandPalette.shade25
        : Colors.transparent;

    return Column(
      children: [
        InkWell(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: Container(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                RtcImage(
                  image: widget.iconPath,
                  width: 24,
                  height: 24,
                  color: iconColor,
                  boxFit: BoxFit.contain,
                ),
                const SizedBox(width: 12),
                Text(
                  widget.title,
                  style: theme.bodyLarge!.copyWith(
                    color: color,
                    fontWeight: _isExpanded ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
                const Spacer(),
                RtcImage(
                  image: _isExpanded
                      ? '$baseImage/arrow_up_tab.svg'
                      : '$baseImage/angle-down_tab.svg',
                  width: 16,
                  height: 16,
                  color: AppColors.grayPalette.shade900,
                  boxFit: BoxFit.contain,
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(children: widget.subItems),
          ),
      ],
    );
  }
}

class _DrawerSubItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isSelected;

  const _DrawerSubItem({
    required this.title,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.fromLTRB(16, 12, 41, 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.brandPalette.shade25
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          textAlign: TextAlign.right,
          style: theme.bodyLarge!.copyWith(
            color: isSelected
                ? AppColors.brandPalette.shade600
                : AppColors.grayPalette.shade600,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
