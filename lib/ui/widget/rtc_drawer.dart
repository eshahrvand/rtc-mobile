import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/ui/router/app_route.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_divider.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';
import '../../../generated/l10n.dart';

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
                      onTap: () => context.push(AppRoutes.customers),
                    ),
                    const RtcDivider(),
                    _DrawerMenuItem(
                      title: S.current.releaseFactor,
                      iconPath: '$baseImage/invoice.svg',
                      onTap: () => context.go(AppRoutes.profile),
                    ),
                    const RtcDivider(),
                    _DrawerMenuItem(
                      title: S.current.wallet,
                      iconPath: '$baseImage/wallet_drawer.svg',
                      onTap: () => context.go(AppRoutes.profile),
                    ),
                    const RtcDivider(),
                  ],
                ),
              ),
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
    return Column(
      children: [
        const RtcDivider(),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 25, 24, 25),
          child: Row(
            children: [
              RtcImage(
                image: userAvatar ?? '$baseImage/Avatar.png',
                width: 40,
                height: 40,
                isCircle: true,
                circleWidth: 40,
                circleHeight: 40,
              ),

              const SizedBox(width: 12),
              Column(
                spacing: 2,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    userName ?? 'آرش فرداد',
                    style: theme.bodyLarge!.copyWith(
                      color: AppColors.grayPalette.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    userRole ?? 'نماینده فروش',
                    style: theme.bodyMedium!.copyWith(
                      color: AppColors.grayPalette.shade600,
                    ),
                  ),
                ],
              ),

              const Spacer(),
              IconButton(
                onPressed: () {
                  context.go(AppRoutes.profile);
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
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
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
