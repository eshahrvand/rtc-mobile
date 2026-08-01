import 'package:flutter/material.dart';

import '../../../../config/constants.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_divider.dart';
import '../../../widget/rtc_image.dart';

class FilterOptionItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final bool showDivider;
  final bool isMultiSelect;

  const FilterOptionItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.showDivider = true,
    this.isMultiSelect = false,
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
                _SelectionIndicator(
                  isSelected: isSelected,
                  isMultiSelect: isMultiSelect,
                ),
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

class _SelectionIndicator extends StatelessWidget {
  final bool isSelected;
  final bool isMultiSelect;

  const _SelectionIndicator({
    required this.isSelected,
    required this.isMultiSelect,
  });

  @override
  Widget build(BuildContext context) {
    if (isMultiSelect) {
      return RtcImage(
        image: isSelected
            ? "$baseImage/check-boxes-select.svg"
            : "$baseImage/check_boxes.svg",
        width: 24,
        height: 24,
        boxFit: BoxFit.fill,
      );
    }
    return RtcImage(
      image: isSelected
          ? "$baseImage/brand_check_circle.svg"
          : "$baseImage/gray_check_circle.svg",
      width: 24,
      height: 24,
    );
  }
}
