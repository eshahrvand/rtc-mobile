import 'package:flutter/material.dart';
import '../../../../data/models/order_model.dart';
import '../../../../generated/l10n.dart';
import 'order_details_info_row.dart';

class OrderDetailsCreditPlanInfo extends StatelessWidget {
  final CreditPlanModel plan;

  const OrderDetailsCreditPlanInfo({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          OrderDetailsInfoRow(label: S.current.providerLabel, value: plan.provider),
          OrderDetailsInfoRow(label: S.current.planNameLabel, value: plan.planName),
          OrderDetailsInfoRow(
            label: S.current.priceIncreaseLabel,
            value: plan.priceIncrease,
            valueColor: Colors.blue,
          ),
          OrderDetailsInfoRow(
            label: S.current.validityPeriodLabel,
            value: plan.validityPeriod,
          ),
        ],
      ),
    );
  }
}
