import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_dto_model.freezed.dart';
part 'customer_dto_model.g.dart';

@freezed
class CustomerListResponse with _$CustomerListResponse {
  const factory CustomerListResponse({
    required int count,
    String? next,
    String? previous,
    required List<CustomerDtoModel> results,
  }) = _CustomerListResponse;

  factory CustomerListResponse.fromJson(Map<String, dynamic> json) => _$CustomerListResponseFromJson(json);
}

@freezed
class CustomerDtoModel with _$CustomerDtoModel {
  const factory CustomerDtoModel({
    required String id,
    @JsonKey(name: 'national_id') required String nationalId,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    required String mobile,
    required String address,
    @JsonKey(name: 'postal_code') required String postalCode,
  }) = _CustomerDtoModel;

  factory CustomerDtoModel.fromJson(Map<String, dynamic> json) => _$CustomerDtoModelFromJson(json);
}
