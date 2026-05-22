import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../../widget/rtc_divider.dart';


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
                const Spacer(),
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected
            ? AppColors.brandPalette.shade600
            : Colors.transparent,
        border: isSelected
            ? null
            : Border.all(
          color: AppColors.grayPalette.shade300,
          width: 1.5,
        ),
      ),
      child: isSelected
          ? const Icon(Icons.check_rounded, color: Colors.white, size: 13)
          : null,
    );
  }
}