import 'package:flutter/material.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import '../../../data/models/product_detail_model.dart';
import 'rtc_image.dart';

class RtcProductBadgeList extends StatelessWidget {
  final List<ProductBadgeModel> badges;

  const RtcProductBadgeList({super.key, required this.badges});

  @override
  Widget build(BuildContext context) {
    if (badges.isEmpty) return const SizedBox.shrink();

    // Separate "Availability" (موجودی) from others if present
    final availabilityBadge = badges.firstWhere(
      (b) => b.label.contains('موجودی'),
      orElse: () =>
          badges.first, // Fallback, though we might want to handle it better
    );

    final otherBadges = badges.where((b) => b != availabilityBadge).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BadgeItem(badge: availabilityBadge, isGreen: true),
          if (otherBadges.isNotEmpty) ...[
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.end,
              children: otherBadges.map((b) => _BadgeItem(badge: b)).toList(),
            ),
          ],
        ],
      ),
    );
  }
}

class _BadgeItem extends StatelessWidget {
  final ProductBadgeModel badge;
  final bool isGreen;

  const _BadgeItem({required this.badge, this.isGreen = false});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isGreen
            ? AppColors.successPalette.shade500
            : AppColors.grayPalette.shade900,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (badge.iconPath != null)
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: RtcImage(
                image: badge.iconPath!,
                width: 14,
                height: 14,
                color: Colors.white,
              ),
            ),
          Text(
            '${badge.label}: ',
            style: theme.bodyMedium!.copyWith(color: Colors.white),
          ),
          Text(
            badge.value,
            style: theme.bodyMedium!.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
