// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_dto_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProfileListResponse _$ProfileListResponseFromJson(Map<String, dynamic> json) {
  return _ProfileListResponse.fromJson(json);
}

/// @nodoc
mixin _$ProfileListResponse {
  int get count => throw _privateConstructorUsedError;
  String? get next => throw _privateConstructorUsedError;
  String? get previous => throw _privateConstructorUsedError;
  List<UserProfileDtoModel> get results => throw _privateConstructorUsedError;

  /// Serializes this ProfileListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfileListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileListResponseCopyWith<ProfileListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileListResponseCopyWith<$Res> {
  factory $ProfileListResponseCopyWith(
    ProfileListResponse value,
    $Res Function(ProfileListResponse) then,
  ) = _$ProfileListResponseCopyWithImpl<$Res, ProfileListResponse>;
  @useResult
  $Res call({
    int count,
    String? next,
    String? previous,
    List<UserProfileDtoModel> results,
  });
}

/// @nodoc
class _$ProfileListResponseCopyWithImpl<$Res, $Val extends ProfileListResponse>
    implements $ProfileListResponseCopyWith<$Res> {
  _$ProfileListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = null,
    Object? next = freezed,
    Object? previous = freezed,
    Object? results = null,
  }) {
    return _then(
      _value.copyWith(
            count: null == count
                ? _value.count
                : count // ignore: cast_nullable_to_non_nullable
                      as int,
            next: freezed == next
                ? _value.next
                : next // ignore: cast_nullable_to_non_nullable
                      as String?,
            previous: freezed == previous
                ? _value.previous
                : previous // ignore: cast_nullable_to_non_nullable
                      as String?,
            results: null == results
                ? _value.results
                : results // ignore: cast_nullable_to_non_nullable
                      as List<UserProfileDtoModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProfileListResponseImplCopyWith<$Res>
    implements $ProfileListResponseCopyWith<$Res> {
  factory _$$ProfileListResponseImplCopyWith(
    _$ProfileListResponseImpl value,
    $Res Function(_$ProfileListResponseImpl) then,
  ) = __$$ProfileListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int count,
    String? next,
    String? previous,
    List<UserProfileDtoModel> results,
  });
}

/// @nodoc
class __$$ProfileListResponseImplCopyWithImpl<$Res>
    extends _$ProfileListResponseCopyWithImpl<$Res, _$ProfileListResponseImpl>
    implements _$$ProfileListResponseImplCopyWith<$Res> {
  __$$ProfileListResponseImplCopyWithImpl(
    _$ProfileListResponseImpl _value,
    $Res Function(_$ProfileListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = null,
    Object? next = freezed,
    Object? previous = freezed,
    Object? results = null,
  }) {
    return _then(
      _$ProfileListResponseImpl(
        count: null == count
            ? _value.count
            : count // ignore: cast_nullable_to_non_nullable
                  as int,
        next: freezed == next
            ? _value.next
            : next // ignore: cast_nullable_to_non_nullable
                  as String?,
        previous: freezed == previous
            ? _value.previous
            : previous // ignore: cast_nullable_to_non_nullable
                  as String?,
        results: null == results
            ? _value._results
            : results // ignore: cast_nullable_to_non_nullable
                  as List<UserProfileDtoModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileListResponseImpl implements _ProfileListResponse {
  const _$ProfileListResponseImpl({
    required this.count,
    this.next,
    this.previous,
    required final List<UserProfileDtoModel> results,
  }) : _results = results;

  factory _$ProfileListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileListResponseImplFromJson(json);

  @override
  final int count;
  @override
  final String? next;
  @override
  final String? previous;
  final List<UserProfileDtoModel> _results;
  @override
  List<UserProfileDtoModel> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  String toString() {
    return 'ProfileListResponse(count: $count, next: $next, previous: $previous, results: $results)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileListResponseImpl &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.next, next) || other.next == next) &&
            (identical(other.previous, previous) ||
                other.previous == previous) &&
            const DeepCollectionEquality().equals(other._results, _results));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    count,
    next,
    previous,
    const DeepCollectionEquality().hash(_results),
  );

  /// Create a copy of ProfileListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileListResponseImplCopyWith<_$ProfileListResponseImpl> get copyWith =>
      __$$ProfileListResponseImplCopyWithImpl<_$ProfileListResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileListResponseImplToJson(this);
  }
}

abstract class _ProfileListResponse implements ProfileListResponse {
  const factory _ProfileListResponse({
    required final int count,
    final String? next,
    final String? previous,
    required final List<UserProfileDtoModel> results,
  }) = _$ProfileListResponseImpl;

  factory _ProfileListResponse.fromJson(Map<String, dynamic> json) =
      _$ProfileListResponseImpl.fromJson;

  @override
  int get count;
  @override
  String? get next;
  @override
  String? get previous;
  @override
  List<UserProfileDtoModel> get results;

  /// Create a copy of ProfileListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileListResponseImplCopyWith<_$ProfileListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserProfileDtoModel _$UserProfileDtoModelFromJson(Map<String, dynamic> json) {
  return _UserProfileDtoModel.fromJson(json);
}

/// @nodoc
mixin _$UserProfileDtoModel {
  String get id => throw _privateConstructorUsedError;
  String get mobile => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  @JsonKey(name: 'first_name')
  String get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_name')
  String get lastName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_joined')
  String get dateJoined => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;
  ImageDtoModel? get avatar => throw _privateConstructorUsedError;
  @JsonKey(name: 'agent_type')
  String? get agentType => throw _privateConstructorUsedError;
  @JsonKey(name: 'national_code')
  String? get nationalCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'insurance_id')
  String? get insuranceId => throw _privateConstructorUsedError;
  CityProvinceDtoModel? get province => throw _privateConstructorUsedError;
  CityProvinceDtoModel? get city => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  @JsonKey(name: 'credit_limit')
  double? get creditLimit => throw _privateConstructorUsedError;
  double? get tolerance => throw _privateConstructorUsedError;
  @JsonKey(name: 'tolerance_check_enabled')
  bool? get toleranceCheckEnabled => throw _privateConstructorUsedError;
  @JsonKey(name: 'agent_code')
  String? get agentCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'store_name')
  String? get storeName => throw _privateConstructorUsedError;
  ManagerDtoModel? get manager => throw _privateConstructorUsedError;
  @JsonKey(name: 'completed_orders_count')
  int? get completedOrdersCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'sales_last_30_days')
  double? get salesLast30Days => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_sales')
  double? get totalSales => throw _privateConstructorUsedError;
  @JsonKey(name: 'wallet_balance')
  double? get walletBalance => throw _privateConstructorUsedError;

  /// Serializes this UserProfileDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfileDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileDtoModelCopyWith<UserProfileDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileDtoModelCopyWith<$Res> {
  factory $UserProfileDtoModelCopyWith(
    UserProfileDtoModel value,
    $Res Function(UserProfileDtoModel) then,
  ) = _$UserProfileDtoModelCopyWithImpl<$Res, UserProfileDtoModel>;
  @useResult
  $Res call({
    String id,
    String mobile,
    String role,
    @JsonKey(name: 'first_name') String firstName,
    @JsonKey(name: 'last_name') String lastName,
    String? email,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'date_joined') String dateJoined,
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
  });

  $ImageDtoModelCopyWith<$Res>? get avatar;
  $CityProvinceDtoModelCopyWith<$Res>? get province;
  $CityProvinceDtoModelCopyWith<$Res>? get city;
  $ManagerDtoModelCopyWith<$Res>? get manager;
}

