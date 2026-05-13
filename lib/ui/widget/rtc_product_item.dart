import 'package:flutter/material.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import '../../../data/models/product_item_model.dart';
import 'rtc_image.dart';

class RtcProductItem extends StatelessWidget {
  final ProductItemModel product;
  final VoidCallback onTap;

  const RtcProductItem({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: AppColors.primaryShadow,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: RtcImage(
                image: product.imageUrl,
                width: 100,
                height: 100,
                boxFit: BoxFit.contain,
              ),
            ),

            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.labelMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.grayPalette.shade20,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'موجودی (${product.inventory})',
                      style: theme.labelSmall!.copyWith(
                        color: AppColors.successPalette.shade600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (product.discount != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.errorPalette.shade500,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              product.discount!,
                              style: theme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (product.oldPrice != null)
                              Padding(
                                padding: const EdgeInsets.only(right: 18),
                                child: Text(
                                  product.oldPrice!,
                                  style: theme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.grayPalette.shade500,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ),
                            Row(
                              spacing: 2,
                              children: [
                                Text(
                                  product.price,
                                  style: theme.labelLarge!.copyWith(
                                    color: AppColors.grayPalette.shade900,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                Text(
                                  'تومان',
                                  style: theme.labelLarge!.copyWith(
                                    color: AppColors.grayPalette.shade900,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
