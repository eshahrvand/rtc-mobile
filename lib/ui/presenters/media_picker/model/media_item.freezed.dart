// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'media_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MediaItem {
  XFile get xFile => throw _privateConstructorUsedError;
  MediaType get type => throw _privateConstructorUsedError;
  Uint8List? get thumbnail => throw _privateConstructorUsedError;
  String? get assetId => throw _privateConstructorUsedError;
  String? get fileName => throw _privateConstructorUsedError;

  /// Create a copy of MediaItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MediaItemCopyWith<MediaItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MediaItemCopyWith<$Res> {
  factory $MediaItemCopyWith(MediaItem value, $Res Function(MediaItem) then) =
      _$MediaItemCopyWithImpl<$Res, MediaItem>;
  @useResult
  $Res call({
    XFile xFile,
    MediaType type,
    Uint8List? thumbnail,
    String? assetId,
    String? fileName,
  });
}

/// @nodoc
class _$MediaItemCopyWithImpl<$Res, $Val extends MediaItem>
    implements $MediaItemCopyWith<$Res> {
  _$MediaItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MediaItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? xFile = null,
    Object? type = null,
    Object? thumbnail = freezed,
    Object? assetId = freezed,
    Object? fileName = freezed,
  }) {
    return _then(
      _value.copyWith(
            xFile: null == xFile
                ? _value.xFile
                : xFile // ignore: cast_nullable_to_non_nullable
                      as XFile,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as MediaType,
            thumbnail: freezed == thumbnail
                ? _value.thumbnail
                : thumbnail // ignore: cast_nullable_to_non_nullable
                      as Uint8List?,
            assetId: freezed == assetId
                ? _value.assetId
                : assetId // ignore: cast_nullable_to_non_nullable
                      as String?,
            fileName: freezed == fileName
                ? _value.fileName
                : fileName // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MediaItemImplCopyWith<$Res>
    implements $MediaItemCopyWith<$Res> {
  factory _$$MediaItemImplCopyWith(
    _$MediaItemImpl value,
    $Res Function(_$MediaItemImpl) then,
  ) = __$$MediaItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    XFile xFile,
    MediaType type,
    Uint8List? thumbnail,
    String? assetId,
    String? fileName,
  });
}

/// @nodoc
class __$$MediaItemImplCopyWithImpl<$Res>
    extends _$MediaItemCopyWithImpl<$Res, _$MediaItemImpl>
    implements _$$MediaItemImplCopyWith<$Res> {
  __$$MediaItemImplCopyWithImpl(
    _$MediaItemImpl _value,
    $Res Function(_$MediaItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MediaItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? xFile = null,
    Object? type = null,
    Object? thumbnail = freezed,
    Object? assetId = freezed,
    Object? fileName = freezed,
  }) {
    return _then(
      _$MediaItemImpl(
        xFile: null == xFile
            ? _value.xFile
            : xFile // ignore: cast_nullable_to_non_nullable
                  as XFile,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as MediaType,
        thumbnail: freezed == thumbnail
            ? _value.thumbnail
            : thumbnail // ignore: cast_nullable_to_non_nullable
                  as Uint8List?,
        assetId: freezed == assetId
            ? _value.assetId
            : assetId // ignore: cast_nullable_to_non_nullable
                  as String?,
        fileName: freezed == fileName
            ? _value.fileName
            : fileName // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$MediaItemImpl implements _MediaItem {
  const _$MediaItemImpl({
    required this.xFile,
    required this.type,
    this.thumbnail,
    this.assetId,
    this.fileName,
  });

  @override
  final XFile xFile;
  @override
  final MediaType type;
  @override
  final Uint8List? thumbnail;
  @override
  final String? assetId;
  @override
  final String? fileName;

  @override
  String toString() {
    return 'MediaItem(xFile: $xFile, type: $type, thumbnail: $thumbnail, assetId: $assetId, fileName: $fileName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MediaItemImpl &&
            (identical(other.xFile, xFile) || other.xFile == xFile) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other.thumbnail, thumbnail) &&
            (identical(other.assetId, assetId) || other.assetId == assetId) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    xFile,
    type,
    const DeepCollectionEquality().hash(thumbnail),
    assetId,
    fileName,
  );

  /// Create a copy of MediaItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MediaItemImplCopyWith<_$MediaItemImpl> get copyWith =>
      __$$MediaItemImplCopyWithImpl<_$MediaItemImpl>(this, _$identity);
}

abstract class _MediaItem implements MediaItem {
  const factory _MediaItem({
    required final XFile xFile,
    required final MediaType type,
    final Uint8List? thumbnail,
    final String? assetId,
    final String? fileName,
  }) = _$MediaItemImpl;

  @override
  XFile get xFile;
  @override
  MediaType get type;
  @override
  Uint8List? get thumbnail;
  @override
  String? get assetId;
  @override
  String? get fileName;

  /// Create a copy of MediaItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MediaItemImplCopyWith<_$MediaItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
