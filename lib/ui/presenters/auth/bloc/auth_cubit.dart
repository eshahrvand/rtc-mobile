import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/network_helper.dart';
import '../../../../locator.dart';
import '../../../../repository/auth/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  final _repo = sl<AuthRepository>();
  Timer? _timer;

  void onPhoneChanged(String phoneNumber) {
    // Basic validation: 11 digits starting with 09
    final bool isValid =
        phoneNumber.length == 11 && phoneNumber.startsWith('09');
    emit(
      state.copyWith(
        phoneNumber: phoneNumber,
        isPhoneValid: isValid,
        showPhoneError: !isValid && phoneNumber.isNotEmpty,
      ),
    );
  }

  void submitPhone() {
    emit(state.copyWith(status: AuthRequestStatus.submitting, isLoading: true));

    _repo
        .requestOtp(state.phoneNumber)
        .then((_) {
          emit(
            state.copyWith(
              status: AuthRequestStatus.otpSent,
              step: AuthStep.getOtp,
              isLoading: false,
            ),
          );
          _startTimer();
        })
        .catchError(_handleError);
  }

  void onOtpChanged(String otpCode) {
    emit(state.copyWith(otp: otpCode, isOtpComplete: otpCode.length == 5));
  }

  void submitOtp() {
    emit(state.copyWith(status: AuthRequestStatus.submitting, isLoading: true));

    _repo
        .verifyOtp(state.phoneNumber, state.otp)
        .then((_) {
          emit(
            state.copyWith(status: AuthRequestStatus.success, isLoading: false),
          );
        })
        .catchError(_handleError);
  }

  void resendOtp() {
    emit(state.copyWith(status: AuthRequestStatus.submitting, isLoading: true));

    _repo
        .requestOtp(state.phoneNumber)
        .then((_) {
          emit(
            state.copyWith(
              status: AuthRequestStatus.otpResent,
              isTimerExpired: false,
              remainingSeconds: 120,
              isLoading: false,
            ),
          );
          _startTimer();
        })
        .catchError(_handleError);
  }

  void sendViaRubika() {
    emit(state.copyWith(status: AuthRequestStatus.submitting, isLoading: true));

    // TODO: call sl<AuthRepository>().sendViaRubika(state.phoneNumber)
    Future.delayed(const Duration(seconds: 1))
        .then((_) {
          emit(
            state.copyWith(status: AuthRequestStatus.otpSent, isLoading: false),
          );
        })
        .catchError(_handleError);
  }

  void editPhoneNumber() {
    _timer?.cancel();
    _resetOtpState();
  }

  void _resetOtpState() {
    emit(
      state.copyWith(
        step: AuthStep.getPhoneNumber,
        otp: '',
        isOtpComplete: false,
        isTimerExpired: false,
        remainingSeconds: 120,
        showPhoneError: false,
      ),
    );
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

  void _handleError(Object e) {
    if (isClosed) return;

    NetworkHelper.getNetworkErrorMessage().then((networkMessage) {
      if (isClosed) return;

      final finalMessage = networkMessage ?? e.toString();
      if (state.errorMessage == finalMessage) return;

      emit(
        state.copyWith(
          status: AuthRequestStatus.error,
          errorMessage: finalMessage,
          isLoading: false,
        ),
      );
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
