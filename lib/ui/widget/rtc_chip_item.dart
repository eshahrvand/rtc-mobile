import 'package:flutter/material.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import '../../core/models/product_chip_model.dart';
import 'rtc_image.dart';
import '../../../../config/constants.dart';

class RtcChipItem extends StatelessWidget {
  final ProductChipModel chip;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback? onClose;
  final int? selectedCount;

  const RtcChipItem({
    super.key,
    required this.chip,
    required this.isSelected,
    required this.onTap,
    this.onClose,
    this.selectedCount,
  });

  static String _toPersianDigits(int number) {
    const farsiDigits = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    return number.toString().split('').map((char) {
      final index = int.tryParse(char);
      return index != null ? farsiDigits[index] : char;
    }).join('');
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    final effectiveCount = selectedCount ?? chip.selectedCount;

    return GestureDetector(
      onTap: () {
        onTap();
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 32,
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : AppColors.grayPalette.shade50,
          boxShadow: AppColors.primaryShadow,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(isSelected ? 12 : 8, 7, 12, 7),
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
                  if (isSelected && effectiveCount != null && effectiveCount > 1) ...[
                    const SizedBox(width: 4),
                    Text(
                      '(${_toPersianDigits(effectiveCount)})',
                      style: theme.bodyMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (isSelected)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Container(
                  width: 1,
                  height: double.infinity,
                  color: Colors.white,
                ),
              ),
            if (isSelected)
              Padding(
                padding: EdgeInsets.fromLTRB(isSelected ? 8 : 12, 7, 0, 7),
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
