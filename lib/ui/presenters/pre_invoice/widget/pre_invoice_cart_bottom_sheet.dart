import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/data/models/pre_invoice_model.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top Handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.grayPalette.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              _buildHeader(state.cartItems.length),
              const SizedBox(height: 16),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: state.cartItems.length,
                  separatorBuilder: (context, index) => const Divider(height: 32),
                  itemBuilder: (context, index) {
                    final item = state.cartItems[index];
                    return _buildCartItem(item, cubit);
                  },
                ),
              ),
              const Divider(height: 40),
              _buildSummary(state),
              const SizedBox(height: 16),
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.successPalette.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '$count ${S.current.productsFound.replaceAll('کالا پیدا شد', 'کالا')}',
            style: TextStyle(
              color: AppColors.successPalette.shade700,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        Row(
          children: [
            Text(
              S.current.cartTitle,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.grayPalette.shade900,
              ),
            ),
            const SizedBox(width: 8),
            RtcImage(
              image: "$baseImage/cart_dashboard.svg",
              width: 24,
              height: 24,
              color: AppColors.grayPalette.shade900,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCartItem(CartItemModel item, PreInvoiceCubit cubit) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product Details and Counter on the Left
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.grayPalette.shade900,
                ),
              ),
              const SizedBox(height: 8),
              if (item.oldPrice != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      item.oldPrice!,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.grayPalette.shade400,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    S.current.toman,
                    style: TextStyle(fontSize: 11, color: AppColors.grayPalette.shade500),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    item.price,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.grayPalette.shade900,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildCounter(item, cubit),
            ],
          ),
        ),
        const SizedBox(width: 16),
        // Product Image on the Right
        Stack(
          children: [
            Container(
              width: 80,
              height: 80,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.grayPalette.shade25,
                border: Border.all(color: AppColors.grayPalette.shade100),
                borderRadius: BorderRadius.circular(12),
              ),
              child: RtcImage(image: item.imageUrl, boxFit: BoxFit.contain),
            ),
            if (item.discount != null)
              Positioned(
                bottom: 8,
                right: -4,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.errorPalette.shade500,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    item.discount!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildCounter(CartItemModel item, PreInvoiceCubit cubit) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grayPalette.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () => cubit.increaseQuantity(item.productId),
            icon: const Icon(Icons.add, size: 20),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
          const SizedBox(width: 8),
          Text(
            '${item.quantity}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.grayPalette.shade900,
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () => cubit.removeFromCart(item.productId),
            icon: item.quantity == 1
                ? Icon(Icons.delete_outline, color: AppColors.errorPalette.shade500, size: 20)
                : const Icon(Icons.remove, size: 20),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
        ],
      ),
    );
  }

  Widget _buildSummary(PreInvoiceState state) {
    // These values should ideally come from the Cubit/State as calculated values
    // For now, keeping the mock or assuming they will be calculated
    return Column(
      children: [
        _buildSummaryRow(S.current.totalAmount, '۱۴,۴۹۰,۰۰۰'),
        _buildSummaryRow(S.current.totalDiscounts, '۴۹۰,۰۰۰'),
        _buildSummaryRow(
          S.current.payableAmount,
          '۱۴,۰۰۰,۰۰۰',
          isBold: true,
          color: AppColors.brandPalette.shade600,
        ),
      ],
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool isBold = false,
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                S.current.toman,
                style: TextStyle(fontSize: 12, color: AppColors.grayPalette.shade500),
              ),
              const SizedBox(width: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
                  color: color ?? AppColors.grayPalette.shade900,
                ),
              ),
            ],
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.grayPalette.shade600,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
