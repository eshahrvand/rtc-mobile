import 'package:flutter/material.dart';
import '../../../data/models/product_chip_model.dart';
import 'rtc_image.dart';
import 'package:rtc_mobile/config/config.dart';

class RtcChipItem extends StatelessWidget {
  final ProductChipModel chip;
  final bool isSelected;
  final VoidCallback onTap;

  const RtcChipItem({
    super.key,
    required this.chip,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          // TODO: replace with theme color
          color: isSelected ? Colors.white : Colors.white,
          // TODO: replace with theme color
          border: Border.all(
            color: isSelected ? Colors.black : Colors.grey.shade300,
            width: isSelected ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (chip.opensBottomSheet)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: RtcImage(
                  image: '$baseImage/angle-right.svg', // Placeholder for chevron-down
                  width: 16,
                  height: 16,
                  // TODO: replace with theme color
                  color: isSelected ? Colors.black : Colors.black,
                ),
              ),
            Text(
              chip.label,
              style: TextStyle(
                // TODO: replace with theme color
                color: isSelected ? Colors.black : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (isSelected && !chip.opensBottomSheet)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: RtcImage(
                  image: '$baseImage/close.svg',
                  width: 14,
                  height: 14,
                  // TODO: replace with theme color
                  color: Colors.black,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
