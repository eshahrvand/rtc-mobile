import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import '../../../router/app_route.dart';
import '../../../widget/rtc_customer_order_item.dart';

class CustomersOrdersTab extends StatelessWidget {
  final List<dynamic> orders;

  const CustomersOrdersTab({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.grayPalette.shade25,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return RtcCustomerOrderItem(
              order: order,
              onTap: () {
                context.push('${AppRoutes.orderDetail.replaceAll(':orderId', order.id)}');
              },
            );
          },
        ),
      ),
    );
  }
}
