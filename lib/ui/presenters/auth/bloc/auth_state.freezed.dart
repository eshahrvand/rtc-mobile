// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AuthState {
  AuthStep get step => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String get otp => throw _privateConstructorUsedError;
  bool get isPhoneValid => throw _privateConstructorUsedError;
  bool get isOtpComplete => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isTimerExpired => throw _privateConstructorUsedError;
  int get remainingSeconds => throw _privateConstructorUsedError;
  AuthRequestStatus get status => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  bool get showPhoneError => throw _privateConstructorUsedError;
  bool get isAutoFill => throw _privateConstructorUsedError;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthStateCopyWith<AuthState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
  @useResult
  $Res call({
    AuthStep step,
    String phoneNumber,
    String otp,
    bool isPhoneValid,
    bool isOtpComplete,
    bool isLoading,
    bool isTimerExpired,
    int remainingSeconds,
    AuthRequestStatus status,
    String errorMessage,
    bool showPhoneError,
    bool isAutoFill,
  });
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? step = null,
    Object? phoneNumber = null,
    Object? otp = null,
    Object? isPhoneValid = null,
    Object? isOtpComplete = null,
    Object? isLoading = null,
    Object? isTimerExpired = null,
    Object? remainingSeconds = null,
    Object? status = null,
    Object? errorMessage = null,
    Object? showPhoneError = null,
    Object? isAutoFill = null,
  }) {
    return _then(
      _value.copyWith(
            step: null == step
                ? _value.step
                : step // ignore: cast_nullable_to_non_nullable
                      as AuthStep,
            phoneNumber: null == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            otp: null == otp
                ? _value.otp
                : otp // ignore: cast_nullable_to_non_nullable
                      as String,
            isPhoneValid: null == isPhoneValid
                ? _value.isPhoneValid
                : isPhoneValid // ignore: cast_nullable_to_non_nullable
                      as bool,
            isOtpComplete: null == isOtpComplete
                ? _value.isOtpComplete
                : isOtpComplete // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isTimerExpired: null == isTimerExpired
                ? _value.isTimerExpired
                : isTimerExpired // ignore: cast_nullable_to_non_nullable
                      as bool,
            remainingSeconds: null == remainingSeconds
                ? _value.remainingSeconds
                : remainingSeconds // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as AuthRequestStatus,
            errorMessage: null == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String,
            showPhoneError: null == showPhoneError
                ? _value.showPhoneError
                : showPhoneError // ignore: cast_nullable_to_non_nullable
                      as bool,
            isAutoFill: null == isAutoFill
                ? _value.isAutoFill
                : isAutoFill // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AuthStateImplCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$$AuthStateImplCopyWith(
    _$AuthStateImpl value,
    $Res Function(_$AuthStateImpl) then,
  ) = __$$AuthStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    AuthStep step,
    String phoneNumber,
    String otp,
    bool isPhoneValid,
    bool isOtpComplete,
    bool isLoading,
    bool isTimerExpired,
    int remainingSeconds,
    AuthRequestStatus status,
    String errorMessage,
    bool showPhoneError,
    bool isAutoFill,
  });
}

