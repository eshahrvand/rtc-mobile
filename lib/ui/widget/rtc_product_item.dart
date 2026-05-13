import 'package:flutter/material.dart';
import '../../../data/models/product_item_model.dart';
import 'rtc_image.dart';

class RtcProductItem extends StatelessWidget {
  final ProductItemModel product;
  final VoidCallback onTap;

  const RtcProductItem({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          // TODO: replace with theme color
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          // TODO: replace with theme shadow
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          // TODO: replace with theme border
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Row(
          children: [
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      // TODO: replace with AppTextStyle
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  if (product.subtitle != null)
                    Text(
                      product.subtitle!,
                      style: const TextStyle(
                        // TODO: replace with AppTextStyle
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  const SizedBox(height: 8),
                  Text(
                    'موجودی (${product.inventory})',
                    style: const TextStyle(
                      // TODO: replace with theme color
                      color: Colors.green,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (product.oldPrice != null)
                            Text(
                              product.oldPrice!,
                              style: const TextStyle(
                                // TODO: replace with AppTextStyle
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                                fontSize: 12,
                              ),
                            ),
                          Row(
                            children: [
                              Text(
                                product.price,
                                style: const TextStyle(
                                  // TODO: replace with AppTextStyle
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                'تومان',
                                style: TextStyle(
                                  // TODO: replace with AppTextStyle
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (product.discount != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            // TODO: replace with theme color
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            product.discount!,
                            style: const TextStyle(
                              // TODO: replace with theme color
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Image
            RtcImage(
              image: product.imageUrl,
              width: 100,
              height: 100,
              boxFit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
