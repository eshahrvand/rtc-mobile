import 'package:flutter/material.dart';
import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import '../../../../data/models/pre_invoice_model.dart';
import 'package:rtc_mobile/ui/widget/rtc_discount_badge.dart';
import '../../../widget/rtc_image.dart';
import '../../../widget/rtc_counter_widget.dart';

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
          _buildImage(context),
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

                _buildAvailability(context),

                _buildPriceAndActions(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
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
              : SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildAvailability(BuildContext context) {
    return SizedBox(
      height: 16,

      child: Text(
        product.isAvailable ? 'موجودی (${product.inventory})' : 'ناموجود',
        style: Theme.of(context).textTheme.labelSmall!.copyWith(
          fontWeight: FontWeight.w600,
          color: !product.isAvailable
              ? AppColors.grayPalette.shade500
              : AppColors.successPalette.shade600,
        ),
      ),
    );
  }

  Widget _buildPriceAndActions(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return SizedBox(
      height: 44,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (product.oldPrice != null)
            Text(
              product.oldPrice!,
              style: theme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.lineThrough,
                color: AppColors.grayPalette.shade500,
              ),
            ),
          product.isAvailable
              ? SizedBox(
                  height: 24,
                  child: Row(
                    children: [
                      if (product.discount != "0%")
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
              : SizedBox(height: 24),
        ],
      ),
    );
  }
}
