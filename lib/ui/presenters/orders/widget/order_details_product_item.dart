import 'package:flutter/material.dart';
import '../../../../data/models/order_model.dart';
import '../../../../generated/l10n.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_image.dart';

class OrderDetailsProductItem extends StatelessWidget {
  final OrderProductModel product;

  const OrderDetailsProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(8),
            child: RtcImage(image: product.imageUrl, boxFit: BoxFit.contain),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  textAlign: TextAlign.right,
                  style: theme.bodyMedium!.copyWith(
                    color: AppColors.grayPalette.shade900,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  spacing: 4,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (product.oldPrice != null)
                      Text(
                        product.oldPrice!,
                        style: theme.bodyMedium!.copyWith(
                          color: AppColors.grayPalette.shade500,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    if (product.discount != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: AppColors.errorPalette.shade50,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          product.discount!,
                          style: theme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.errorPalette.shade700,
                          ),
                        ),
                      ),
                  ],
                ),
                Row(
                  spacing: 4,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      product.price,
                      style: theme.labelMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.grayPalette.shade900,
                      ),
                    ),
                    Text(
                      S.current.toman,
                      style: theme.labelMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.grayPalette.shade900,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 24,
                      height: 24,
                      padding: const EdgeInsets.only(right: 2, left: 2),
                      decoration: BoxDecoration(
                        color: AppColors.brandPalette.shade25,
                        borderRadius: const BorderRadius.all(Radius.circular(100)),
                      ),
                      child: Center(
                        child: Text(
                          product.quantity,
                          style: theme.labelLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.brandPalette.shade600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
