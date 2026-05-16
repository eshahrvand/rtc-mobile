import 'package:flutter/material.dart';
import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';
import '../../data/models/customer_model.dart';
import '../theme/colors.dart';

class RtcCustomerItem extends StatelessWidget {
  final CustomerItemModel customer;
  final VoidCallback onTap;

  const RtcCustomerItem({
    super.key,
    required this.customer,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.grayPalette.shade200, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customer.name,
                  style: theme.bodyLarge!.copyWith(
                    color: AppColors.grayPalette.shade900,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Text(
                  customer.phoneNumber,
                  style: theme.bodyMedium!.copyWith(
                    color: AppColors.grayPalette.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RtcImage(
                  image: "$baseImage/more-horizontal.svg",
                  width: 20,
                  height: 20,
                ),

                Text(
                  customer.city,
                  style: theme.bodyMedium!.copyWith(
                    color: AppColors.grayPalette.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
