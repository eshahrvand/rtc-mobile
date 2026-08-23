// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ProductDetailState {
  ProductDetailRequestStatus get status => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  ProductDetailModel? get product => throw _privateConstructorUsedError;
  int get selectedImageIndex => throw _privateConstructorUsedError;

  /// Create a copy of ProductDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductDetailStateCopyWith<ProductDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductDetailStateCopyWith<$Res> {
  factory $ProductDetailStateCopyWith(
    ProductDetailState value,
    $Res Function(ProductDetailState) then,
  ) = _$ProductDetailStateCopyWithImpl<$Res, ProductDetailState>;
  @useResult
  $Res call({
    ProductDetailRequestStatus status,
    String errorMessage,
    ProductDetailModel? product,
    int selectedImageIndex,
  });
}

/// @nodoc
class _$ProductDetailStateCopyWithImpl<$Res, $Val extends ProductDetailState>
    implements $ProductDetailStateCopyWith<$Res> {
  _$ProductDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? errorMessage = null,
    Object? product = freezed,
    Object? selectedImageIndex = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ProductDetailRequestStatus,
            errorMessage: null == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String,
            product: freezed == product
                ? _value.product
                : product // ignore: cast_nullable_to_non_nullable
                      as ProductDetailModel?,
            selectedImageIndex: null == selectedImageIndex
                ? _value.selectedImageIndex
                : selectedImageIndex // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProductDetailStateImplCopyWith<$Res>
    implements $ProductDetailStateCopyWith<$Res> {
  factory _$$ProductDetailStateImplCopyWith(
    _$ProductDetailStateImpl value,
    $Res Function(_$ProductDetailStateImpl) then,
  ) = __$$ProductDetailStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ProductDetailRequestStatus status,
    String errorMessage,
    ProductDetailModel? product,
    int selectedImageIndex,
  });
}

/// @nodoc
class __$$ProductDetailStateImplCopyWithImpl<$Res>
    extends _$ProductDetailStateCopyWithImpl<$Res, _$ProductDetailStateImpl>
    implements _$$ProductDetailStateImplCopyWith<$Res> {
  __$$ProductDetailStateImplCopyWithImpl(
    _$ProductDetailStateImpl _value,
    $Res Function(_$ProductDetailStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? errorMessage = null,
    Object? product = freezed,
    Object? selectedImageIndex = null,
  }) {
    return _then(
      _$ProductDetailStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ProductDetailRequestStatus,
        errorMessage: null == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String,
        product: freezed == product
            ? _value.product
            : product // ignore: cast_nullable_to_non_nullable
                  as ProductDetailModel?,
        selectedImageIndex: null == selectedImageIndex
            ? _value.selectedImageIndex
            : selectedImageIndex // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$ProductDetailStateImpl implements _ProductDetailState {
  const _$ProductDetailStateImpl({
    this.status = ProductDetailRequestStatus.initial,
    this.errorMessage = '',
    this.product,
    this.selectedImageIndex = 0,
  });

  @override
  @JsonKey()
  final ProductDetailRequestStatus status;
  @override
  @JsonKey()
  final String errorMessage;
  @override
  final ProductDetailModel? product;
  @override
  @JsonKey()
  final int selectedImageIndex;

  @override
  String toString() {
    return 'ProductDetailState(status: $status, errorMessage: $errorMessage, product: $product, selectedImageIndex: $selectedImageIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductDetailStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.product, product) || other.product == product) &&
            (identical(other.selectedImageIndex, selectedImageIndex) ||
                other.selectedImageIndex == selectedImageIndex));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    errorMessage,
    product,
    selectedImageIndex,
  );

  /// Create a copy of ProductDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductDetailStateImplCopyWith<_$ProductDetailStateImpl> get copyWith =>
      __$$ProductDetailStateImplCopyWithImpl<_$ProductDetailStateImpl>(
        this,
        _$identity,
      );
}

abstract class _ProductDetailState implements ProductDetailState {
  const factory _ProductDetailState({
    final ProductDetailRequestStatus status,
    final String errorMessage,
    final ProductDetailModel? product,
    final int selectedImageIndex,
  }) = _$ProductDetailStateImpl;

  @override
  ProductDetailRequestStatus get status;
  @override
  String get errorMessage;
  @override
  ProductDetailModel? get product;
  @override
  int get selectedImageIndex;

  /// Create a copy of ProductDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductDetailStateImplCopyWith<_$ProductDetailStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
