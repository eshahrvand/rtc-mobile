import 'package:flutter/material.dart';
import 'package:rtc_mobile/config/constants.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_discount_badge.dart';
import '../../core/models/product_item_model.dart';
import 'rtc_image.dart';

class RtcProductItem extends StatelessWidget {
  final ProductItemModel product;
  final VoidCallback onTap;
  final bool showPrice;

  const RtcProductItem({
    super.key,
    required this.product,
    required this.onTap,
    this.showPrice = true,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: AppColors.primaryShadow,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: RtcImage(
                  image: product.imageUrl.isNotEmpty
                      ? product.imageUrl
                      : '$baseImage/package_check_gray.svg',
                  width: 104,
                  height: 104,
                  boxFit: BoxFit.contain,
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40,
                        child: Text(
                          product.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.labelMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.grayPalette.shade20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        height: 16,
                        child: Text(
                          product.inventory == "0"
                              ? "ناموجود"
                              : 'موجودی (${product.inventory})',
                          style: theme.labelSmall!.copyWith(
                            color: product.inventory == "0"
                                ? AppColors.grayPalette.shade500
                                : AppColors.successPalette.shade600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        height: 44,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (product.discount != null &&
                                showPrice &&
                                product.discount != '۰٪' &&
                                product.discount != '0٪')
                              SizedBox(
                                width: 34,
                                height: 22,
                                child: RtcDiscountBadge(
                                  discount: product.discount!,
                                ),
                              ),
                            const Spacer(),
                            if (showPrice)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if (product.oldPrice != null &&
                                      product.discount != null)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 26),
                                      child: Text(
                                        product.oldPrice!,
                                        style: theme.bodyMedium!.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.grayPalette.shade500,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ),
                                  if (product.inventory != "0")
                                    Row(
                                      spacing: 2,
                                      children: [
                                        Text(
                                          product.price,
                                          style: theme.labelLarge!.copyWith(
                                            color:
                                                AppColors.grayPalette.shade900,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),

                                        RtcImage(
                                          image: "assets/images/rial.svg",
                                          width: 24,
                                          height: 24,
                                          boxFit: BoxFit.contain,
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
