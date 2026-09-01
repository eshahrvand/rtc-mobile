// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_dto_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProductListResponse _$ProductListResponseFromJson(Map<String, dynamic> json) {
  return _ProductListResponse.fromJson(json);
}

/// @nodoc
mixin _$ProductListResponse {
  int get count => throw _privateConstructorUsedError;
  String? get next => throw _privateConstructorUsedError;
  String? get previous => throw _privateConstructorUsedError;
  List<ProductDtoModel> get results => throw _privateConstructorUsedError;

  /// Serializes this ProductListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductListResponseCopyWith<ProductListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductListResponseCopyWith<$Res> {
  factory $ProductListResponseCopyWith(
    ProductListResponse value,
    $Res Function(ProductListResponse) then,
  ) = _$ProductListResponseCopyWithImpl<$Res, ProductListResponse>;
  @useResult
  $Res call({
    int count,
    String? next,
    String? previous,
    List<ProductDtoModel> results,
  });
}

/// @nodoc
class _$ProductListResponseCopyWithImpl<$Res, $Val extends ProductListResponse>
    implements $ProductListResponseCopyWith<$Res> {
  _$ProductListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductListResponse
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
                      as List<ProductDtoModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProductListResponseImplCopyWith<$Res>
    implements $ProductListResponseCopyWith<$Res> {
  factory _$$ProductListResponseImplCopyWith(
    _$ProductListResponseImpl value,
    $Res Function(_$ProductListResponseImpl) then,
  ) = __$$ProductListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int count,
    String? next,
    String? previous,
    List<ProductDtoModel> results,
  });
}

/// @nodoc
class __$$ProductListResponseImplCopyWithImpl<$Res>
    extends _$ProductListResponseCopyWithImpl<$Res, _$ProductListResponseImpl>
    implements _$$ProductListResponseImplCopyWith<$Res> {
  __$$ProductListResponseImplCopyWithImpl(
    _$ProductListResponseImpl _value,
    $Res Function(_$ProductListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductListResponse
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
      _$ProductListResponseImpl(
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
                  as List<ProductDtoModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductListResponseImpl implements _ProductListResponse {
  const _$ProductListResponseImpl({
    required this.count,
    this.next,
    this.previous,
    required final List<ProductDtoModel> results,
  }) : _results = results;

  factory _$ProductListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductListResponseImplFromJson(json);

  @override
  final int count;
  @override
  final String? next;
  @override
  final String? previous;
  final List<ProductDtoModel> _results;
  @override
  List<ProductDtoModel> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  String toString() {
    return 'ProductListResponse(count: $count, next: $next, previous: $previous, results: $results)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductListResponseImpl &&
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

  /// Create a copy of ProductListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductListResponseImplCopyWith<_$ProductListResponseImpl> get copyWith =>
      __$$ProductListResponseImplCopyWithImpl<_$ProductListResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductListResponseImplToJson(this);
  }
}

abstract class _ProductListResponse implements ProductListResponse {
  const factory _ProductListResponse({
    required final int count,
    final String? next,
    final String? previous,
    required final List<ProductDtoModel> results,
  }) = _$ProductListResponseImpl;

  factory _ProductListResponse.fromJson(Map<String, dynamic> json) =
      _$ProductListResponseImpl.fromJson;

  @override
  int get count;
  @override
  String? get next;
  @override
  String? get previous;
  @override
  List<ProductDtoModel> get results;

  /// Create a copy of ProductListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductListResponseImplCopyWith<_$ProductListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProductDtoModel _$ProductDtoModelFromJson(Map<String, dynamic> json) {
  return _ProductDtoModel.fromJson(json);
}

/// @nodoc
mixin _$ProductDtoModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get sku => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'technical_detail')
  String? get technicalDetail => throw _privateConstructorUsedError;
  CategorySummaryDtoModel get category => throw _privateConstructorUsedError;
  BrandSummaryDtoModel? get brand => throw _privateConstructorUsedError;
  @JsonKey(name: 'price')
  int? get price => throw _privateConstructorUsedError;
  @JsonKey(name: 'price_before_discount')
  int? get priceBeforeDiscount => throw _privateConstructorUsedError;
  @JsonKey(name: 'base_price')
  int? get basePrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'plan_price')
  int? get planPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'plan_price_before_discount')
  int? get planPriceBeforeDiscount => throw _privateConstructorUsedError;
  @JsonKey(name: 'old_price')
  int? get oldPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_pct')
  int? get discountPct => throw _privateConstructorUsedError;
  @JsonKey(name: 'stock_qty')
  int get stockQty => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'featured_image')
  ImageDtoModel? get featuredImage => throw _privateConstructorUsedError;
  List<ProductGalleryImageDtoModel>? get images =>
      throw _privateConstructorUsedError;

  /// Serializes this ProductDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductDtoModelCopyWith<ProductDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductDtoModelCopyWith<$Res> {
  factory $ProductDtoModelCopyWith(
    ProductDtoModel value,
    $Res Function(ProductDtoModel) then,
  ) = _$ProductDtoModelCopyWithImpl<$Res, ProductDtoModel>;
  @useResult
  $Res call({
    String id,
    String name,
    String sku,
    String? description,
    @JsonKey(name: 'technical_detail') String? technicalDetail,
    CategorySummaryDtoModel category,
    BrandSummaryDtoModel? brand,
    @JsonKey(name: 'price') int? price,
    @JsonKey(name: 'price_before_discount') int? priceBeforeDiscount,
    @JsonKey(name: 'base_price') int? basePrice,
    @JsonKey(name: 'plan_price') int? planPrice,
    @JsonKey(name: 'plan_price_before_discount') int? planPriceBeforeDiscount,
    @JsonKey(name: 'old_price') int? oldPrice,
    @JsonKey(name: 'discount_pct') int? discountPct,
    @JsonKey(name: 'stock_qty') int stockQty,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'featured_image') ImageDtoModel? featuredImage,
    List<ProductGalleryImageDtoModel>? images,
  });

  $CategorySummaryDtoModelCopyWith<$Res> get category;
  $BrandSummaryDtoModelCopyWith<$Res>? get brand;
  $ImageDtoModelCopyWith<$Res>? get featuredImage;
}

