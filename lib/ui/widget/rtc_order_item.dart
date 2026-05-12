import 'package:flutter/material.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import '../../data/models/order_item_model.dart';

class RtcOrderItem extends StatelessWidget {
  final OrderItemModel order;
  final VoidCallback onTap;

  const RtcOrderItem({super.key, required this.order, required this.onTap});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(12),

          border: Border.all(width: 1, color: AppColors.grayPalette.shade200),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            spacing: 16,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '# ${order.orderId}',
                    style: theme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grayPalette.shade900,
                    ),
                  ),

                  Text(
                    order.amount,
                    style: theme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grayPalette.shade900,
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    order.customerName,
                    style: theme.bodyMedium!.copyWith(
                      color: AppColors.grayPalette.shade700,
                    ),
                  ),

                  _buildStatusBadge(order.status),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color = Colors.blue; // // TODO: replace with theme color per status
    if (status == 'تایید شده') color = Colors.green;
    if (status == 'رد شده') color = Colors.red;
    if (status == 'در انتظار تایید') color = Colors.orange;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1), // // TODO: replace with theme values
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 10,
          color: color, // // TODO: replace with theme values
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
