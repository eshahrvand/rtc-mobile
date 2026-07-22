import 'package:flutter/material.dart';
import '../../../../config/constants.dart';
import '../../../../core/models/report_item_model.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_image.dart';

class ReportSummaryCard extends StatelessWidget {
  final ReportSummaryMetric metric;

  const ReportSummaryCard({super.key, required this.metric});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Container(
      width: 170, // Increased width for long Persian labels
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            metric.label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.bodySmall!.copyWith(
              color: AppColors.grayPalette.shade600,
              fontSize: 11, // Slightly smaller font to fit more text
              height: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                metric.isCurrency ? metric.value.formatCurrency : metric.value,
                style: theme.bodyLarge!.copyWith(
                  color: AppColors.grayPalette.shade900,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
              if (metric.isCurrency)
                Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: RtcImage(
                    image: "$baseImage/rial.svg",
                    width: 16,
                    height: 16,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
