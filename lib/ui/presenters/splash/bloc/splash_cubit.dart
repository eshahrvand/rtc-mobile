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
          print('>> SPLASH: Summary fetch failed: $error. Emitting tokenNotValid');
          emit(state.copyWith(status: SplashStatus.tokenNotValid));
        });
  }
}