/// @nodoc
class __$$AuthStateImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateImpl>
    implements _$$AuthStateImplCopyWith<$Res> {
  __$$AuthStateImplCopyWithImpl(
    _$AuthStateImpl _value,
    $Res Function(_$AuthStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? step = null,
    Object? phoneNumber = null,
    Object? otp = null,
    Object? isPhoneValid = null,
    Object? isOtpComplete = null,
    Object? isLoading = null,
    Object? isTimerExpired = null,
    Object? remainingSeconds = null,
    Object? status = null,
    Object? errorMessage = null,
    Object? showPhoneError = null,
    Object? isAutoFill = null,
  }) {
    return _then(
      _$AuthStateImpl(
        step: null == step
            ? _value.step
            : step // ignore: cast_nullable_to_non_nullable
                  as AuthStep,
        phoneNumber: null == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        otp: null == otp
            ? _value.otp
            : otp // ignore: cast_nullable_to_non_nullable
                  as String,
        isPhoneValid: null == isPhoneValid
            ? _value.isPhoneValid
            : isPhoneValid // ignore: cast_nullable_to_non_nullable
                  as bool,
        isOtpComplete: null == isOtpComplete
            ? _value.isOtpComplete
            : isOtpComplete // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isTimerExpired: null == isTimerExpired
            ? _value.isTimerExpired
            : isTimerExpired // ignore: cast_nullable_to_non_nullable
                  as bool,
        remainingSeconds: null == remainingSeconds
            ? _value.remainingSeconds
            : remainingSeconds // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as AuthRequestStatus,
        errorMessage: null == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String,
        showPhoneError: null == showPhoneError
            ? _value.showPhoneError
            : showPhoneError // ignore: cast_nullable_to_non_nullable
                  as bool,
        isAutoFill: null == isAutoFill
            ? _value.isAutoFill
            : isAutoFill // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$AuthStateImpl implements _AuthState {
  const _$AuthStateImpl({
    this.step = AuthStep.getPhoneNumber,
    this.phoneNumber = '',
    this.otp = '',
    this.isPhoneValid = false,
    this.isOtpComplete = false,
    this.isLoading = false,
    this.isTimerExpired = false,
    this.remainingSeconds = 120,
    this.status = AuthRequestStatus.initial,
    this.errorMessage = '',
    this.showPhoneError = false,
    this.isAutoFill = false,
  });

  @override
  @JsonKey()
  final AuthStep step;
  @override
  @JsonKey()
  final String phoneNumber;
  @override
  @JsonKey()
  final String otp;
  @override
  @JsonKey()
  final bool isPhoneValid;
  @override
  @JsonKey()
  final bool isOtpComplete;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isTimerExpired;
  @override
  @JsonKey()
  final int remainingSeconds;
  @override
  @JsonKey()
  final AuthRequestStatus status;
  @override
  @JsonKey()
  final String errorMessage;
  @override
  @JsonKey()
  final bool showPhoneError;
  @override
  @JsonKey()
  final bool isAutoFill;

  @override
  String toString() {
    return 'AuthState(step: $step, phoneNumber: $phoneNumber, otp: $otp, isPhoneValid: $isPhoneValid, isOtpComplete: $isOtpComplete, isLoading: $isLoading, isTimerExpired: $isTimerExpired, remainingSeconds: $remainingSeconds, status: $status, errorMessage: $errorMessage, showPhoneError: $showPhoneError, isAutoFill: $isAutoFill)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthStateImpl &&
            (identical(other.step, step) || other.step == step) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.otp, otp) || other.otp == otp) &&
            (identical(other.isPhoneValid, isPhoneValid) ||
                other.isPhoneValid == isPhoneValid) &&
            (identical(other.isOtpComplete, isOtpComplete) ||
                other.isOtpComplete == isOtpComplete) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isTimerExpired, isTimerExpired) ||
                other.isTimerExpired == isTimerExpired) &&
            (identical(other.remainingSeconds, remainingSeconds) ||
                other.remainingSeconds == remainingSeconds) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.showPhoneError, showPhoneError) ||
                other.showPhoneError == showPhoneError) &&
            (identical(other.isAutoFill, isAutoFill) ||
                other.isAutoFill == isAutoFill));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    step,
    phoneNumber,
    otp,
    isPhoneValid,
    isOtpComplete,
    isLoading,
    isTimerExpired,
    remainingSeconds,
    status,
    errorMessage,
    showPhoneError,
    isAutoFill,
  );

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthStateImplCopyWith<_$AuthStateImpl> get copyWith =>
      __$$AuthStateImplCopyWithImpl<_$AuthStateImpl>(this, _$identity);
}

abstract class _AuthState implements AuthState {
  const factory _AuthState({
    final AuthStep step,
    final String phoneNumber,
    final String otp,
    final bool isPhoneValid,
    final bool isOtpComplete,
    final bool isLoading,
    final bool isTimerExpired,
    final int remainingSeconds,
    final AuthRequestStatus status,
    final String errorMessage,
    final bool showPhoneError,
    final bool isAutoFill,
  }) = _$AuthStateImpl;

  @override
  AuthStep get step;
  @override
  String get phoneNumber;
  @override
  String get otp;
  @override
  bool get isPhoneValid;
  @override
  bool get isOtpComplete;
  @override
  bool get isLoading;
  @override
  bool get isTimerExpired;
  @override
  int get remainingSeconds;
  @override
  AuthRequestStatus get status;
  @override
  String get errorMessage;
  @override
  bool get showPhoneError;
  @override
  bool get isAutoFill;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthStateImplCopyWith<_$AuthStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
