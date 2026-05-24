import 'package:flutter/material.dart';

import '../../../../config/config.dart';
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onTap,
          splashColor: AppColors.brandPalette.shade50,
          highlightColor: AppColors.brandPalette.shade50.withAlpha(128),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                _RadioIndicator(isSelected: isSelected),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.grayPalette.shade800,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
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
          ? "$baseImage/brand_check_circle.svg"
          : "$baseImage/gray_check_circle.svg",
      width: 24,
      height: 24,
    );
  }
}
