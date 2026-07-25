import 'package:flutter/material.dart';
import '../../../../config/constants.dart';
import '../../../../core/models/report_item_model.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../generated/l10n.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_divider.dart';
import '../../../widget/rtc_image.dart';
import '../bloc/report_step.dart';

class ReportItemWidget extends StatelessWidget {
  final ReportItemModel item;
  final ReportStep step;
  final VoidCallback onTap;

  const ReportItemWidget({
    super.key,
    required this.item,
    required this.step,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1, color: AppColors.grayPalette.shade200),
        ),
        child: Column(
          spacing: 12,
          children: [_buildHeader(theme), ..._buildContentRows(theme)],
        ),
      ),
    );
  }

  Widget _buildHeader(TextTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 4,
                children: [
                  Flexible(
                    child: Text(
                      item.title,
                      maxLines: step == ReportStep.products ? 2 : 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.bodyLarge!.copyWith(
                        fontWeight: step == ReportStep.sales
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: AppColors.grayPalette.shade900,
                      ),
                    ),
                  ),
                  if (step == ReportStep.sales)
                    Text(
                      '#',
                      style: theme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.grayPalette.shade900,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            RtcImage(
              image: '$baseImage/arrow_left_report.svg',
              width: 24,
              height: 24,
            ),
          ],
        ),
        if (step == ReportStep.plan || step == ReportStep.category)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: RtcDivider(
              height: 0.5,
              color: AppColors.grayPalette.shade200,
            ),
          ),
        if (item.sku != null)
          Text(
            '${S.current.sku}: ${item.sku}',
            style: theme.bodyLarge!.copyWith(
              color: AppColors.grayPalette.shade600,
            ),
          ),
        if (step == ReportStep.products)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: RtcDivider(
              height: 0.5,
              color: AppColors.grayPalette.shade200,
            ),
          ),
      ],
    );
  }

  List<Widget> _buildContentRows(TextTheme theme) {
    switch (step) {
      case ReportStep.sales:
        return [
          _buildMiddleRow(theme),
          RtcDivider(height: 0.5, color: AppColors.grayPalette.shade200),
          _buildFooter(theme, S.current.dateLabel, item.date, time: item.time),
        ];
      case ReportStep.products:
        return [
          _buildMiddleRow(theme),
          _buildAmountRow(theme, S.current.basePriceLabel, item.amount),
          _buildLabelRow(theme, S.current.orderCountLabel, item.quantity),
          RtcDivider(height: 0.5, color: AppColors.grayPalette.shade200),
          _buildAmountRow(
            theme,
            S.current.totalSalesAmountLabel,
            item.secondaryAmount,
          ),
        ];
      case ReportStep.plan:
        return [
          _buildMiddleRow(theme),
          _buildLabelRow(theme, S.current.orderCountLabel, item.quantity),
          _buildAmountRow(theme, S.current.purchaseAmountLabel, item.amount),
        ];

      case ReportStep.category:
        return [
          _buildMiddleRow(theme),
          _buildLabelRow(theme, S.current.orderCountLabel, item.quantity),
          RtcDivider(height: 0.5, color: AppColors.grayPalette.shade200),
          _buildAmountRow(theme, S.current.purchaseAmountLabel, item.amount),
        ];
    }
  }

  Widget _buildMiddleRow(TextTheme theme) {
    final tagWidget = item.tagLabel != null
        ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.brandPalette.shade50,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              item.tagLabel!,
              style: theme.bodyMedium!.copyWith(
                color: AppColors.brandPalette.shade900,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        : const SizedBox.shrink();

    final secondaryWidget =
        (item.secondaryLabel != null ||
            (step == ReportStep.sales && item.quantity != null))
        ? Row(
            spacing: 4,
            children: [
              if (item.secondaryLabel != null)
                Text(
                  item.secondaryLabel!,
                  style: theme.bodyMedium!.copyWith(
                    color: AppColors.grayPalette.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              if (step == ReportStep.sales && item.quantity != null)
                Text(
                  '${item.quantity} ${S.current.product}',
                  style: theme.bodyMedium!.copyWith(
                    color: AppColors.grayPalette.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          )
        : const SizedBox.shrink();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:
          step == ReportStep.plan ||
              step == ReportStep.category ||
              step == ReportStep.products
          ? [secondaryWidget, tagWidget]
          : [tagWidget, secondaryWidget],
    );
  }

  Widget _buildAmountRow(TextTheme theme, String label, String? amount) {
    if (amount == null) return const SizedBox.shrink();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: theme.bodyMedium!.copyWith(
              color: AppColors.grayPalette.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 2,
            children: [
              Flexible(
                child: Text(
                  amount.formatCurrency,
                  overflow: TextOverflow.ellipsis,
                  style: theme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.grayPalette.shade900,
                  ),
                ),
              ),
              RtcImage(
                image: "$baseImage/rial.svg",
                width: 20,
                height: 20,
                color: AppColors.grayPalette.shade900,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLabelRow(TextTheme theme, String label, String? value) {
    if (value == null) return const SizedBox.shrink();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: theme.bodyMedium!.copyWith(
              color: AppColors.grayPalette.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            style: theme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.grayPalette.shade900,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(
    TextTheme theme,
    String label,
    String? value, {
    String? time,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            spacing: 4,
            children: [
              if (time != null) ...[
                Text(
                  time,
                  style: theme.bodyMedium!.copyWith(
                    color: AppColors.grayPalette.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '|',
                  style: theme.bodyMedium!.copyWith(
                    color: AppColors.grayPalette.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
              if (value != null)
                Flexible(
                  child: Text(
                    value,
                    overflow: TextOverflow.ellipsis,
                    style: theme.bodyMedium!.copyWith(
                      color: AppColors.grayPalette.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        if (item.amount != null)
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 2,
              children: [
                Flexible(
                  child: Text(
                    item.amount!.formatCurrency,
                    overflow: TextOverflow.ellipsis,
                    style: theme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grayPalette.shade900,
                    ),
                  ),
                ),
                RtcImage(
                  image: "$baseImage/rial.svg",
                  width: 20,
                  height: 20,
                  color: AppColors.grayPalette.shade900,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
