import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';
import 'customers_detail_field.dart';

class CustomersInfoTab extends StatelessWidget {
  final dynamic customer;

  const CustomersInfoTab({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomersDetailField(label: S.current.customerName, value: customer.name),
          CustomersDetailField(
            label: S.current.nationalId,
            value: customer.nationalCode,
          ),
          CustomersDetailField(
            label: S.current.phoneNumber,
            value: customer.phoneNumber,
          ),
          CustomersDetailField(
            label: S.current.postalCode,
            value: customer.postalCode,
          ),
          CustomersDetailField(
            label: S.current.address,
            value: customer.address,
            minLines: 1,
            maxLines: 4,
            lineHeight: 2.0,
            isAddress: true,
          ),
        ],
      ),
    );
  }
}
