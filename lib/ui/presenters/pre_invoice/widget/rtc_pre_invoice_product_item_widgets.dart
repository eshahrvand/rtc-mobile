import 'package:flutter/material.dart';
import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_discount_badge.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';
import 'package:rtc_mobile/ui/widget/rtc_counter_widget.dart';
import '../../../../data/models/pre_invoice_model.dart';

class RtcPreInvoiceProductImage extends StatelessWidget {
  final PreInvoiceProductModel product;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const RtcPreInvoiceProductImage({
    super.key,
    required this.product,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          child: RtcImage(
            image: product.imageUrl,
            boxFit: BoxFit.contain,
            width: 104,
            height: 104,
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: product.isAvailable
              ? RtcCounterWidget(
                  quantity: quantity,
                  onAdd: onAdd,
                  onRemove: onRemove,
                  isAvailable: product.isAvailable,
                  isCardStyle: false,
                  colorDeleteIcon: false,
                  textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class RtcPreInvoiceProductAvailability extends StatelessWidget {
  final bool isAvailable;
  final String inventory;

  const RtcPreInvoiceProductAvailability({
    super.key,
    required this.isAvailable,
    required this.inventory,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 16,
      child: Text(
        isAvailable ? 'موجودی ($inventory)' : 'ناموجود',
        style: Theme.of(context).textTheme.labelSmall!.copyWith(
          fontWeight: FontWeight.w600,
          color: !isAvailable
              ? AppColors.grayPalette.shade500
              : AppColors.successPalette.shade600,
        ),
      ),
    );
  }
}

class RtcPreInvoiceProductPriceAndActions extends StatelessWidget {
  final PreInvoiceProductModel product;

  const RtcPreInvoiceProductPriceAndActions({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return SizedBox(
      height: 44,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (product.oldPrice != null && product.isAvailable)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  product.oldPrice!,
                  style: theme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.lineThrough,
                    color: AppColors.grayPalette.shade500,
                  ),
                ),
                SizedBox(width: 26, height: 0),
              ],
            ),
          product.isAvailable
              ? SizedBox(
                  height: 24,
                  child: Row(
                    children: [
                      if (product.discount != null && product.discount != "0%")
                        RtcDiscountBadge(
                          discount: product.discount!,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                        ),
                      const Spacer(),
                      Text(
                        product.price,
                        style: theme.labelLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.grayPalette.shade900,
                        ),
                      ),
                      const SizedBox(width: 2),
                      RtcImage(
                        image: "$baseImage/toman.svg",
                        width: 24,
                        height: 24,
                      ),
                    ],
                  ),
                )
              : const SizedBox(height: 24),
        ],
      ),
    );
  }
}
