import 'package:flutter/material.dart';
import '../../../data/models/product_detail_model.dart';
import 'rtc_image.dart';

class RtcProductBadgeList extends StatelessWidget {
  final List<ProductBadgeModel> badges;

  const RtcProductBadgeList({
    super.key,
    required this.badges,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: badges.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final badge = badges[index];
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              // TODO: replace with theme color
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (badge.iconPath != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: RtcImage(
                      image: badge.iconPath!,
                      width: 16,
                      height: 16,
                    ),
                  ),
                Text(
                  '${badge.label}: ',
                  style: const TextStyle(
                    // TODO: replace with AppTextStyle
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  badge.value,
                  style: const TextStyle(
                    // TODO: replace with AppTextStyle
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
