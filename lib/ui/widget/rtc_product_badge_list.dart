import 'package:flutter/material.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import '../../../data/models/product_detail_model.dart';
import '../../generated/l10n.dart';
import 'rtc_image.dart';

class RtcProductBadgeList extends StatelessWidget {
  final List<ProductBadgeModel> badges;

  const RtcProductBadgeList({super.key, required this.badges});

  @override
  Widget build(BuildContext context) {
    if (badges.isEmpty) return const SizedBox.shrink();

    // Separate "Availability" (موجودی or ناموجود) from others if present
    final availabilityBadge = badges.firstWhere(
      (b) => b.label.contains('موجودی') || b.label == 'ناموجود',
      orElse: () => badges.first,
    );

    final planBadge = badges.any((b) => b.label.contains('طرح')) 
        ? badges.firstWhere((b) => b.label.contains('طرح'))
        : null;

    final otherBadges = badges
        .where((b) => b != availabilityBadge && b != planBadge)
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 8,
            children: [
              _BadgeItem(badge: availabilityBadge, isGreen: true),
              if (planBadge != null)
                _BadgeItem(badge: planBadge, color: AppColors.brandPalette.shade600),
            ],
          ),
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
  final Color? color;

  const _BadgeItem({
    required this.badge, 
    this.isGreen = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    final bool isOutOfStock = badge.label == 'ناموجود';
    final bool isSku = badge.label == 'SKU';

    Color bgColor = AppColors.grayPalette.shade900;
    if (isOutOfStock) {
      bgColor = AppColors.grayPalette.shade500;
    } else if (isGreen) {
      bgColor = AppColors.successPalette.shade500;
    }
    if (color != null) bgColor = color!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Directionality(
        textDirection: isSku ? TextDirection.ltr : TextDirection.rtl,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (badge.iconPath != null)
              Padding(
                padding: EdgeInsets.only(
                  left: isSku ? 0 : 8,
                  right: isSku ? 8 : 0,
                ),
                child: RtcImage(
                  image: badge.iconPath!,
                  width: 14,
                  height: 14,
                  color: Colors.white,
                ),
              ),
            Text(
              isOutOfStock ? badge.label : S.current.labelWithColon(badge.label),
              style: theme.bodyMedium!.copyWith(color: Colors.white),
            ),
            if (!isOutOfStock)
              Text(
                badge.value,
                style: theme.bodyMedium!.copyWith(color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}
