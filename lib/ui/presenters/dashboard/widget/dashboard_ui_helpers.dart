import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rtc_mobile/ui/router/app_route.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import '../../../../generated/l10n.dart';
import '../../../widget/rtc_dashboard_order_item.dart';
import '../bloc/dashboard_cubit.dart';
import '../bloc/dashboard_state.dart';

class DashboardUiHelpers {
  /// Resolves the recent orders list or empty state.
  static Widget resolveRecentOrdersList({
    required BuildContext context,
    required DashboardState state,
    required TextTheme theme,
  }) {
    if (state.recentOrders.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Text(
            S.current.noItemsFound,
            style: theme.bodyLarge?.copyWith(
              color: AppColors.grayPalette.shade600,
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: state.recentOrders.length,
      itemBuilder: (context, index) {
        final order = state.recentOrders[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: RtcDashboardOrderItem(
            order: order,
            onTap: () {
              context.read<DashboardCubit>().onNavItemSelected(2);
              context.push('${AppRoutes.orderDetail.replaceAll(':orderId', order.id)}');
            },
          ),
        );
      },
    );
  }
}
