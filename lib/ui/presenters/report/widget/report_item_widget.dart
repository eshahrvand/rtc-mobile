import 'package:flutter/material.dart';
import '../../../../config/constants.dart';
import '../../../../core/models/report_item_model.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../theme/colors.dart';
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (step == ReportStep.sales)
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text(
                        '#',
                        style: theme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.grayPalette.shade900,
                        ),
                      ),
                    ),
                  Expanded(
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
                ],
              ),
              if (item.sku != null)
                Text(
                  'SKU: ${item.sku}',
                  style: theme.bodySmall!.copyWith(
                    color: AppColors.grayPalette.shade600,
                    fontSize: 12,
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
    );
  }

  List<Widget> _buildContentRows(TextTheme theme) {
    switch (step) {
      case ReportStep.sales:
        return [
          _buildMiddleRow(theme),
          _buildFooter(theme, 'تاریخ', item.date, time: item.time),
        ];
      case ReportStep.products:
        return [
          _buildMiddleRow(theme),
          _buildAmountRow(theme, 'قیمت پایه', item.amount),
          _buildLabelRow(theme, 'تعداد سفارش', item.quantity),
          _buildAmountRow(theme, 'جمع مبلغ فروش', item.secondaryAmount),
        ];
      case ReportStep.plan:
      case ReportStep.category:
        return [
          _buildMiddleRow(theme),
          _buildLabelRow(theme, 'تعداد سفارش', item.quantity),
          _buildAmountRow(
            theme,
            step == ReportStep.plan ? 'مبلغ خرید' : 'مبلغ خرید',
            item.amount,
          ),
        ];
    }
  }

  Widget _buildMiddleRow(TextTheme theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (item.secondaryLabel != null ||
            (step == ReportStep.sales && item.quantity != null))
          Row(
            spacing: 4,
            children: [
              if (item.secondaryLabel != null)
                Text(
                  item.secondaryLabel!,
                  style: theme.bodySmall!.copyWith(
                    color: AppColors.grayPalette.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              if (step == ReportStep.sales && item.quantity != null)
                Text(
                  'کالا ${item.quantity}',
                  style: theme.bodySmall!.copyWith(
                    color: AppColors.grayPalette.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
        if (item.tagLabel != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.brandPalette.shade50,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              item.tagLabel!,
              style: theme.bodySmall!.copyWith(
                color: AppColors.brandPalette.shade700,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),
      ],
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
            style: theme.bodySmall!.copyWith(
              color: AppColors.grayPalette.shade600,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 4,
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
            style: theme.bodySmall!.copyWith(
              color: AppColors.grayPalette.shade600,
              fontSize: 12,
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
              if (value != null)
                Flexible(
                  child: Text(
                    value,
                    overflow: TextOverflow.ellipsis,
                    style: theme.bodySmall!.copyWith(
                      color: AppColors.grayPalette.shade600,
                      fontSize: 12,
                    ),
                  ),
                ),
              if (time != null) ...[
                Text(
                  '|',
                  style: TextStyle(color: AppColors.grayPalette.shade600),
                ),
                Text(
                  time,
                  style: theme.bodySmall!.copyWith(
                    color: AppColors.grayPalette.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(width: 8),
        if (item.amount != null)
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 4,
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

                ),
              ],
            ),
          ),
      ],
    );
  }
}
