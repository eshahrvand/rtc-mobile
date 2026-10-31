import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/models/commission_report_entry.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../generated/l10n.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_button.dart';
import '../../../widget/rtc_divider.dart';

class CommissionReportDetails extends StatelessWidget {
  final CommissionReportEntry entry;

  const CommissionReportDetails({super.key, required this.entry});

  static void show(BuildContext context, CommissionReportEntry entry) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CommissionReportDetails(entry: entry),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final rows = [
      (S.current.proInvoiceNumberLabel, entry.orderNumber),
      (S.current.customerInfo, entry.customerName),
      (S.current.creditPlanTitle, entry.planName),
      (
        S.current.commissionSalesAmount,
        CurrencyFormatter.format(entry.saleAmount),
      ),
      (
        S.current.commissionDisbursedAt,
        entry.disbursedAt == null
            ? '—'
            : DateTimeUtils.formatToJalali(
                entry.disbursedAt!.toIso8601String(),
              ),
      ),
      (
        S.current.commissionApprovedAt,
        entry.approvedAt == null
            ? '—'
            : DateTimeUtils.formatToJalali(entry.approvedAt!.toIso8601String()),
      ),
    ];
    return Container(
      decoration: BoxDecoration(
        color: AppColors.grayPalette.shade50,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 33,
                height: 2,
                color: AppColors.brandPalette.shade600,
              ),
              const SizedBox(height: 32),
              for (var index = 0; index < rows.length; index++) ...[
                Row(
                  children: [
                    Text(
                      '${rows[index].$1}:',
                      style: theme.bodyMedium?.copyWith(
                        color: AppColors.grayPalette.shade600,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        rows[index].$2,
                        textAlign: TextAlign.end,
                        style: theme.labelMedium?.copyWith(
                          color: AppColors.grayPalette.shade900,
                        ),
                      ),
                    ),
                  ],
                ),
                if (index < rows.length - 1)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: RtcDivider(),
                  ),
              ],
              const SizedBox(height: 24),
              RtcButton(
                title: S.current.back,
                width: double.infinity,
                onPressed: () => context.pop(),
                styleBtn: theme.labelLarge?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
