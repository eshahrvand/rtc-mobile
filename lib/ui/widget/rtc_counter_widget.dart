import 'package:flutter/material.dart';
import '../../../../config/constants.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'rtc_image.dart';

/// A unified counter widget for incrementing and decrementing values.
///
/// This widget handles three distinct styles found in the codebase:
/// 1. Standard counter with circular Add button at quantity 0.
/// 2. Card style counter with fixed width and spacers (used in cart).
/// 3. Product item counter with specific text styles and optional icon coloring.
///
/// Parameters:
/// - [quantity]: The current value to display.
/// - [onAdd]: Callback when the increment button is tapped.
/// - [onRemove]: Callback when the decrement/delete button is tapped.
/// - [isAvailable]: Whether the item can be added (only used when quantity is 0).
/// - [isCardStyle]: If true, applies fixed width (108), specific border radius (8), and uses Spacers.
/// - [colorDeleteIcon]: If true, colors the delete icon with error palette shade 600.
/// - [textStyle]: Custom text style for the quantity display.
class RtcCounterWidget extends StatelessWidget {
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final bool isAvailable;
  final bool isCardStyle;
  final bool colorDeleteIcon;
  final TextStyle textStyle;

  const RtcCounterWidget({
    super.key,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
    required this.isAvailable,
    required this.isCardStyle,
    required this.colorDeleteIcon,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    // Quantity 0 state: Circular Add button
    if (quantity == 0) {
      return GestureDetector(
        onTap: isAvailable ? onAdd : null,
        child: Container(
          width: 32,
          height: 32,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: AppColors.grayPalette.shade200,
              width: 0.5,
            ),
            shape: BoxShape.circle,
          ),
          child: RtcImage(
            image: "$baseImage/add-basket.svg",
            width: 16,
            height: 16,
          ),
        ),
      );
    }

    // Standard / Card Style state
    return Container(
      width: isCardStyle ? 108 : 96,
      height: 32,

      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.grayPalette.shade200),
        borderRadius: BorderRadius.circular(isCardStyle ? 8 : 100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 32,
            height: 32,
            child: GestureDetector(
              onTap: onAdd,
              child: RtcImage(
                image: "$baseImage/add-basket.svg",
                width: 16,
                height: 16,
              ),
            ),
          ),
          Spacer(),
          Text('$quantity', style: textStyle),

          Spacer(),
          SizedBox(
            width: 32,
            height: 32,
            child: GestureDetector(
              onTap: onRemove,
              child: RtcImage(
                image: quantity == 1
                    ? "$baseImage/delete.svg"
                    : "$baseImage/mines.svg",
                width: 16,
                height: 16,
                color: (quantity == 1 && colorDeleteIcon)
                    ? AppColors.errorPalette.shade600
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
