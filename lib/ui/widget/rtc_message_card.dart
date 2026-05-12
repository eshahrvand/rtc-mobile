import 'package:flutter/material.dart';
import 'rtc_image.dart';

class RtcMessageCard extends StatelessWidget {
  final String message;
  final String iconPath;

  const RtcMessageCard({
    super.key,
    required this.message,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9F2), // // TODO: replace with theme values
        borderRadius: BorderRadius.circular(8), // // TODO: replace with theme values
        border: Border.all(
          color: const Color(0xFFFFE4C4), // // TODO: replace with theme values
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RtcImage(
            image: iconPath,
            width: 20,
            height: 20,
            color: const Color(0xFFFB8C00), // // TODO: replace with theme values
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 12, // // TODO: replace with theme values
                color: Color(0xFFD87C00), // // TODO: replace with theme values
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
