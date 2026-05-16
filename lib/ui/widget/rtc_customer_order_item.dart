import 'package:flutter/material.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import '../../config/config.dart';
import '../../data/models/customer_model.dart';
import 'rtc_image.dart';

class RtcCustomerOrderItem extends StatelessWidget {
  final CustomerOrderItemModel order;

  const RtcCustomerOrderItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
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
                    order.orderId,
                    style: theme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grayPalette.shade900,
                    ),
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
                spacing: 4,
                children: [
                  Text(
                    order.amount,
                    style: theme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grayPalette.shade900,
                    ),
                  ),
                  Text(
                    S.current.toman,
                    style: theme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grayPalette.shade900,
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
              Text(
                order.date,
                style: theme.bodyMedium!.copyWith(
                  color: AppColors.grayPalette.shade700,
                ),
              ),

              _buildStatusBadge(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
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
          RtcImage(image: iconPath, width: 14, height: 14, color: textColor),
          const SizedBox(width: 4),
          Text(
            order.status,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
