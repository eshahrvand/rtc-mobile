import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import '../../../../config/config.dart';
import '../../../widget/rtc_appbar.dart';
import '../../../widget/rtc_image.dart';
import '../../../widget/rtc_status_badge.dart';
import '../../../widget/rtc_tab_bar.dart';
import '../bloc/orders_cubit.dart';
import '../bloc/orders_state.dart';
import 'order_tab_details.dart';
import 'order_tab_financial.dart';
import 'order_tab_history.dart';

class OrderDetailView extends StatelessWidget {
  const OrderDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        if (state.selectedOrder == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final order = state.selectedOrder!;
        final cubit = context.read<OrdersCubit>();

        return Scaffold(
          appBar: RtcAppBar(
            onBack: () => context.pop(),
            backIconPath: '$baseImage/angle-right.svg',
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: RtcImage(
                  image: '$baseImage/print.svg',
                  width: 24,
                  height: 24,
                ),
              ),
            ],
          ),
          // Order detail body
          body: Column(
            children: [
              // Order validity header
              _buildValidityHeader(context, order),
              // Tab bar
              RtcTabBar(
                tabs: const ['جزییات سفارش', 'اطلاعات مالی', 'تاریخچه'],
                selectedIndex: state.selectedTabIndex,
                onTabChanged: (index) => cubit.onTabChanged(index),
              ),
              // Order content tabs
              Expanded(
                child: IndexedStack(
                  index: state.selectedTabIndex,
                  children: [
                    OrderTabDetails(order: order),
                    OrderTabFinancial(order: order),
                    OrderTabHistory(order: order),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildValidityHeader(BuildContext context, dynamic order) {
    var theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (order.remainingTime.isNotEmpty)
            Row(
              spacing: 4,
              children: [
                Text(
                  'زمان باقی‌مانده: ',
                  style: theme.bodySmall!.copyWith(
                    color: AppColors.grayPalette.shade600,
                  ),
                ),
                Text(
                  order.remainingTime,
                  style: theme.bodySmall!.copyWith(
                    color: AppColors.errorPalette.shade600,
                  ),
                ),
              ],
            )
          else
            const SizedBox.shrink(),
          RtcStatusBadge(
            status: order.status,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          ),
        ],
      ),
    );
  }
}
