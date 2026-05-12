import 'package:flutter/material.dart';
import '../../data/models/order_item_model.dart';

class RtcOrderItem extends StatelessWidget {
  final OrderItemModel order;
  final VoidCallback onTap;

  const RtcOrderItem({
    super.key,
    required this.order,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white, // // TODO: replace with theme values
          borderRadius: BorderRadius.circular(12), // // TODO: replace with theme values
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05), // // TODO: replace with theme values
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.amount,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // // TODO: replace with theme values
                  ),
                ),
                Text(
                  '# ${order.orderId}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey, // // TODO: replace with theme values
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatusBadge(order.status),
                Text(
                  order.customerName,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black87, // // TODO: replace with theme values
                  ),
                ),
              ],
            ),
          ],
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
