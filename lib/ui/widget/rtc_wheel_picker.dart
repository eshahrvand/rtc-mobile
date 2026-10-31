import 'package:flutter/material.dart';
import '../theme/colors.dart';

/// A single scrolling selection column, matching the project's Jalali picker.
class RtcWheelPicker extends StatefulWidget {
  final List<String> items;
  final int initialIndex;
  final ValueChanged<int> onChanged;

  const RtcWheelPicker({
    super.key,
    required this.items,
    required this.initialIndex,
    required this.onChanged,
  }) : assert(items.length > 0),
       assert(initialIndex >= 0 && initialIndex < items.length);

  @override
  State<RtcWheelPicker> createState() => _RtcWheelPickerState();
}

class _RtcWheelPickerState extends State<RtcWheelPicker> {
  late final FixedExtentScrollController _controller;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _controller = FixedExtentScrollController(initialItem: _selectedIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return SizedBox(
      height: 150,
      child: Stack(
        alignment: Alignment.center,
        children: [
          IgnorePointer(
            child: Container(
              width: 120,
              height: 50,
              decoration: BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(color: AppColors.grayPalette.shade200),
                ),
              ),
            ),
          ),
          ListWheelScrollView.useDelegate(
            controller: _controller,
            itemExtent: 50,
            perspective: 0.000001,
            diameterRatio: 100,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: (index) {
              setState(() => _selectedIndex = index);
              widget.onChanged(index);
            },
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: widget.items.length,
              builder: (context, index) => Center(
                child: Text(
                  widget.items[index],
                  style: index == _selectedIndex
                      ? theme.labelLarge?.copyWith(
                          color: AppColors.grayPalette.shade800,
                        )
                      : theme.bodyLarge?.copyWith(
                          color: AppColors.grayPalette.shade400,
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
