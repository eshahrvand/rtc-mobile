import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../../widget/rtc_divider.dart';
import '../../../widget/rtc_image.dart';

class FilterOptionItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final bool showDivider;

  const FilterOptionItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InkWell(
          onTap: onTap,
          splashColor: AppColors.brandPalette.shade50,
          highlightColor: AppColors.brandPalette.shade50.withAlpha(128),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                const Spacer(),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: isSelected
                        ? AppColors.grayPalette.shade900
                        : AppColors.grayPalette.shade700,
                    fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                  ),
                ),
                const SizedBox(width: 12),
                _RadioIndicator(isSelected: isSelected),
              ],
            ),
          ),
        ),
        if (showDivider)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RtcDivider(),
          ),
      ],
    );
  }
}

class _RadioIndicator extends StatelessWidget {
  final bool isSelected;

  const _RadioIndicator({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    if (isSelected) {
      return RtcImage(
        image: 'assets/images/tick_circle.svg',
        width: 24,
        height: 24,
      );
    } else {
      return Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.grayPalette.shade300, width: 1),
        ),
      );
    }
  }
}
