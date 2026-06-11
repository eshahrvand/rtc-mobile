import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../locator.dart';
import '../../../../repository/dashboard/dashboard_repository.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState());

  final _dashboardRepo = sl<DashboardRepository>();

  void init() {
    emit(state.copyWith(status: SplashStatus.loading));

    final delay = Future.delayed(const Duration(seconds: 2));
    final summaryFetch = _dashboardRepo.getSummary();

    Future.wait([delay, summaryFetch])
        .then((_) {
          print('>> SPLASH: Summary fetched successfully. Emitting tokenValid');
          emit(state.copyWith(status: SplashStatus.tokenValid));
        })
        .catchError((Object error) {
          print(
            '>> SPLASH: Summary fetch failed: $error. Checking connectivity',
          );

          if (error is DioException) {
            final type = error.type;
            if (type == DioExceptionType.connectionTimeout ||
                type == DioExceptionType.sendTimeout ||
                type == DioExceptionType.receiveTimeout ||
                type == DioExceptionType.connectionError) {
              _handleNetworkError();
              return;
            }

            // If it's a response error, check status code
            if (error.response?.statusCode == 401) {
              emit(state.copyWith(status: SplashStatus.tokenNotValid));
              return;
            }
          }

          _handleNetworkError();
        });
  }

  void _handleNetworkError() {
    _checkConnectivityStatus().then((connectivityStatus) {
      emit(state.copyWith(status: connectivityStatus));
    });
  }

  Future<SplashStatus> _checkConnectivityStatus() async {
    bool hasConnection = false;

    // 1. Try connectivity_plus plugin
    try {
      final List<ConnectivityResult> connectivityResult = await Connectivity()
          .checkConnectivity();
      hasConnection = !connectivityResult.contains(ConnectivityResult.none);
    } catch (e) {
      print('>> SPLASH: Connectivity plugin failed (MissingPlugin?): $e');
      // Fallback if plugin fails: check Network Interfaces
      try {
        final interfaces = await NetworkInterface.list();
        hasConnection = interfaces.any((i) => i.addresses.isNotEmpty);
      } catch (_) {
        hasConnection = false;
      }
    }

    // 2. Double check with InternetAddress.lookup (most reliable for "reachability")
    if (hasConnection) {
      try {
        final result = await InternetAddress.lookup(
          'google.com',
        ).timeout(const Duration(seconds: 3));
        hasConnection = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      } catch (_) {
        hasConnection = false;
      }
    }

    if (!hasConnection) {
      return SplashStatus.internetError;
    }

    return SplashStatus.internetError;
  }
}
