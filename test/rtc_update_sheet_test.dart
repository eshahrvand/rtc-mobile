import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rtc_mobile/main_ui_preview.dart';
import 'package:rtc_mobile/locator.dart';
import 'package:rtc_mobile/core/models/app_update_model.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/repository/workspace/workspace_repository.dart';
import 'package:rtc_mobile/ui/presenters/dashboard/bloc/dashboard_cubit.dart';
import 'package:rtc_mobile/ui/theme/theme.dart';
import 'package:rtc_mobile/ui/widget/rtc_button.dart';
import 'package:rtc_mobile/ui/widget/rtc_update_sheet.dart';

Widget _buildTestApp(Widget child) {
  return MaterialApp(
    theme: appTheme(),
    locale: const Locale('fa'),
    localizationsDelegates: const [
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: S.delegate.supportedLocales,
    home: Scaffold(body: child),
  );
}

void main() {
  setUp(() async {
    await sl.reset();
    await initializeUiPreview();
  });

  group('AppUpdateModel', () {
    test('parses app-releases/check response accurately', () {
      final json = {
        'update_available': true,
        'force_update': true,
        'latest': {
          'version_name': '1.0.0',
          'build_number': 39,
          'is_mandatory': true,
          'download_url':
              'http://192.168.2.20:8001/media/releases/rtc-1.0.0-39.apk',
          'file_size': 82669313,
          'sha256':
              '6248d3f5e7f606479b1df9c539efcc734f140240747c14d585e7f1fb8c313276',
          'changelog': [
            '- قابلیت جدید اضافه کردن نقش',
            '- بهبود مشکلات',
          ],
          'published_at': '2026-11-04T18:14:45+03:30',
        },
      };

      final model = AppUpdateModel.fromJson(json);

      expect(model.updateAvailable, isTrue);
      expect(model.isForce, isTrue);
      expect(model.version, '1.0.0');
      expect(model.buildNumber, 39);
      expect(model.downloadUrl,
          'http://192.168.2.20:8001/media/releases/rtc-1.0.0-39.apk');
      expect(model.changeLog,
          '- قابلیت جدید اضافه کردن نقش\n- بهبود مشکلات');
      expect(model.fileSize, 82669313);
    });

    test('returns updateAvailable false when update_available is false', () {
      final json = {
        'update_available': false,
        'force_update': false,
        'latest': null,
      };

      final model = AppUpdateModel.fromJson(json);
      expect(model.updateAvailable, isFalse);
    });

    test('parses alternative backend keys flexibly', () {
      final json = {
        'version_name': '3.0.1',
        'update_force': false,
        'description': 'تغییرات جزئی در رابط کاربری',
        'url': 'https://example.com/app',
      };

      final model = AppUpdateModel.fromJson(json);

      expect(model.version, '3.0.1');
      expect(model.isForce, isFalse);
      expect(model.changeLog, 'تغییرات جزئی در رابط کاربری');
      expect(model.downloadUrl, 'https://example.com/app');
    });
  });

  group('RtcUpdateSheet Widget', () {
    testWidgets('renders version, changelog, and both buttons when not forced',
        (tester) async {
      bool skipPressed = false;
      bool updatePressed = false;

      const update = AppUpdateModel(
        version: '2.5.0',
        isForce: false,
        changeLog: 'بهبود سرعت و عملکرد سیستم',
        downloadUrl: 'https://example.com/apk',
      );

      await tester.pumpWidget(
        _buildTestApp(
          RtcUpdateSheet(
            update: update,
            onSkip: () => skipPressed = true,
            onUpdate: () => updatePressed = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Check version and changelog text
      expect(find.text('نسخه 2.5.0'), findsOneWidget);
      expect(find.text('تغییرات نسخه جدید'), findsOneWidget);
      expect(find.text('بهبود سرعت و عملکرد سیستم'), findsOneWidget);

      // Check skip button exists
      expect(find.text('بعداً'), findsOneWidget);

      // Tap skip button
      await tester.tap(find.text('بعداً'));
      await tester.pump();
      expect(skipPressed, isTrue);

      // Tap update button
      await tester.tap(find.widgetWithText(RtcButton, 'بروزرسانی'));
      await tester.pump();
      expect(updatePressed, isTrue);
    });

    testWidgets('hides skip button and close icon when forced update',
        (tester) async {
      const update = AppUpdateModel(
        version: '3.0.0',
        isForce: true,
        changeLog: 'بروزرسانی اجباری',
      );

      await tester.pumpWidget(
        _buildTestApp(
          const RtcUpdateSheet(
            update: update,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('نسخه 3.0.0'), findsOneWidget);
      // Skip button must NOT be present
      expect(find.text('بعداً'), findsNothing);
      // Only the primary update button
      expect(find.widgetWithText(RtcButton, 'بروزرسانی'), findsOneWidget);
    });
  });

  group('DashboardCubit update release check', () {
    test('DashboardCubit loads release update on initialization', () async {
      PackageInfo.setMockInitialValues(
        appName: 'rtc_mobile',
        packageName: 'com.rtc.mobile',
        version: '1.0.0',
        buildNumber: '38',
        buildSignature: '',
      );

      final updateData = AppUpdateModel.fromJson({
        'update_available': true,
        'force_update': true,
        'latest': {
          'version_name': '1.0.0',
          'build_number': 39,
          'is_mandatory': true,
          'download_url': 'http://example.com/app.apk',
          'changelog': ['- تغییرات'],
        },
      });

      final repo = WorkspaceRepository(
        checkAppRelease: (buildNumber) async => updateData,
      );
      await sl.unregister<WorkspaceRepository>();
      sl.registerSingleton<WorkspaceRepository>(repo);

      final cubit = DashboardCubit();
      cubit.init();

      await Future<void>.delayed(const Duration(milliseconds: 100));

      expect(cubit.state.appUpdate, isNotNull);
      expect(cubit.state.appUpdate?.version, '1.0.0');
      expect(cubit.state.appUpdate?.isForce, isTrue);
    });
  });
}
