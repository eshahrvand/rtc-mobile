import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';
import '../bloc/dashboard_cubit.dart';

class DashboardRecentOrdersHeader extends StatelessWidget {
  const DashboardRecentOrdersHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            S.current.recentOrdersHeader,
            style: theme.labelLarge!.copyWith(
              color: AppColors.grayPalette.shade900,
              fontWeight: FontWeight.w600,
            ),
          ),
          GestureDetector(
            onTap: () => context.read<DashboardCubit>().onNavItemSelected(2),
            child: Container(
              width: 32.0,
              height: 32.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100.0),
              ),
              child: RtcImage(
                image: "$baseImage/arrow-left-dashboard.svg",
                width: 16.0,
                height: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
