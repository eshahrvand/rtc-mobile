import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../config/constants.dart';

import '../../ui/router/app_route.dart';
import '../../ui/router/router.dart';
import '../local/prefs/prefs.dart';

class ServiceUtil {
  static Dio createDio(
    Prefs prefs, {
    bool Function(DioException error)? isTermsRequired,
    void Function()? onTermsRequired,
    void Function()? onSignedOut,
    void Function(String code)? onPolicyBlocked,
    void Function(Map<String, dynamic> json)? onAccountMe,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: connectionTimeout,
        receiveTimeout: receiveTimeout,
        sendTimeout: sendTimeout,
      ),
    );

    _addTemporaryApiLogging(dio);

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
          if (response.requestOptions.uri.path
                  .replaceAll(RegExp(r'/+$'), '')
                  .endsWith('/accounts/me') &&
              response.data is Map) {
            // Ignore an old session's response after logout/account switch.
            final currentToken = prefs.accessToken;
            if (currentToken != null &&
                response.requestOptions.headers['Authorization'] ==
                    'Bearer $currentToken') {
              onAccountMe?.call(
                Map<String, dynamic>.from(response.data as Map),
              );
            }
          }
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 403 &&
              (isTermsRequired?.call(e) ?? false)) {
            e.requestOptions.extra['policyGated'] = true;
            final data = e.response?.data;
            final code = data is Map && data['error'] is Map
                ? data['error']['code']
                : null;
            if (code is String) onPolicyBlocked?.call(code);
            onTermsRequired?.call();
          }
          if (e.response?.statusCode == 401) {
            final refreshToken = prefs.refreshToken;
            if (refreshToken != null) {
              String? newAccess;
              try {
                // Separate Dio for refresh to avoid cycles
                final refreshDio = Dio(
                  BaseOptions(baseUrl: dio.options.baseUrl),
                );
                _addTemporaryApiLogging(refreshDio);
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
                onSignedOut?.call();
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
              onSignedOut?.call();

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

  // TEMP: Remove this helper and its two calls after API debugging.
  static void _addTemporaryApiLogging(Dio dio) {
    if (!kDebugMode) return;
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: false,
        responseHeader: false,
        logPrint: (message) => debugPrint('[API] $message', wrapWidth: 1024),
      ),
    );
  }
}