/// @nodoc
class _$ProductDtoModelCopyWithImpl<$Res, $Val extends ProductDtoModel>
    implements $ProductDtoModelCopyWith<$Res> {
  _$ProductDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? sku = null,
    Object? description = freezed,
    Object? technicalDetail = freezed,
    Object? category = null,
    Object? brand = freezed,
    Object? price = freezed,
    Object? priceBeforeDiscount = freezed,
    Object? basePrice = freezed,
    Object? planPrice = freezed,
    Object? planPriceBeforeDiscount = freezed,
    Object? oldPrice = freezed,
    Object? discountPct = freezed,
    Object? stockQty = null,
    Object? isActive = null,
    Object? featuredImage = freezed,
    Object? images = freezed,
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
            sku: null == sku
                ? _value.sku
                : sku // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            technicalDetail: freezed == technicalDetail
                ? _value.technicalDetail
                : technicalDetail // ignore: cast_nullable_to_non_nullable
                      as String?,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as CategorySummaryDtoModel,
            brand: freezed == brand
                ? _value.brand
                : brand // ignore: cast_nullable_to_non_nullable
                      as BrandSummaryDtoModel?,
            price: freezed == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as int?,
            priceBeforeDiscount: freezed == priceBeforeDiscount
                ? _value.priceBeforeDiscount
                : priceBeforeDiscount // ignore: cast_nullable_to_non_nullable
                      as int?,
            basePrice: freezed == basePrice
                ? _value.basePrice
                : basePrice // ignore: cast_nullable_to_non_nullable
                      as int?,
            planPrice: freezed == planPrice
                ? _value.planPrice
                : planPrice // ignore: cast_nullable_to_non_nullable
                      as int?,
            planPriceBeforeDiscount: freezed == planPriceBeforeDiscount
                ? _value.planPriceBeforeDiscount
                : planPriceBeforeDiscount // ignore: cast_nullable_to_non_nullable
                      as int?,
            oldPrice: freezed == oldPrice
                ? _value.oldPrice
                : oldPrice // ignore: cast_nullable_to_non_nullable
                      as int?,
            discountPct: freezed == discountPct
                ? _value.discountPct
                : discountPct // ignore: cast_nullable_to_non_nullable
                      as int?,
            stockQty: null == stockQty
                ? _value.stockQty
                : stockQty // ignore: cast_nullable_to_non_nullable
                      as int,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            featuredImage: freezed == featuredImage
                ? _value.featuredImage
                : featuredImage // ignore: cast_nullable_to_non_nullable
                      as ImageDtoModel?,
            images: freezed == images
                ? _value.images
                : images // ignore: cast_nullable_to_non_nullable
                      as List<ProductGalleryImageDtoModel>?,
          )
          as $Val,
    );
  }

  /// Create a copy of ProductDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CategorySummaryDtoModelCopyWith<$Res> get category {
    return $CategorySummaryDtoModelCopyWith<$Res>(_value.category, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }

  /// Create a copy of ProductDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BrandSummaryDtoModelCopyWith<$Res>? get brand {
    if (_value.brand == null) {
      return null;
    }

    return $BrandSummaryDtoModelCopyWith<$Res>(_value.brand!, (value) {
      return _then(_value.copyWith(brand: value) as $Val);
    });
  }

  /// Create a copy of ProductDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ImageDtoModelCopyWith<$Res>? get featuredImage {
    if (_value.featuredImage == null) {
      return null;
    }

    return $ImageDtoModelCopyWith<$Res>(_value.featuredImage!, (value) {
      return _then(_value.copyWith(featuredImage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProductDtoModelImplCopyWith<$Res>
    implements $ProductDtoModelCopyWith<$Res> {
  factory _$$ProductDtoModelImplCopyWith(
    _$ProductDtoModelImpl value,
    $Res Function(_$ProductDtoModelImpl) then,
  ) = __$$ProductDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String sku,
    String? description,
    @JsonKey(name: 'technical_detail') String? technicalDetail,
    CategorySummaryDtoModel category,
    BrandSummaryDtoModel? brand,
    @JsonKey(name: 'price') int? price,
    @JsonKey(name: 'price_before_discount') int? priceBeforeDiscount,
    @JsonKey(name: 'base_price') int? basePrice,
    @JsonKey(name: 'plan_price') int? planPrice,
    @JsonKey(name: 'plan_price_before_discount') int? planPriceBeforeDiscount,
    @JsonKey(name: 'old_price') int? oldPrice,
    @JsonKey(name: 'discount_pct') int? discountPct,
    @JsonKey(name: 'stock_qty') int stockQty,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'featured_image') ImageDtoModel? featuredImage,
    List<ProductGalleryImageDtoModel>? images,
  });

  @override
  $CategorySummaryDtoModelCopyWith<$Res> get category;
  @override
  $BrandSummaryDtoModelCopyWith<$Res>? get brand;
  @override
  $ImageDtoModelCopyWith<$Res>? get featuredImage;
}

/// @nodoc
class __$$ProductDtoModelImplCopyWithImpl<$Res>
    extends _$ProductDtoModelCopyWithImpl<$Res, _$ProductDtoModelImpl>
    implements _$$ProductDtoModelImplCopyWith<$Res> {
  __$$ProductDtoModelImplCopyWithImpl(
    _$ProductDtoModelImpl _value,
    $Res Function(_$ProductDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? sku = null,
    Object? description = freezed,
    Object? technicalDetail = freezed,
    Object? category = null,
    Object? brand = freezed,
    Object? price = freezed,
    Object? priceBeforeDiscount = freezed,
    Object? basePrice = freezed,
    Object? planPrice = freezed,
    Object? planPriceBeforeDiscount = freezed,
    Object? oldPrice = freezed,
    Object? discountPct = freezed,
    Object? stockQty = null,
    Object? isActive = null,
    Object? featuredImage = freezed,
    Object? images = freezed,
  }) {
    return _then(
      _$ProductDtoModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        sku: null == sku
            ? _value.sku
            : sku // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        technicalDetail: freezed == technicalDetail
            ? _value.technicalDetail
            : technicalDetail // ignore: cast_nullable_to_non_nullable
                  as String?,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as CategorySummaryDtoModel,
        brand: freezed == brand
            ? _value.brand
            : brand // ignore: cast_nullable_to_non_nullable
                  as BrandSummaryDtoModel?,
        price: freezed == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as int?,
        priceBeforeDiscount: freezed == priceBeforeDiscount
            ? _value.priceBeforeDiscount
            : priceBeforeDiscount // ignore: cast_nullable_to_non_nullable
                  as int?,
        basePrice: freezed == basePrice
            ? _value.basePrice
            : basePrice // ignore: cast_nullable_to_non_nullable
                  as int?,
        planPrice: freezed == planPrice
            ? _value.planPrice
            : planPrice // ignore: cast_nullable_to_non_nullable
                  as int?,
        planPriceBeforeDiscount: freezed == planPriceBeforeDiscount
            ? _value.planPriceBeforeDiscount
            : planPriceBeforeDiscount // ignore: cast_nullable_to_non_nullable
                  as int?,
        oldPrice: freezed == oldPrice
            ? _value.oldPrice
            : oldPrice // ignore: cast_nullable_to_non_nullable
                  as int?,
        discountPct: freezed == discountPct
            ? _value.discountPct
            : discountPct // ignore: cast_nullable_to_non_nullable
                  as int?,
        stockQty: null == stockQty
            ? _value.stockQty
            : stockQty // ignore: cast_nullable_to_non_nullable
                  as int,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        featuredImage: freezed == featuredImage
            ? _value.featuredImage
            : featuredImage // ignore: cast_nullable_to_non_nullable
                  as ImageDtoModel?,
        images: freezed == images
            ? _value._images
            : images // ignore: cast_nullable_to_non_nullable
                  as List<ProductGalleryImageDtoModel>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductDtoModelImpl implements _ProductDtoModel {
  const _$ProductDtoModelImpl({
    required this.id,
    required this.name,
    required this.sku,
    this.description,
    @JsonKey(name: 'technical_detail') this.technicalDetail,
    required this.category,
    this.brand,
    @JsonKey(name: 'price') this.price,
    @JsonKey(name: 'price_before_discount') this.priceBeforeDiscount,
    @JsonKey(name: 'base_price') this.basePrice,
    @JsonKey(name: 'plan_price') this.planPrice,
    @JsonKey(name: 'plan_price_before_discount') this.planPriceBeforeDiscount,
    @JsonKey(name: 'old_price') this.oldPrice,
    @JsonKey(name: 'discount_pct') this.discountPct,
    @JsonKey(name: 'stock_qty') required this.stockQty,
    @JsonKey(name: 'is_active') required this.isActive,
    @JsonKey(name: 'featured_image') this.featuredImage,
    final List<ProductGalleryImageDtoModel>? images,
  }) : _images = images;

  factory _$ProductDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductDtoModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String sku;
  @override
  final String? description;
  @override
  @JsonKey(name: 'technical_detail')
  final String? technicalDetail;
  @override
  final CategorySummaryDtoModel category;
  @override
  final BrandSummaryDtoModel? brand;
  @override
  @JsonKey(name: 'price')
  final int? price;
  @override
  @JsonKey(name: 'price_before_discount')
  final int? priceBeforeDiscount;
  @override
  @JsonKey(name: 'base_price')
  final int? basePrice;
  @override
  @JsonKey(name: 'plan_price')
  final int? planPrice;
  @override
  @JsonKey(name: 'plan_price_before_discount')
  final int? planPriceBeforeDiscount;
  @override
  @JsonKey(name: 'old_price')
  final int? oldPrice;
  @override
  @JsonKey(name: 'discount_pct')
  final int? discountPct;
  @override
  @JsonKey(name: 'stock_qty')
  final int stockQty;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'featured_image')
  final ImageDtoModel? featuredImage;
  final List<ProductGalleryImageDtoModel>? _images;
  @override
  List<ProductGalleryImageDtoModel>? get images {
    final value = _images;
    if (value == null) return null;
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ProductDtoModel(id: $id, name: $name, sku: $sku, description: $description, technicalDetail: $technicalDetail, category: $category, brand: $brand, price: $price, priceBeforeDiscount: $priceBeforeDiscount, basePrice: $basePrice, planPrice: $planPrice, planPriceBeforeDiscount: $planPriceBeforeDiscount, oldPrice: $oldPrice, discountPct: $discountPct, stockQty: $stockQty, isActive: $isActive, featuredImage: $featuredImage, images: $images)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductDtoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.sku, sku) || other.sku == sku) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.technicalDetail, technicalDetail) ||
                other.technicalDetail == technicalDetail) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.priceBeforeDiscount, priceBeforeDiscount) ||
                other.priceBeforeDiscount == priceBeforeDiscount) &&
            (identical(other.basePrice, basePrice) ||
                other.basePrice == basePrice) &&
            (identical(other.planPrice, planPrice) ||
                other.planPrice == planPrice) &&
            (identical(
                  other.planPriceBeforeDiscount,
                  planPriceBeforeDiscount,
                ) ||
                other.planPriceBeforeDiscount == planPriceBeforeDiscount) &&
            (identical(other.oldPrice, oldPrice) ||
                other.oldPrice == oldPrice) &&
            (identical(other.discountPct, discountPct) ||
                other.discountPct == discountPct) &&
            (identical(other.stockQty, stockQty) ||
                other.stockQty == stockQty) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.featuredImage, featuredImage) ||
                other.featuredImage == featuredImage) &&
            const DeepCollectionEquality().equals(other._images, _images));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    sku,
    description,
    technicalDetail,
    category,
    brand,
    price,
    priceBeforeDiscount,
    basePrice,
    planPrice,
    planPriceBeforeDiscount,
    oldPrice,
    discountPct,
    stockQty,
    isActive,
    featuredImage,
    const DeepCollectionEquality().hash(_images),
  );

  /// Create a copy of ProductDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductDtoModelImplCopyWith<_$ProductDtoModelImpl> get copyWith =>
      __$$ProductDtoModelImplCopyWithImpl<_$ProductDtoModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductDtoModelImplToJson(this);
  }
}

