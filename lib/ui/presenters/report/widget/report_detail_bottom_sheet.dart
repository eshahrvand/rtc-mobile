import 'package:flutter/material.dart';
import '../../../../config/constants.dart';
import '../../../../core/models/report_item_model.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../generated/l10n.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_button.dart';
import '../../../widget/rtc_divider.dart';
import '../../../widget/rtc_image.dart';
import '../bloc/report_step.dart';

class ReportDetailBottomSheet extends StatelessWidget {
  final ReportItemModel item;
  final ReportStep step;

  const ReportDetailBottomSheet({
    super.key,
    required this.item,
    required this.step,
  });

  static Future<void> show(
    BuildContext context, {
    required ReportItemModel item,
    required ReportStep step,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => ReportDetailBottomSheet(item: item, step: step),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFFAFAFA),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHandle(),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 35, 20, 32),
              child: Column(
                children: [
                  _buildDetailsList(context),
                  const SizedBox(height: 24),
                  RtcButton(
                    title: S.current.back,
                    styleBtn: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Colors.white
                    ),
                    onPressed: () => Navigator.pop(context),
                    width: double.infinity,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHandle() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: 33,
      height: 2,
      decoration: BoxDecoration(
        color: AppColors.brandPalette.shade600,
        borderRadius: BorderRadius.circular(42),
      ),
    );
  }

  Widget _buildDetailsList(BuildContext context) {
    final rows = <Widget>[];

    switch (step) {
      case ReportStep.sales:
        rows.addAll([
          _buildRow(S.current.proInvoiceNumberLabel, item.title, context),
          _buildRow(S.current.creditPlanTitle, item.tagLabel, context),
          _buildRow(
            S.current.finalFactorAmount,
            item.amount?.formatCurrency,
            context,
            isCurrency: true,
          ),
          _buildRow(S.current.product, item.quantity ?? '', context),
          _buildRow(
            S.current.dateLabel,
            '${item.date ?? ''} - ${item.time ?? ''}',
            context,
          ),
        ]);
        break;

      case ReportStep.plan:
        rows.addAll([
          _buildRow(S.current.planNameLabel, item.title, context),
          _buildRow(S.current.subPlanNameLabel, item.tagLabel, context),
          _buildRow(
            S.current.purchaseAmountLabel,
            item.amount?.formatCurrency,
            context,
            isCurrency: true,
          ),
          _buildRow(S.current.orderCountLabel, item.quantity, context),
        ]);
        break;

      case ReportStep.category:
        rows.addAll([
          _buildRow(S.current.categoryLabel, item.title, context),
          _buildRow(
            S.current.parentCategorySecondaryLabel,
            item.secondaryLabel,
            context,
          ),
          _buildRow(
            S.current.purchaseAmountLabel,
            item.amount?.formatCurrency,
            context,
            isCurrency: true,
          ),
          _buildRow(S.current.orderCountLabel, item.quantity, context),
        ]);
        break;

      case ReportStep.products:
        rows.addAll([
          _buildRow(S.current.nameLabel, item.title, context),
          _buildRow(S.current.sku, item.sku, context),
          _buildRow(
            S.current.basePriceLabel,
            item.amount?.formatCurrency,
            context,
            isCurrency: true,
          ),
          _buildRow(
            S.current.totalSalesAmountLabel,
            item.secondaryAmount?.formatCurrency,
            context,
            isCurrency: true,
          ),
          _buildRow(S.current.orderCountLabel, item.quantity, context),
        ]);
        break;
    }

    return Column(
      children: rows
          .expand(
            (widget) => [
              widget,
              if (widget != rows.last) ...[
                const SizedBox(height: 12),
                const RtcDivider(),
                const SizedBox(height: 12),
              ],
            ],
          )
          .toList(),
    );
  }

  Widget _buildRow(
    String label,
    String? value,
    BuildContext context, {
    bool isCurrency = false,
  }) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();

    final textTheme = Theme.of(context).textTheme;

    // Clean label if it has a colon at the end to match the design (though HTML had colons)
    final cleanLabel = label.endsWith(':') ? label : '$label:';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          cleanLabel,
          textAlign: TextAlign.right,
          style: textTheme.bodyMedium!.copyWith(
            color: AppColors.grayPalette.shade600,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 4,
          children: [
            Text(
              value,
              style: textTheme.labelMedium!.copyWith(
                color: AppColors.grayPalette.shade900,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (isCurrency)
              RtcImage(
                image: "$baseImage/rial.svg",
                width: 20,
                height: 20,
                color: AppColors.grayPalette.shade900,
              ),
          ],
        ),
      ],
    );
  }
}
