// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'media_dto_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MediaDtoModel _$MediaDtoModelFromJson(Map<String, dynamic> json) {
  return _MediaDtoModel.fromJson(json);
}

/// @nodoc
mixin _$MediaDtoModel {
  String get id => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  @JsonKey(name: 'original_name')
  String get originalName => throw _privateConstructorUsedError;
  @JsonKey(name: 'mime_type')
  String get mimeType => throw _privateConstructorUsedError;
  @JsonKey(name: 'size_bytes')
  int get sizeBytes => throw _privateConstructorUsedError;
  @JsonKey(name: 'uploaded_by_id')
  String? get uploadedById => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_deleted')
  bool get isDeleted => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;

  /// Serializes this MediaDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MediaDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MediaDtoModelCopyWith<MediaDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MediaDtoModelCopyWith<$Res> {
  factory $MediaDtoModelCopyWith(
    MediaDtoModel value,
    $Res Function(MediaDtoModel) then,
  ) = _$MediaDtoModelCopyWithImpl<$Res, MediaDtoModel>;
  @useResult
  $Res call({
    String id,
    String category,
    @JsonKey(name: 'original_name') String originalName,
    @JsonKey(name: 'mime_type') String mimeType,
    @JsonKey(name: 'size_bytes') int sizeBytes,
    @JsonKey(name: 'uploaded_by_id') String? uploadedById,
    @JsonKey(name: 'is_deleted') bool isDeleted,
    @JsonKey(name: 'created_at') String createdAt,
  });
}

/// @nodoc
class _$MediaDtoModelCopyWithImpl<$Res, $Val extends MediaDtoModel>
    implements $MediaDtoModelCopyWith<$Res> {
  _$MediaDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MediaDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? category = null,
    Object? originalName = null,
    Object? mimeType = null,
    Object? sizeBytes = null,
    Object? uploadedById = freezed,
    Object? isDeleted = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            originalName: null == originalName
                ? _value.originalName
                : originalName // ignore: cast_nullable_to_non_nullable
                      as String,
            mimeType: null == mimeType
                ? _value.mimeType
                : mimeType // ignore: cast_nullable_to_non_nullable
                      as String,
            sizeBytes: null == sizeBytes
                ? _value.sizeBytes
                : sizeBytes // ignore: cast_nullable_to_non_nullable
                      as int,
            uploadedById: freezed == uploadedById
                ? _value.uploadedById
                : uploadedById // ignore: cast_nullable_to_non_nullable
                      as String?,
            isDeleted: null == isDeleted
                ? _value.isDeleted
                : isDeleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MediaDtoModelImplCopyWith<$Res>
    implements $MediaDtoModelCopyWith<$Res> {
  factory _$$MediaDtoModelImplCopyWith(
    _$MediaDtoModelImpl value,
    $Res Function(_$MediaDtoModelImpl) then,
  ) = __$$MediaDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String category,
    @JsonKey(name: 'original_name') String originalName,
    @JsonKey(name: 'mime_type') String mimeType,
    @JsonKey(name: 'size_bytes') int sizeBytes,
    @JsonKey(name: 'uploaded_by_id') String? uploadedById,
    @JsonKey(name: 'is_deleted') bool isDeleted,
    @JsonKey(name: 'created_at') String createdAt,
  });
}

