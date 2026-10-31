import 'package:flutter/material.dart';
import '../../../../config/constants.dart';
import '../../../../core/models/commission_report_entry.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../generated/l10n.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_divider.dart';
import '../../../widget/rtc_image.dart';

class CommissionReportItem extends StatelessWidget {
  final CommissionReportEntry entry;
  final VoidCallback onTap;

  const CommissionReportItem({
    super.key,
    required this.entry,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final labelStyle = theme.bodyMedium?.copyWith(
      color: AppColors.grayPalette.shade700,
    );
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.grayPalette.shade200),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            spacing: 12,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '# ${entry.orderNumber}',
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.grayPalette.shade900,
                      ),
                    ),
                  ),
                  RtcImage(
                    image: '$baseImage/arrow_left_report.svg',
                    width: 24,
                    height: 24,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      entry.customerName,
                      style: labelStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.blueLightPalette.shade50,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        entry.planName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.bodyMedium?.copyWith(
                          color: AppColors.blueLightPalette.shade900,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      S.current.commissionConsumerPrice,
                      style: labelStyle,
                    ),
                  ),
                  Text(
                    CurrencyFormatter.format(entry.saleAmount),
                    style: theme.bodyLarge?.copyWith(
                      color: AppColors.grayPalette.shade900,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  RtcImage(
                    image: '$baseImage/rial.svg',
                    width: 20,
                    height: 20,
                    color: AppColors.grayPalette.shade900,
                    boxFit: BoxFit.fill,
                  ),
                ],
              ),
              RtcDivider(height: 0.5, color: AppColors.grayPalette.shade100),
              Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: CommissionReportDate(
                      label: S.current.commissionDisbursedAt,
                      date: entry.disbursedAt,
                    ),
                  ),
                  Expanded(
                    child: CommissionReportDate(
                      label: S.current.commissionApprovedAt,
                      date: entry.approvedAt,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommissionReportDate extends StatelessWidget {
  final String label;
  final DateTime? date;

  const CommissionReportDate({
    super.key,
    required this.label,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        '$label: ${date == null ? '—' : DateTimeUtils.formatToJalali(date!.toIso8601String())}',
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: AppColors.grayPalette.shade700),
      ),
    );
  }
}
