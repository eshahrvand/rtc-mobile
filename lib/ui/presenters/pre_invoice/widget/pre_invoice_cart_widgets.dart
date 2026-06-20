import 'package:flutter/material.dart';
import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/data/models/pre_invoice_model.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_discount_badge.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';
import 'package:rtc_mobile/ui/widget/rtc_counter_widget.dart';
import '../bloc/pre_invoice_cubit.dart';
import '../bloc/pre_invoice_state.dart';

class PreInvoiceCartHeader extends StatelessWidget {
  final int count;

  const PreInvoiceCartHeader({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            RtcImage(
              image: "$baseImage/cart_bottom_sheet.svg",
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 8),
            Text(
              S.current.cartTitle,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.grayPalette.shade20,
                  ),
            ),
          ],
        ),
        Container(
          width: 42,
          height: 22,
          decoration: BoxDecoration(
            color: AppColors.successPalette.shade500,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              '$count ${S.current.productsFound.replaceAll('کالا پیدا شد', 'کالا')}',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}

class PreInvoiceCartItem extends StatelessWidget {
  final CartItemModel item;
  final PreInvoiceCubit cubit;

  const PreInvoiceCartItem({super.key, required this.item, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Column(
      spacing: 10,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 64,
              height: 64,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.grayPalette.shade100),
                borderRadius: BorderRadius.circular(8),
              ),
              child: RtcImage(image: item.imageUrl, boxFit: BoxFit.contain),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    textAlign: TextAlign.right,
                    style: theme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grayPalette.shade900,
                    ),
                  ),
                  const SizedBox(height: 18),
                  if (item.oldPrice != null)
                    Text(
                      item.oldPrice!,
                      style: theme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.grayPalette.shade700,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        item.price,
                        style: theme.labelLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.grayPalette.shade900,
                        ),
                      ),
                      const SizedBox(width: 2),
                      RtcImage(
                        image: "$baseImage/rial.svg",
                        width: 20,
                        height: 20,
                        boxFit: BoxFit.contain,
                      ),
                      const Spacer(),
                      if (item.discount != null && item.discount != "0%")
                        RtcDiscountBadge(
                          discount: item.discount!,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.centerRight,
          child: RtcCounterWidget(
            quantity: item.quantity,
            onAdd: () => cubit.increaseQuantity(item.productId),
            onRemove: () => cubit.removeFromCart(item.productId),
            isAvailable: true,
            isCardStyle: true,
            colorDeleteIcon: true,
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class PreInvoiceCartSummary extends StatelessWidget {
  final PreInvoiceState state;

  const PreInvoiceCartSummary({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        PreInvoiceCartSummaryRow(
          label: S.current.totalAmount,
          value: state.totalAmount,
        ),
        PreInvoiceCartSummaryRow(
          label: S.current.totalDiscounts,
          value: state.totalDiscounts,
        ),
        PreInvoiceCartSummaryRow(
          label: S.current.payableAmount,
          value: state.payableAmount,
          isBold: true,
          color: AppColors.brandPalette.shade600,
        ),
      ],
    );
  }
}

class PreInvoiceCartSummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final Color? color;

  const PreInvoiceCartSummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.isBold = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.grayPalette.shade700,
              ),
        ),
        Row(
          children: [
            Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: color ?? AppColors.grayPalette.shade700,
                    fontWeight: color != null ? FontWeight.bold : FontWeight.w500,
                    fontSize: 14,
                  ),
            ),
            const SizedBox(width: 4),
            RtcImage(
              image: "$baseImage/rial.svg",
              width: 16,
              height: 16,
              color: color,
              boxFit: BoxFit.contain,
            ),
          ],
        ),
      ],
    );
  }
}
