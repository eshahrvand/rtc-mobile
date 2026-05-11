import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  Timer? _timer;

  void onPhoneChanged(String phone) {
    // Basic validation: 11 digits starting with 09
    final bool isValid = phone.length == 11 && phone.startsWith('09');
    emit(state.copyWith(
      phoneNumber: phone,
      isPhoneValid: isValid,
    ));
  }

  void submitPhone() {
    emit(state.copyWith(status: AuthRequestStatus.submitting, isLoading: true));

    // TODO: call sl<AuthRepository>().requestOtp(state.phoneNumber)
    Future.delayed(const Duration(seconds: 1))
        .then((_) {
          emit(state.copyWith(
            status: AuthRequestStatus.otpSent,
            step: AuthStep.getOtp,
            isLoading: false,
          ));
          _startTimer();
        })
        .catchError((Object e) {
          emit(state.copyWith(
            status: AuthRequestStatus.error,
            errorMessage: e.toString(),
            isLoading: false,
          ));
        });
  }

  void onOtpChanged(String otp) {
    emit(state.copyWith(
      otp: otp,
      isOtpComplete: otp.length == 5,
    ));
  }

  void submitOtp() {
    emit(state.copyWith(status: AuthRequestStatus.submitting, isLoading: true));

    // TODO: call sl<AuthRepository>().verifyOtp(state.phoneNumber, state.otp)
    Future.delayed(const Duration(seconds: 1))
        .then((_) {
          emit(state.copyWith(
            status: AuthRequestStatus.success,
            isLoading: false,
          ));
        })
        .catchError((Object e) {
          emit(state.copyWith(
            status: AuthRequestStatus.error,
            errorMessage: e.toString(),
            isLoading: false,
          ));
        });
  }

  void resendOtp() {
    emit(state.copyWith(status: AuthRequestStatus.submitting, isLoading: true));

    // TODO: call sl<AuthRepository>().requestOtp(state.phoneNumber)
    Future.delayed(const Duration(seconds: 1))
        .then((_) {
          emit(state.copyWith(
            status: AuthRequestStatus.otpResent,
            isTimerExpired: false,
            remainingSeconds: 120,
            isLoading: false,
          ));
          _startTimer();
        })
        .catchError((Object e) {
          emit(state.copyWith(
            status: AuthRequestStatus.error,
            errorMessage: e.toString(),
            isLoading: false,
          ));
        });
  }

  void sendViaRubika() {
    emit(state.copyWith(status: AuthRequestStatus.submitting, isLoading: true));

    // TODO: call sl<AuthRepository>().sendViaRubika(state.phoneNumber)
    Future.delayed(const Duration(seconds: 1))
        .then((_) {
          emit(state.copyWith(
            status: AuthRequestStatus.otpSent,
            isLoading: false,
          ));
        })
        .catchError((Object e) {
          emit(state.copyWith(
            status: AuthRequestStatus.error,
            errorMessage: e.toString(),
            isLoading: false,
          ));
        });
  }

  void editPhoneNumber() {
    _timer?.cancel();
    emit(state.copyWith(
      step: AuthStep.getPhoneNumber,
      otp: '',
      isOtpComplete: false,
      isTimerExpired: false,
      remainingSeconds: 120,
    ));
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingSeconds > 0) {
        emit(state.copyWith(remainingSeconds: state.remainingSeconds - 1));
      } else {
        _timer?.cancel();
        emit(state.copyWith(isTimerExpired: true));
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
