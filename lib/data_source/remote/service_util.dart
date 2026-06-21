import 'package:dio/dio.dart';
import '../../config/constants.dart';
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
          print('>> [API REQUEST] ${options.method} ${options.uri}');
          if (options.data != null) {
            print('>> [API BODY] ${options.data}');
          }

          final token = prefs.accessToken;
          if (token != null) {
            print('>> ACCESS TOKEN: $token');
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print(
            '>> [API RESPONSE] ${response.statusCode} ${response.requestOptions.uri}',
          );
          print('>> [API DATA] ${response.data}');
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          print(
            '>> [API ERROR] ${e.response?.statusCode} ${e.requestOptions.uri}',
          );
          print('>> [API MESSAGE] ${e.message}');
          if (e.response?.data != null) {
            print('>> [API DATA] ${e.response?.data}');
          }

          if (e.response?.statusCode == 401) {
            final refreshToken = prefs.refreshToken;
            if (refreshToken != null) {
              print('>> REFRESH TOKEN: $refreshToken');
              try {
                // Separate Dio for refresh to avoid cycles
                final refreshDio = Dio(
                  BaseOptions(baseUrl: dio.options.baseUrl),
                );
                final response = await refreshDio.post(
                  'accounts/token/refresh',
                  data: {'refresh': refreshToken},
                );

                final newAccess = response.data['access'];
                final newRefresh = response.data['refresh'];

                print('>> NEW ACCESS TOKEN: $newAccess');
                print('>> NEW REFRESH TOKEN: $newRefresh');

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