/// @nodoc
class __$$MediaDtoModelImplCopyWithImpl<$Res>
    extends _$MediaDtoModelCopyWithImpl<$Res, _$MediaDtoModelImpl>
    implements _$$MediaDtoModelImplCopyWith<$Res> {
  __$$MediaDtoModelImplCopyWithImpl(
    _$MediaDtoModelImpl _value,
    $Res Function(_$MediaDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MediaDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? category = null,
    Object? originalName = null,
    Object? mimeType = null,
    Object? sizeBytes = null,
    Object? uploadedById = freezed,
    Object? isDeleted = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$MediaDtoModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        originalName: null == originalName
            ? _value.originalName
            : originalName // ignore: cast_nullable_to_non_nullable
                  as String,
        mimeType: null == mimeType
            ? _value.mimeType
            : mimeType // ignore: cast_nullable_to_non_nullable
                  as String,
        sizeBytes: null == sizeBytes
            ? _value.sizeBytes
            : sizeBytes // ignore: cast_nullable_to_non_nullable
                  as int,
        uploadedById: freezed == uploadedById
            ? _value.uploadedById
            : uploadedById // ignore: cast_nullable_to_non_nullable
                  as String?,
        isDeleted: null == isDeleted
            ? _value.isDeleted
            : isDeleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MediaDtoModelImpl implements _MediaDtoModel {
  const _$MediaDtoModelImpl({
    required this.id,
    required this.category,
    @JsonKey(name: 'original_name') required this.originalName,
    @JsonKey(name: 'mime_type') required this.mimeType,
    @JsonKey(name: 'size_bytes') required this.sizeBytes,
    @JsonKey(name: 'uploaded_by_id') this.uploadedById,
    @JsonKey(name: 'is_deleted') required this.isDeleted,
    @JsonKey(name: 'created_at') required this.createdAt,
  });

  factory _$MediaDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MediaDtoModelImplFromJson(json);

  @override
  final String id;
  @override
  final String category;
  @override
  @JsonKey(name: 'original_name')
  final String originalName;
  @override
  @JsonKey(name: 'mime_type')
  final String mimeType;
  @override
  @JsonKey(name: 'size_bytes')
  final int sizeBytes;
  @override
  @JsonKey(name: 'uploaded_by_id')
  final String? uploadedById;
  @override
  @JsonKey(name: 'is_deleted')
  final bool isDeleted;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;

  @override
  String toString() {
    return 'MediaDtoModel(id: $id, category: $category, originalName: $originalName, mimeType: $mimeType, sizeBytes: $sizeBytes, uploadedById: $uploadedById, isDeleted: $isDeleted, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MediaDtoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.originalName, originalName) ||
                other.originalName == originalName) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType) &&
            (identical(other.sizeBytes, sizeBytes) ||
                other.sizeBytes == sizeBytes) &&
            (identical(other.uploadedById, uploadedById) ||
                other.uploadedById == uploadedById) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    category,
    originalName,
    mimeType,
    sizeBytes,
    uploadedById,
    isDeleted,
    createdAt,
  );

  /// Create a copy of MediaDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MediaDtoModelImplCopyWith<_$MediaDtoModelImpl> get copyWith =>
      __$$MediaDtoModelImplCopyWithImpl<_$MediaDtoModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MediaDtoModelImplToJson(this);
  }
}

abstract class _MediaDtoModel implements MediaDtoModel {
  const factory _MediaDtoModel({
    required final String id,
    required final String category,
    @JsonKey(name: 'original_name') required final String originalName,
    @JsonKey(name: 'mime_type') required final String mimeType,
    @JsonKey(name: 'size_bytes') required final int sizeBytes,
    @JsonKey(name: 'uploaded_by_id') final String? uploadedById,
    @JsonKey(name: 'is_deleted') required final bool isDeleted,
    @JsonKey(name: 'created_at') required final String createdAt,
  }) = _$MediaDtoModelImpl;

  factory _MediaDtoModel.fromJson(Map<String, dynamic> json) =
      _$MediaDtoModelImpl.fromJson;

  @override
  String get id;
  @override
  String get category;
  @override
  @JsonKey(name: 'original_name')
  String get originalName;
  @override
  @JsonKey(name: 'mime_type')
  String get mimeType;
  @override
  @JsonKey(name: 'size_bytes')
  int get sizeBytes;
  @override
  @JsonKey(name: 'uploaded_by_id')
  String? get uploadedById;
  @override
  @JsonKey(name: 'is_deleted')
  bool get isDeleted;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;

  /// Create a copy of MediaDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MediaDtoModelImplCopyWith<_$MediaDtoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
