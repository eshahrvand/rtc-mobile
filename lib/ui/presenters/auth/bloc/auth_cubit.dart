import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../locator.dart';
import '../../../../repository/auth/auth_repository.dart';
import 'auth_state.dart';

// ─── REFACTOR LOG ───────────────────────────────────────────────────
// [1] Extracted `_handleError()` to remove duplication in API error handling.
// [2] Extracted `_resetOtpState()` helper to cleanly separate state reset logic.
// [3] Renamed parameters in `onPhoneChanged` and `onOtpChanged` for better naming consistency.
// [4] Reordered methods: Public event handlers first, followed by private helpers.
// [5] Added documentation comments to clarify the purpose of timer and validation logic.
// ────────────────────────────────────────────────────────────────────

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  final _repo = sl<AuthRepository>();
  Timer? _timer;

  // ─── Event Handlers ────────────────────────────────────────────────

  /// Updates the phone number and validates it against the standard Iranian format.
  void onPhoneChanged(String phoneNumber) {
    // Basic validation: 11 digits starting with 09
    final bool isValid = phoneNumber.length == 11 && phoneNumber.startsWith('09');
    emit(state.copyWith(
      phoneNumber: phoneNumber,
      isPhoneValid: isValid,
      showPhoneError: !isValid && phoneNumber.isNotEmpty,
    ));
  }

  /// Initiates the OTP request for the currently entered phone number.
  void submitPhone() {
    emit(state.copyWith(status: AuthRequestStatus.submitting, isLoading: true));

    _repo.requestOtp(state.phoneNumber).then((_) {
      emit(state.copyWith(
        status: AuthRequestStatus.otpSent,
        step: AuthStep.getOtp,
        isLoading: false,
      ));
      _startTimer();
    }).catchError(_handleError);
  }

  /// Updates the current OTP input and checks if completion requirements are met.
  void onOtpChanged(String otpCode) {
    emit(state.copyWith(
      otp: otpCode,
      isOtpComplete: otpCode.length == 5,
    ));
  }

  /// Verifies the entered OTP code with the repository.
  void submitOtp() {
    emit(state.copyWith(status: AuthRequestStatus.submitting, isLoading: true));

    _repo.verifyOtp(state.phoneNumber, state.otp).then((_) {
      emit(state.copyWith(
        status: AuthRequestStatus.success,
        isLoading: false,
      ));
    }).catchError(_handleError);
  }

  /// Requests a new OTP and resets the countdown timer.
  void resendOtp() {
    emit(state.copyWith(status: AuthRequestStatus.submitting, isLoading: true));

    _repo.requestOtp(state.phoneNumber).then((_) {
      emit(state.copyWith(
        status: AuthRequestStatus.otpResent,
        isTimerExpired: false,
        remainingSeconds: 120,
        isLoading: false,
      ));
      _startTimer();
    }).catchError(_handleError);
  }

  /// Mock implementation for OTP delivery via Rubika.
  void sendViaRubika() {
    emit(state.copyWith(status: AuthRequestStatus.submitting, isLoading: true));

    // TODO: call sl<AuthRepository>().sendViaRubika(state.phoneNumber)
    Future.delayed(const Duration(seconds: 1)).then((_) {
      emit(state.copyWith(
        status: AuthRequestStatus.otpSent,
        isLoading: false,
      ));
    }).catchError(_handleError);
  }

  /// Cancels the active timer and returns the user to the phone entry step.
  void editPhoneNumber() {
    _timer?.cancel();
    _resetOtpState();
  }

  // ─── Private Helpers ───────────────────────────────────────────────

  /// Resets state fields related to the OTP entry step.
  void _resetOtpState() {
    emit(state.copyWith(
      step: AuthStep.getPhoneNumber,
      otp: '',
      isOtpComplete: false,
      isTimerExpired: false,
      remainingSeconds: 120,
      showPhoneError: false,
    ));
  }

  /// Manages the periodic countdown for OTP resend availability.
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

  /// Centralized handler for repository errors.
  void _handleError(Object e) {
    emit(state.copyWith(
      status: AuthRequestStatus.error,
      errorMessage: e.toString(),
      isLoading: false,
    ));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
