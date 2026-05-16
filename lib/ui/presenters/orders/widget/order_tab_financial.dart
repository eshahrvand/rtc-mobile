import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import '../../../../config/config.dart';
import '../../../../data/models/order_model.dart';
import '../../../widget/rtc_button.dart';
import '../../../widget/rtc_collapsible_section.dart';
import '../../../widget/rtc_image.dart';
import '../bloc/orders_cubit.dart';
import '../bloc/orders_state.dart';

class OrderTabFinancial extends StatelessWidget {
  final OrderDetailModel order;

  const OrderTabFinancial({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        final cubit = context.read<OrdersCubit>();
        final isWaitingSettlement = order.status == 'در انتظار تسویه';

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    RtcCollapsibleSection(
                      title: S.current.financialSummaryTitle,
                      icon: RtcImage(
                        image: '$baseImage/dollar.svg',
                        width: 20,
                        height: 20,
                        // TODO: replace with theme color
                        color: Colors.black,
                      ),
                      isExpanded: state.isFinancialSummaryExpanded,
                      onToggle: () => cubit.toggleFinancialSummary(),
                      showDivider: false,
                      headerSpacing: 8,
                      trailing: Icon(
                        state.isFinancialSummaryExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        // TODO: replace with theme color
                        color: Colors.grey,
                      ),
                      child: _buildFinancialSummary(
                        order.financialSummary,
                        order.isSettled,
                        isWaitingSettlement,
                      ),
                    ),
                    const Divider(),
                    ...order.operations.map((op) {
                      if (op.step == 2 && isWaitingSettlement) {
                        return _buildSettlementOperations(op);
                      }
                      return _buildOperationItem(op);
                    }).toList(),
                  ],
                ),
              ),
            ),
            if (order.status == 'پیش فاکتور')
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: RtcButton(
                  title: S.current.dischargeAndSettlement,
                  onPressed: () {},
                  // TODO: replace with theme values
                  backgroundColor: const Color(0xFF2563EB),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildFinancialSummary(FinancialSummaryModel summary, bool isSettled, bool isWaitingSettlement) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          if (isWaitingSettlement) ...[
            _buildInfoRow(S.current.finalFactorAmount, summary.finalAmount, isBold: true),
          ] else if (isSettled) ...[
            _buildInfoRow(S.current.finalFactorAmount, summary.finalAmount, isBold: true),
          ] else ...[
            _buildInfoRow(S.current.totalBasePrice, summary.basePrice),
            _buildInfoRow(S.current.totalDiscounts, summary.totalDiscount),
            _buildInfoRow(S.current.finalFactorAmount, summary.finalAmount, isBold: true),
          ],
        ],
      ),
    );
  }

  Widget _buildSettlementOperations(OrderOperationModel op) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const Icon(Icons.keyboard_arrow_up, color: Colors.grey),
              const Spacer(),
              Text(
                op.title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  // TODO: replace with theme color
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  // TODO: replace with theme color
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    '${op.step}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Divider(
              // TODO: replace with theme color
              ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                S.current.settlementMethod,
                style: const TextStyle(
                  fontSize: 12,
                  // TODO: replace with theme color
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  // TODO: replace with theme color
                  border: Border.all(color: Colors.grey.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.keyboard_arrow_down,
                      // TODO: replace with theme color
                      color: Colors.grey,
                    ),
                    const Spacer(),
                    Text(
                      S.current.walletSettlement,
                      style: const TextStyle(
                        // TODO: replace with theme color
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        S.current.toman,
                        style: const TextStyle(
                          fontSize: 12,
                          // TODO: replace with theme color
                          color: Color(0xFFD97706),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        '۲۴,۰۰۰,۰۰۰',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFD97706)),
                      ),
                    ],
                  ),
                  Text(
                    S.current.differenceAmount,
                    style: const TextStyle(
                      fontSize: 12,
                      // TODO: replace with theme color
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  // TODO: replace with theme color
                  color: const Color(0xFFF0FDF4),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFDCFCE7)),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      // TODO: replace with theme color
                      color: Color(0xFF16A34A),
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        S.current.walletBalanceSufficient,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 12,
                          // TODO: replace with theme color
                          color: Color(0xFF16A34A),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              RtcButton(
                title: S.current.payWithWallet,
                onPressed: () {},
                // TODO: replace with theme values
                backgroundColor: const Color(0xFF2563EB),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOperationItem(OrderOperationModel op) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
              const Spacer(),
              if (op.isCompleted)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    // TODO: replace with theme color
                    color: const Color(0xFFECFDF5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check,
                        // TODO: replace with theme color
                        color: Color(0xFF059669),
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        op.status,
                        style: const TextStyle(
                          fontSize: 12,
                          // TODO: replace with theme color
                          color: Color(0xFF059669),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(width: 8),
              Text(
                op.title,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  // TODO: replace with theme color
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    '${op.step}',
                    style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                S.current.toman,
                style: const TextStyle(
                  fontSize: 12,
                  // TODO: replace with theme color
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
