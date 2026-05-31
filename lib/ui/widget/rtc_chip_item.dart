import 'package:flutter/material.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import '../../../data/models/product_chip_model.dart';
import 'rtc_image.dart';
import 'package:rtc_mobile/config/config.dart';

class RtcChipItem extends StatelessWidget {
  final ProductChipModel chip;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback? onClose;

  const RtcChipItem({
    super.key,
    required this.chip,
    required this.isSelected,
    required this.onTap,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        onTap();
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : AppColors.grayPalette.shade50,
          boxShadow: AppColors.primaryShadow,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 7, 12, 7),
              child: Text(
                chip.label,
                style: theme.bodyMedium!.copyWith(
                  color: isSelected
                      ? Colors.white
                      : AppColors.grayPalette.shade900,
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                ),
              ),
            ),
            if (isSelected)
              Padding(
                padding: const EdgeInsets.only(right: 12, left: 8),
                child: Container(
                  width: 1,
                  height: double.infinity,
                  color: Colors.white,
                ),
              ),
            if (isSelected)
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 7, 0, 7),
                child: GestureDetector(
                  onTap: (onClose ?? onTap),
                  behavior: HitTestBehavior.opaque,
                  child: RtcImage(
                    image: '$baseImage/close.svg',
                    width: 16,
                    height: 16,
                    color: Colors.white,
                  ),
                ),
              )
            else if (chip.opensBottomSheet)
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 7, 8, 7),
                child: RtcImage(
                  image: '$baseImage/angle-down-thick.svg',
                  width: 16,
                  height: 16,
                  color: AppColors.grayPalette.shade700,
                ),
              )
            else
              const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
