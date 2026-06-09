import 'package:flutter/material.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import '../../../../data/models/order_model.dart';
import 'order_history_row_widget.dart';

class OrderTabHistory extends StatelessWidget {
  final OrderDetailModel order;

  const OrderTabHistory({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    final historyLength = order.history.length;
    final splitIndex = (historyLength - 2).clamp(0, historyLength);

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 2.0),
            if (historyLength > 2) ...[
              ...order.history
                  .take(splitIndex)
                  .map((h) => OrderHistoryRowWidget(label: h.label, value: h.value)),
            ],
            ...order.history
                .skip(splitIndex)
                .map((h) => OrderHistoryRowWidget(label: h.label, value: h.value)),

            if ((order.assignedSalesReviewer != null &&
                    order.assignedSalesReviewer!.isNotEmpty) ||
                (order.assignedFinanceReviewer != null &&
                    order.assignedFinanceReviewer!.isNotEmpty)) ...[
              const SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(
                  height: 1,
                  color: AppColors.grayPalette.shade200,
                ),
              ),
              const SizedBox(height: 15.0),
              if (order.assignedSalesReviewer != null &&
                  order.assignedSalesReviewer!.isNotEmpty)
                OrderHistoryRowWidget(
                  label: 'نام پشتیبان:',
                  value: order.assignedSalesReviewer!,
                ),
              if (order.assignedFinanceReviewer != null &&
                  order.assignedFinanceReviewer!.isNotEmpty)
                OrderHistoryRowWidget(
                  label: 'نام سرپرست مالی:',
                  value: order.assignedFinanceReviewer!,
                ),
            ],

            const SizedBox(height: 15.0),

            if (order.rejectionReason != null && order.rejectionReason!.isNotEmpty) ...[
              const SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'علت رد شدن:',
                  style: theme.labelMedium!.copyWith(
                    color: AppColors.errorPalette.shade600,
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  order.rejectionReason!,
                  textAlign: TextAlign.right,
                  style: theme.bodyLarge!.copyWith(
                    color: AppColors.grayPalette.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
