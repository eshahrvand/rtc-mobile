import 'package:freezed_annotation/freezed_annotation.dart';

part 'brand_dto_model.freezed.dart';
part 'brand_dto_model.g.dart';

@freezed
class BrandListResponse with _$BrandListResponse {
  const factory BrandListResponse({
    required int count,
    String? next,
    String? previous,
    required List<BrandDtoModel> results,
  }) = _BrandListResponse;

  factory BrandListResponse.fromJson(Map<String, dynamic> json) => _$BrandListResponseFromJson(json);
}

@freezed
class BrandDtoModel with _$BrandDtoModel {
  const factory BrandDtoModel({
    required String id,
    required String name,
  }) = _BrandDtoModel;

  factory BrandDtoModel.fromJson(Map<String, dynamic> json) => _$BrandDtoModelFromJson(json);
}
