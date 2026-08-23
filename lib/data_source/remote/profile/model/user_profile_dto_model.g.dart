// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_dto_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileListResponseImpl _$$ProfileListResponseImplFromJson(
  Map<String, dynamic> json,
) => _$ProfileListResponseImpl(
  count: (json['count'] as num).toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>)
      .map((e) => UserProfileDtoModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$ProfileListResponseImplToJson(
  _$ProfileListResponseImpl instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results,
};

_$UserProfileDtoModelImpl _$$UserProfileDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$UserProfileDtoModelImpl(
  id: json['id'] as String,
  mobile: json['mobile'] as String,
  role: json['role'] as String,
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String,
  email: json['email'] as String?,
  isActive: json['is_active'] as bool,
  dateJoined: json['date_joined'] as String,
  updatedAt: json['updated_at'] as String?,
  avatar: json['avatar'] == null
      ? null
      : ImageDtoModel.fromJson(json['avatar'] as Map<String, dynamic>),
  agentType: json['agent_type'] as String?,
  nationalCode: json['national_code'] as String?,
  insuranceId: json['insurance_id'] as String?,
  province: json['province'] == null
      ? null
      : CityProvinceDtoModel.fromJson(json['province'] as Map<String, dynamic>),
  city: json['city'] == null
      ? null
      : CityProvinceDtoModel.fromJson(json['city'] as Map<String, dynamic>),
  address: json['address'] as String?,
  creditLimit: (json['credit_limit'] as num?)?.toDouble(),
  tolerance: (json['tolerance'] as num?)?.toDouble(),
  toleranceCheckEnabled: json['tolerance_check_enabled'] as bool?,
  agentCode: json['agent_code'] as String?,
  storeName: json['store_name'] as String?,
  manager: json['manager'] == null
      ? null
      : ManagerDtoModel.fromJson(json['manager'] as Map<String, dynamic>),
  completedOrdersCount: (json['completed_orders_count'] as num?)?.toInt(),
  salesLast30Days: (json['sales_last_30_days'] as num?)?.toDouble(),
  totalSales: (json['total_sales'] as num?)?.toDouble(),
  walletBalance: (json['wallet_balance'] as num?)?.toDouble(),
);

Map<String, dynamic> _$$UserProfileDtoModelImplToJson(
  _$UserProfileDtoModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'mobile': instance.mobile,
  'role': instance.role,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'email': instance.email,
  'is_active': instance.isActive,
  'date_joined': instance.dateJoined,
  'updated_at': instance.updatedAt,
  'avatar': instance.avatar,
  'agent_type': instance.agentType,
  'national_code': instance.nationalCode,
  'insurance_id': instance.insuranceId,
  'province': instance.province,
  'city': instance.city,
  'address': instance.address,
  'credit_limit': instance.creditLimit,
  'tolerance': instance.tolerance,
  'tolerance_check_enabled': instance.toleranceCheckEnabled,
  'agent_code': instance.agentCode,
  'store_name': instance.storeName,
  'manager': instance.manager,
  'completed_orders_count': instance.completedOrdersCount,
  'sales_last_30_days': instance.salesLast30Days,
  'total_sales': instance.totalSales,
  'wallet_balance': instance.walletBalance,
};

_$CityProvinceDtoModelImpl _$$CityProvinceDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$CityProvinceDtoModelImpl(
  id: json['id'] as String,
  name: json['name'] as String,
);

Map<String, dynamic> _$$CityProvinceDtoModelImplToJson(
  _$CityProvinceDtoModelImpl instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};

_$ManagerDtoModelImpl _$$ManagerDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$ManagerDtoModelImpl(
  id: json['id'] as String,
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String,
);

Map<String, dynamic> _$$ManagerDtoModelImplToJson(
  _$ManagerDtoModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
};
