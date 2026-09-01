// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_dto_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CustomerListResponse _$CustomerListResponseFromJson(Map<String, dynamic> json) {
  return _CustomerListResponse.fromJson(json);
}

/// @nodoc
mixin _$CustomerListResponse {
  int get count => throw _privateConstructorUsedError;
  String? get next => throw _privateConstructorUsedError;
  String? get previous => throw _privateConstructorUsedError;
  List<CustomerDtoModel> get results => throw _privateConstructorUsedError;

  /// Serializes this CustomerListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CustomerListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomerListResponseCopyWith<CustomerListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerListResponseCopyWith<$Res> {
  factory $CustomerListResponseCopyWith(
    CustomerListResponse value,
    $Res Function(CustomerListResponse) then,
  ) = _$CustomerListResponseCopyWithImpl<$Res, CustomerListResponse>;
  @useResult
  $Res call({
    int count,
    String? next,
    String? previous,
    List<CustomerDtoModel> results,
  });
}

/// @nodoc
class _$CustomerListResponseCopyWithImpl<
  $Res,
  $Val extends CustomerListResponse
>
    implements $CustomerListResponseCopyWith<$Res> {
  _$CustomerListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomerListResponse
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
                      as List<CustomerDtoModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CustomerListResponseImplCopyWith<$Res>
    implements $CustomerListResponseCopyWith<$Res> {
  factory _$$CustomerListResponseImplCopyWith(
    _$CustomerListResponseImpl value,
    $Res Function(_$CustomerListResponseImpl) then,
  ) = __$$CustomerListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int count,
    String? next,
    String? previous,
    List<CustomerDtoModel> results,
  });
}

/// @nodoc
class __$$CustomerListResponseImplCopyWithImpl<$Res>
    extends _$CustomerListResponseCopyWithImpl<$Res, _$CustomerListResponseImpl>
    implements _$$CustomerListResponseImplCopyWith<$Res> {
  __$$CustomerListResponseImplCopyWithImpl(
    _$CustomerListResponseImpl _value,
    $Res Function(_$CustomerListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CustomerListResponse
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
      _$CustomerListResponseImpl(
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
                  as List<CustomerDtoModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomerListResponseImpl implements _CustomerListResponse {
  const _$CustomerListResponseImpl({
    required this.count,
    this.next,
    this.previous,
    required final List<CustomerDtoModel> results,
  }) : _results = results;

  factory _$CustomerListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerListResponseImplFromJson(json);

  @override
  final int count;
  @override
  final String? next;
  @override
  final String? previous;
  final List<CustomerDtoModel> _results;
  @override
  List<CustomerDtoModel> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  String toString() {
    return 'CustomerListResponse(count: $count, next: $next, previous: $previous, results: $results)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerListResponseImpl &&
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

  /// Create a copy of CustomerListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerListResponseImplCopyWith<_$CustomerListResponseImpl>
  get copyWith =>
      __$$CustomerListResponseImplCopyWithImpl<_$CustomerListResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerListResponseImplToJson(this);
  }
}

abstract class _CustomerListResponse implements CustomerListResponse {
  const factory _CustomerListResponse({
    required final int count,
    final String? next,
    final String? previous,
    required final List<CustomerDtoModel> results,
  }) = _$CustomerListResponseImpl;

  factory _CustomerListResponse.fromJson(Map<String, dynamic> json) =
      _$CustomerListResponseImpl.fromJson;

  @override
  int get count;
  @override
  String? get next;
  @override
  String? get previous;
  @override
  List<CustomerDtoModel> get results;

  /// Create a copy of CustomerListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomerListResponseImplCopyWith<_$CustomerListResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

CustomerDtoModel _$CustomerDtoModelFromJson(Map<String, dynamic> json) {
  return _CustomerDtoModel.fromJson(json);
}

/// @nodoc
mixin _$CustomerDtoModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'national_id')
  String get nationalId => throw _privateConstructorUsedError;
  @JsonKey(name: 'first_name')
  String get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_name')
  String get lastName => throw _privateConstructorUsedError;
  String get mobile => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  @JsonKey(name: 'postal_code')
  String get postalCode => throw _privateConstructorUsedError;

  /// Serializes this CustomerDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CustomerDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomerDtoModelCopyWith<CustomerDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerDtoModelCopyWith<$Res> {
  factory $CustomerDtoModelCopyWith(
    CustomerDtoModel value,
    $Res Function(CustomerDtoModel) then,
  ) = _$CustomerDtoModelCopyWithImpl<$Res, CustomerDtoModel>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'national_id') String nationalId,
    @JsonKey(name: 'first_name') String firstName,
    @JsonKey(name: 'last_name') String lastName,
    String mobile,
    String address,
    @JsonKey(name: 'postal_code') String postalCode,
  });
}

