import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_image.dart';
import '../../workspace/bloc/workspace_cubit.dart';
import '../../workspace/bloc/workspace_state.dart';

class HomeBannerCarousel extends StatefulWidget {
  const HomeBannerCarousel({super.key});
  @override
  State<HomeBannerCarousel> createState() => _HomeBannerCarouselState();
}

class _HomeBannerCarouselState extends State<HomeBannerCarousel> {
  final PageController _pages = PageController(viewportFraction: .995);
  int _index = 0;
  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) => BlocBuilder<WorkspaceCubit, WorkspaceState>(
    buildWhen: (previous, current) => previous.banners != current.banners,
    builder: (context, state) {
      final banners = state.banners
          .where((banner) => banner.height.isFinite && banner.height > 0)
          .toList();
      if (banners.isEmpty) return const SizedBox.shrink();
      final index = _index.clamp(0, banners.length - 1);
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Column(
          children: [
            SizedBox(
              height: banners[index].height,
              child: PageView.builder(
                controller: _pages,
                itemCount: banners.length,
                onPageChanged: (index) => setState(() => _index = index),
                itemBuilder: (context, i) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Semantics(
                    label: banners[i].description,
                    image: true,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: banners[i].link == null
                          ? null
                          : () => launchUrl(
                              banners[i].link!,
                              mode: LaunchMode.externalApplication,
                            ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Transform.scale(
                          scale: banners[i].imageScale,
                          alignment: Alignment(banners[i].imageAlignmentX, 0),
                          child: RtcImage(
                            image: banners[i].image,
                            alignment: Alignment(banners[i].imageAlignmentX, 0),
                            width: double.infinity,
                            height: banners[i].height,
                            boxFit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                banners.length,
                (i) => GestureDetector(
                  onTap: () => _pages.animateToPage(
                    i,
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Container(
                      width: i == index ? 14 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: i == index
                            ? AppColors.grayPalette.shade700
                            : AppColors.grayPalette.shade200,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
