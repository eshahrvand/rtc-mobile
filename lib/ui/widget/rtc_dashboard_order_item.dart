import 'package:flutter/material.dart';
import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';
import 'package:rtc_mobile/ui/widget/rtc_status_badge.dart';
import '../../data/models/order_item_model.dart';
import '../../generated/l10n.dart';

class RtcDashboardOrderItem extends StatelessWidget {
  final OrderItemModel order;
  final VoidCallback onTap;

  const RtcDashboardOrderItem({
    super.key,
    required this.order,
    required this.onTap,
  });

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
                  RtcStatusBadge(status: order.status),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
