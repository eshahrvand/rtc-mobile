import 'package:flutter/material.dart';
import '../../../../config/constants.dart';
import '../../../../core/models/report_item_model.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_image.dart';

class ReportSummaryCard extends StatelessWidget {
  final ReportSummaryMetric metric;

  const ReportSummaryCard({
    super.key,
    required this.metric,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    
    return Container(
      width: 160, // Fixed width for horizontal scroll items
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            metric.label,
            textAlign: TextAlign.center,
            style: theme.bodySmall!.copyWith(
              color: AppColors.grayPalette.shade600,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                metric.isCurrency ? metric.value.formatCurrency : metric.value,
                style: theme.bodyLarge!.copyWith(
                  color: AppColors.grayPalette.shade900,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              if (metric.isCurrency)
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: RtcImage(
                    image: "$baseImage/rial.svg",
                    width: 16,
                    height: 16,
                    color: AppColors.grayPalette.shade900,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
