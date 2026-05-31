import 'package:flutter/material.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_divider.dart';
import '../../../../data/models/order_model.dart';

class OrderTabHistory extends StatelessWidget {
  final OrderDetailModel order;

  const OrderTabHistory({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    final historyLength = order.history.length;
    final splitIndex = (historyLength - 2).clamp(0, historyLength);

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (historyLength > 2) ...[
              ...order.history
                  .take(splitIndex)
                  .map((h) => _buildHistoryRow(h.label, h.value, theme)),
            ],
            ...order.history
                .skip(splitIndex)
                .map((h) => _buildHistoryRow(h.label, h.value, theme)),

            const SizedBox(height: 15),

            if (order.rejectionReason!.isNotEmpty ?? false) ...[
              const SizedBox(height: 15),
              Text(
                'علت رد شدن:',
                style: theme.labelMedium!.copyWith(
                  color: AppColors.errorPalette.shade600,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                order.rejectionReason!,
                textAlign: TextAlign.right,
                style: theme.bodyLarge!.copyWith(
                  color: AppColors.grayPalette.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
      child: RtcDivider(height: 0.5, color: AppColors.grayPalette.shade200),
    );
  }

  Widget _buildHistoryRow(String label, String value, TextTheme theme) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.bodyMedium!.copyWith(
              color: AppColors.grayPalette.shade600,
            ),
          ),
          Text(
            value,
            style: theme.labelLarge!.copyWith(
              color: AppColors.grayPalette.shade900,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
