import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data_source/local/prefs/prefs.dart';
import 'data_source/remote/auth/auth_service.dart';
import 'data_source/remote/catalog/catalog_service.dart';
import 'data_source/remote/customers/customers_service.dart';
import 'data_source/remote/dashboard/dashboard_service.dart';
import 'data_source/remote/plans/plans_service.dart';
import 'data_source/remote/service_util.dart';
import 'domain/repository/auth/auth_repository.dart';
import 'repository/customers/customers_repository.dart';
import 'repository/dashboard/dashboard_repository.dart';
import 'repository/plans/plans_repository.dart';
import 'repository/product/product_repository.dart';

final sl = GetIt.instance;

Future<void> initLocator() async {
  // External
  final sharedPrefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPrefs);

  // Data Sources - Local
  sl.registerLazySingleton(() => Prefs(sl()));

  // Network
  sl.registerLazySingleton(() => ServiceUtil.createDio(sl()));

  // Services
  sl.registerLazySingleton(() => AuthService(sl()));
  sl.registerLazySingleton(() => DashboardService(sl()));
  sl.registerLazySingleton(() => CatalogService(sl()));
  sl.registerLazySingleton(() => PlansService(sl()));
  sl.registerLazySingleton(() => CustomersService(sl()));

  // Repositories
  sl.registerLazySingleton(() => AuthRepository(sl(), sl()));
  sl.registerLazySingleton(() => DashboardRepository(sl()));
  sl.registerLazySingleton(() => ProductRepository(sl()));
  sl.registerLazySingleton(() => PlansRepository(sl()));
  sl.registerLazySingleton(() => CustomersRepository(sl()));
}
