import 'package:flutter/material.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_divider.dart';
import '../../../../core/models/order_model.dart';
import '../../../../generated/l10n.dart';
import 'order_history_row_widget.dart';

class OrderTabHistory extends StatelessWidget {
  final OrderDetailModel order;

  const OrderTabHistory({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final hasMetadata = _hasMetadata(order);

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 8.0, bottom: 32.0),
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 2.0),
                _HistoryList(history: order.history),
                _ReviewersSection(order: order),
                _RejectionSection(order: order),
              ],
            ),
          ),
          if (hasMetadata) ...[
            const SizedBox(height: 8.0),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(bottom: 15.0),
              child: _GatewayMetadataSection(order: order),
            ),
          ],
        ],
      ),
    );
  }

  bool _hasMetadata(OrderDetailModel order) {
    if (order.disbursementRecords.isEmpty) return false;
    final record = order.disbursementRecords.lastWhere(
      (r) => r.gatewayMetadata != null,
      orElse: () => order.disbursementRecords.first,
    );
    final metadata = record.gatewayMetadata;
    if (metadata == null) return false;
    final creditInfo = metadata['creditInfo'] as Map<String, dynamic>?;
    final creditName = creditInfo?['creditName'] as String?;
    final referenceNumber =
        (metadata['referenceNumber'] ?? metadata['transactionId'])?.toString();
    return creditName != null || referenceNumber != null;
  }
}

class _HistoryList extends StatelessWidget {
  final List<OrderHistoryModel> history;

  const _HistoryList({required this.history});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...history.map(
          (h) => OrderHistoryRowWidget(label: h.label, value: h.value),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

class _GatewayMetadataSection extends StatelessWidget {
  final OrderDetailModel order;

  const _GatewayMetadataSection({required this.order});

  @override
  Widget build(BuildContext context) {
    // Find the last record that has gateway metadata
    final recordWithMetadata = order.disbursementRecords.lastWhere(
      (r) => r.gatewayMetadata != null,
      orElse: () => order.disbursementRecords.first,
    );

    final metadata = recordWithMetadata.gatewayMetadata!;
    final creditInfo = metadata['creditInfo'] as Map<String, dynamic>?;
    final creditName = creditInfo?['creditName'] as String?;
    final referenceNumber =
        (metadata['referenceNumber'] ?? metadata['transactionId'])?.toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (creditName != null)
          OrderHistoryRowWidget(
            label: '${S.current.planNameLabel}:',
            value: creditName,
          ),
        if (referenceNumber != null)
          OrderHistoryRowWidget(
            label: S.current.trackingNumberLabel,
            value: referenceNumber,
          ),
      ],
    );
  }
}

class _ReviewersSection extends StatelessWidget {
  final OrderDetailModel order;

  const _ReviewersSection({required this.order});

  @override
  Widget build(BuildContext context) {
    final hasSalesReviewer =
        order.assignedSalesReviewer != null &&
        order.assignedSalesReviewer!.isNotEmpty;
    final hasFinanceReviewer =
        order.assignedFinanceReviewer != null &&
        order.assignedFinanceReviewer!.isNotEmpty;

    if (!hasSalesReviewer && !hasFinanceReviewer) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15.0),
        const _SectionDivider(),
        if (hasSalesReviewer)
          OrderHistoryRowWidget(
            label: S.current.supportNameLabel,
            value: order.assignedSalesReviewer!,
          ),
        if (hasFinanceReviewer)
          OrderHistoryRowWidget(
            label: S.current.financialManagerNameLabel,
            value: order.assignedFinanceReviewer!,
          ),
        if (hasSalesReviewer || hasFinanceReviewer) const SizedBox(height: 12),
      ],
    );
  }
}

class _RejectionSection extends StatelessWidget {
  final OrderDetailModel order;

  const _RejectionSection({required this.order});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final hasRejection =
        order.rejectionReason != null && order.rejectionReason!.isNotEmpty;

    if (!hasRejection) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        const _SectionDivider(),
        const SizedBox(height: 15.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            S.current.rejectionReasonLabel,
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
        const SizedBox(height: 12),
      ],
    );
  }
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: RtcDivider(height: 1, color: AppColors.grayPalette.shade200),
    );
  }
}
