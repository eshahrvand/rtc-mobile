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
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.grayPalette.shade600,
                    ),
                  ),
                );
              },
            ),

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
