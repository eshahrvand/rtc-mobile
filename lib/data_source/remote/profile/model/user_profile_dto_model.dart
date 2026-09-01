import 'package:freezed_annotation/freezed_annotation.dart';
import '../../catalog/model/product_dto_model.dart';

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
    String? email,
    @JsonKey(name: 'is_active') required bool isActive,
    @JsonKey(name: 'date_joined') required String dateJoined,
    @JsonKey(name: 'updated_at') String? updatedAt,
    ImageDtoModel? avatar,
    @JsonKey(name: 'agent_type') String? agentType,
    @JsonKey(name: 'national_code') String? nationalCode,
    @JsonKey(name: 'insurance_id') String? insuranceId,
    CityProvinceDtoModel? province,
    CityProvinceDtoModel? city,
    String? address,
    @JsonKey(name: 'credit_limit') double? creditLimit,
    double? tolerance,
    @JsonKey(name: 'tolerance_check_enabled') bool? toleranceCheckEnabled,
    @JsonKey(name: 'agent_code') String? agentCode,
    @JsonKey(name: 'store_name') String? storeName,
    ManagerDtoModel? manager,
    @JsonKey(name: 'completed_orders_count') int? completedOrdersCount,
    @JsonKey(name: 'sales_last_30_days') double? salesLast30Days,
    @JsonKey(name: 'total_sales') double? totalSales,
    @JsonKey(name: 'wallet_balance') double? walletBalance,
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
