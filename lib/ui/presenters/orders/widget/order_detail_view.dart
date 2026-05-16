import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/config.dart';
import '../../../widget/rtc_appbar.dart';
import '../../../widget/rtc_image.dart';
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
          _buildStatusBadge(order.status),
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

  Widget _buildStatusBadge(String status) {
    Color bgColor;
    Color textColor;
    String? iconPath;

    switch (status) {
      case 'پیش فاکتور':
        bgColor = const Color(0xFFEEF2FF);
        textColor = const Color(0xFF4338CA);
        iconPath = '$baseImage/dollar.svg';
        break;
      case 'تایید شده':
        bgColor = const Color(0xFFECFDF5);
        textColor = const Color(0xFF059669);
        iconPath = '$baseImage/package-check.svg';
        break;
      case 'در انتظار تسویه':
        bgColor = const Color(0xFFEEF2FF);
        textColor = const Color(0xFF4338CA);
        iconPath = '$baseImage/dollar.svg';
        break;
      case 'در انتظار تایید':
        bgColor = const Color(0xFFFFF7ED);
        textColor = const Color(0xFFEA580C);
        iconPath = '$baseImage/waiting.svg';
        break;
      case 'رد شده':
        bgColor = const Color(0xFFFEF2F2);
        textColor = const Color(0xFFDC2626);
        iconPath = '$baseImage/close.svg';
        break;
      case 'منقضی شده':
        bgColor = const Color(0xFFF3F4F6);
        textColor = const Color(0xFF4B5563);
        iconPath = '$baseImage/calendar-close.svg';
        break;
      default:
        bgColor = Colors.grey.withOpacity(0.1);
        textColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (iconPath != null) ...[
            RtcImage(image: iconPath, width: 14, height: 14, color: textColor),
            const SizedBox(width: 8),
          ],
          Text(
            status,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
