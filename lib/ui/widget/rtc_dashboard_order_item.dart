import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/core/utils/currency_formatter.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';
import 'package:rtc_mobile/ui/widget/rtc_status_badge.dart';
import '../../data/models/order_model.dart';

class RtcDashboardOrderItem extends StatelessWidget {
  final OrderSummaryModel order;
  final VoidCallback onTap;

  const RtcDashboardOrderItem({
    super.key,
    required this.order,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    log(">> ${order.orderId}}");
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
                children: [
                  Text(
                    '# ${order.orderId}',
                    style: theme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grayPalette.shade900,
                    ),
                  ),
                  Spacer(),
                  Text(
                    order.amount.formatCurrency,
                    style: theme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grayPalette.shade900,
                    ),
                  ),
                  SizedBox(width: 2),
                  RtcImage(
                    image: "$baseImage/rial.svg",
                    width: 20,
                    height: 20,
                    boxFit: BoxFit.contain,
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
                  RtcStatusBadge(status: order.status ,   isPrimary: false,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
