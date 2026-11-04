import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../config/errorhandler.dart';
import '../../../../config/snackbar.dart';
import '../../../../core/models/workspace_models.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_image.dart';
import '../../workspace/bloc/workspace_cubit.dart';
import '../../workspace/bloc/workspace_state.dart';
import '../bloc/dashboard_cubit.dart';

class HomeBannerCarousel extends StatefulWidget {
  const HomeBannerCarousel({super.key, this.horizontalBleed = 16});
  final double horizontalBleed;
  @override
  State<HomeBannerCarousel> createState() => _HomeBannerCarouselState();
}

class _HomeBannerCarouselState extends State<HomeBannerCarousel> {
  final PageController _pages = PageController(
    viewportFraction: 341 / 375,
    keepPage: false,
  );
  int _index = 0;

  VoidCallback? _action(BuildContext context, HomeBanner banner) {
    if (banner.screen == 'orders') {
      return () => context.read<DashboardCubit>().onNavItemSelected(2);
    }
    final link = banner.link;
    if (link == null) return null;
    return () {
      launchUrl(link, mode: LaunchMode.externalApplication)
          .then((opened) {
            if (!opened) throw StateError('Could not open slider URL');
          })
          .catchError((Object error) {
            if (context.mounted) {
              rtcSnackBar(
                context: context,
                type: SnackBarType.error,
                message: ErrorHandler.getMessage(error),
              );
            }
          });
    };
  }

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) => BlocConsumer<WorkspaceCubit, WorkspaceState>(
    listenWhen: (previous, current) =>
        !listEquals(previous.banners, current.banners),
    listener: (context, state) {
      setState(() => _index = 0);
      if (_pages.hasClients) _pages.jumpToPage(0);
    },
    buildWhen: (previous, current) =>
        !listEquals(previous.banners, current.banners),
    builder: (context, state) {
      final banners = state.banners
          .where((banner) => banner.height.isFinite && banner.height > 0)
          .toList();
      if (banners.isEmpty) return const SizedBox.shrink();
      final index = _index.clamp(0, banners.length - 1);
      return LayoutBuilder(
        builder: (context, constraints) {
          final banner = banners[index];
          // Extend through the dashboard's side padding so the adjacent
          // slide remains visible, matching the 329 px card in Figma.
          final viewportWidth =
              constraints.maxWidth + widget.horizontalBleed * 2;
          final imageWidth = viewportWidth * _pages.viewportFraction - 12;
          final height = banner.imageWidth == null
              ? banner.height
              : imageWidth * banner.height / banner.imageWidth!;
          return SizedBox(
            height: height + 52,
            child: OverflowBox(
              minWidth: viewportWidth,
              maxWidth: viewportWidth,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: Column(
                  children: [
                    SizedBox(
                      height: height,
                      child: PageView.builder(
                        clipBehavior: Clip.none,
                        controller: _pages,
                        itemCount: banners.length,
                        onPageChanged: (index) =>
                            setState(() => _index = index),
                        itemBuilder: (context, i) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Semantics(
                            label: banners[i].description,
                            image: true,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: _action(context, banners[i]),
                              child: Container(
                                key: ValueKey('home-slide-${banners[i].id}'),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: AppColors.primaryShadow,
                                ),
                                foregroundDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: AppColors.grayPalette.shade200,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Transform.scale(
                                    scale: banners[i].imageScale,
                                    alignment: Alignment(
                                      banners[i].imageAlignmentX,
                                      0,
                                    ),
                                    child: RtcImage(
                                      image: banners[i].image,
                                      alignment: Alignment(
                                        banners[i].imageAlignmentX,
                                        0,
                                      ),
                                      width: double.infinity,
                                      height: height,
                                      boxFit: BoxFit.cover,
                                    ),
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
              ),
            ),
          );
        },
      );
    },
  );
}
