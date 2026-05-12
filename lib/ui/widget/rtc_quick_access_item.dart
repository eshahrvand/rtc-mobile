import 'package:flutter/material.dart';
import 'rtc_image.dart';

class RtcQuickAccessItem extends StatelessWidget {
  final String title;
  final String iconPath;
  final String? badgeCount;
  final VoidCallback onTap;

  const RtcQuickAccessItem({
    super.key,
    required this.title,
    required this.iconPath,
    this.badgeCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white, // // TODO: replace with theme values
            borderRadius: BorderRadius.circular(12), // // TODO: replace with theme values
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05), // // TODO: replace with theme values
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: RtcImage(
                      image: iconPath,
                      width: 24,
                      height: 24,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10, // // TODO: replace with theme values
                      color: Colors.grey, // // TODO: replace with theme values
                    ),
                  ),
                ],
              ),
              if (badgeCount != null)
                Positioned(
                  top: -8,
                  right: -8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1), // // TODO: replace with theme values
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      badgeCount!,
                      style: const TextStyle(
                        color: Colors.green, // // TODO: replace with theme values
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