/// @nodoc
class _$UserProfileDtoModelCopyWithImpl<$Res, $Val extends UserProfileDtoModel>
    implements $UserProfileDtoModelCopyWith<$Res> {
  _$UserProfileDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfileDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? mobile = null,
    Object? role = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = freezed,
    Object? isActive = null,
    Object? dateJoined = null,
    Object? updatedAt = freezed,
    Object? avatar = freezed,
    Object? agentType = freezed,
    Object? nationalCode = freezed,
    Object? insuranceId = freezed,
    Object? province = freezed,
    Object? city = freezed,
    Object? address = freezed,
    Object? creditLimit = freezed,
    Object? tolerance = freezed,
    Object? toleranceCheckEnabled = freezed,
    Object? agentCode = freezed,
    Object? storeName = freezed,
    Object? manager = freezed,
    Object? completedOrdersCount = freezed,
    Object? salesLast30Days = freezed,
    Object? totalSales = freezed,
    Object? walletBalance = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            mobile: null == mobile
                ? _value.mobile
                : mobile // ignore: cast_nullable_to_non_nullable
                      as String,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String,
            firstName: null == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String,
            lastName: null == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                      as String,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            dateJoined: null == dateJoined
                ? _value.dateJoined
                : dateJoined // ignore: cast_nullable_to_non_nullable
                      as String,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatar: freezed == avatar
                ? _value.avatar
                : avatar // ignore: cast_nullable_to_non_nullable
                      as ImageDtoModel?,
            agentType: freezed == agentType
                ? _value.agentType
                : agentType // ignore: cast_nullable_to_non_nullable
                      as String?,
            nationalCode: freezed == nationalCode
                ? _value.nationalCode
                : nationalCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            insuranceId: freezed == insuranceId
                ? _value.insuranceId
                : insuranceId // ignore: cast_nullable_to_non_nullable
                      as String?,
            province: freezed == province
                ? _value.province
                : province // ignore: cast_nullable_to_non_nullable
                      as CityProvinceDtoModel?,
            city: freezed == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as CityProvinceDtoModel?,
            address: freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String?,
            creditLimit: freezed == creditLimit
                ? _value.creditLimit
                : creditLimit // ignore: cast_nullable_to_non_nullable
                      as double?,
            tolerance: freezed == tolerance
                ? _value.tolerance
                : tolerance // ignore: cast_nullable_to_non_nullable
                      as double?,
            toleranceCheckEnabled: freezed == toleranceCheckEnabled
                ? _value.toleranceCheckEnabled
                : toleranceCheckEnabled // ignore: cast_nullable_to_non_nullable
                      as bool?,
            agentCode: freezed == agentCode
                ? _value.agentCode
                : agentCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            storeName: freezed == storeName
                ? _value.storeName
                : storeName // ignore: cast_nullable_to_non_nullable
                      as String?,
            manager: freezed == manager
                ? _value.manager
                : manager // ignore: cast_nullable_to_non_nullable
                      as ManagerDtoModel?,
            completedOrdersCount: freezed == completedOrdersCount
                ? _value.completedOrdersCount
                : completedOrdersCount // ignore: cast_nullable_to_non_nullable
                      as int?,
            salesLast30Days: freezed == salesLast30Days
                ? _value.salesLast30Days
                : salesLast30Days // ignore: cast_nullable_to_non_nullable
                      as double?,
            totalSales: freezed == totalSales
                ? _value.totalSales
                : totalSales // ignore: cast_nullable_to_non_nullable
                      as double?,
            walletBalance: freezed == walletBalance
                ? _value.walletBalance
                : walletBalance // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }

  /// Create a copy of UserProfileDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ImageDtoModelCopyWith<$Res>? get avatar {
    if (_value.avatar == null) {
      return null;
    }

    return $ImageDtoModelCopyWith<$Res>(_value.avatar!, (value) {
      return _then(_value.copyWith(avatar: value) as $Val);
    });
  }

  /// Create a copy of UserProfileDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CityProvinceDtoModelCopyWith<$Res>? get province {
    if (_value.province == null) {
      return null;
    }

    return $CityProvinceDtoModelCopyWith<$Res>(_value.province!, (value) {
      return _then(_value.copyWith(province: value) as $Val);
    });
  }

  /// Create a copy of UserProfileDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CityProvinceDtoModelCopyWith<$Res>? get city {
    if (_value.city == null) {
      return null;
    }

    return $CityProvinceDtoModelCopyWith<$Res>(_value.city!, (value) {
      return _then(_value.copyWith(city: value) as $Val);
    });
  }

  /// Create a copy of UserProfileDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ManagerDtoModelCopyWith<$Res>? get manager {
    if (_value.manager == null) {
      return null;
    }

    return $ManagerDtoModelCopyWith<$Res>(_value.manager!, (value) {
      return _then(_value.copyWith(manager: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserProfileDtoModelImplCopyWith<$Res>
    implements $UserProfileDtoModelCopyWith<$Res> {
  factory _$$UserProfileDtoModelImplCopyWith(
    _$UserProfileDtoModelImpl value,
    $Res Function(_$UserProfileDtoModelImpl) then,
  ) = __$$UserProfileDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String mobile,
    String role,
    @JsonKey(name: 'first_name') String firstName,
    @JsonKey(name: 'last_name') String lastName,
    String? email,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'date_joined') String dateJoined,
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
  });

  @override
  $ImageDtoModelCopyWith<$Res>? get avatar;
  @override
  $CityProvinceDtoModelCopyWith<$Res>? get province;
  @override
  $CityProvinceDtoModelCopyWith<$Res>? get city;
  @override
  $ManagerDtoModelCopyWith<$Res>? get manager;
}

/// @nodoc
class __$$UserProfileDtoModelImplCopyWithImpl<$Res>
    extends _$UserProfileDtoModelCopyWithImpl<$Res, _$UserProfileDtoModelImpl>
    implements _$$UserProfileDtoModelImplCopyWith<$Res> {
  __$$UserProfileDtoModelImplCopyWithImpl(
    _$UserProfileDtoModelImpl _value,
    $Res Function(_$UserProfileDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserProfileDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? mobile = null,
    Object? role = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = freezed,
    Object? isActive = null,
    Object? dateJoined = null,
    Object? updatedAt = freezed,
    Object? avatar = freezed,
    Object? agentType = freezed,
    Object? nationalCode = freezed,
    Object? insuranceId = freezed,
    Object? province = freezed,
    Object? city = freezed,
    Object? address = freezed,
    Object? creditLimit = freezed,
    Object? tolerance = freezed,
    Object? toleranceCheckEnabled = freezed,
    Object? agentCode = freezed,
    Object? storeName = freezed,
    Object? manager = freezed,
    Object? completedOrdersCount = freezed,
    Object? salesLast30Days = freezed,
    Object? totalSales = freezed,
    Object? walletBalance = freezed,
  }) {
    return _then(
      _$UserProfileDtoModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        mobile: null == mobile
            ? _value.mobile
            : mobile // ignore: cast_nullable_to_non_nullable
                  as String,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String,
        firstName: null == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String,
        lastName: null == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        dateJoined: null == dateJoined
            ? _value.dateJoined
            : dateJoined // ignore: cast_nullable_to_non_nullable
                  as String,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatar: freezed == avatar
            ? _value.avatar
            : avatar // ignore: cast_nullable_to_non_nullable
                  as ImageDtoModel?,
        agentType: freezed == agentType
            ? _value.agentType
            : agentType // ignore: cast_nullable_to_non_nullable
                  as String?,
        nationalCode: freezed == nationalCode
            ? _value.nationalCode
            : nationalCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        insuranceId: freezed == insuranceId
            ? _value.insuranceId
            : insuranceId // ignore: cast_nullable_to_non_nullable
                  as String?,
        province: freezed == province
            ? _value.province
            : province // ignore: cast_nullable_to_non_nullable
                  as CityProvinceDtoModel?,
        city: freezed == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as CityProvinceDtoModel?,
        address: freezed == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String?,
        creditLimit: freezed == creditLimit
            ? _value.creditLimit
            : creditLimit // ignore: cast_nullable_to_non_nullable
                  as double?,
        tolerance: freezed == tolerance
            ? _value.tolerance
            : tolerance // ignore: cast_nullable_to_non_nullable
                  as double?,
        toleranceCheckEnabled: freezed == toleranceCheckEnabled
            ? _value.toleranceCheckEnabled
            : toleranceCheckEnabled // ignore: cast_nullable_to_non_nullable
                  as bool?,
        agentCode: freezed == agentCode
            ? _value.agentCode
            : agentCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        storeName: freezed == storeName
            ? _value.storeName
            : storeName // ignore: cast_nullable_to_non_nullable
                  as String?,
        manager: freezed == manager
            ? _value.manager
            : manager // ignore: cast_nullable_to_non_nullable
                  as ManagerDtoModel?,
        completedOrdersCount: freezed == completedOrdersCount
            ? _value.completedOrdersCount
            : completedOrdersCount // ignore: cast_nullable_to_non_nullable
                  as int?,
        salesLast30Days: freezed == salesLast30Days
            ? _value.salesLast30Days
            : salesLast30Days // ignore: cast_nullable_to_non_nullable
                  as double?,
        totalSales: freezed == totalSales
            ? _value.totalSales
            : totalSales // ignore: cast_nullable_to_non_nullable
                  as double?,
        walletBalance: freezed == walletBalance
            ? _value.walletBalance
            : walletBalance // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileDtoModelImpl implements _UserProfileDtoModel {
  const _$UserProfileDtoModelImpl({
    required this.id,
    required this.mobile,
    required this.role,
    @JsonKey(name: 'first_name') required this.firstName,
    @JsonKey(name: 'last_name') required this.lastName,
    this.email,
    @JsonKey(name: 'is_active') required this.isActive,
    @JsonKey(name: 'date_joined') required this.dateJoined,
    @JsonKey(name: 'updated_at') this.updatedAt,
    this.avatar,
    @JsonKey(name: 'agent_type') this.agentType,
    @JsonKey(name: 'national_code') this.nationalCode,
    @JsonKey(name: 'insurance_id') this.insuranceId,
    this.province,
    this.city,
    this.address,
    @JsonKey(name: 'credit_limit') this.creditLimit,
    this.tolerance,
    @JsonKey(name: 'tolerance_check_enabled') this.toleranceCheckEnabled,
    @JsonKey(name: 'agent_code') this.agentCode,
    @JsonKey(name: 'store_name') this.storeName,
    this.manager,
    @JsonKey(name: 'completed_orders_count') this.completedOrdersCount,
    @JsonKey(name: 'sales_last_30_days') this.salesLast30Days,
    @JsonKey(name: 'total_sales') this.totalSales,
    @JsonKey(name: 'wallet_balance') this.walletBalance,
  });

  factory _$UserProfileDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileDtoModelImplFromJson(json);

  @override
  final String id;
  @override
  final String mobile;
  @override
  final String role;
  @override
  @JsonKey(name: 'first_name')
  final String firstName;
  @override
  @JsonKey(name: 'last_name')
  final String lastName;
  @override
  final String? email;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'date_joined')
  final String dateJoined;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @override
  final ImageDtoModel? avatar;
  @override
  @JsonKey(name: 'agent_type')
  final String? agentType;
  @override
  @JsonKey(name: 'national_code')
  final String? nationalCode;
  @override
  @JsonKey(name: 'insurance_id')
  final String? insuranceId;
  @override
  final CityProvinceDtoModel? province;
  @override
  final CityProvinceDtoModel? city;
  @override
  final String? address;
  @override
  @JsonKey(name: 'credit_limit')
  final double? creditLimit;
  @override
  final double? tolerance;
  @override
  @JsonKey(name: 'tolerance_check_enabled')
  final bool? toleranceCheckEnabled;
  @override
  @JsonKey(name: 'agent_code')
  final String? agentCode;
  @override
  @JsonKey(name: 'store_name')
  final String? storeName;
  @override
  final ManagerDtoModel? manager;
  @override
  @JsonKey(name: 'completed_orders_count')
  final int? completedOrdersCount;
  @override
  @JsonKey(name: 'sales_last_30_days')
  final double? salesLast30Days;
  @override
  @JsonKey(name: 'total_sales')
  final double? totalSales;
  @override
  @JsonKey(name: 'wallet_balance')
  final double? walletBalance;

  @override
  String toString() {
    return 'UserProfileDtoModel(id: $id, mobile: $mobile, role: $role, firstName: $firstName, lastName: $lastName, email: $email, isActive: $isActive, dateJoined: $dateJoined, updatedAt: $updatedAt, avatar: $avatar, agentType: $agentType, nationalCode: $nationalCode, insuranceId: $insuranceId, province: $province, city: $city, address: $address, creditLimit: $creditLimit, tolerance: $tolerance, toleranceCheckEnabled: $toleranceCheckEnabled, agentCode: $agentCode, storeName: $storeName, manager: $manager, completedOrdersCount: $completedOrdersCount, salesLast30Days: $salesLast30Days, totalSales: $totalSales, walletBalance: $walletBalance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileDtoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.mobile, mobile) || other.mobile == mobile) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.dateJoined, dateJoined) ||
                other.dateJoined == dateJoined) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.agentType, agentType) ||
                other.agentType == agentType) &&
            (identical(other.nationalCode, nationalCode) ||
                other.nationalCode == nationalCode) &&
            (identical(other.insuranceId, insuranceId) ||
                other.insuranceId == insuranceId) &&
            (identical(other.province, province) ||
                other.province == province) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.creditLimit, creditLimit) ||
                other.creditLimit == creditLimit) &&
            (identical(other.tolerance, tolerance) ||
                other.tolerance == tolerance) &&
            (identical(other.toleranceCheckEnabled, toleranceCheckEnabled) ||
                other.toleranceCheckEnabled == toleranceCheckEnabled) &&
            (identical(other.agentCode, agentCode) ||
                other.agentCode == agentCode) &&
            (identical(other.storeName, storeName) ||
                other.storeName == storeName) &&
            (identical(other.manager, manager) || other.manager == manager) &&
            (identical(other.completedOrdersCount, completedOrdersCount) ||
                other.completedOrdersCount == completedOrdersCount) &&
            (identical(other.salesLast30Days, salesLast30Days) ||
                other.salesLast30Days == salesLast30Days) &&
            (identical(other.totalSales, totalSales) ||
                other.totalSales == totalSales) &&
            (identical(other.walletBalance, walletBalance) ||
                other.walletBalance == walletBalance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    mobile,
    role,
    firstName,
    lastName,
    email,
    isActive,
    dateJoined,
    updatedAt,
    avatar,
    agentType,
    nationalCode,
    insuranceId,
    province,
    city,
    address,
    creditLimit,
    tolerance,
    toleranceCheckEnabled,
    agentCode,
    storeName,
    manager,
    completedOrdersCount,
    salesLast30Days,
    totalSales,
    walletBalance,
  ]);

  /// Create a copy of UserProfileDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileDtoModelImplCopyWith<_$UserProfileDtoModelImpl> get copyWith =>
      __$$UserProfileDtoModelImplCopyWithImpl<_$UserProfileDtoModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileDtoModelImplToJson(this);
  }
}

