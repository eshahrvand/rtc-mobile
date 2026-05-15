import 'package:flutter/material.dart';
import '../../config/config.dart';
import '../../data/models/order_model.dart';
import '../theme/colors.dart';
import 'rtc_image.dart';

class RtcOrderItem extends StatelessWidget {
  final OrderSummaryModel order;
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
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            // TODO: replace with theme color
            color: Colors.grey.withOpacity(0.1),
          ),
          boxShadow: [
            BoxShadow(
              // TODO: replace with theme color
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RtcImage(
                  image: '$baseImage/angle-left.svg',
                  width: 16,
                  height: 16,
                  color: Colors.grey,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  order.customerName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    // TODO: replace with theme color
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatusBadge(),
                Text(
                  order.itemCount,
                  style: const TextStyle(
                    fontSize: 14,
                    // TODO: replace with theme color
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
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
                        color: Colors.black,
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
                Text(
                  order.dateTime,
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
      ),
    );
  }

  Widget _buildStatusBadge() {
    Color bgColor;
    Color textColor;
    IconData? icon;
    String? iconPath;

    switch (order.status) {
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
      case 'تایید شده':
        bgColor = const Color(0xFFECFDF5);
        textColor = const Color(0xFF059669);
        iconPath = '$baseImage/package-check.svg';
        break;
      case 'رد شده':
        bgColor = const Color(0xFFFEF2F2);
        textColor = const Color(0xFFDC2626);
        iconPath = '$baseImage/close.svg';
        break;
      default:
        bgColor = Colors.grey.withOpacity(0.1);
        textColor = Colors.grey;
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
          if (iconPath != null) ...[
            RtcImage(
              image: iconPath,
              width: 14,
              height: 14,
              color: textColor,
            ),
            const SizedBox(width: 4),
          ],
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
