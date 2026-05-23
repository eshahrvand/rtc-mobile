import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_dto_model.freezed.dart';
part 'user_profile_dto_model.g.dart';

@freezed
class ProfileListResponse with _$ProfileListResponse {
  const factory ProfileListResponse({
    required int count,
    String? next,
    String? previous,
    required List<UserProfileDtoModel> results,
  }) = _ProfileListResponse;

  factory ProfileListResponse.fromJson(Map<String, dynamic> json) => _$ProfileListResponseFromJson(json);
}

@freezed
class UserProfileDtoModel with _$UserProfileDtoModel {
  const factory UserProfileDtoModel({
    required String id,
    required String mobile,
    required String role,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    @JsonKey(name: 'is_active') required bool isActive,
    @JsonKey(name: 'date_joined') required String dateJoined,
    @JsonKey(name: 'agent_type') required String agentType,
    CityProvinceDtoModel? city,
    CityProvinceDtoModel? province,
    @JsonKey(name: 'credit_limit') required int creditLimit,
    required int tolerance,
    ManagerDtoModel? manager,
    String? email, // Email wasn't in your last snippet, but was in the previous one. Adding as optional.
  }) = _UserProfileDtoModel;

  factory UserProfileDtoModel.fromJson(Map<String, dynamic> json) => _$UserProfileDtoModelFromJson(json);
}

@freezed
class CityProvinceDtoModel with _$CityProvinceDtoModel {
  const factory CityProvinceDtoModel({
    required String id,
    required String name,
  }) = _CityProvinceDtoModel;

  factory CityProvinceDtoModel.fromJson(Map<String, dynamic> json) => _$CityProvinceDtoModelFromJson(json);
}

@freezed
class ManagerDtoModel with _$ManagerDtoModel {
  const factory ManagerDtoModel({
    required String id,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
  }) = _ManagerDtoModel;

  factory ManagerDtoModel.fromJson(Map<String, dynamic> json) => _$ManagerDtoModelFromJson(json);
}