abstract class _UserProfileDtoModel implements UserProfileDtoModel {
  const factory _UserProfileDtoModel({
    required final String id,
    required final String mobile,
    required final String role,
    @JsonKey(name: 'first_name') required final String firstName,
    @JsonKey(name: 'last_name') required final String lastName,
    final String? email,
    @JsonKey(name: 'is_active') required final bool isActive,
    @JsonKey(name: 'date_joined') required final String dateJoined,
    @JsonKey(name: 'updated_at') final String? updatedAt,
    final ImageDtoModel? avatar,
    @JsonKey(name: 'agent_type') final String? agentType,
    @JsonKey(name: 'national_code') final String? nationalCode,
    @JsonKey(name: 'insurance_id') final String? insuranceId,
    final CityProvinceDtoModel? province,
    final CityProvinceDtoModel? city,
    final String? address,
    @JsonKey(name: 'credit_limit') final double? creditLimit,
    final double? tolerance,
    @JsonKey(name: 'tolerance_check_enabled') final bool? toleranceCheckEnabled,
    @JsonKey(name: 'agent_code') final String? agentCode,
    @JsonKey(name: 'store_name') final String? storeName,
    final ManagerDtoModel? manager,
    @JsonKey(name: 'completed_orders_count') final int? completedOrdersCount,
    @JsonKey(name: 'sales_last_30_days') final double? salesLast30Days,
    @JsonKey(name: 'total_sales') final double? totalSales,
    @JsonKey(name: 'wallet_balance') final double? walletBalance,
  }) = _$UserProfileDtoModelImpl;

