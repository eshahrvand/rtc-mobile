import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState());

  void init() {
    emit(state.copyWith(status: SplashStatus.loading));

    Future.delayed(const Duration(seconds: 2))
        .then((_) {
          // Currently: emits tokenValid directly (placeholder)
          // Future: will call the repository to validate the stored token
          emit(state.copyWith(status: SplashStatus.tokenValid));
        })
        .catchError((Object error) {
          emit(state.copyWith(status: SplashStatus.tokenNotValid));
        });
  }
}
