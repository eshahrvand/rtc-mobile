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
      children: [
        InkWell(
          onTap: onTap,
          splashColor: AppColors.brandPalette.shade50,
          highlightColor: AppColors.brandPalette.shade50.withOpacity(0.5),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                _RadioIndicator(isSelected: isSelected),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: isSelected
                        ? AppColors.brandPalette.shade700
                        : AppColors.grayPalette.shade700,
                    fontWeight:
                    isSelected ? FontWeight.w500 : FontWeight.w400,
                  ),
                ),
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
    return RtcImage(
      image: isSelected
          ? 'assets/icons/radio_active.svg'
          : 'assets/icons/radio_inactive.svg',
      width: 20,
      height: 20,
    );
  }
}