import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:rtc_mobile/core/service/notification_service.dart';
import 'package:rtc_mobile/repository/auth/auth_repository.dart';
import 'package:rtc_mobile/repository/media/media_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data_source/local/prefs/prefs.dart';
import 'data_source/remote/auth/auth_service.dart';
import 'data_source/remote/catalog/catalog_service.dart';
import 'data_source/remote/customers/customers_service.dart';
import 'data_source/remote/dashboard/dashboard_service.dart';
import 'data_source/remote/media/media_service.dart';
import 'data_source/remote/orders/orders_service.dart';
import 'data_source/remote/plans/plans_service.dart';
import 'data_source/remote/report/report_service.dart';
import 'data_source/remote/service_util.dart';
import 'data_source/remote/wallet/wallet_service.dart';
import 'core/service/analytics_service.dart';
import 'repository/customers/customers_repository.dart';
import 'repository/dashboard/dashboard_repository.dart';
import 'repository/orders/orders_repository.dart';
import 'repository/plans/plans_repository.dart';
import 'repository/product/product_repository.dart';
import 'repository/report/report_repository.dart';
import 'repository/wallet/wallet_repository.dart';

final sl = GetIt.instance;

Future<void> initLocator() async {
  // External
  final sharedPrefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPrefs);

  // Data Sources - Local
  sl.registerLazySingleton(() => Prefs(sl()));

  // Network
  sl.registerLazySingleton(() => ServiceUtil.createDio(sl()));

  // Analytics
  sl.registerLazySingleton(() => AnalyticsService(FirebaseAnalytics.instance));

  // Notifications
  sl.registerLazySingleton(
    () => NotificationService(
      FirebaseMessaging.instance,
      FlutterLocalNotificationsPlugin(),
    ),
  );

  // Services
  sl.registerLazySingleton(() => AuthService(sl()));
  sl.registerLazySingleton(() => DashboardService(sl()));
  sl.registerLazySingleton(() => CatalogService(sl()));
  sl.registerLazySingleton(() => PlansService(sl()));
  sl.registerLazySingleton(() => CustomersService(sl()));
  sl.registerLazySingleton(() => WalletService(sl()));
  sl.registerLazySingleton(() => OrdersService(sl()));
  sl.registerLazySingleton(() => MediaService(sl()));
  sl.registerLazySingleton(() => ReportService(sl()));

  // Repositories
  sl.registerLazySingleton(() => AuthRepository(sl(), sl()));
  sl.registerLazySingleton(() => DashboardRepository(sl(), sl()));
  sl.registerLazySingleton(() => ProductRepository(sl()));
  sl.registerLazySingleton(() => PlansRepository(sl()));
  sl.registerLazySingleton(() => CustomersRepository(sl()));
  sl.registerLazySingleton(() => WalletRepository(sl()));
  sl.registerLazySingleton(() => OrdersRepository(sl()));
  sl.registerLazySingleton(() => MediaRepository(sl()));
  sl.registerLazySingleton(() => ReportRepository(sl()));
}
