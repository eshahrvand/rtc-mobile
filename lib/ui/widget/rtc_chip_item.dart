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
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          boxShadow: AppColors.primaryShadow,
          border: Border.all(
            color: isSelected ? Colors.black : Colors.grey.shade300,
            width: isSelected ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              chip.label,
              style: theme.bodyMedium!.copyWith(
                color: isSelected
                    ? Colors.white
                    : AppColors.grayPalette.shade900,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
              ),
            ),

            if (isSelected)
              Padding(
                padding: const EdgeInsets.only(right: 8),
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
                padding: const EdgeInsets.only(right: 8),
                child: RtcImage(
                  image: '$baseImage/angle-down-thick.svg',
                  width: 16,
                  height: 16,
                  color: AppColors.grayPalette.shade700,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
