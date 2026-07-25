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
        boxShadow: AppColors.summaryShadow,
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
            style: theme.bodyMedium!.copyWith(
              color: AppColors.grayPalette.shade700,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                metric.isCurrency ? metric.value.formatCurrency : metric.value,
                style: theme.labelLarge!.copyWith(
                  color: AppColors.grayPalette.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (metric.isCurrency)
                Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: RtcImage(
                    image: "$baseImage/rial.svg",
                    width: 16,
                    height: 16,
                    boxFit: BoxFit.fill,
                    color: AppColors.grayPalette.shade800,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
