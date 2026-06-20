import 'package:flutter/material.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_divider.dart';
import '../../../../core/models/order_model.dart';
import '../../../../generated/l10n.dart';
import 'order_financial_info_row.dart';

class OrderFinancialSummaryWidget extends StatelessWidget {
  final FinancialSummaryModel summary;
  final bool isExpanded;

  const OrderFinancialSummaryWidget({
    super.key,
    required this.summary,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          if (isExpanded) ...[
            OrderFinancialInfoRow(
              label: S.current.totalBasePrice,
              value: summary.basePrice,
            ),
            OrderFinancialInfoRow(
              label: S.current.totalDiscounts,
              value: summary.totalDiscount,
            ),
            RtcDivider(
              isDashed: true,
              color: AppColors.grayPalette.shade200,
              height: 0.7,
            ),
          ],
          OrderFinancialInfoRow(
            label: S.current.finalFactorAmount,
            value: summary.finalAmount,
            isBold: true,
          ),
        ],
      ),
    );
  }
}
