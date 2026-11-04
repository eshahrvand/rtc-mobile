// Use url_launcher's installed platform interface solely to fake native calls.
// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rtc_mobile/core/models/workspace_models.dart';
import 'package:rtc_mobile/locator.dart';
import 'package:rtc_mobile/main_ui_preview.dart';
import 'package:rtc_mobile/repository/workspace/workspace_repository.dart';
import 'package:rtc_mobile/ui/presenters/dashboard/bloc/dashboard_cubit.dart';
import 'package:rtc_mobile/ui/presenters/dashboard/widget/home_banner_carousel.dart';
import 'package:rtc_mobile/ui/presenters/workspace/bloc/workspace_cubit.dart';
import 'package:rtc_mobile/ui/presenters/workspace/bloc/workspace_state.dart';
import 'package:rtc_mobile/ui/theme/theme.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';
import 'package:url_launcher_platform_interface/link.dart';

class _Browser extends UrlLauncherPlatform {
  final calls = <(String, PreferredLaunchMode)>[];
  @override
  LinkDelegate? get linkDelegate => null;
  @override
  Future<bool> launchUrl(String url, LaunchOptions options) async {
    calls.add((url, options.mode));
    return true;
  }
}

HomeBanner banner(String id, {String? screen, Uri? link}) => HomeBanner(
  id: id,
  image: 'assets/images/workspace_rectangle34625736.png',
  imageWidth: 662,
  height: 391,
  screen: screen,
  link: link,
);

void main() {
  late _Browser browser;
  final boundary = GlobalKey();
  setUp(() async {
    await sl.reset();
    await initializeUiPreview();
    final original = UrlLauncherPlatform.instance;
    browser = _Browser();
    UrlLauncherPlatform.instance = browser;
    addTearDown(() => UrlLauncherPlatform.instance = original);
  });
  tearDown(() => sl.reset());

  Future<DashboardCubit> mount(
    WidgetTester tester,
    List<HomeBanner> banners, {
    AccountRole role = AccountRole.agent,
    WorkspaceRepository? repository,
  }) async {
    tester.view.physicalSize = const Size(375, 814);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final workspace = WorkspaceCubit(
      repository ?? WorkspaceRepository(),
      initialState: WorkspaceState(role: role, banners: banners),
    );
    final dashboard = DashboardCubit();
    addTearDown(workspace.close);
    addTearDown(dashboard.close);
    await tester.pumpWidget(
      RepaintBoundary(
        key: boundary,
        child: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: workspace),
            BlocProvider.value(value: dashboard),
          ],
          child: MaterialApp(
            theme: appTheme(),
            home: const Scaffold(
              body: Directionality(
                textDirection: TextDirection.rtl,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: HomeBannerCarousel(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    return dashboard;
  }

  testWidgets('empty slider occupies no space', (tester) async {
    await mount(tester, []);
    expect(find.byType(PageView), findsNothing);
    expect(tester.getSize(find.byType(HomeBannerCarousel)).height, 0);
  });

  for (final role in AccountRole.values) {
    testWidgets('orders slide opens the existing orders tab for ${role.name}', (
      tester,
    ) async {
      final dashboard = await mount(tester, [
        banner('orders', screen: 'orders'),
      ], role: role);
      final page = find.byType(PageView);
      expect(tester.getSize(page).height, closeTo(329 * 391 / 662, .01));
      if (role == AccountRole.agent &&
          const bool.fromEnvironment('RTC_SCREENSHOTS')) {
        await tester.runAsync(() async {
          await precacheImage(
            const AssetImage('assets/images/workspace_rectangle34625736.png'),
            tester.element(find.byType(HomeBannerCarousel)),
          );
        });
        await tester.pumpAndSettle();
        await tester.runAsync(() async {
          final render =
              boundary.currentContext!.findRenderObject()
                  as RenderRepaintBoundary;
          final image = await render.toImage(pixelRatio: 2);
          final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
          await File(
            '/private/tmp/rtc_slider_ratio.png',
          ).writeAsBytes(bytes!.buffer.asUint8List());
          image.dispose();
        });
      }
      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();
      expect(dashboard.state.selectedNavIndex, 2);
      expect(browser.calls, isEmpty);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets(
    'next slide is partially visible and cards have border and Figma shadows',
    (tester) async {
      await mount(tester, [banner('first'), banner('next')]);
      final current = find.byKey(const ValueKey('home-slide-first'));
      final next = find.byKey(const ValueKey('home-slide-next'));
      expect(tester.getRect(current).left, closeTo(23, .01));
      expect(tester.getSize(current).width, closeTo(329, .01));
      final viewport = tester.getRect(find.byType(PageView));
      final adjacent = tester.getRect(next);
      expect(adjacent.left, lessThan(viewport.left));
      expect(adjacent.right - viewport.left, closeTo(11, .01));
      final card = tester.widget<Container>(current);
      final decoration = card.decoration as BoxDecoration;
      expect(decoration.boxShadow, AppColors.primaryShadow);
      expect(decoration.borderRadius, BorderRadius.circular(16));
      expect(
        (card.foregroundDecoration as BoxDecoration).border,
        Border.all(color: AppColors.grayPalette.shade200),
      );
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'URL uses the external browser; none and unknown screens have no action',
    (tester) async {
      final dashboard = await mount(tester, [
        banner('url', link: Uri.parse('https://caltivita.ir')),
        banner('none'),
        banner('unknown', screen: 'not-yet-supported'),
      ]);
      await tester.tap(find.byType(InkWell).first);
      await tester.pumpAndSettle();
      expect(browser.calls, [
        ('https://caltivita.ir', PreferredLaunchMode.externalApplication),
      ]);
      for (final index in [1, 2]) {
        tester
            .widget<PageView>(find.byType(PageView))
            .controller!
            .jumpToPage(index);
        await tester.pumpAndSettle();
        final visible = find.byType(InkWell).hitTestable();
        expect(visible, findsOneWidget);
        expect(tester.widget<InkWell>(visible).onTap, isNull);
        await tester.tap(visible);
        await tester.pumpAndSettle();
      }
      expect(browser.calls, hasLength(1));
      expect(dashboard.state.selectedNavIndex, 0);
    },
  );

  testWidgets(
    'refresh hides empty section and resets a changed slider to its first slide',
    (tester) async {
      List<HomeBanner> next = [];
      await mount(
        tester,
        [banner('first'), banner('second')],
        repository: WorkspaceRepository(loadBanners: () => Future.value(next)),
      );
      tester.widget<PageView>(find.byType(PageView)).controller!.jumpToPage(1);
      await tester.pumpAndSettle();
      final workspace = tester
          .element(find.byType(HomeBannerCarousel))
          .read<WorkspaceCubit>();
      workspace.loadHomeBanners();
      await tester.pumpAndSettle();
      expect(find.byType(PageView), findsNothing);
      expect(tester.getSize(find.byType(HomeBannerCarousel)).height, 0);
      next = [banner('new')];
      workspace.loadHomeBanners();
      await tester.pumpAndSettle();
      expect(
        tester.widget<PageView>(find.byType(PageView)).controller!.page,
        0,
      );
      expect(tester.takeException(), isNull);
    },
  );
}