  factory _UserProfileDtoModel.fromJson(Map<String, dynamic> json) =
      _$UserProfileDtoModelImpl.fromJson;

  @override
  String get id;
  @override
  String get mobile;
  @override
  String get role;
  @override
  @JsonKey(name: 'first_name')
  String get firstName;
  @override
  @JsonKey(name: 'last_name')
  String get lastName;
  @override
  String? get email;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(name: 'date_joined')
  String get dateJoined;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;
  @override
  ImageDtoModel? get avatar;
  @override
  @JsonKey(name: 'agent_type')
  String? get agentType;
  @override
  @JsonKey(name: 'national_code')
  String? get nationalCode;
  @override
  @JsonKey(name: 'insurance_id')
  String? get insuranceId;
  @override
  CityProvinceDtoModel? get province;
  @override
  CityProvinceDtoModel? get city;
  @override
  String? get address;
  @override
  @JsonKey(name: 'credit_limit')
  double? get creditLimit;
  @override
  double? get tolerance;
  @override
  @JsonKey(name: 'tolerance_check_enabled')
  bool? get toleranceCheckEnabled;
  @override
  @JsonKey(name: 'agent_code')
  String? get agentCode;
  @override
  @JsonKey(name: 'store_name')
  String? get storeName;
  @override
  ManagerDtoModel? get manager;
  @override
  @JsonKey(name: 'completed_orders_count')
  int? get completedOrdersCount;
  @override
  @JsonKey(name: 'sales_last_30_days')
  double? get salesLast30Days;
  @override
  @JsonKey(name: 'total_sales')
  double? get totalSales;
  @override
  @JsonKey(name: 'wallet_balance')
  double? get walletBalance;

