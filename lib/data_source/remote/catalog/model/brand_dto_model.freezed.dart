// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'brand_dto_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BrandListResponse _$BrandListResponseFromJson(Map<String, dynamic> json) {
  return _BrandListResponse.fromJson(json);
}

/// @nodoc
mixin _$BrandListResponse {
  int get count => throw _privateConstructorUsedError;
  String? get next => throw _privateConstructorUsedError;
  String? get previous => throw _privateConstructorUsedError;
  List<BrandDtoModel> get results => throw _privateConstructorUsedError;

  /// Serializes this BrandListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BrandListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BrandListResponseCopyWith<BrandListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrandListResponseCopyWith<$Res> {
  factory $BrandListResponseCopyWith(
    BrandListResponse value,
    $Res Function(BrandListResponse) then,
  ) = _$BrandListResponseCopyWithImpl<$Res, BrandListResponse>;
  @useResult
  $Res call({
    int count,
    String? next,
    String? previous,
    List<BrandDtoModel> results,
  });
}

/// @nodoc
class _$BrandListResponseCopyWithImpl<$Res, $Val extends BrandListResponse>
    implements $BrandListResponseCopyWith<$Res> {
  _$BrandListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BrandListResponse
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
                      as List<BrandDtoModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BrandListResponseImplCopyWith<$Res>
    implements $BrandListResponseCopyWith<$Res> {
  factory _$$BrandListResponseImplCopyWith(
    _$BrandListResponseImpl value,
    $Res Function(_$BrandListResponseImpl) then,
  ) = __$$BrandListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int count,
    String? next,
    String? previous,
    List<BrandDtoModel> results,
  });
}

/// @nodoc
class __$$BrandListResponseImplCopyWithImpl<$Res>
    extends _$BrandListResponseCopyWithImpl<$Res, _$BrandListResponseImpl>
    implements _$$BrandListResponseImplCopyWith<$Res> {
  __$$BrandListResponseImplCopyWithImpl(
    _$BrandListResponseImpl _value,
    $Res Function(_$BrandListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BrandListResponse
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
      _$BrandListResponseImpl(
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
                  as List<BrandDtoModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BrandListResponseImpl implements _BrandListResponse {
  const _$BrandListResponseImpl({
    required this.count,
    this.next,
    this.previous,
    required final List<BrandDtoModel> results,
  }) : _results = results;

  factory _$BrandListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$BrandListResponseImplFromJson(json);

  @override
  final int count;
  @override
  final String? next;
  @override
  final String? previous;
  final List<BrandDtoModel> _results;
  @override
  List<BrandDtoModel> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  String toString() {
    return 'BrandListResponse(count: $count, next: $next, previous: $previous, results: $results)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BrandListResponseImpl &&
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

  /// Create a copy of BrandListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BrandListResponseImplCopyWith<_$BrandListResponseImpl> get copyWith =>
      __$$BrandListResponseImplCopyWithImpl<_$BrandListResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BrandListResponseImplToJson(this);
  }
}

abstract class _BrandListResponse implements BrandListResponse {
  const factory _BrandListResponse({
    required final int count,
    final String? next,
    final String? previous,
    required final List<BrandDtoModel> results,
  }) = _$BrandListResponseImpl;

  factory _BrandListResponse.fromJson(Map<String, dynamic> json) =
      _$BrandListResponseImpl.fromJson;

  @override
  int get count;
  @override
  String? get next;
  @override
  String? get previous;
  @override
  List<BrandDtoModel> get results;

  /// Create a copy of BrandListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BrandListResponseImplCopyWith<_$BrandListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BrandDtoModel _$BrandDtoModelFromJson(Map<String, dynamic> json) {
  return _BrandDtoModel.fromJson(json);
}

/// @nodoc
mixin _$BrandDtoModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this BrandDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BrandDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BrandDtoModelCopyWith<BrandDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrandDtoModelCopyWith<$Res> {
  factory $BrandDtoModelCopyWith(
    BrandDtoModel value,
    $Res Function(BrandDtoModel) then,
  ) = _$BrandDtoModelCopyWithImpl<$Res, BrandDtoModel>;
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class _$BrandDtoModelCopyWithImpl<$Res, $Val extends BrandDtoModel>
    implements $BrandDtoModelCopyWith<$Res> {
  _$BrandDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BrandDtoModel
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
abstract class _$$BrandDtoModelImplCopyWith<$Res>
    implements $BrandDtoModelCopyWith<$Res> {
  factory _$$BrandDtoModelImplCopyWith(
    _$BrandDtoModelImpl value,
    $Res Function(_$BrandDtoModelImpl) then,
  ) = __$$BrandDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class __$$BrandDtoModelImplCopyWithImpl<$Res>
    extends _$BrandDtoModelCopyWithImpl<$Res, _$BrandDtoModelImpl>
    implements _$$BrandDtoModelImplCopyWith<$Res> {
  __$$BrandDtoModelImplCopyWithImpl(
    _$BrandDtoModelImpl _value,
    $Res Function(_$BrandDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BrandDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _$BrandDtoModelImpl(
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
class _$BrandDtoModelImpl implements _BrandDtoModel {
  const _$BrandDtoModelImpl({required this.id, required this.name});

  factory _$BrandDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BrandDtoModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;

  @override
  String toString() {
    return 'BrandDtoModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BrandDtoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of BrandDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BrandDtoModelImplCopyWith<_$BrandDtoModelImpl> get copyWith =>
      __$$BrandDtoModelImplCopyWithImpl<_$BrandDtoModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BrandDtoModelImplToJson(this);
  }
}

abstract class _BrandDtoModel implements BrandDtoModel {
  const factory _BrandDtoModel({
    required final String id,
    required final String name,
  }) = _$BrandDtoModelImpl;

  factory _BrandDtoModel.fromJson(Map<String, dynamic> json) =
      _$BrandDtoModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;

  /// Create a copy of BrandDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BrandDtoModelImplCopyWith<_$BrandDtoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
