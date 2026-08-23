// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_dto_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CategoryListResponse _$CategoryListResponseFromJson(Map<String, dynamic> json) {
  return _CategoryListResponse.fromJson(json);
}

/// @nodoc
mixin _$CategoryListResponse {
  int get count => throw _privateConstructorUsedError;
  String? get next => throw _privateConstructorUsedError;
  String? get previous => throw _privateConstructorUsedError;
  List<CategoryDtoModel> get results => throw _privateConstructorUsedError;

  /// Serializes this CategoryListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CategoryListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CategoryListResponseCopyWith<CategoryListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryListResponseCopyWith<$Res> {
  factory $CategoryListResponseCopyWith(
    CategoryListResponse value,
    $Res Function(CategoryListResponse) then,
  ) = _$CategoryListResponseCopyWithImpl<$Res, CategoryListResponse>;
  @useResult
  $Res call({
    int count,
    String? next,
    String? previous,
    List<CategoryDtoModel> results,
  });
}

/// @nodoc
class _$CategoryListResponseCopyWithImpl<
  $Res,
  $Val extends CategoryListResponse
>
    implements $CategoryListResponseCopyWith<$Res> {
  _$CategoryListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CategoryListResponse
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
                      as List<CategoryDtoModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CategoryListResponseImplCopyWith<$Res>
    implements $CategoryListResponseCopyWith<$Res> {
  factory _$$CategoryListResponseImplCopyWith(
    _$CategoryListResponseImpl value,
    $Res Function(_$CategoryListResponseImpl) then,
  ) = __$$CategoryListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int count,
    String? next,
    String? previous,
    List<CategoryDtoModel> results,
  });
}