abstract class _ProductDtoModel implements ProductDtoModel {
  const factory _ProductDtoModel({
    required final String id,
    required final String name,
    required final String sku,
    final String? description,
    @JsonKey(name: 'technical_detail') final String? technicalDetail,
    required final CategorySummaryDtoModel category,
    final BrandSummaryDtoModel? brand,
    @JsonKey(name: 'price') final int? price,
    @JsonKey(name: 'price_before_discount') final int? priceBeforeDiscount,
    @JsonKey(name: 'base_price') final int? basePrice,
    @JsonKey(name: 'plan_price') final int? planPrice,
    @JsonKey(name: 'plan_price_before_discount')
    final int? planPriceBeforeDiscount,
    @JsonKey(name: 'old_price') final int? oldPrice,
    @JsonKey(name: 'discount_pct') final int? discountPct,
    @JsonKey(name: 'stock_qty') required final int stockQty,
    @JsonKey(name: 'is_active') required final bool isActive,
    @JsonKey(name: 'featured_image') final ImageDtoModel? featuredImage,
    final List<ProductGalleryImageDtoModel>? images,
  }) = _$ProductDtoModelImpl;

  factory _ProductDtoModel.fromJson(Map<String, dynamic> json) =
      _$ProductDtoModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get sku;
  @override
  String? get description;
  @override
  @JsonKey(name: 'technical_detail')
  String? get technicalDetail;
  @override
  CategorySummaryDtoModel get category;
  @override
  BrandSummaryDtoModel? get brand;
  @override
  @JsonKey(name: 'price')
  int? get price;
  @override
  @JsonKey(name: 'price_before_discount')
  int? get priceBeforeDiscount;
  @override
  @JsonKey(name: 'base_price')
  int? get basePrice;
  @override
  @JsonKey(name: 'plan_price')
  int? get planPrice;
  @override
  @JsonKey(name: 'plan_price_before_discount')
  int? get planPriceBeforeDiscount;
  @override
  @JsonKey(name: 'old_price')
  int? get oldPrice;
  @override
  @JsonKey(name: 'discount_pct')
  int? get discountPct;
  @override
  @JsonKey(name: 'stock_qty')
  int get stockQty;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(name: 'featured_image')
  ImageDtoModel? get featuredImage;
  @override
  List<ProductGalleryImageDtoModel>? get images;

