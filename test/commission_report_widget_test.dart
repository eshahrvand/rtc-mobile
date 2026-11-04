import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:rtc_mobile/core/service/analytics_service.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/locator.dart';
import 'package:rtc_mobile/repository/report/commission_report_repository.dart';
import 'package:rtc_mobile/ui/presenters/commission_report/bloc/commission_report_cubit.dart';
import 'package:rtc_mobile/ui/presenters/commission_report/commission_report.dart';
import 'package:rtc_mobile/ui/theme/theme.dart';
import 'package:rtc_mobile/ui/widget/rtc_chip_item.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';
import 'package:rtc_mobile/ui/widget/rtc_wheel_picker.dart';
import 'support/commission_test_api.dart';

class _AnalyticsStub implements AnalyticsService {
  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

void main() {
  late CommissionTestApi api;
  setUpAll(() async {
    await S.load(const Locale('fa'));
    final loader = FontLoader('IranYekan');
    for (final weight in ['Regular', 'Medium', 'Bold']) {
      loader.addFont(
        rootBundle.load('assets/fonts/IRANYekanXFaNum-$weight.ttf'),
      );
    }
    await loader.load();
    sl.registerSingleton<AnalyticsService>(_AnalyticsStub());
  });
  setUp(() {
    api = CommissionTestApi();
    sl.registerSingleton<CommissionReportRepository>(api.repository());
  });
  tearDown(() async {
    await sl.unregister<CommissionReportRepository>();
  });
  tearDownAll(() => sl.reset());

  Finder chip(int id) => find.byWidgetPredicate(
    (widget) => widget is RtcChipItem && widget.chip.id == id,
  );

  Future<void> capture(WidgetTester tester, String name) async {
    if (const bool.fromEnvironment('CAPTURE_COMMISSION_UI')) {
      await expectLater(
        find.byKey(const Key('capture')),
        matchesGoldenFile('/private/tmp/commission-api-$name.png'),
      );
    }
  }

  Future<CommissionReportCubit> openReport(WidgetTester tester) async {
    tester.view.physicalSize = const Size(375, 814);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (_, _) => const CommissionReportScreen()),
      ],
    );
    addTearDown(router.dispose);
    await tester.pumpWidget(
      RepaintBoundary(
        key: const Key('capture'),
        child: MaterialApp.router(
          routerConfig: router,
          theme: appTheme(),
          debugShowCheckedModeBanner: false,
          locale: const Locale('fa'),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
        ),
      ),
    );
    await tester.pumpAndSettle();
    return tester
        .element(find.byType(CommissionReportView))
        .read<CommissionReportCubit>();
  }

  testWidgets('renders API count and summary without a branch filter', (
    tester,
  ) async {
    await openReport(tester);
    expect(find.text(S.current.resultsCountLabel(123)), findsOneWidget);
    expect(find.text('2,000,000,000'), findsOneWidget);
    expect(find.text(S.current.commissionStoreFilter), findsNothing);
    expect(chip(1), findsNothing);
    expect(find.byType(RtcChipItem), findsNWidgets(2));
    for (final id in [2, 3]) {
      expect(tester.widget<RtcChipItem>(chip(id)).isSelected, isFalse);
    }
    expect(tester.widget<RtcChipItem>(chip(2)).chip.label, S.current.year);
    expect(tester.widget<RtcChipItem>(chip(3)).chip.label, S.current.month);
    expect(api.requests.length, 2);
    await capture(tester, 'report');
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'year/month keep their labels; apply selects and clear deselects only its chip',
    (tester) async {
      final cubit = await openReport(tester);
      final today = Jalali.now();
      await tester.tap(chip(2));
      await tester.pumpAndSettle();
      expect(find.byType(RtcWheelPicker), findsOneWidget);
      await tester.drag(find.byType(ListWheelScrollView), const Offset(0, 50));
      await tester.pumpAndSettle();
      expect(cubit.state.selectedYear, isNull);
      await tester.tap(find.text(S.current.back));
      await tester.pumpAndSettle();
      expect(api.requests.length, 2);
      cubit.selectYear(today.year - 1);
      await tester.pumpAndSettle();
      expect(tester.widget<RtcChipItem>(chip(2)).isSelected, isTrue);
      expect(tester.widget<RtcChipItem>(chip(2)).chip.label, S.current.year);
      await tester.tap(chip(3));
      await tester.pumpAndSettle();
      await capture(tester, 'month');
      await tester.drag(find.byType(ListWheelScrollView), const Offset(0, 50));
      await tester.pumpAndSettle();
      final wheel = tester.widget<ListWheelScrollView>(
        find.byType(ListWheelScrollView),
      );
      final month =
          (wheel.controller! as FixedExtentScrollController).selectedItem + 1;
      await tester.tap(find.text(S.current.applyFilter));
      await tester.pumpAndSettle();
      expect(cubit.state.selectedMonth, month);
      expect(cubit.state.selectedYear, today.year - 1);
      expect(tester.widget<RtcChipItem>(chip(3)).isSelected, isTrue);
      expect(tester.widget<RtcChipItem>(chip(3)).chip.label, S.current.month);
      await capture(tester, 'selected-filters');
      await tester.tap(chip(3));
      await tester.pumpAndSettle();
      await tester.tap(find.text(S.current.clearFilter));
      await tester.pumpAndSettle();
      expect(cubit.state.selectedMonth, isNull);
      expect(cubit.state.selectedYear, today.year - 1);
      expect(tester.widget<RtcChipItem>(chip(3)).isSelected, isFalse);
      expect(tester.widget<RtcChipItem>(chip(3)).chip.label, S.current.month);
      await tester.tap(
        find.descendant(
          of: chip(2),
          matching: find.byWidgetPredicate(
            (widget) =>
                widget is RtcImage &&
                widget.image?.endsWith('/close.svg') == true,
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(cubit.state.selectedYear, isNull);
      expect(tester.widget<RtcChipItem>(chip(2)).isSelected, isFalse);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('search is sent to server and can return an empty result', (
    tester,
  ) async {
    await openReport(tester);
    api.onRequest = (request) => CommissionTestApi.response(
      request.path.endsWith('/summary')
          ? CommissionTestApi.summary()
          : {'count': 0, 'next': null, 'previous': null, 'results': []},
    );
    await tester.tap(
      find.byWidgetPredicate(
        (widget) =>
            widget is RtcImage &&
            widget.image?.endsWith('/search-product.svg') == true,
      ),
    );
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(EditableText), 'missing-order');
    await tester.pumpAndSettle();
    expect(api.requests.last.queryParameters['search'], 'missing-order');
    expect(find.text(S.current.noReportFound), findsOneWidget);
    expect(find.text(S.current.resultsCountLabel(0)), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
