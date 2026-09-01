// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_dto_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomerListResponseImpl _$$CustomerListResponseImplFromJson(
  Map<String, dynamic> json,
) => _$CustomerListResponseImpl(
  count: (json['count'] as num).toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>)
      .map((e) => CustomerDtoModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$CustomerListResponseImplToJson(
  _$CustomerListResponseImpl instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results,
};

_$CustomerDtoModelImpl _$$CustomerDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$CustomerDtoModelImpl(
  id: json['id'] as String,
  nationalId: json['national_id'] as String,
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String,
  mobile: json['mobile'] as String,
  address: json['address'] as String,
  postalCode: json['postal_code'] as String,
);

Map<String, dynamic> _$$CustomerDtoModelImplToJson(
  _$CustomerDtoModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'national_id': instance.nationalId,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'mobile': instance.mobile,
  'address': instance.address,
  'postal_code': instance.postalCode,
};
