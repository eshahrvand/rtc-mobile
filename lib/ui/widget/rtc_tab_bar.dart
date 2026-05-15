import 'package:flutter/material.dart';

class RtcTabBar extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final Function(int) onTabChanged;

  const RtcTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            // TODO: replace with theme color
            color: Colors.grey.withOpacity(0.2),
          ),
        ),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = index == selectedIndex;
          return Expanded(
            child: InkWell(
              onTap: () => onTabChanged(index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected
                          ? Colors.blue // TODO: replace with theme color
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    tabs[index],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected
                          ? Colors.blue // TODO: replace with theme color
                          : Colors.grey, // TODO: replace with theme color
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