/// @nodoc
class __$$CategoryListResponseImplCopyWithImpl<$Res>
    extends _$CategoryListResponseCopyWithImpl<$Res, _$CategoryListResponseImpl>
    implements _$$CategoryListResponseImplCopyWith<$Res> {
  __$$CategoryListResponseImplCopyWithImpl(
    _$CategoryListResponseImpl _value,
    $Res Function(_$CategoryListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CategoryListResponse
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
      _$CategoryListResponseImpl(
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
                  as List<CategoryDtoModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CategoryListResponseImpl implements _CategoryListResponse {
  const _$CategoryListResponseImpl({
    required this.count,
    this.next,
    this.previous,
    required final List<CategoryDtoModel> results,
  }) : _results = results;

  factory _$CategoryListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CategoryListResponseImplFromJson(json);

  @override
  final int count;
  @override
  final String? next;
  @override
  final String? previous;
  final List<CategoryDtoModel> _results;
  @override
  List<CategoryDtoModel> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  String toString() {
    return 'CategoryListResponse(count: $count, next: $next, previous: $previous, results: $results)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryListResponseImpl &&
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

  /// Create a copy of CategoryListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryListResponseImplCopyWith<_$CategoryListResponseImpl>
  get copyWith =>
      __$$CategoryListResponseImplCopyWithImpl<_$CategoryListResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CategoryListResponseImplToJson(this);
  }
}

abstract class _CategoryListResponse implements CategoryListResponse {
  const factory _CategoryListResponse({
    required final int count,
    final String? next,
    final String? previous,
    required final List<CategoryDtoModel> results,
  }) = _$CategoryListResponseImpl;

  factory _CategoryListResponse.fromJson(Map<String, dynamic> json) =
      _$CategoryListResponseImpl.fromJson;

  @override
  int get count;
  @override
  String? get next;
  @override
  String? get previous;
  @override
  List<CategoryDtoModel> get results;

  /// Create a copy of CategoryListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategoryListResponseImplCopyWith<_$CategoryListResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

CategoryDtoModel _$CategoryDtoModelFromJson(Map<String, dynamic> json) {
  return _CategoryDtoModel.fromJson(json);
}

/// @nodoc
mixin _$CategoryDtoModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  ParentCategoryDtoModel? get parent => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'direct_products_count')
  int get directProductsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_products_count')
  int get totalProductsCount => throw _privateConstructorUsedError;

  /// Serializes this CategoryDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CategoryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CategoryDtoModelCopyWith<CategoryDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryDtoModelCopyWith<$Res> {
  factory $CategoryDtoModelCopyWith(
    CategoryDtoModel value,
    $Res Function(CategoryDtoModel) then,
  ) = _$CategoryDtoModelCopyWithImpl<$Res, CategoryDtoModel>;
  @useResult
  $Res call({
    String id,
    String name,
    String? color,
    ParentCategoryDtoModel? parent,
    int order,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'direct_products_count') int directProductsCount,
    @JsonKey(name: 'total_products_count') int totalProductsCount,
  });

  $ParentCategoryDtoModelCopyWith<$Res>? get parent;
}

/// @nodoc
class _$CategoryDtoModelCopyWithImpl<$Res, $Val extends CategoryDtoModel>
    implements $CategoryDtoModelCopyWith<$Res> {
  _$CategoryDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CategoryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? color = freezed,
    Object? parent = freezed,
    Object? order = null,
    Object? isActive = null,
    Object? directProductsCount = null,
    Object? totalProductsCount = null,
  }) {
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
            color: freezed == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as String?,
            parent: freezed == parent
                ? _value.parent
                : parent // ignore: cast_nullable_to_non_nullable
                      as ParentCategoryDtoModel?,
            order: null == order
                ? _value.order
                : order // ignore: cast_nullable_to_non_nullable
                      as int,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            directProductsCount: null == directProductsCount
                ? _value.directProductsCount
                : directProductsCount // ignore: cast_nullable_to_non_nullable
                      as int,
            totalProductsCount: null == totalProductsCount
                ? _value.totalProductsCount
                : totalProductsCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }

  /// Create a copy of CategoryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ParentCategoryDtoModelCopyWith<$Res>? get parent {
    if (_value.parent == null) {
      return null;
    }

    return $ParentCategoryDtoModelCopyWith<$Res>(_value.parent!, (value) {
      return _then(_value.copyWith(parent: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CategoryDtoModelImplCopyWith<$Res>
    implements $CategoryDtoModelCopyWith<$Res> {
  factory _$$CategoryDtoModelImplCopyWith(
    _$CategoryDtoModelImpl value,
    $Res Function(_$CategoryDtoModelImpl) then,
  ) = __$$CategoryDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? color,
    ParentCategoryDtoModel? parent,
    int order,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'direct_products_count') int directProductsCount,
    @JsonKey(name: 'total_products_count') int totalProductsCount,
  });

  @override
  $ParentCategoryDtoModelCopyWith<$Res>? get parent;
}

/// @nodoc
class __$$CategoryDtoModelImplCopyWithImpl<$Res>
    extends _$CategoryDtoModelCopyWithImpl<$Res, _$CategoryDtoModelImpl>
    implements _$$CategoryDtoModelImplCopyWith<$Res> {
  __$$CategoryDtoModelImplCopyWithImpl(
    _$CategoryDtoModelImpl _value,
    $Res Function(_$CategoryDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CategoryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? color = freezed,
    Object? parent = freezed,
    Object? order = null,
    Object? isActive = null,
    Object? directProductsCount = null,
    Object? totalProductsCount = null,
  }) {
    return _then(
      _$CategoryDtoModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        color: freezed == color
            ? _value.color
            : color // ignore: cast_nullable_to_non_nullable
                  as String?,
        parent: freezed == parent
            ? _value.parent
            : parent // ignore: cast_nullable_to_non_nullable
                  as ParentCategoryDtoModel?,
        order: null == order
            ? _value.order
            : order // ignore: cast_nullable_to_non_nullable
                  as int,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        directProductsCount: null == directProductsCount
            ? _value.directProductsCount
            : directProductsCount // ignore: cast_nullable_to_non_nullable
                  as int,
        totalProductsCount: null == totalProductsCount
            ? _value.totalProductsCount
            : totalProductsCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CategoryDtoModelImpl implements _CategoryDtoModel {
  const _$CategoryDtoModelImpl({
    required this.id,
    required this.name,
    this.color,
    this.parent,
    required this.order,
    @JsonKey(name: 'is_active') required this.isActive,
    @JsonKey(name: 'direct_products_count') required this.directProductsCount,
    @JsonKey(name: 'total_products_count') required this.totalProductsCount,
  });

  factory _$CategoryDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CategoryDtoModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? color;
  @override
  final ParentCategoryDtoModel? parent;
  @override
  final int order;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'direct_products_count')
  final int directProductsCount;
  @override
  @JsonKey(name: 'total_products_count')
  final int totalProductsCount;

  @override
  String toString() {
    return 'CategoryDtoModel(id: $id, name: $name, color: $color, parent: $parent, order: $order, isActive: $isActive, directProductsCount: $directProductsCount, totalProductsCount: $totalProductsCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryDtoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.parent, parent) || other.parent == parent) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.directProductsCount, directProductsCount) ||
                other.directProductsCount == directProductsCount) &&
            (identical(other.totalProductsCount, totalProductsCount) ||
                other.totalProductsCount == totalProductsCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    color,
    parent,
    order,
    isActive,
    directProductsCount,
    totalProductsCount,
  );

  /// Create a copy of CategoryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryDtoModelImplCopyWith<_$CategoryDtoModelImpl> get copyWith =>
      __$$CategoryDtoModelImplCopyWithImpl<_$CategoryDtoModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CategoryDtoModelImplToJson(this);
  }
}

abstract class _CategoryDtoModel implements CategoryDtoModel {
  const factory _CategoryDtoModel({
    required final String id,
    required final String name,
    final String? color,
    final ParentCategoryDtoModel? parent,
    required final int order,
    @JsonKey(name: 'is_active') required final bool isActive,
    @JsonKey(name: 'direct_products_count')
    required final int directProductsCount,
    @JsonKey(name: 'total_products_count')
    required final int totalProductsCount,
  }) = _$CategoryDtoModelImpl;

  factory _CategoryDtoModel.fromJson(Map<String, dynamic> json) =
      _$CategoryDtoModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get color;
  @override
  ParentCategoryDtoModel? get parent;
  @override
  int get order;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(name: 'direct_products_count')
  int get directProductsCount;
  @override
  @JsonKey(name: 'total_products_count')
  int get totalProductsCount;

  /// Create a copy of CategoryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategoryDtoModelImplCopyWith<_$CategoryDtoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ParentCategoryDtoModel _$ParentCategoryDtoModelFromJson(
  Map<String, dynamic> json,
) {
  return _ParentCategoryDtoModel.fromJson(json);
}

/// @nodoc
mixin _$ParentCategoryDtoModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this ParentCategoryDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ParentCategoryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ParentCategoryDtoModelCopyWith<ParentCategoryDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParentCategoryDtoModelCopyWith<$Res> {
  factory $ParentCategoryDtoModelCopyWith(
    ParentCategoryDtoModel value,
    $Res Function(ParentCategoryDtoModel) then,
  ) = _$ParentCategoryDtoModelCopyWithImpl<$Res, ParentCategoryDtoModel>;
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class _$ParentCategoryDtoModelCopyWithImpl<
  $Res,
  $Val extends ParentCategoryDtoModel
>
    implements $ParentCategoryDtoModelCopyWith<$Res> {
  _$ParentCategoryDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ParentCategoryDtoModel
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
abstract class _$$ParentCategoryDtoModelImplCopyWith<$Res>
    implements $ParentCategoryDtoModelCopyWith<$Res> {
  factory _$$ParentCategoryDtoModelImplCopyWith(
    _$ParentCategoryDtoModelImpl value,
    $Res Function(_$ParentCategoryDtoModelImpl) then,
  ) = __$$ParentCategoryDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class __$$ParentCategoryDtoModelImplCopyWithImpl<$Res>
    extends
        _$ParentCategoryDtoModelCopyWithImpl<$Res, _$ParentCategoryDtoModelImpl>
    implements _$$ParentCategoryDtoModelImplCopyWith<$Res> {
  __$$ParentCategoryDtoModelImplCopyWithImpl(
    _$ParentCategoryDtoModelImpl _value,
    $Res Function(_$ParentCategoryDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ParentCategoryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _$ParentCategoryDtoModelImpl(
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
class _$ParentCategoryDtoModelImpl implements _ParentCategoryDtoModel {
  const _$ParentCategoryDtoModelImpl({required this.id, required this.name});

  factory _$ParentCategoryDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParentCategoryDtoModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;

  @override
  String toString() {
    return 'ParentCategoryDtoModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParentCategoryDtoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of ParentCategoryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ParentCategoryDtoModelImplCopyWith<_$ParentCategoryDtoModelImpl>
  get copyWith =>
      __$$ParentCategoryDtoModelImplCopyWithImpl<_$ParentCategoryDtoModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ParentCategoryDtoModelImplToJson(this);
  }
}

abstract class _ParentCategoryDtoModel implements ParentCategoryDtoModel {
  const factory _ParentCategoryDtoModel({
    required final String id,
    required final String name,
  }) = _$ParentCategoryDtoModelImpl;

  factory _ParentCategoryDtoModel.fromJson(Map<String, dynamic> json) =
      _$ParentCategoryDtoModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;

  /// Create a copy of ParentCategoryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ParentCategoryDtoModelImplCopyWith<_$ParentCategoryDtoModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
