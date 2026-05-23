import 'package:dio/dio.dart';
import '../local/prefs/prefs.dart';

class ServiceUtil {
  static Dio createDio(Prefs prefs) {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'http://192.168.2.20:8001/api/v1/',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = prefs.accessToken;
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            final refreshToken = prefs.refreshToken;
            if (refreshToken != null) {
              try {
                // Separate Dio for refresh to avoid cycles
                final refreshDio = Dio(BaseOptions(baseUrl: dio.options.baseUrl));
                final response = await refreshDio.post(
                  'accounts/token/refresh',
                  data: {'refresh': refreshToken},
                );

                final newAccess = response.data['access'];
                final newRefresh = response.data['refresh'];

                await prefs.saveTokens(access: newAccess, refresh: newRefresh);

                // Retry original request
                e.requestOptions.headers['Authorization'] = 'Bearer $newAccess';
                final clonedRequest = await dio.fetch(e.requestOptions);
                return handler.resolve(clonedRequest);
              } catch (refreshError) {
                await prefs.clearTokens();
                return handler.next(e);
              }
            }
          }
          return handler.next(e);
        },
      ),
    );

    return dio;
  }
}
