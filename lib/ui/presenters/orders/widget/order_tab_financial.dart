import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/order_model.dart';
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

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildCollapsibleSection(
                      title: 'خلاصه مالی',
                      icon: Icons.attach_money,
                      isExpanded: state.isFinancialSummaryExpanded,
                      onToggle: () => cubit.toggleFinancialSummary(),
                      child: _buildFinancialSummary(order.financialSummary, order.isSettled),
                    ),
                    const Divider(),
                    ...order.operations.map((op) => _buildOperationItem(op, cubit, state)).toList(),
                  ],
                ),
              ),
            ),
            if (!order.isSettled) _buildSettlementFooter(),
          ],
        );
      },
    );
  }

  Widget _buildCollapsibleSection({
    required String title,
    required IconData icon,
    required bool isExpanded,
    required VoidCallback onToggle,
    required Widget child,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onToggle,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(
                  isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: Colors.grey,
                ),
                const Spacer(),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(icon, color: Colors.black, size: 20),
              ],
            ),
          ),
        ),
        if (isExpanded) child,
      ],
    );
  }

  Widget _buildFinancialSummary(FinancialSummaryModel summary, bool isSettled) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          if (isSettled) ...[
            _buildInfoRow('جمع قیمت پایه (۳ کالا)', summary.basePrice),
            _buildInfoRow('جمع تخفیفات', summary.totalDiscount),
            _buildInfoRow('مبلغ نهایی فاکتور', summary.finalAmount, isBold: true),
          ] else ...[
            _buildInfoRow('مبلغ نهایی فاکتور', summary.finalAmount, isBold: true),
          ],
        ],
      ),
    );
  }

  Widget _buildOperationItem(OrderOperationModel op, OrdersCubit cubit, OrdersState state) {
    return Column(
      children: [
        InkWell(
          onTap: () {}, // Toggle logic if needed
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFECFDF5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check, color: Color(0xFF059669), size: 14),
                      const SizedBox(width: 4),
                      Text(
                        op.status,
                        style: const TextStyle(fontSize: 12, color: Color(0xFF059669), fontWeight: FontWeight.bold),
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
                    color: Colors.black,
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
        ),
        const Divider(),
      ],
    );
  }

  Widget _buildSettlementFooter() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangle_border(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text(
          'تخلیه و تسویه',
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
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
              const Text('تومان', style: TextStyle(fontSize: 12, color: Colors.grey)),
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

// Helper to fix potential typo in ElevatedButton style
class RoundedRectangle_border extends RoundedRectangleBorder {
  const RoundedRectangle_border({super.borderRadius});
}
