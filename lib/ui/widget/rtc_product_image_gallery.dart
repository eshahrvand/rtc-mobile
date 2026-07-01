import 'package:flutter/material.dart';
import 'package:rtc_mobile/config/constants.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'rtc_image.dart';
import 'rtc_image_preview.dart';

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
    final effectiveImages = imageUrls.isEmpty
        ? ['$baseImage/package_check_gray.svg']
        : imageUrls;

    return Column(
      children: [
        SizedBox(
          height: 270,
          child: PageView.builder(
            itemCount: effectiveImages.length,
            onPageChanged: onImageChanged,
            itemBuilder: (context, index) {
              final img = effectiveImages[index];
              final displayImage = img.isNotEmpty
                  ? img
                  : '$baseImage/package_check_gray.svg';

              return GestureDetector(
                onTap: () =>
                    RtcImagePreview.show(context, effectiveImages, index),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: RtcImage(image: displayImage, boxFit: BoxFit.contain),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        AnimatedSmoothIndicator(
          activeIndex: selectedIndex,
          count: effectiveImages.length,
          effect: ExpandingDotsEffect(
            dotHeight: 6,
            dotWidth: 6,
            spacing: 6,
            activeDotColor: AppColors.brandPalette.shade500,
            dotColor: AppColors.grayPalette.shade200,
          ),
        ),
      ],
    );
  }
}
