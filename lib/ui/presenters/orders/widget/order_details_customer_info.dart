import 'package:flutter/material.dart';
import 'package:rtc_mobile/ui/widget/rtc_divider.dart';
import '../../../../data/models/order_model.dart';
import '../../../../generated/l10n.dart';
import '../../../theme/colors.dart';
import 'order_details_info_row.dart';

class OrderDetailsCustomerInfo extends StatelessWidget {
  final OrderCustomerModel customer;

  const OrderDetailsCustomerInfo({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        spacing: 7,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderDetailsInfoRow(label: S.current.nameLabel, value: customer.name),
          RtcDivider(height: 0.5, color: AppColors.grayPalette.shade200),
          OrderDetailsInfoRow(
            label: S.current.phoneNumberLabel,
            value: customer.phone,
          ),
          RtcDivider(height: 0.5, color: AppColors.grayPalette.shade200),
          OrderDetailsInfoRow(
            label: S.current.nationalCodeLabel,
            value: customer.nationalCode,
          ),
          RtcDivider(height: 0.5, color: AppColors.grayPalette.shade200),
          OrderDetailsInfoRow(
            label: S.current.postalCodeLabel,
            value: customer.postalCode,
          ),
          RtcDivider(height: 0.5, color: AppColors.grayPalette.shade200),
          OrderDetailsInfoRow(label: S.current.addressLabel, value: ''),

          Text(
            customer.address,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.grayPalette.shade900,
            ),
          ),
        ],
      ),
    );
  }
}