  /// Create a copy of ProductDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductDtoModelImplCopyWith<_$ProductDtoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CategorySummaryDtoModel _$CategorySummaryDtoModelFromJson(
  Map<String, dynamic> json,
) {
  return _CategorySummaryDtoModel.fromJson(json);
}

/// @nodoc
mixin _$CategorySummaryDtoModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this CategorySummaryDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CategorySummaryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CategorySummaryDtoModelCopyWith<CategorySummaryDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategorySummaryDtoModelCopyWith<$Res> {
  factory $CategorySummaryDtoModelCopyWith(
    CategorySummaryDtoModel value,
    $Res Function(CategorySummaryDtoModel) then,
  ) = _$CategorySummaryDtoModelCopyWithImpl<$Res, CategorySummaryDtoModel>;
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class _$CategorySummaryDtoModelCopyWithImpl<
  $Res,
  $Val extends CategorySummaryDtoModel
>
    implements $CategorySummaryDtoModelCopyWith<$Res> {
  _$CategorySummaryDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CategorySummaryDtoModel
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
abstract class _$$CategorySummaryDtoModelImplCopyWith<$Res>
    implements $CategorySummaryDtoModelCopyWith<$Res> {
  factory _$$CategorySummaryDtoModelImplCopyWith(
    _$CategorySummaryDtoModelImpl value,
    $Res Function(_$CategorySummaryDtoModelImpl) then,
  ) = __$$CategorySummaryDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class __$$CategorySummaryDtoModelImplCopyWithImpl<$Res>
    extends
        _$CategorySummaryDtoModelCopyWithImpl<
          $Res,
          _$CategorySummaryDtoModelImpl
        >
    implements _$$CategorySummaryDtoModelImplCopyWith<$Res> {
  __$$CategorySummaryDtoModelImplCopyWithImpl(
    _$CategorySummaryDtoModelImpl _value,
    $Res Function(_$CategorySummaryDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CategorySummaryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _$CategorySummaryDtoModelImpl(
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
class _$CategorySummaryDtoModelImpl implements _CategorySummaryDtoModel {
  const _$CategorySummaryDtoModelImpl({required this.id, required this.name});

  factory _$CategorySummaryDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CategorySummaryDtoModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;

  @override
  String toString() {
    return 'CategorySummaryDtoModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategorySummaryDtoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of CategorySummaryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategorySummaryDtoModelImplCopyWith<_$CategorySummaryDtoModelImpl>
  get copyWith =>
      __$$CategorySummaryDtoModelImplCopyWithImpl<
        _$CategorySummaryDtoModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CategorySummaryDtoModelImplToJson(this);
  }
}

abstract class _CategorySummaryDtoModel implements CategorySummaryDtoModel {
  const factory _CategorySummaryDtoModel({
    required final String id,
    required final String name,
  }) = _$CategorySummaryDtoModelImpl;

  factory _CategorySummaryDtoModel.fromJson(Map<String, dynamic> json) =
      _$CategorySummaryDtoModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;

  /// Create a copy of CategorySummaryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategorySummaryDtoModelImplCopyWith<_$CategorySummaryDtoModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

BrandSummaryDtoModel _$BrandSummaryDtoModelFromJson(Map<String, dynamic> json) {
  return _BrandSummaryDtoModel.fromJson(json);
}

/// @nodoc
mixin _$BrandSummaryDtoModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this BrandSummaryDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BrandSummaryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BrandSummaryDtoModelCopyWith<BrandSummaryDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrandSummaryDtoModelCopyWith<$Res> {
  factory $BrandSummaryDtoModelCopyWith(
    BrandSummaryDtoModel value,
    $Res Function(BrandSummaryDtoModel) then,
  ) = _$BrandSummaryDtoModelCopyWithImpl<$Res, BrandSummaryDtoModel>;
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class _$BrandSummaryDtoModelCopyWithImpl<
  $Res,
  $Val extends BrandSummaryDtoModel
>
    implements $BrandSummaryDtoModelCopyWith<$Res> {
  _$BrandSummaryDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BrandSummaryDtoModel
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
abstract class _$$BrandSummaryDtoModelImplCopyWith<$Res>
    implements $BrandSummaryDtoModelCopyWith<$Res> {
  factory _$$BrandSummaryDtoModelImplCopyWith(
    _$BrandSummaryDtoModelImpl value,
    $Res Function(_$BrandSummaryDtoModelImpl) then,
  ) = __$$BrandSummaryDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class __$$BrandSummaryDtoModelImplCopyWithImpl<$Res>
    extends _$BrandSummaryDtoModelCopyWithImpl<$Res, _$BrandSummaryDtoModelImpl>
    implements _$$BrandSummaryDtoModelImplCopyWith<$Res> {
  __$$BrandSummaryDtoModelImplCopyWithImpl(
    _$BrandSummaryDtoModelImpl _value,
    $Res Function(_$BrandSummaryDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BrandSummaryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _$BrandSummaryDtoModelImpl(
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
class _$BrandSummaryDtoModelImpl implements _BrandSummaryDtoModel {
  const _$BrandSummaryDtoModelImpl({required this.id, required this.name});

  factory _$BrandSummaryDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BrandSummaryDtoModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;

  @override
  String toString() {
    return 'BrandSummaryDtoModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BrandSummaryDtoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of BrandSummaryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BrandSummaryDtoModelImplCopyWith<_$BrandSummaryDtoModelImpl>
  get copyWith =>
      __$$BrandSummaryDtoModelImplCopyWithImpl<_$BrandSummaryDtoModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BrandSummaryDtoModelImplToJson(this);
  }
}

abstract class _BrandSummaryDtoModel implements BrandSummaryDtoModel {
  const factory _BrandSummaryDtoModel({
    required final String id,
    required final String name,
  }) = _$BrandSummaryDtoModelImpl;

  factory _BrandSummaryDtoModel.fromJson(Map<String, dynamic> json) =
      _$BrandSummaryDtoModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;

  /// Create a copy of BrandSummaryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BrandSummaryDtoModelImplCopyWith<_$BrandSummaryDtoModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ImageDtoModel _$ImageDtoModelFromJson(Map<String, dynamic> json) {
  return _ImageDtoModel.fromJson(json);
}

/// @nodoc
mixin _$ImageDtoModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_group')
  String get imageGroup => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get file => throw _privateConstructorUsedError;
  int get width => throw _privateConstructorUsedError;
  int get height => throw _privateConstructorUsedError;
  @JsonKey(name: 'file_size')
  int get fileSize => throw _privateConstructorUsedError;
  @JsonKey(name: 'uploaded_by_id')
  String? get uploadedById => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;

  /// Serializes this ImageDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ImageDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ImageDtoModelCopyWith<ImageDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageDtoModelCopyWith<$Res> {
  factory $ImageDtoModelCopyWith(
    ImageDtoModel value,
    $Res Function(ImageDtoModel) then,
  ) = _$ImageDtoModelCopyWithImpl<$Res, ImageDtoModel>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'image_group') String imageGroup,
    String title,
    String file,
    int width,
    int height,
    @JsonKey(name: 'file_size') int fileSize,
    @JsonKey(name: 'uploaded_by_id') String? uploadedById,
    @JsonKey(name: 'created_at') String createdAt,
  });
}

/// @nodoc
class _$ImageDtoModelCopyWithImpl<$Res, $Val extends ImageDtoModel>
    implements $ImageDtoModelCopyWith<$Res> {
  _$ImageDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ImageDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? imageGroup = null,
    Object? title = null,
    Object? file = null,
    Object? width = null,
    Object? height = null,
    Object? fileSize = null,
    Object? uploadedById = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            imageGroup: null == imageGroup
                ? _value.imageGroup
                : imageGroup // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            file: null == file
                ? _value.file
                : file // ignore: cast_nullable_to_non_nullable
                      as String,
            width: null == width
                ? _value.width
                : width // ignore: cast_nullable_to_non_nullable
                      as int,
            height: null == height
                ? _value.height
                : height // ignore: cast_nullable_to_non_nullable
                      as int,
            fileSize: null == fileSize
                ? _value.fileSize
                : fileSize // ignore: cast_nullable_to_non_nullable
                      as int,
            uploadedById: freezed == uploadedById
                ? _value.uploadedById
                : uploadedById // ignore: cast_nullable_to_non_nullable
                      as String?,
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
abstract class _$$ImageDtoModelImplCopyWith<$Res>
    implements $ImageDtoModelCopyWith<$Res> {
  factory _$$ImageDtoModelImplCopyWith(
    _$ImageDtoModelImpl value,
    $Res Function(_$ImageDtoModelImpl) then,
  ) = __$$ImageDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'image_group') String imageGroup,
    String title,
    String file,
    int width,
    int height,
    @JsonKey(name: 'file_size') int fileSize,
    @JsonKey(name: 'uploaded_by_id') String? uploadedById,
    @JsonKey(name: 'created_at') String createdAt,
  });
}

/// @nodoc
class __$$ImageDtoModelImplCopyWithImpl<$Res>
    extends _$ImageDtoModelCopyWithImpl<$Res, _$ImageDtoModelImpl>
    implements _$$ImageDtoModelImplCopyWith<$Res> {
  __$$ImageDtoModelImplCopyWithImpl(
    _$ImageDtoModelImpl _value,
    $Res Function(_$ImageDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ImageDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? imageGroup = null,
    Object? title = null,
    Object? file = null,
    Object? width = null,
    Object? height = null,
    Object? fileSize = null,
    Object? uploadedById = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _$ImageDtoModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        imageGroup: null == imageGroup
            ? _value.imageGroup
            : imageGroup // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        file: null == file
            ? _value.file
            : file // ignore: cast_nullable_to_non_nullable
                  as String,
        width: null == width
            ? _value.width
            : width // ignore: cast_nullable_to_non_nullable
                  as int,
        height: null == height
            ? _value.height
            : height // ignore: cast_nullable_to_non_nullable
                  as int,
        fileSize: null == fileSize
            ? _value.fileSize
            : fileSize // ignore: cast_nullable_to_non_nullable
                  as int,
        uploadedById: freezed == uploadedById
            ? _value.uploadedById
            : uploadedById // ignore: cast_nullable_to_non_nullable
                  as String?,
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
class _$ImageDtoModelImpl implements _ImageDtoModel {
  const _$ImageDtoModelImpl({
    required this.id,
    @JsonKey(name: 'image_group') required this.imageGroup,
    required this.title,
    required this.file,
    required this.width,
    required this.height,
    @JsonKey(name: 'file_size') required this.fileSize,
    @JsonKey(name: 'uploaded_by_id') this.uploadedById,
    @JsonKey(name: 'created_at') required this.createdAt,
  });

  factory _$ImageDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImageDtoModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'image_group')
  final String imageGroup;
  @override
  final String title;
  @override
  final String file;
  @override
  final int width;
  @override
  final int height;
  @override
  @JsonKey(name: 'file_size')
  final int fileSize;
  @override
  @JsonKey(name: 'uploaded_by_id')
  final String? uploadedById;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;

  @override
  String toString() {
    return 'ImageDtoModel(id: $id, imageGroup: $imageGroup, title: $title, file: $file, width: $width, height: $height, fileSize: $fileSize, uploadedById: $uploadedById, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageDtoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.imageGroup, imageGroup) ||
                other.imageGroup == imageGroup) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.file, file) || other.file == file) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.fileSize, fileSize) ||
                other.fileSize == fileSize) &&
            (identical(other.uploadedById, uploadedById) ||
                other.uploadedById == uploadedById) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    imageGroup,
    title,
    file,
    width,
    height,
    fileSize,
    uploadedById,
    createdAt,
  );

  /// Create a copy of ImageDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageDtoModelImplCopyWith<_$ImageDtoModelImpl> get copyWith =>
      __$$ImageDtoModelImplCopyWithImpl<_$ImageDtoModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImageDtoModelImplToJson(this);
  }
}

abstract class _ImageDtoModel implements ImageDtoModel {
  const factory _ImageDtoModel({
    required final String id,
    @JsonKey(name: 'image_group') required final String imageGroup,
    required final String title,
    required final String file,
    required final int width,
    required final int height,
    @JsonKey(name: 'file_size') required final int fileSize,
    @JsonKey(name: 'uploaded_by_id') final String? uploadedById,
    @JsonKey(name: 'created_at') required final String createdAt,
  }) = _$ImageDtoModelImpl;

  factory _ImageDtoModel.fromJson(Map<String, dynamic> json) =
      _$ImageDtoModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'image_group')
  String get imageGroup;
  @override
  String get title;
  @override
  String get file;
  @override
  int get width;
  @override
  int get height;
  @override
  @JsonKey(name: 'file_size')
  int get fileSize;
  @override
  @JsonKey(name: 'uploaded_by_id')
  String? get uploadedById;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;

  /// Create a copy of ImageDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ImageDtoModelImplCopyWith<_$ImageDtoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProductGalleryImageDtoModel _$ProductGalleryImageDtoModelFromJson(
  Map<String, dynamic> json,
) {
  return _ProductGalleryImageDtoModel.fromJson(json);
}

/// @nodoc
mixin _$ProductGalleryImageDtoModel {
  String get id => throw _privateConstructorUsedError;
  ImageDtoModel get image => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;

  /// Serializes this ProductGalleryImageDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductGalleryImageDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductGalleryImageDtoModelCopyWith<ProductGalleryImageDtoModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductGalleryImageDtoModelCopyWith<$Res> {
  factory $ProductGalleryImageDtoModelCopyWith(
    ProductGalleryImageDtoModel value,
    $Res Function(ProductGalleryImageDtoModel) then,
  ) =
      _$ProductGalleryImageDtoModelCopyWithImpl<
        $Res,
        ProductGalleryImageDtoModel
      >;
  @useResult
  $Res call({String id, ImageDtoModel image, int order});

  $ImageDtoModelCopyWith<$Res> get image;
}

/// @nodoc
class _$ProductGalleryImageDtoModelCopyWithImpl<
  $Res,
  $Val extends ProductGalleryImageDtoModel
>
    implements $ProductGalleryImageDtoModelCopyWith<$Res> {
  _$ProductGalleryImageDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductGalleryImageDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? image = null, Object? order = null}) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            image: null == image
                ? _value.image
                : image // ignore: cast_nullable_to_non_nullable
                      as ImageDtoModel,
            order: null == order
                ? _value.order
                : order // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }

  /// Create a copy of ProductGalleryImageDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ImageDtoModelCopyWith<$Res> get image {
    return $ImageDtoModelCopyWith<$Res>(_value.image, (value) {
      return _then(_value.copyWith(image: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProductGalleryImageDtoModelImplCopyWith<$Res>
    implements $ProductGalleryImageDtoModelCopyWith<$Res> {
  factory _$$ProductGalleryImageDtoModelImplCopyWith(
    _$ProductGalleryImageDtoModelImpl value,
    $Res Function(_$ProductGalleryImageDtoModelImpl) then,
  ) = __$$ProductGalleryImageDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, ImageDtoModel image, int order});

  @override
  $ImageDtoModelCopyWith<$Res> get image;
}

/// @nodoc
class __$$ProductGalleryImageDtoModelImplCopyWithImpl<$Res>
    extends
        _$ProductGalleryImageDtoModelCopyWithImpl<
          $Res,
          _$ProductGalleryImageDtoModelImpl
        >
    implements _$$ProductGalleryImageDtoModelImplCopyWith<$Res> {
  __$$ProductGalleryImageDtoModelImplCopyWithImpl(
    _$ProductGalleryImageDtoModelImpl _value,
    $Res Function(_$ProductGalleryImageDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductGalleryImageDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? image = null, Object? order = null}) {
    return _then(
      _$ProductGalleryImageDtoModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        image: null == image
            ? _value.image
            : image // ignore: cast_nullable_to_non_nullable
                  as ImageDtoModel,
        order: null == order
            ? _value.order
            : order // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductGalleryImageDtoModelImpl
    implements _ProductGalleryImageDtoModel {
  const _$ProductGalleryImageDtoModelImpl({
    required this.id,
    required this.image,
    required this.order,
  });

  factory _$ProductGalleryImageDtoModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$ProductGalleryImageDtoModelImplFromJson(json);

  @override
  final String id;
  @override
  final ImageDtoModel image;
  @override
  final int order;

  @override
  String toString() {
    return 'ProductGalleryImageDtoModel(id: $id, image: $image, order: $order)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductGalleryImageDtoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.order, order) || other.order == order));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, image, order);

  /// Create a copy of ProductGalleryImageDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductGalleryImageDtoModelImplCopyWith<_$ProductGalleryImageDtoModelImpl>
  get copyWith =>
      __$$ProductGalleryImageDtoModelImplCopyWithImpl<
        _$ProductGalleryImageDtoModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductGalleryImageDtoModelImplToJson(this);
  }
}

abstract class _ProductGalleryImageDtoModel
    implements ProductGalleryImageDtoModel {
  const factory _ProductGalleryImageDtoModel({
    required final String id,
    required final ImageDtoModel image,
    required final int order,
  }) = _$ProductGalleryImageDtoModelImpl;

  factory _ProductGalleryImageDtoModel.fromJson(Map<String, dynamic> json) =
      _$ProductGalleryImageDtoModelImpl.fromJson;

  @override
  String get id;
  @override
  ImageDtoModel get image;
  @override
  int get order;

  /// Create a copy of ProductGalleryImageDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductGalleryImageDtoModelImplCopyWith<_$ProductGalleryImageDtoModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
