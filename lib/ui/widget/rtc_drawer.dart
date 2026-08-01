import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/constants.dart';
import 'package:rtc_mobile/ui/router/app_route.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_divider.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';
import '../../../generated/l10n.dart';
import '../presenters/dashboard/bloc/dashboard_cubit.dart';
import '../presenters/dashboard/bloc/dashboard_state.dart';
import '../presenters/dashboard/widget/log_out_botttom_sheet.dart';
import '../presenters/report/bloc/report_step.dart';

class RtcDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String? userName;
  final String? userRole;
  final String? userAvatar;

  const RtcDrawer({
    super.key,
    required this.scaffoldKey,
    this.userName,
    this.userRole,
    this.userAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 12, left: 12, top: 16),
                child: ListView(
                  children: [
                    _DrawerMenuItem(
                      title: S.current.myCustomers,
                      iconPath: '$baseImage/family.svg',
                      onTap: () {
                        scaffoldKey.currentState?.closeDrawer();
                        context.push(AppRoutes.customers);
                      },
                    ),
                    RtcDivider(
                      height: 0.5,
                      color: AppColors.grayPalette.shade200,
                    ),
                    _DrawerMenuItem(
                      title: S.current.releaseFactor,
                      iconPath: '$baseImage/invoice.svg',
                      onTap: () {
                        scaffoldKey.currentState?.closeDrawer();
                        context.push(AppRoutes.preInvoice);
                      },
                    ),
                    RtcDivider(
                      height: 0.5,
                      color: AppColors.grayPalette.shade200,
                    ),
                    _DrawerMenuItem(
                      title: S.current.wallet,
                      iconPath: '$baseImage/wallet_drawer.svg',
                      onTap: () {
                        scaffoldKey.currentState?.closeDrawer();
                        context.push(AppRoutes.wallet);
                      },
                    ),
                    RtcDivider(
                      height: 0.5,
                      color: AppColors.grayPalette.shade200,
                    ),
                    _ExpandableDrawerMenuItem(
                      title: 'گزارشات',
                      iconPath: '$baseImage/chart-pie.2.svg',
                      subItems: [
                        _DrawerSubItem(
                          title: 'فروش',
                          onTap: () {
                            scaffoldKey.currentState?.closeDrawer();
                            context.push(AppRoutes.reports,
                                extra: ReportStep.sales);
                          },
                        ),
                        _DrawerSubItem(
                          title: 'طرح‌ها',
                          onTap: () {
                            scaffoldKey.currentState?.closeDrawer();
                            context.push(AppRoutes.reports,
                                extra: ReportStep.plan);
                          },
                        ),
                        _DrawerSubItem(
                          title: 'دسته‌بندی کالاها',
                          onTap: () {
                            scaffoldKey.currentState?.closeDrawer();
                            context.push(AppRoutes.reports,
                                extra: ReportStep.category);
                          },
                        ),
                        _DrawerSubItem(
                          title: 'محصولات',
                          onTap: () {
                            scaffoldKey.currentState?.closeDrawer();
                            context.push(AppRoutes.reports,
                                extra: ReportStep.products);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            BlocBuilder<DashboardCubit, DashboardState>(
              builder: (context, state) {
                if (state.appVersion.isEmpty) return const SizedBox.shrink();
                return Center(
                  child: Text(
                    'نسخه (${state.buildNumber}) ${state.appVersion}',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.grayPalette.shade600,
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 12),

            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 72,
      color: AppColors.grayPalette.shade25,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 15, 16, 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RtcImage(image: '$baseImage/rtc_logo.png', width: 80, height: 42),
            Spacer(),
            IconButton(
              onPressed: () => scaffoldKey.currentState?.closeDrawer(),
              icon: RtcImage(
                image: "$baseImage/close.svg",
                height: 24,
                width: 24,
                color: AppColors.grayPalette.shade900,
                boxFit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        final profile = state.userProfile;

        return Column(
          children: [
            const RtcDivider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 25, 24, 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      scaffoldKey.currentState?.closeDrawer();
                      context.push(AppRoutes.profile, extra: profile);
                    },
                    child: RtcImage(
                      image:
                          // profile??.file ?? userAvatar ??
                          '$baseImage/Avatar.png',
                      width: 40,
                      height: 40,
                      isCircle: true,
                      circleWidth: 40,
                      circleHeight: 40,
                    ),
                  ),

                  const SizedBox(width: 12),
                  Column(
                    spacing: 2,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile != null
                            ? '${profile.firstName} ${profile.lastName}'
                            : userName ?? '',
                        style: theme.bodyLarge!.copyWith(
                          color: AppColors.grayPalette.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        profile?.agentType == 'natural'
                            ? S.current.naturalAgent
                            : S.current.legalAgent,
                        style: theme.bodyMedium!.copyWith(
                          color: AppColors.grayPalette.shade600,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      showLogOutBottomSheet(context: context);
                    },
                    icon: RtcImage(
                      image: "$baseImage/door_close.svg",
                      width: 24,
                      height: 24,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
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
        padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
        child: Row(
          spacing: 12,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RtcImage(image: iconPath, width: 20, height: 20),
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
    final bgColor =
        _isExpanded ? AppColors.brandPalette.shade25 : Colors.transparent;

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
