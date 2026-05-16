import 'package:rtc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../widget/rtc_image.dart';
import '../bloc/pre_invoice_cubit.dart';
import '../bloc/pre_invoice_state.dart';

class PreInvoiceCartBottomSheet extends StatelessWidget {
  const PreInvoiceCartBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreInvoiceCubit, PreInvoiceState>(
      builder: (context, state) {
        final cubit = context.read<PreInvoiceCubit>();

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(state.cartItems.length),
              const SizedBox(height: 16),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = state.cartItems[index];
                    return _buildCartItem(item, cubit);
                  },
                ),
              ),
              const Divider(),
              _buildSummary(state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '$count ${S.current.products}',
            style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          children: [
            Text(S.current.cartTitle, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            const Icon(Icons.shopping_cart_outlined),
          ],
        ),
      ],
    );
  }

  Widget _buildCartItem(dynamic item, PreInvoiceCubit cubit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade100),
              borderRadius: BorderRadius.circular(8),
            ),
            child: RtcImage(image: item.imageUrl, boxFit: BoxFit.contain),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  item.name,
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(S.current.toman, style: const TextStyle(fontSize: 10)),
                    const SizedBox(width: 4),
                    Text(item.price, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                _buildCounter(item, cubit),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCounter(dynamic item, PreInvoiceCubit cubit) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => cubit.increaseQuantity(item.productId),
            child: const Icon(Icons.add, size: 16),
          ),
          const SizedBox(width: 12),
          Text('${item.quantity}', style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () => cubit.removeFromCart(item.productId),
            child: Icon(
              item.quantity == 1 ? Icons.delete_outline : Icons.remove,
              size: 16,
              color: item.quantity == 1 ? Colors.red : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummary(PreInvoiceState state) {
    // Mock calculation
    return Column(
      children: [
        _buildSummaryRow(S.current.totalAmount, '۱۴,۴۹۰,۰۰۰'),
        _buildSummaryRow(S.current.totalDiscounts, '۴۹۰,۰۰۰'),
        _buildSummaryRow(S.current.payableAmount, '۱۴,۰۰۰,۰۰۰', isBold: true, color: Colors.blue),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(S.current.toman, style: const TextStyle(fontSize: 10, color: Colors.grey)),
              const SizedBox(width: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  color: color ?? Colors.black,
                ),
              ),
            ],
          ),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}
