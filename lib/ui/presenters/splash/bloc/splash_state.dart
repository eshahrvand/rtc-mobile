import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_state.freezed.dart';

enum SplashStatus {
  initial,
  loading,
  tokenValid,
  tokenNotValid,
}

@freezed
class SplashState with _$SplashState {
  const factory SplashState({
    @Default(SplashStatus.initial) SplashStatus status,
  }) = _SplashState;
}