  /// Create a copy of UserProfileDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileDtoModelImplCopyWith<_$UserProfileDtoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CityProvinceDtoModel _$CityProvinceDtoModelFromJson(Map<String, dynamic> json) {
  return _CityProvinceDtoModel.fromJson(json);
}

/// @nodoc
mixin _$CityProvinceDtoModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this CityProvinceDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CityProvinceDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CityProvinceDtoModelCopyWith<CityProvinceDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CityProvinceDtoModelCopyWith<$Res> {
  factory $CityProvinceDtoModelCopyWith(
    CityProvinceDtoModel value,
    $Res Function(CityProvinceDtoModel) then,
  ) = _$CityProvinceDtoModelCopyWithImpl<$Res, CityProvinceDtoModel>;
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class _$CityProvinceDtoModelCopyWithImpl<
  $Res,
  $Val extends CityProvinceDtoModel
>
    implements $CityProvinceDtoModelCopyWith<$Res> {
  _$CityProvinceDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CityProvinceDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CityProvinceDtoModelImplCopyWith<$Res>
    implements $CityProvinceDtoModelCopyWith<$Res> {
  factory _$$CityProvinceDtoModelImplCopyWith(
    _$CityProvinceDtoModelImpl value,
    $Res Function(_$CityProvinceDtoModelImpl) then,
  ) = __$$CityProvinceDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class __$$CityProvinceDtoModelImplCopyWithImpl<$Res>
    extends _$CityProvinceDtoModelCopyWithImpl<$Res, _$CityProvinceDtoModelImpl>
    implements _$$CityProvinceDtoModelImplCopyWith<$Res> {
  __$$CityProvinceDtoModelImplCopyWithImpl(
    _$CityProvinceDtoModelImpl _value,
    $Res Function(_$CityProvinceDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CityProvinceDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _$CityProvinceDtoModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CityProvinceDtoModelImpl implements _CityProvinceDtoModel {
  const _$CityProvinceDtoModelImpl({required this.id, required this.name});

  factory _$CityProvinceDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CityProvinceDtoModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;

  @override
  String toString() {
    return 'CityProvinceDtoModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CityProvinceDtoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of CityProvinceDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CityProvinceDtoModelImplCopyWith<_$CityProvinceDtoModelImpl>
  get copyWith =>
      __$$CityProvinceDtoModelImplCopyWithImpl<_$CityProvinceDtoModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CityProvinceDtoModelImplToJson(this);
  }
}

abstract class _CityProvinceDtoModel implements CityProvinceDtoModel {
  const factory _CityProvinceDtoModel({
    required final String id,
    required final String name,
  }) = _$CityProvinceDtoModelImpl;

  factory _CityProvinceDtoModel.fromJson(Map<String, dynamic> json) =
      _$CityProvinceDtoModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;

  /// Create a copy of CityProvinceDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CityProvinceDtoModelImplCopyWith<_$CityProvinceDtoModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ManagerDtoModel _$ManagerDtoModelFromJson(Map<String, dynamic> json) {
  return _ManagerDtoModel.fromJson(json);
}

/// @nodoc
mixin _$ManagerDtoModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'first_name')
  String get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_name')
  String get lastName => throw _privateConstructorUsedError;

  /// Serializes this ManagerDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ManagerDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ManagerDtoModelCopyWith<ManagerDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ManagerDtoModelCopyWith<$Res> {
  factory $ManagerDtoModelCopyWith(
    ManagerDtoModel value,
    $Res Function(ManagerDtoModel) then,
  ) = _$ManagerDtoModelCopyWithImpl<$Res, ManagerDtoModel>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'first_name') String firstName,
    @JsonKey(name: 'last_name') String lastName,
  });
}

/// @nodoc
class _$ManagerDtoModelCopyWithImpl<$Res, $Val extends ManagerDtoModel>
    implements $ManagerDtoModelCopyWith<$Res> {
  _$ManagerDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ManagerDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            firstName: null == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String,
            lastName: null == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ManagerDtoModelImplCopyWith<$Res>
    implements $ManagerDtoModelCopyWith<$Res> {
  factory _$$ManagerDtoModelImplCopyWith(
    _$ManagerDtoModelImpl value,
    $Res Function(_$ManagerDtoModelImpl) then,
  ) = __$$ManagerDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'first_name') String firstName,
    @JsonKey(name: 'last_name') String lastName,
  });
}

