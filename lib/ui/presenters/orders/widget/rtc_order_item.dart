import 'package:flutter/material.dart';
import 'package:rtc_mobile/ui/widget/rtc_divider.dart';
import 'package:rtc_mobile/ui/widget/rtc_status_badge.dart';

import '../../../../config/config.dart';
import '../../../../core/models/order_model.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_image.dart';

class RtcOrderItem extends StatelessWidget {
  final OrderSummaryModel order;
  final VoidCallback onTap;

  const RtcOrderItem({super.key, required this.order, required this.onTap});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1, color: AppColors.grayPalette.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 4.0,
                  children: [
                    Text(
                      order.orderId,
                      style: theme.labelLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.grayPalette.shade900,
                      ),
                    ),
                    Text(
                      '#',
                      style: theme.labelLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.grayPalette.shade900,
                      ),
                    ),
                  ],
                ),
                RtcImage(
                  image: '$baseImage/angle-left.svg',
                  width: 20.0,
                  height: 20.0,
                  color: AppColors.grayPalette.shade600,
                ),
              ],
            ),
            const SizedBox(height: 6.0),
            Text(
              order.customerName,
              style: theme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.grayPalette.shade700,
              ),
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.itemCount,
                  style: theme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.grayPalette.shade700,
                  ),
                ),
                RtcStatusBadge(status: order.status, isPrimary: false),
              ],
            ),
            const SizedBox(height: 12.0),
            RtcDivider(color: AppColors.grayPalette.shade200, height: 0.5),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.dateTime,
                  style: theme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.grayPalette.shade700,
                  ),
                ),
                Row(
                  spacing: 2.0,
                  children: [
                    Text(
                      order.amount,
                      style: theme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.grayPalette.shade900,
                      ),
                    ),
                    RtcImage(
                      image: "$baseImage/rial.svg",
                      width: 24.0,
                      height: 24.0,
                      boxFit: BoxFit.contain,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
