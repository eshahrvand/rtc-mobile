import 'package:flutter/material.dart';
import '../../config/config.dart';
import '../../data/models/customer_model.dart';
import 'rtc_image.dart';

class RtcCustomerOrderItem extends StatelessWidget {
  final CustomerOrderItemModel order;

  const RtcCustomerOrderItem({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          // TODO: replace with theme color
          color: Colors.grey.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'تومان',
                    style: TextStyle(
                      fontSize: 12,
                      // TODO: replace with theme color
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    order.amount,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      // TODO: replace with theme color
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    order.orderId,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      // TODO: replace with theme color
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    '#',
                    style: TextStyle(
                      fontSize: 14,
                      // TODO: replace with theme color
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatusBadge(),
              Text(
                order.date,
                style: const TextStyle(
                  fontSize: 12,
                  // TODO: replace with theme color
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    Color bgColor;
    Color textColor;
    String iconPath;

    if (order.status == 'پیش فاکتور') {
      bgColor = Colors.blue.withOpacity(0.1);
      textColor = Colors.blue;
      iconPath = '$baseImage/document-list-check.svg';
    } else if (order.status == 'رد شده') {
      bgColor = Colors.red.withOpacity(0.1);
      textColor = Colors.red;
      iconPath = '$baseImage/calendar-close.svg';
    } else {
      bgColor = Colors.grey.withOpacity(0.1);
      textColor = Colors.grey;
      iconPath = '$baseImage/calendar-close.svg';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          RtcImage(
            image: iconPath,
            width: 14,
            height: 14,
            color: textColor,
          ),
          const SizedBox(width: 4),
          Text(
            order.status,
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
