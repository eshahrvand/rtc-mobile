import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_dto_model.freezed.dart';
part 'category_dto_model.g.dart';

@freezed
class CategoryListResponse with _$CategoryListResponse {
  const factory CategoryListResponse({
    required int count,
    String? next,
    String? previous,
    required List<CategoryDtoModel> results,
  }) = _CategoryListResponse;

  factory CategoryListResponse.fromJson(Map<String, dynamic> json) => _$CategoryListResponseFromJson(json);
}

@freezed
class CategoryDtoModel with _$CategoryDtoModel {
  const factory CategoryDtoModel({
    required String id,
    required String name,
    String? color,
    ParentCategoryDtoModel? parent,
    required int order,
    @JsonKey(name: 'is_active') required bool isActive,
    @JsonKey(name: 'direct_products_count') required int directProductsCount,
    @JsonKey(name: 'total_products_count') required int totalProductsCount,
  }) = _CategoryDtoModel;

  factory CategoryDtoModel.fromJson(Map<String, dynamic> json) => _$CategoryDtoModelFromJson(json);
}

@freezed
class ParentCategoryDtoModel with _$ParentCategoryDtoModel {
  const factory ParentCategoryDtoModel({
    required String id,
    required String name,
  }) = _ParentCategoryDtoModel;

  factory ParentCategoryDtoModel.fromJson(Map<String, dynamic> json) => _$ParentCategoryDtoModelFromJson(json);
}
