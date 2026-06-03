import 'package:flutter/material.dart';
import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import '../../../../data/models/pre_invoice_model.dart';
import 'package:rtc_mobile/ui/widget/rtc_discount_badge.dart';
import '../../../widget/rtc_image.dart';

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
          child: product.isAvailable ? _buildCounter(context) : SizedBox(),
        ),
      ],
    );
  }

  Widget _buildAvailability(BuildContext context) {
    return Text(
      product.isAvailable ? 'موجودی (${product.inventory})' : 'ناموجود',
      style: Theme.of(context).textTheme.labelSmall!.copyWith(
        fontWeight: FontWeight.w600,
        color: !product.isAvailable
            ? AppColors.grayPalette.shade500
            : AppColors.successPalette.shade600,
      ),
    );
  }

  Widget _buildPriceAndActions(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
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
        Row(
          children: [
            if (product.discount != "0%")
              RtcDiscountBadge(
                discount: product.discount!,
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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
            RtcImage(image: "$baseImage/toman.svg", width: 24, height: 24),
          ],
        ),
      ],
    );
  }

  Widget _buildCounter(BuildContext context) {
    if (quantity == 0) {
      return GestureDetector(
        onTap: product.isAvailable ? onAdd : null,
        child: Container(
          width: 32,
          height: 32,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.grayPalette.shade200),
            shape: BoxShape.circle,
          ),
          child: RtcImage(
            image: "$baseImage/add-basket.svg",
            width: 16,
            height: 16,
          ),
        ),
      );
    }

    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.grayPalette.shade200),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onAdd,
            child: RtcImage(
              image: "$baseImage/add-basket.svg",
              width: 16,
              height: 16,
            ),
          ),
          const SizedBox(width: 14),
          Text(
            '$quantity',
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w600
            )
          ),
          const SizedBox(width: 14),
          GestureDetector(
            onTap: onRemove,
            child: RtcImage(
              image: quantity == 1
                  ? "$baseImage/delete.svg"
                  : "$baseImage/mines.svg",
              width: 16,
              height: 16,
            ),
          ),
        ],
      ),
    );
  }
}