/// @nodoc
class _$CustomerDtoModelCopyWithImpl<$Res, $Val extends CustomerDtoModel>
    implements $CustomerDtoModelCopyWith<$Res> {
  _$CustomerDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomerDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nationalId = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? mobile = null,
    Object? address = null,
    Object? postalCode = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            nationalId: null == nationalId
                ? _value.nationalId
                : nationalId // ignore: cast_nullable_to_non_nullable
                      as String,
            firstName: null == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String,
            lastName: null == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                      as String,
            mobile: null == mobile
                ? _value.mobile
                : mobile // ignore: cast_nullable_to_non_nullable
                      as String,
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            postalCode: null == postalCode
                ? _value.postalCode
                : postalCode // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CustomerDtoModelImplCopyWith<$Res>
    implements $CustomerDtoModelCopyWith<$Res> {
  factory _$$CustomerDtoModelImplCopyWith(
    _$CustomerDtoModelImpl value,
    $Res Function(_$CustomerDtoModelImpl) then,
  ) = __$$CustomerDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'national_id') String nationalId,
    @JsonKey(name: 'first_name') String firstName,
    @JsonKey(name: 'last_name') String lastName,
    String mobile,
    String address,
    @JsonKey(name: 'postal_code') String postalCode,
  });
}

/// @nodoc
class __$$CustomerDtoModelImplCopyWithImpl<$Res>
    extends _$CustomerDtoModelCopyWithImpl<$Res, _$CustomerDtoModelImpl>
    implements _$$CustomerDtoModelImplCopyWith<$Res> {
  __$$CustomerDtoModelImplCopyWithImpl(
    _$CustomerDtoModelImpl _value,
    $Res Function(_$CustomerDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CustomerDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nationalId = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? mobile = null,
    Object? address = null,
    Object? postalCode = null,
  }) {
    return _then(
      _$CustomerDtoModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        nationalId: null == nationalId
            ? _value.nationalId
            : nationalId // ignore: cast_nullable_to_non_nullable
                  as String,
        firstName: null == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String,
        lastName: null == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String,
        mobile: null == mobile
            ? _value.mobile
            : mobile // ignore: cast_nullable_to_non_nullable
                  as String,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        postalCode: null == postalCode
            ? _value.postalCode
            : postalCode // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomerDtoModelImpl implements _CustomerDtoModel {
  const _$CustomerDtoModelImpl({
    required this.id,
    @JsonKey(name: 'national_id') required this.nationalId,
    @JsonKey(name: 'first_name') required this.firstName,
    @JsonKey(name: 'last_name') required this.lastName,
    required this.mobile,
    required this.address,
    @JsonKey(name: 'postal_code') required this.postalCode,
  });

  factory _$CustomerDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerDtoModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'national_id')
  final String nationalId;
  @override
  @JsonKey(name: 'first_name')
  final String firstName;
  @override
  @JsonKey(name: 'last_name')
  final String lastName;
  @override
  final String mobile;
  @override
  final String address;
  @override
  @JsonKey(name: 'postal_code')
  final String postalCode;

  @override
  String toString() {
    return 'CustomerDtoModel(id: $id, nationalId: $nationalId, firstName: $firstName, lastName: $lastName, mobile: $mobile, address: $address, postalCode: $postalCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerDtoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nationalId, nationalId) ||
                other.nationalId == nationalId) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.mobile, mobile) || other.mobile == mobile) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.postalCode, postalCode) ||
                other.postalCode == postalCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    nationalId,
    firstName,
    lastName,
    mobile,
    address,
    postalCode,
  );

  /// Create a copy of CustomerDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerDtoModelImplCopyWith<_$CustomerDtoModelImpl> get copyWith =>
      __$$CustomerDtoModelImplCopyWithImpl<_$CustomerDtoModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerDtoModelImplToJson(this);
  }
}

abstract class _CustomerDtoModel implements CustomerDtoModel {
  const factory _CustomerDtoModel({
    required final String id,
    @JsonKey(name: 'national_id') required final String nationalId,
    @JsonKey(name: 'first_name') required final String firstName,
    @JsonKey(name: 'last_name') required final String lastName,
    required final String mobile,
    required final String address,
    @JsonKey(name: 'postal_code') required final String postalCode,
  }) = _$CustomerDtoModelImpl;

  factory _CustomerDtoModel.fromJson(Map<String, dynamic> json) =
      _$CustomerDtoModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'national_id')
  String get nationalId;
  @override
  @JsonKey(name: 'first_name')
  String get firstName;
  @override
  @JsonKey(name: 'last_name')
  String get lastName;
  @override
  String get mobile;
  @override
  String get address;
  @override
  @JsonKey(name: 'postal_code')
  String get postalCode;

  /// Create a copy of CustomerDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomerDtoModelImplCopyWith<_$CustomerDtoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
