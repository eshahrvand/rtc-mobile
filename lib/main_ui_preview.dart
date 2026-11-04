// Run with: flutter run -t lib/main_ui_preview.dart
// Uses only in-memory data for all newly introduced actions.
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/service/analytics_service.dart';
import 'generated/l10n.dart';
import 'locator.dart';
import 'repository/workspace/workspace_repository.dart';
import 'ui/preview/workspace_preview_app.dart';
import 'ui/preview/workspace_preview_data.dart';

Future<WorkspacePreviewData> initializeUiPreview() async {
  // This development harness intentionally uses an isolated in-memory store.
  // ignore: invalid_use_of_visible_for_testing_member
  SharedPreferences.setMockInitialValues({});
  await initLocator();
  await sl.unregister<AnalyticsService>();
  sl.registerSingleton(AnalyticsService.disabled());
  final data = WorkspacePreviewData();
  await sl.unregister<WorkspaceRepository>();
  sl.registerSingleton(data.repository);
  sl<Dio>().interceptors.insert(
    0,
    InterceptorsWrapper(
      onRequest: (options, handler) {
        handler.reject(
          DioException(
            requestOptions: options,
            error: StateError('UI preview network is disabled'),
          ),
        );
      },
    ),
  );
  await S.load(const Locale('fa'));
  return data;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final data = await initializeUiPreview();
  runApp(WorkspacePreviewApp(data: data));
}
