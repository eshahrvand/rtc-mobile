// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_dto_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CategoryListResponseImpl _$$CategoryListResponseImplFromJson(
  Map<String, dynamic> json,
) => _$CategoryListResponseImpl(
  count: (json['count'] as num).toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>)
      .map((e) => CategoryDtoModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$CategoryListResponseImplToJson(
  _$CategoryListResponseImpl instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results,
};

_$CategoryDtoModelImpl _$$CategoryDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$CategoryDtoModelImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  color: json['color'] as String?,
  parent: json['parent'] == null
      ? null
      : ParentCategoryDtoModel.fromJson(json['parent'] as Map<String, dynamic>),
  order: (json['order'] as num).toInt(),
  isActive: json['is_active'] as bool,
  directProductsCount: (json['direct_products_count'] as num).toInt(),
  totalProductsCount: (json['total_products_count'] as num).toInt(),
);

Map<String, dynamic> _$$CategoryDtoModelImplToJson(
  _$CategoryDtoModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'color': instance.color,
  'parent': instance.parent,
  'order': instance.order,
  'is_active': instance.isActive,
  'direct_products_count': instance.directProductsCount,
  'total_products_count': instance.totalProductsCount,
};

_$ParentCategoryDtoModelImpl _$$ParentCategoryDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$ParentCategoryDtoModelImpl(
  id: json['id'] as String,
  name: json['name'] as String,
);

Map<String, dynamic> _$$ParentCategoryDtoModelImplToJson(
  _$ParentCategoryDtoModelImpl instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};
