import 'package:flutter/material.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
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
        AnimatedSmoothIndicator(
          activeIndex: selectedIndex,
          count: imageUrls.length,
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
