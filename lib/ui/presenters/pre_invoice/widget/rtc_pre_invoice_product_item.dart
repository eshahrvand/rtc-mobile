import 'package:flutter/material.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import '../../../../core/models/pre_invoice_model.dart';
import 'rtc_pre_invoice_product_item_widgets.dart';

class RtcPreInvoiceProductItem extends StatelessWidget {
  final PreInvoiceProductModel product;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const RtcPreInvoiceProductItem({
    super.key,
    required this.product,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: AppColors.primaryShadow,
      ),
      child: Row(
        children: [
          RtcPreInvoiceProductImage(
            product: product,
            quantity: quantity,
            onAdd: onAdd,
            onRemove: onRemove,
          ),
          const SizedBox(width: 30),
          Expanded(
            child: Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  textAlign: TextAlign.right,
                  style: theme.labelMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.grayPalette.shade20,
                  ),
                ),
                RtcPreInvoiceProductAvailability(
                  isAvailable: product.isAvailable,
                  inventory: product.inventory,
                ),
                RtcPreInvoiceProductPriceAndActions(product: product),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
