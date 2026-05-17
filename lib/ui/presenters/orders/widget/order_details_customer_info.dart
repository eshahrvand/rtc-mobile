import 'package:flutter/material.dart';
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderDetailsInfoRow(label: S.current.nameLabel, value: customer.name),
          OrderDetailsInfoRow(label: S.current.phoneNumberLabel, value: customer.phone),
          OrderDetailsInfoRow(
            label: S.current.nationalCodeLabel,
            value: customer.nationalCode,
          ),
          OrderDetailsInfoRow(
            label: S.current.postalCodeLabel,
            value: customer.postalCode,
          ),
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
