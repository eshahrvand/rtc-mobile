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
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: chips.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final chip = chips[index];
          return RtcChipItem(
            chip: chip,
            isSelected: isChipSelected(index, chip),
            onTap: () => onChipTap(index, chip),
            onClose: onChipClose != null ? () => onChipClose!(index, chip) : null,
          );
        },
      ),
    );
  }
}