/// @nodoc
class __$$ManagerDtoModelImplCopyWithImpl<$Res>
    extends _$ManagerDtoModelCopyWithImpl<$Res, _$ManagerDtoModelImpl>
    implements _$$ManagerDtoModelImplCopyWith<$Res> {
  __$$ManagerDtoModelImplCopyWithImpl(
    _$ManagerDtoModelImpl _value,
    $Res Function(_$ManagerDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ManagerDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
  }) {
    return _then(
      _$ManagerDtoModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        firstName: null == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String,
        lastName: null == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ManagerDtoModelImpl implements _ManagerDtoModel {
  const _$ManagerDtoModelImpl({
    required this.id,
    @JsonKey(name: 'first_name') required this.firstName,
    @JsonKey(name: 'last_name') required this.lastName,
  });

  factory _$ManagerDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ManagerDtoModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'first_name')
  final String firstName;
  @override
  @JsonKey(name: 'last_name')
  final String lastName;

  @override
  String toString() {
    return 'ManagerDtoModel(id: $id, firstName: $firstName, lastName: $lastName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ManagerDtoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, firstName, lastName);

  /// Create a copy of ManagerDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ManagerDtoModelImplCopyWith<_$ManagerDtoModelImpl> get copyWith =>
      __$$ManagerDtoModelImplCopyWithImpl<_$ManagerDtoModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ManagerDtoModelImplToJson(this);
  }
}

abstract class _ManagerDtoModel implements ManagerDtoModel {
  const factory _ManagerDtoModel({
    required final String id,
    @JsonKey(name: 'first_name') required final String firstName,
    @JsonKey(name: 'last_name') required final String lastName,
  }) = _$ManagerDtoModelImpl;

  factory _ManagerDtoModel.fromJson(Map<String, dynamic> json) =
      _$ManagerDtoModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'first_name')
  String get firstName;
  @override
  @JsonKey(name: 'last_name')
  String get lastName;

  /// Create a copy of ManagerDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ManagerDtoModelImplCopyWith<_$ManagerDtoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
