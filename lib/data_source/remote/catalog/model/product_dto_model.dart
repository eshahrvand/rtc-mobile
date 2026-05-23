import 'package:freezed_annotation/freezed_annotation.dart';
import '../../profile/model/user_profile_dto_model.dart'; // For CityProvinceDtoModel/AvatarDtoModel reuse if applicable or use generic

part 'product_dto_model.freezed.dart';
part 'product_dto_model.g.dart';

@freezed
class ProductListResponse with _$ProductListResponse {
  const factory ProductListResponse({
    required int count,
    String? next,
    String? previous,
    required List<ProductDtoModel> results,
  }) = _ProductListResponse;

  factory ProductListResponse.fromJson(Map<String, dynamic> json) => _$ProductListResponseFromJson(json);
}

@freezed
class ProductDtoModel with _$ProductDtoModel {
  const factory ProductDtoModel({
    required String id,
    required String name,
    required String sku,
    String? description,
    @JsonKey(name: 'technical_detail') String? technicalDetail,
    required CategorySummaryDtoModel category,
    @JsonKey(name: 'base_price') int? basePrice,
    @JsonKey(name: 'plan_price') int? planPrice,
    @JsonKey(name: 'discount_pct') int? discountPct,
    @JsonKey(name: 'stock_qty') required int stockQty,
    @JsonKey(name: 'is_active') required bool isActive,
    @JsonKey(name: 'featured_image') ImageDtoModel? featuredImage,
    List<ProductGalleryImageDtoModel>? images,
  }) = _ProductDtoModel;

  factory ProductDtoModel.fromJson(Map<String, dynamic> json) => _$ProductDtoModelFromJson(json);
}

@freezed
class CategorySummaryDtoModel with _$CategorySummaryDtoModel {
  const factory CategorySummaryDtoModel({
    required String id,
    required String name,
  }) = _CategorySummaryDtoModel;

  factory CategorySummaryDtoModel.fromJson(Map<String, dynamic> json) => _$CategorySummaryDtoModelFromJson(json);
}

@freezed
class ImageDtoModel with _$ImageDtoModel {
  const factory ImageDtoModel({
    required String id,
    @JsonKey(name: 'image_group') required String imageGroup,
    required String title,
    required String file,
    required int width,
    required int height,
    @JsonKey(name: 'file_size') required int fileSize,
    @JsonKey(name: 'uploaded_by_id') required String uploadedById,
    @JsonKey(name: 'created_at') required String createdAt,
  }) = _ImageDtoModel;

  factory ImageDtoModel.fromJson(Map<String, dynamic> json) => _$ImageDtoModelFromJson(json);
}

@freezed
class ProductGalleryImageDtoModel with _$ProductGalleryImageDtoModel {
  const factory ProductGalleryImageDtoModel({
    required String id,
    required ImageDtoModel image,
    required int order,
  }) = _ProductGalleryImageDtoModel;

  factory ProductGalleryImageDtoModel.fromJson(Map<String, dynamic> json) => _$ProductGalleryImageDtoModelFromJson(json);
}
