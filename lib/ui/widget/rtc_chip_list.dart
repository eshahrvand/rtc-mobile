import 'package:flutter/material.dart';
import '../../../data/models/product_chip_model.dart';
import 'rtc_chip_item.dart';

class RtcChipList extends StatelessWidget {
  final List<ProductChipModel> chips;
  final int selectedIndex;
  final Function(int index, ProductChipModel chip) onChipTap;

  const RtcChipList({
    super.key,
    required this.chips,
    required this.selectedIndex,
    required this.onChipTap,
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
            isSelected: selectedIndex == index,
            onTap: () => onChipTap(index, chip),
          );
        },
      ),
    );
  }
}
