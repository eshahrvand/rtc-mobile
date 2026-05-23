import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data_source/local/prefs/prefs.dart';
import 'data_source/remote/auth/auth_service.dart';
import 'data_source/remote/service_util.dart';
import 'domain/repository/auth/auth_repository.dart';

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

  // Repositories
  sl.registerLazySingleton(() => AuthRepository(sl(), sl()));
}
