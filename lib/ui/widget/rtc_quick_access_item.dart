import 'package:flutter/material.dart';
import 'rtc_image.dart';

class RtcQuickAccessItem extends StatelessWidget {
  final String title;
  final String value;
  final String currency;
  final String iconPath;
  final String? percentage;
  final VoidCallback onTap;

  const RtcQuickAccessItem({
    super.key,
    required this.title,
    required this.value,
    required this.currency,
    required this.iconPath,
    this.percentage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(6),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white, // // TODO: replace with theme color
            borderRadius: BorderRadius.circular(24), // // TODO: replace with theme color
            border: Border.all(
              color: const Color(0xFFF2F4F7), // // TODO: replace with theme color
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Icon Container
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF8FF), // // TODO: replace with theme color
                      borderRadius: BorderRadius.circular(12), // // TODO: replace with theme color
                    ),
                    child: Center(
                      child: RtcImage(
                        image: iconPath,
                        width: 24,
                        height: 24,
                        color: const Color(0xFF2E90FA), // // TODO: replace with theme color
                      ),
                    ),
                  ),
                  // Percentage Badge
                  if (percentage != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFECFDF3), // // TODO: replace with theme color
                        borderRadius: BorderRadius.circular(10), // // TODO: replace with theme color
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            percentage!,
                            style: const TextStyle(
                              color: Color(0xFF12B76A), // // TODO: replace with theme color
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 2),
                          const Icon(
                            Icons.arrow_upward,
                            size: 14,
                            color: Color(0xFF12B76A), // // TODO: replace with theme color
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                title,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 14, // // TODO: replace with theme color
                  color: Color(0xFF475467), // // TODO: replace with theme color
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 20, // // TODO: replace with theme color
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF101828), // // TODO: replace with theme color
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    currency,
                    style: const TextStyle(
                      fontSize: 12, // // TODO: replace with theme color
                      color: Color(0xFF101828), // // TODO: replace with theme color
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
