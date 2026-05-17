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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...order.history
              .take(order.history.length - 2)
              .map((h) => _buildHistoryRow(h.label, h.value, theme)),
          _divider(),
          ...order.history
              .skip(order.history.length - 2)
              .map((h) => _buildHistoryRow(h.label, h.value, theme)),
          _divider(),
          if (order.rejectionReason != null) ...[
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
    );
  }

  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: RtcDivider(
        height: 0.5,
        color: AppColors.grayPalette.shade300,
      ),
    );
  }

  Widget _buildHistoryRow(String label, String value, TextTheme theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
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
