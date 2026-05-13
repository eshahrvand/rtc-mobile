import 'package:flutter/material.dart';
import 'rtc_image.dart';

class RtcProductImageGallery extends StatelessWidget {
  final List<String> imageUrls;
  final int selectedIndex;
  final Function(int) onImageChanged;

  const RtcProductImageGallery({
    super.key,
    required this.imageUrls,
    required this.selectedIndex,
    required this.onImageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: PageView.builder(
            itemCount: imageUrls.length,
            onPageChanged: onImageChanged,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: RtcImage(
                  image: imageUrls[index],
                  boxFit: BoxFit.contain,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            imageUrls.length,
            (index) => Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // TODO: replace with theme color
                color: selectedIndex == index
                    ? Colors.blue
                    : Colors.grey.shade300,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
