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
    final profileFetch = _dashboardRepo.getMyProfile();

    Future.wait([delay, profileFetch])
        .then((results) {
          final profile = results[1];
          if (profile != null) {
            emit(state.copyWith(status: SplashStatus.tokenValid));
          } else {
            emit(state.copyWith(status: SplashStatus.tokenNotValid));
          }
        })
        .catchError((Object error) {
          emit(state.copyWith(status: SplashStatus.tokenNotValid));
        });
  }
}
