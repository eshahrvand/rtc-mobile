import 'package:flutter/material.dart';
import '../../../../config/constants.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';
import 'package:rtc_mobile/ui/widget/rtc_status_badge.dart';
import '../../core/models/customer_model.dart';

class RtcCustomerOrderItem extends StatelessWidget {
  final CustomerOrderItemModel order;
  final VoidCallback? onTap;

  const RtcCustomerOrderItem({super.key, required this.order, this.onTap});

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
          border: Border.all(color: AppColors.grayPalette.shade200, width: 1),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 4,
                  children: [
                    Text(
                      order.orderId.substring(0, 8),
                      style: theme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.grayPalette.shade900,
                      ),
                      // maxLines: 2,
                    ),

                    Text(
                      '#',
                      style: theme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.grayPalette.shade900,
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 2,
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
                      width: 24,
                      height: 24,
                      boxFit: BoxFit.contain,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.date,
                  style: theme.bodyMedium!.copyWith(
                    color: AppColors.grayPalette.shade700,
                  ),
                ),

                RtcStatusBadge(status: order.status, isPrimary: false),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
