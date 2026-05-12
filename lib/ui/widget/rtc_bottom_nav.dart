import 'package:flutter/material.dart';
import 'rtc_image.dart';

class RtcBottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const RtcBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // // TODO: replace with theme values
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05), // // TODO: replace with theme values
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(0, 'داشبورد', 'assets/images/ic_dashboard.svg'),
              _buildNavItem(1, 'کالاها', 'assets/images/ic_products.svg'),
              _buildNavItem(2, 'سفارشات', 'assets/images/ic_orders.svg'),
              _buildNavItem(3, 'پروفایل', 'assets/images/ic_profile.svg'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String label, String iconPath) {
    final bool isSelected = selectedIndex == index;
    final Color color = isSelected
        ? Colors.blue // // TODO: replace with theme values
        : Colors.grey; // // TODO: replace with theme values

    return Expanded(
      child: GestureDetector(
        onTap: () => onItemSelected(index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RtcImage(
              image: iconPath,
              width: 24,
              height: 24,
              color: color,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10, // // TODO: replace with theme values
                color: color,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
