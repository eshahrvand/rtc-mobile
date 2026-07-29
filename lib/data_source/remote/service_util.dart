import 'package:dio/dio.dart';
import '../../config/constants.dart';

import '../../ui/router/app_route.dart';
import '../../ui/router/router.dart';
import '../local/prefs/prefs.dart';

class ServiceUtil {
  static Dio createDio(Prefs prefs) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: connectionTimeout,
        receiveTimeout: receiveTimeout,
        sendTimeout: sendTimeout,
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
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            final refreshToken = prefs.refreshToken;
            if (refreshToken != null) {
              String? newAccess;
              try {
                // Separate Dio for refresh to avoid cycles
                final refreshDio = Dio(
                  BaseOptions(baseUrl: dio.options.baseUrl),
                );
                final response = await refreshDio.post(
                  'accounts/token/refresh',
                  data: {'refresh': refreshToken},
                );

                final String? access = response.data['access'];
                final String? refresh = response.data['refresh'];

                if (access == null || refresh == null) {
                  throw Exception('Invalid refresh response');
                }

                newAccess = access;

                await prefs.saveTokens(access: newAccess, refresh: refresh);
              } catch (refreshError) {
                await prefs.clearTokens();
                router.go(AppRoutes.auth);
                return handler.next(e);
              }

              if (newAccess != null) {
                try {
                  // Retry original request
                  e.requestOptions.headers['Authorization'] =
                      'Bearer $newAccess';
                  final clonedRequest = await dio.fetch(e.requestOptions);
                  return handler.resolve(clonedRequest);
                } on DioException catch (retryError) {
                  // Propagate retry error without logging out
                  return handler.next(retryError);
                }
              }
            } else {
              await prefs.clearTokens();

              router.go(AppRoutes.auth);
              return handler.next(e);
            }
          }
          return handler.next(e);
        },
      ),
    );

    return dio;
  }
}
