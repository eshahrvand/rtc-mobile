// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_dto_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BrandListResponseImpl _$$BrandListResponseImplFromJson(
  Map<String, dynamic> json,
) => _$BrandListResponseImpl(
  count: (json['count'] as num).toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>)
      .map((e) => BrandDtoModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$BrandListResponseImplToJson(
  _$BrandListResponseImpl instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results,
};

_$BrandDtoModelImpl _$$BrandDtoModelImplFromJson(Map<String, dynamic> json) =>
    _$BrandDtoModelImpl(id: json['id'] as String, name: json['name'] as String);

Map<String, dynamic> _$$BrandDtoModelImplToJson(_$BrandDtoModelImpl instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};
