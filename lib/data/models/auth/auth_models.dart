import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/auth/auth_token.dart';

part 'auth_models.freezed.dart';
part 'auth_models.g.dart';

@freezed
class RequestOtpRequest with _$RequestOtpRequest {
  const factory RequestOtpRequest({
    required String mobile,
  }) = _RequestOtpRequest;

  factory RequestOtpRequest.fromJson(Map<String, dynamic> json) => _$RequestOtpRequestFromJson(json);
}

@freezed
class VerifyOtpRequest with _$VerifyOtpRequest {
  const factory VerifyOtpRequest({
    required String mobile,
    required String otp,
  }) = _VerifyOtpRequest;

  factory VerifyOtpRequest.fromJson(Map<String, dynamic> json) => _$VerifyOtpRequestFromJson(json);
}

@freezed
class AuthResponseModel with _$AuthResponseModel {
  const factory AuthResponseModel({
    required String access,
    required String refresh,
  }) = _AuthResponseModel;

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) => _$AuthResponseModelFromJson(json);

  AuthToken toEntity() => AuthToken(access: access, refresh: refresh);
}

@freezed
class RefreshTokenRequest with _$RefreshTokenRequest {
  const factory RefreshTokenRequest({
    required String refresh,
  }) = _RefreshTokenRequest;

  factory RefreshTokenRequest.fromJson(Map<String, dynamic> json) => _$RefreshTokenRequestFromJson(json);
}
