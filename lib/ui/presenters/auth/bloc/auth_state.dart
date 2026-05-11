import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

enum AuthStep {
  getPhoneNumber,
  getOtp,
}

enum AuthRequestStatus {
  initial,
  submitting,
  otpSent,
  otpResent,
  success,
  error,
}

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AuthStep.getPhoneNumber) AuthStep step,
    @Default('') String phoneNumber,
    @Default('') String otp,
    @Default(false) bool isPhoneValid,
    @Default(false) bool isOtpComplete,
    @Default(false) bool isLoading,
    @Default(false) bool isTimerExpired,
    @Default(120) int remainingSeconds,
    @Default(AuthRequestStatus.initial) AuthRequestStatus status,
    @Default('') String errorMessage,
  }) = _AuthState;
}
