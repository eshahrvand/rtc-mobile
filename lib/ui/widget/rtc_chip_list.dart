import 'package:flutter/material.dart';
import '../../../data/models/product_chip_model.dart';
import '../presenters/products/widget/filter_bottom_sheet.dart';
import 'rtc_chip_item.dart';

class RtcChipList extends StatelessWidget {
  final List<ProductChipModel> chips;
  final bool Function(int index, ProductChipModel chip) isChipSelected;
  final Function(int index, ProductChipModel chip) onChipTap;
  final Function(int index, ProductChipModel chip)? onChipClose;

  const RtcChipList({
    super.key,
    required this.chips,
    required this.isChipSelected,
    required this.onChipTap,
    this.onChipClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      alignment: Alignment.center,
      child: SizedBox(
        height: 44, // Increased height to allow shadow to render
        child: ListView.separated(
          clipBehavior: Clip.none, // Allow shadow to bleed out if needed
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: chips.length,
          separatorBuilder: (context, index) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final chip = chips[index];
            return Center(
              child: RtcChipItem(
                chip: chip,
                isSelected: isChipSelected(index, chip),
                onTap: () => onChipTap(index, chip),
                onClose: onChipClose != null
                    ? () => onChipClose!(index, chip)
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }
}
