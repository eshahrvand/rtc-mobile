import 'package:flutter/material.dart';
import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'rtc_image.dart';

class RtcCounter extends StatelessWidget {
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final bool isAvailable;

  const RtcCounter({
    super.key,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
    this.isAvailable = true,
  });

  @override
  Widget build(BuildContext context) {
    if (quantity == 0) {
      return GestureDetector(
        onTap: isAvailable ? onAdd : null,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.grayPalette.shade200),
            shape: BoxShape.circle,
          ),
          child: RtcImage(
            image: "$baseImage/add-basket.svg",
            width: 16,
            height: 16,
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.grayPalette.shade200),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onAdd,
            child: RtcImage(
              image: "$baseImage/add-basket.svg",
              width: 16,
              height: 16,
            ),
          ),
          const SizedBox(width: 14),
          Text(
            '$quantity',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 14),
          GestureDetector(
            onTap: onRemove,
            child: RtcImage(
              image: quantity == 1
                  ? "$baseImage/delete.svg"
                  : "$baseImage/remove.svg",
              width: 16,
              height: 16,
              color: quantity == 1 ? AppColors.errorPalette.shade600 : null,
            ),
          ),
        ],
      ),
    );
  }
}
