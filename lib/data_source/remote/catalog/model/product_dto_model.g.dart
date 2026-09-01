// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_dto_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductListResponseImpl _$$ProductListResponseImplFromJson(
  Map<String, dynamic> json,
) => _$ProductListResponseImpl(
  count: (json['count'] as num).toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>)
      .map((e) => ProductDtoModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$ProductListResponseImplToJson(
  _$ProductListResponseImpl instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results,
};

_$ProductDtoModelImpl _$$ProductDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$ProductDtoModelImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  sku: json['sku'] as String,
  description: json['description'] as String?,
  technicalDetail: json['technical_detail'] as String?,
  category: CategorySummaryDtoModel.fromJson(
    json['category'] as Map<String, dynamic>,
  ),
  brand: json['brand'] == null
      ? null
      : BrandSummaryDtoModel.fromJson(json['brand'] as Map<String, dynamic>),
  price: (json['price'] as num?)?.toInt(),
  priceBeforeDiscount: (json['price_before_discount'] as num?)?.toInt(),
  basePrice: (json['base_price'] as num?)?.toInt(),
  planPrice: (json['plan_price'] as num?)?.toInt(),
  planPriceBeforeDiscount: (json['plan_price_before_discount'] as num?)
      ?.toInt(),
  oldPrice: (json['old_price'] as num?)?.toInt(),
  discountPct: (json['discount_pct'] as num?)?.toInt(),
  stockQty: (json['stock_qty'] as num).toInt(),
  isActive: json['is_active'] as bool,
  featuredImage: json['featured_image'] == null
      ? null
      : ImageDtoModel.fromJson(json['featured_image'] as Map<String, dynamic>),
  images: (json['images'] as List<dynamic>?)
      ?.map(
        (e) => ProductGalleryImageDtoModel.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
);

Map<String, dynamic> _$$ProductDtoModelImplToJson(
  _$ProductDtoModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'sku': instance.sku,
  'description': instance.description,
  'technical_detail': instance.technicalDetail,
  'category': instance.category,
  'brand': instance.brand,
  'price': instance.price,
  'price_before_discount': instance.priceBeforeDiscount,
  'base_price': instance.basePrice,
  'plan_price': instance.planPrice,
  'plan_price_before_discount': instance.planPriceBeforeDiscount,
  'old_price': instance.oldPrice,
  'discount_pct': instance.discountPct,
  'stock_qty': instance.stockQty,
  'is_active': instance.isActive,
  'featured_image': instance.featuredImage,
  'images': instance.images,
};

_$CategorySummaryDtoModelImpl _$$CategorySummaryDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$CategorySummaryDtoModelImpl(
  id: json['id'] as String,
  name: json['name'] as String,
);

Map<String, dynamic> _$$CategorySummaryDtoModelImplToJson(
  _$CategorySummaryDtoModelImpl instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};

_$BrandSummaryDtoModelImpl _$$BrandSummaryDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$BrandSummaryDtoModelImpl(
  id: json['id'] as String,
  name: json['name'] as String,
);

Map<String, dynamic> _$$BrandSummaryDtoModelImplToJson(
  _$BrandSummaryDtoModelImpl instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};

_$ImageDtoModelImpl _$$ImageDtoModelImplFromJson(Map<String, dynamic> json) =>
    _$ImageDtoModelImpl(
      id: json['id'] as String,
      imageGroup: json['image_group'] as String,
      title: json['title'] as String,
      file: json['file'] as String,
      width: (json['width'] as num).toInt(),
      height: (json['height'] as num).toInt(),
      fileSize: (json['file_size'] as num).toInt(),
      uploadedById: json['uploaded_by_id'] as String?,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$$ImageDtoModelImplToJson(_$ImageDtoModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image_group': instance.imageGroup,
      'title': instance.title,
      'file': instance.file,
      'width': instance.width,
      'height': instance.height,
      'file_size': instance.fileSize,
      'uploaded_by_id': instance.uploadedById,
      'created_at': instance.createdAt,
    };

_$ProductGalleryImageDtoModelImpl _$$ProductGalleryImageDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$ProductGalleryImageDtoModelImpl(
  id: json['id'] as String,
  image: ImageDtoModel.fromJson(json['image'] as Map<String, dynamic>),
  order: (json['order'] as num).toInt(),
);

Map<String, dynamic> _$$ProductGalleryImageDtoModelImplToJson(
  _$ProductGalleryImageDtoModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'image': instance.image,
  'order': instance.order,
};
