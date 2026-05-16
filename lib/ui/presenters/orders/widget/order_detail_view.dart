import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
          backgroundColor: Colors.white,
          appBar: RtcAppBar(
            onBack: () => context.pop(),
            backIconPath: '$baseImage/angle-left.svg',
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: RtcImage(
                  image: '$baseImage/print.svg',
                  width: 24,
                  height: 24,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              _buildValidityHeader(context, order),
              RtcTabBar(
                tabs: const ['جزییات سفارش', 'اطلاعات مالی', 'تاریخچه'],
                selectedIndex: state.selectedTabIndex,
                onTabChanged: (index) => cubit.onTabChanged(index),
              ),
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RtcStatusBadge(
            status: order.status,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          ),
          Row(
            children: [
              Text(
                'زمان باقی‌مانده: ',
                style: const TextStyle(
                  fontSize: 12,
                  // TODO: replace with theme color
                  color: Colors.grey,
                ),
              ),
              Text(
                order.remainingTime,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  // TODO: replace with theme color
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
