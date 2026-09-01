// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ProductState {
  ProductRequestStatus get status => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError; // AppBar
  bool get isSearchActive => throw _privateConstructorUsedError;
  String get searchQuery => throw _privateConstructorUsedError; // Choice Chips
  List<ProductChipModel> get chips => throw _privateConstructorUsedError;
  int get selectedChipIndex =>
      throw _privateConstructorUsedError; // -1 means no chip is selected by default
  String? get selectedCategoryId => throw _privateConstructorUsedError;
  String? get selectedBrandId => throw _privateConstructorUsedError;
  String? get selectedSubPlanId => throw _privateConstructorUsedError;
  String? get selectedSubPlanName => throw _privateConstructorUsedError;
  bool get isOnlyAvailable => throw _privateConstructorUsedError;
  ProductChipModel? get activeFilterChip =>
      throw _privateConstructorUsedError; // Dynamic Filter Data
  List<CategoryDtoModel> get availableCategories =>
      throw _privateConstructorUsedError;
  int get currentCategoryPage => throw _privateConstructorUsedError;
  bool get hasMoreCategories => throw _privateConstructorUsedError;
  bool get isCategoryPaginationLoading => throw _privateConstructorUsedError;
  List<SubPlanDtoModel> get availableSubPlans =>
      throw _privateConstructorUsedError;
  int get currentSubPlanPage => throw _privateConstructorUsedError;
  bool get hasMoreSubPlans => throw _privateConstructorUsedError;
  bool get isSubPlanPaginationLoading => throw _privateConstructorUsedError;
  List<BrandDtoModel> get availableBrands => throw _privateConstructorUsedError;
  int get currentBrandPage => throw _privateConstructorUsedError;
  bool get hasMoreBrands => throw _privateConstructorUsedError;
  bool get isBrandPaginationLoading =>
      throw _privateConstructorUsedError; // Product List
  List<ProductItemModel> get allProducts => throw _privateConstructorUsedError;
  List<ProductItemModel> get filteredProducts =>
      throw _privateConstructorUsedError; // Pagination
  int get currentPage => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  bool get isPaginationLoading => throw _privateConstructorUsedError;
  bool get hasMoreData => throw _privateConstructorUsedError;

  /// Create a copy of ProductState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductStateCopyWith<ProductState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductStateCopyWith<$Res> {
  factory $ProductStateCopyWith(
    ProductState value,
    $Res Function(ProductState) then,
  ) = _$ProductStateCopyWithImpl<$Res, ProductState>;
  @useResult
  $Res call({
    ProductRequestStatus status,
    String errorMessage,
    bool isSearchActive,
    String searchQuery,
    List<ProductChipModel> chips,
    int selectedChipIndex,
    String? selectedCategoryId,
    String? selectedBrandId,
    String? selectedSubPlanId,
    String? selectedSubPlanName,
    bool isOnlyAvailable,
    ProductChipModel? activeFilterChip,
    List<CategoryDtoModel> availableCategories,
    int currentCategoryPage,
    bool hasMoreCategories,
    bool isCategoryPaginationLoading,
    List<SubPlanDtoModel> availableSubPlans,
    int currentSubPlanPage,
    bool hasMoreSubPlans,
    bool isSubPlanPaginationLoading,
    List<BrandDtoModel> availableBrands,
    int currentBrandPage,
    bool hasMoreBrands,
    bool isBrandPaginationLoading,
    List<ProductItemModel> allProducts,
    List<ProductItemModel> filteredProducts,
    int currentPage,
    int totalCount,
    bool isPaginationLoading,
    bool hasMoreData,
  });
}

/// @nodoc
class _$ProductStateCopyWithImpl<$Res, $Val extends ProductState>
    implements $ProductStateCopyWith<$Res> {
  _$ProductStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? errorMessage = null,
    Object? isSearchActive = null,
    Object? searchQuery = null,
    Object? chips = null,
    Object? selectedChipIndex = null,
    Object? selectedCategoryId = freezed,
    Object? selectedBrandId = freezed,
    Object? selectedSubPlanId = freezed,
    Object? selectedSubPlanName = freezed,
    Object? isOnlyAvailable = null,
    Object? activeFilterChip = freezed,
    Object? availableCategories = null,
    Object? currentCategoryPage = null,
    Object? hasMoreCategories = null,
    Object? isCategoryPaginationLoading = null,
    Object? availableSubPlans = null,
    Object? currentSubPlanPage = null,
    Object? hasMoreSubPlans = null,
    Object? isSubPlanPaginationLoading = null,
    Object? availableBrands = null,
    Object? currentBrandPage = null,
    Object? hasMoreBrands = null,
    Object? isBrandPaginationLoading = null,
    Object? allProducts = null,
    Object? filteredProducts = null,
    Object? currentPage = null,
    Object? totalCount = null,
    Object? isPaginationLoading = null,
    Object? hasMoreData = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ProductRequestStatus,
            errorMessage: null == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String,
            isSearchActive: null == isSearchActive
                ? _value.isSearchActive
                : isSearchActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            searchQuery: null == searchQuery
                ? _value.searchQuery
                : searchQuery // ignore: cast_nullable_to_non_nullable
                      as String,
            chips: null == chips
                ? _value.chips
                : chips // ignore: cast_nullable_to_non_nullable
                      as List<ProductChipModel>,
            selectedChipIndex: null == selectedChipIndex
                ? _value.selectedChipIndex
                : selectedChipIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            selectedCategoryId: freezed == selectedCategoryId
                ? _value.selectedCategoryId
                : selectedCategoryId // ignore: cast_nullable_to_non_nullable
                      as String?,
            selectedBrandId: freezed == selectedBrandId
                ? _value.selectedBrandId
                : selectedBrandId // ignore: cast_nullable_to_non_nullable
                      as String?,
            selectedSubPlanId: freezed == selectedSubPlanId
                ? _value.selectedSubPlanId
                : selectedSubPlanId // ignore: cast_nullable_to_non_nullable
                      as String?,
            selectedSubPlanName: freezed == selectedSubPlanName
                ? _value.selectedSubPlanName
                : selectedSubPlanName // ignore: cast_nullable_to_non_nullable
                      as String?,
            isOnlyAvailable: null == isOnlyAvailable
                ? _value.isOnlyAvailable
                : isOnlyAvailable // ignore: cast_nullable_to_non_nullable
                      as bool,
            activeFilterChip: freezed == activeFilterChip
                ? _value.activeFilterChip
                : activeFilterChip // ignore: cast_nullable_to_non_nullable
                      as ProductChipModel?,
            availableCategories: null == availableCategories
                ? _value.availableCategories
                : availableCategories // ignore: cast_nullable_to_non_nullable
                      as List<CategoryDtoModel>,
            currentCategoryPage: null == currentCategoryPage
                ? _value.currentCategoryPage
                : currentCategoryPage // ignore: cast_nullable_to_non_nullable
                      as int,
            hasMoreCategories: null == hasMoreCategories
                ? _value.hasMoreCategories
                : hasMoreCategories // ignore: cast_nullable_to_non_nullable
                      as bool,
            isCategoryPaginationLoading: null == isCategoryPaginationLoading
                ? _value.isCategoryPaginationLoading
                : isCategoryPaginationLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            availableSubPlans: null == availableSubPlans
                ? _value.availableSubPlans
                : availableSubPlans // ignore: cast_nullable_to_non_nullable
                      as List<SubPlanDtoModel>,
            currentSubPlanPage: null == currentSubPlanPage
                ? _value.currentSubPlanPage
                : currentSubPlanPage // ignore: cast_nullable_to_non_nullable
                      as int,
            hasMoreSubPlans: null == hasMoreSubPlans
                ? _value.hasMoreSubPlans
                : hasMoreSubPlans // ignore: cast_nullable_to_non_nullable
                      as bool,
            isSubPlanPaginationLoading: null == isSubPlanPaginationLoading
                ? _value.isSubPlanPaginationLoading
                : isSubPlanPaginationLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            availableBrands: null == availableBrands
                ? _value.availableBrands
                : availableBrands // ignore: cast_nullable_to_non_nullable
                      as List<BrandDtoModel>,
            currentBrandPage: null == currentBrandPage
                ? _value.currentBrandPage
                : currentBrandPage // ignore: cast_nullable_to_non_nullable
                      as int,
            hasMoreBrands: null == hasMoreBrands
                ? _value.hasMoreBrands
                : hasMoreBrands // ignore: cast_nullable_to_non_nullable
                      as bool,
            isBrandPaginationLoading: null == isBrandPaginationLoading
                ? _value.isBrandPaginationLoading
                : isBrandPaginationLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            allProducts: null == allProducts
                ? _value.allProducts
                : allProducts // ignore: cast_nullable_to_non_nullable
                      as List<ProductItemModel>,
            filteredProducts: null == filteredProducts
                ? _value.filteredProducts
                : filteredProducts // ignore: cast_nullable_to_non_nullable
                      as List<ProductItemModel>,
            currentPage: null == currentPage
                ? _value.currentPage
                : currentPage // ignore: cast_nullable_to_non_nullable
                      as int,
            totalCount: null == totalCount
                ? _value.totalCount
                : totalCount // ignore: cast_nullable_to_non_nullable
                      as int,
            isPaginationLoading: null == isPaginationLoading
                ? _value.isPaginationLoading
                : isPaginationLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasMoreData: null == hasMoreData
                ? _value.hasMoreData
                : hasMoreData // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProductStateImplCopyWith<$Res>
    implements $ProductStateCopyWith<$Res> {
  factory _$$ProductStateImplCopyWith(
    _$ProductStateImpl value,
    $Res Function(_$ProductStateImpl) then,
  ) = __$$ProductStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ProductRequestStatus status,
    String errorMessage,
    bool isSearchActive,
    String searchQuery,
    List<ProductChipModel> chips,
    int selectedChipIndex,
    String? selectedCategoryId,
    String? selectedBrandId,
    String? selectedSubPlanId,
    String? selectedSubPlanName,
    bool isOnlyAvailable,
    ProductChipModel? activeFilterChip,
    List<CategoryDtoModel> availableCategories,
    int currentCategoryPage,
    bool hasMoreCategories,
    bool isCategoryPaginationLoading,
    List<SubPlanDtoModel> availableSubPlans,
    int currentSubPlanPage,
    bool hasMoreSubPlans,
    bool isSubPlanPaginationLoading,
    List<BrandDtoModel> availableBrands,
    int currentBrandPage,
    bool hasMoreBrands,
    bool isBrandPaginationLoading,
    List<ProductItemModel> allProducts,
    List<ProductItemModel> filteredProducts,
    int currentPage,
    int totalCount,
    bool isPaginationLoading,
    bool hasMoreData,
  });
}

/// @nodoc
class __$$ProductStateImplCopyWithImpl<$Res>
    extends _$ProductStateCopyWithImpl<$Res, _$ProductStateImpl>
    implements _$$ProductStateImplCopyWith<$Res> {
  __$$ProductStateImplCopyWithImpl(
    _$ProductStateImpl _value,
    $Res Function(_$ProductStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? errorMessage = null,
    Object? isSearchActive = null,
    Object? searchQuery = null,
    Object? chips = null,
    Object? selectedChipIndex = null,
    Object? selectedCategoryId = freezed,
    Object? selectedBrandId = freezed,
    Object? selectedSubPlanId = freezed,
    Object? selectedSubPlanName = freezed,
    Object? isOnlyAvailable = null,
    Object? activeFilterChip = freezed,
    Object? availableCategories = null,
    Object? currentCategoryPage = null,
    Object? hasMoreCategories = null,
    Object? isCategoryPaginationLoading = null,
    Object? availableSubPlans = null,
    Object? currentSubPlanPage = null,
    Object? hasMoreSubPlans = null,
    Object? isSubPlanPaginationLoading = null,
    Object? availableBrands = null,
    Object? currentBrandPage = null,
    Object? hasMoreBrands = null,
    Object? isBrandPaginationLoading = null,
    Object? allProducts = null,
    Object? filteredProducts = null,
    Object? currentPage = null,
    Object? totalCount = null,
    Object? isPaginationLoading = null,
    Object? hasMoreData = null,
  }) {
    return _then(
      _$ProductStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ProductRequestStatus,
        errorMessage: null == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String,
        isSearchActive: null == isSearchActive
            ? _value.isSearchActive
            : isSearchActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        searchQuery: null == searchQuery
            ? _value.searchQuery
            : searchQuery // ignore: cast_nullable_to_non_nullable
                  as String,
        chips: null == chips
            ? _value._chips
            : chips // ignore: cast_nullable_to_non_nullable
                  as List<ProductChipModel>,
        selectedChipIndex: null == selectedChipIndex
            ? _value.selectedChipIndex
            : selectedChipIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        selectedCategoryId: freezed == selectedCategoryId
            ? _value.selectedCategoryId
            : selectedCategoryId // ignore: cast_nullable_to_non_nullable
                  as String?,
        selectedBrandId: freezed == selectedBrandId
            ? _value.selectedBrandId
            : selectedBrandId // ignore: cast_nullable_to_non_nullable
                  as String?,
        selectedSubPlanId: freezed == selectedSubPlanId
            ? _value.selectedSubPlanId
            : selectedSubPlanId // ignore: cast_nullable_to_non_nullable
                  as String?,
        selectedSubPlanName: freezed == selectedSubPlanName
            ? _value.selectedSubPlanName
            : selectedSubPlanName // ignore: cast_nullable_to_non_nullable
                  as String?,
        isOnlyAvailable: null == isOnlyAvailable
            ? _value.isOnlyAvailable
            : isOnlyAvailable // ignore: cast_nullable_to_non_nullable
                  as bool,
        activeFilterChip: freezed == activeFilterChip
            ? _value.activeFilterChip
            : activeFilterChip // ignore: cast_nullable_to_non_nullable
                  as ProductChipModel?,
        availableCategories: null == availableCategories
            ? _value._availableCategories
            : availableCategories // ignore: cast_nullable_to_non_nullable
                  as List<CategoryDtoModel>,
        currentCategoryPage: null == currentCategoryPage
            ? _value.currentCategoryPage
            : currentCategoryPage // ignore: cast_nullable_to_non_nullable
                  as int,
        hasMoreCategories: null == hasMoreCategories
            ? _value.hasMoreCategories
            : hasMoreCategories // ignore: cast_nullable_to_non_nullable
                  as bool,
        isCategoryPaginationLoading: null == isCategoryPaginationLoading
            ? _value.isCategoryPaginationLoading
            : isCategoryPaginationLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        availableSubPlans: null == availableSubPlans
            ? _value._availableSubPlans
            : availableSubPlans // ignore: cast_nullable_to_non_nullable
                  as List<SubPlanDtoModel>,
        currentSubPlanPage: null == currentSubPlanPage
            ? _value.currentSubPlanPage
            : currentSubPlanPage // ignore: cast_nullable_to_non_nullable
                  as int,
        hasMoreSubPlans: null == hasMoreSubPlans
            ? _value.hasMoreSubPlans
            : hasMoreSubPlans // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSubPlanPaginationLoading: null == isSubPlanPaginationLoading
            ? _value.isSubPlanPaginationLoading
            : isSubPlanPaginationLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        availableBrands: null == availableBrands
            ? _value._availableBrands
            : availableBrands // ignore: cast_nullable_to_non_nullable
                  as List<BrandDtoModel>,
        currentBrandPage: null == currentBrandPage
            ? _value.currentBrandPage
            : currentBrandPage // ignore: cast_nullable_to_non_nullable
                  as int,
        hasMoreBrands: null == hasMoreBrands
            ? _value.hasMoreBrands
            : hasMoreBrands // ignore: cast_nullable_to_non_nullable
                  as bool,
        isBrandPaginationLoading: null == isBrandPaginationLoading
            ? _value.isBrandPaginationLoading
            : isBrandPaginationLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        allProducts: null == allProducts
            ? _value._allProducts
            : allProducts // ignore: cast_nullable_to_non_nullable
                  as List<ProductItemModel>,
        filteredProducts: null == filteredProducts
            ? _value._filteredProducts
            : filteredProducts // ignore: cast_nullable_to_non_nullable
                  as List<ProductItemModel>,
        currentPage: null == currentPage
            ? _value.currentPage
            : currentPage // ignore: cast_nullable_to_non_nullable
                  as int,
        totalCount: null == totalCount
            ? _value.totalCount
            : totalCount // ignore: cast_nullable_to_non_nullable
                  as int,
        isPaginationLoading: null == isPaginationLoading
            ? _value.isPaginationLoading
            : isPaginationLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasMoreData: null == hasMoreData
            ? _value.hasMoreData
            : hasMoreData // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$ProductStateImpl implements _ProductState {
  const _$ProductStateImpl({
    this.status = ProductRequestStatus.initial,
    this.errorMessage = '',
    this.isSearchActive = false,
    this.searchQuery = '',
    final List<ProductChipModel> chips = const [],
    this.selectedChipIndex = -1,
    this.selectedCategoryId,
    this.selectedBrandId,
    this.selectedSubPlanId,
    this.selectedSubPlanName,
    this.isOnlyAvailable = false,
    this.activeFilterChip,
    final List<CategoryDtoModel> availableCategories = const [],
    this.currentCategoryPage = 1,
    this.hasMoreCategories = false,
    this.isCategoryPaginationLoading = false,
    final List<SubPlanDtoModel> availableSubPlans = const [],
    this.currentSubPlanPage = 1,
    this.hasMoreSubPlans = false,
    this.isSubPlanPaginationLoading = false,
    final List<BrandDtoModel> availableBrands = const [],
    this.currentBrandPage = 1,
    this.hasMoreBrands = false,
    this.isBrandPaginationLoading = false,
    final List<ProductItemModel> allProducts = const [],
    final List<ProductItemModel> filteredProducts = const [],
    this.currentPage = 1,
    this.totalCount = 0,
    this.isPaginationLoading = false,
    this.hasMoreData = true,
  }) : _chips = chips,
       _availableCategories = availableCategories,
       _availableSubPlans = availableSubPlans,
       _availableBrands = availableBrands,
       _allProducts = allProducts,
       _filteredProducts = filteredProducts;

  @override
  @JsonKey()
  final ProductRequestStatus status;
  @override
  @JsonKey()
  final String errorMessage;
  // AppBar
  @override
  @JsonKey()
  final bool isSearchActive;
  @override
  @JsonKey()
  final String searchQuery;
  // Choice Chips
  final List<ProductChipModel> _chips;
  // Choice Chips
  @override
  @JsonKey()
  List<ProductChipModel> get chips {
    if (_chips is EqualUnmodifiableListView) return _chips;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chips);
  }

  @override
  @JsonKey()
  final int selectedChipIndex;
  // -1 means no chip is selected by default
  @override
  final String? selectedCategoryId;
  @override
  final String? selectedBrandId;
  @override
  final String? selectedSubPlanId;
  @override
  final String? selectedSubPlanName;
  @override
  @JsonKey()
  final bool isOnlyAvailable;
  @override
  final ProductChipModel? activeFilterChip;
  // Dynamic Filter Data
  final List<CategoryDtoModel> _availableCategories;
  // Dynamic Filter Data
  @override
  @JsonKey()
  List<CategoryDtoModel> get availableCategories {
    if (_availableCategories is EqualUnmodifiableListView)
      return _availableCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableCategories);
  }

  @override
  @JsonKey()
  final int currentCategoryPage;
  @override
  @JsonKey()
  final bool hasMoreCategories;
  @override
  @JsonKey()
  final bool isCategoryPaginationLoading;
  final List<SubPlanDtoModel> _availableSubPlans;
  @override
  @JsonKey()
  List<SubPlanDtoModel> get availableSubPlans {
    if (_availableSubPlans is EqualUnmodifiableListView)
      return _availableSubPlans;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableSubPlans);
  }

  @override
  @JsonKey()
  final int currentSubPlanPage;
  @override
  @JsonKey()
  final bool hasMoreSubPlans;
  @override
  @JsonKey()
  final bool isSubPlanPaginationLoading;
  final List<BrandDtoModel> _availableBrands;
  @override
  @JsonKey()
  List<BrandDtoModel> get availableBrands {
    if (_availableBrands is EqualUnmodifiableListView) return _availableBrands;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableBrands);
  }

  @override
  @JsonKey()
  final int currentBrandPage;
  @override
  @JsonKey()
  final bool hasMoreBrands;
  @override
  @JsonKey()
  final bool isBrandPaginationLoading;
  // Product List
  final List<ProductItemModel> _allProducts;
  // Product List
  @override
  @JsonKey()
  List<ProductItemModel> get allProducts {
    if (_allProducts is EqualUnmodifiableListView) return _allProducts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allProducts);
  }

  final List<ProductItemModel> _filteredProducts;
  @override
  @JsonKey()
  List<ProductItemModel> get filteredProducts {
    if (_filteredProducts is EqualUnmodifiableListView)
      return _filteredProducts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredProducts);
  }

  // Pagination
  @override
  @JsonKey()
  final int currentPage;
  @override
  @JsonKey()
  final int totalCount;
  @override
  @JsonKey()
  final bool isPaginationLoading;
  @override
  @JsonKey()
  final bool hasMoreData;

  @override
  String toString() {
    return 'ProductState(status: $status, errorMessage: $errorMessage, isSearchActive: $isSearchActive, searchQuery: $searchQuery, chips: $chips, selectedChipIndex: $selectedChipIndex, selectedCategoryId: $selectedCategoryId, selectedBrandId: $selectedBrandId, selectedSubPlanId: $selectedSubPlanId, selectedSubPlanName: $selectedSubPlanName, isOnlyAvailable: $isOnlyAvailable, activeFilterChip: $activeFilterChip, availableCategories: $availableCategories, currentCategoryPage: $currentCategoryPage, hasMoreCategories: $hasMoreCategories, isCategoryPaginationLoading: $isCategoryPaginationLoading, availableSubPlans: $availableSubPlans, currentSubPlanPage: $currentSubPlanPage, hasMoreSubPlans: $hasMoreSubPlans, isSubPlanPaginationLoading: $isSubPlanPaginationLoading, availableBrands: $availableBrands, currentBrandPage: $currentBrandPage, hasMoreBrands: $hasMoreBrands, isBrandPaginationLoading: $isBrandPaginationLoading, allProducts: $allProducts, filteredProducts: $filteredProducts, currentPage: $currentPage, totalCount: $totalCount, isPaginationLoading: $isPaginationLoading, hasMoreData: $hasMoreData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.isSearchActive, isSearchActive) ||
                other.isSearchActive == isSearchActive) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            const DeepCollectionEquality().equals(other._chips, _chips) &&
            (identical(other.selectedChipIndex, selectedChipIndex) ||
                other.selectedChipIndex == selectedChipIndex) &&
            (identical(other.selectedCategoryId, selectedCategoryId) ||
                other.selectedCategoryId == selectedCategoryId) &&
            (identical(other.selectedBrandId, selectedBrandId) ||
                other.selectedBrandId == selectedBrandId) &&
            (identical(other.selectedSubPlanId, selectedSubPlanId) ||
                other.selectedSubPlanId == selectedSubPlanId) &&
            (identical(other.selectedSubPlanName, selectedSubPlanName) ||
                other.selectedSubPlanName == selectedSubPlanName) &&
            (identical(other.isOnlyAvailable, isOnlyAvailable) ||
                other.isOnlyAvailable == isOnlyAvailable) &&
            (identical(other.activeFilterChip, activeFilterChip) ||
                other.activeFilterChip == activeFilterChip) &&
            const DeepCollectionEquality().equals(
              other._availableCategories,
              _availableCategories,
            ) &&
            (identical(other.currentCategoryPage, currentCategoryPage) ||
                other.currentCategoryPage == currentCategoryPage) &&
            (identical(other.hasMoreCategories, hasMoreCategories) ||
                other.hasMoreCategories == hasMoreCategories) &&
            (identical(
                  other.isCategoryPaginationLoading,
                  isCategoryPaginationLoading,
                ) ||
                other.isCategoryPaginationLoading ==
                    isCategoryPaginationLoading) &&
            const DeepCollectionEquality().equals(
              other._availableSubPlans,
              _availableSubPlans,
            ) &&
            (identical(other.currentSubPlanPage, currentSubPlanPage) ||
                other.currentSubPlanPage == currentSubPlanPage) &&
            (identical(other.hasMoreSubPlans, hasMoreSubPlans) ||
                other.hasMoreSubPlans == hasMoreSubPlans) &&
            (identical(
                  other.isSubPlanPaginationLoading,
                  isSubPlanPaginationLoading,
                ) ||
                other.isSubPlanPaginationLoading ==
                    isSubPlanPaginationLoading) &&
            const DeepCollectionEquality().equals(
              other._availableBrands,
              _availableBrands,
            ) &&
            (identical(other.currentBrandPage, currentBrandPage) ||
                other.currentBrandPage == currentBrandPage) &&
            (identical(other.hasMoreBrands, hasMoreBrands) ||
                other.hasMoreBrands == hasMoreBrands) &&
            (identical(
                  other.isBrandPaginationLoading,
                  isBrandPaginationLoading,
                ) ||
                other.isBrandPaginationLoading == isBrandPaginationLoading) &&
            const DeepCollectionEquality().equals(
              other._allProducts,
              _allProducts,
            ) &&
            const DeepCollectionEquality().equals(
              other._filteredProducts,
              _filteredProducts,
            ) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.isPaginationLoading, isPaginationLoading) ||
                other.isPaginationLoading == isPaginationLoading) &&
            (identical(other.hasMoreData, hasMoreData) ||
                other.hasMoreData == hasMoreData));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    status,
    errorMessage,
    isSearchActive,
    searchQuery,
    const DeepCollectionEquality().hash(_chips),
    selectedChipIndex,
    selectedCategoryId,
    selectedBrandId,
    selectedSubPlanId,
    selectedSubPlanName,
    isOnlyAvailable,
    activeFilterChip,
    const DeepCollectionEquality().hash(_availableCategories),
    currentCategoryPage,
    hasMoreCategories,
    isCategoryPaginationLoading,
    const DeepCollectionEquality().hash(_availableSubPlans),
    currentSubPlanPage,
    hasMoreSubPlans,
    isSubPlanPaginationLoading,
    const DeepCollectionEquality().hash(_availableBrands),
    currentBrandPage,
    hasMoreBrands,
    isBrandPaginationLoading,
    const DeepCollectionEquality().hash(_allProducts),
    const DeepCollectionEquality().hash(_filteredProducts),
    currentPage,
    totalCount,
    isPaginationLoading,
    hasMoreData,
  ]);

  /// Create a copy of ProductState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductStateImplCopyWith<_$ProductStateImpl> get copyWith =>
      __$$ProductStateImplCopyWithImpl<_$ProductStateImpl>(this, _$identity);
}

abstract class _ProductState implements ProductState {
  const factory _ProductState({
    final ProductRequestStatus status,
    final String errorMessage,
    final bool isSearchActive,
    final String searchQuery,
    final List<ProductChipModel> chips,
    final int selectedChipIndex,
    final String? selectedCategoryId,
    final String? selectedBrandId,
    final String? selectedSubPlanId,
    final String? selectedSubPlanName,
    final bool isOnlyAvailable,
    final ProductChipModel? activeFilterChip,
    final List<CategoryDtoModel> availableCategories,
    final int currentCategoryPage,
    final bool hasMoreCategories,
    final bool isCategoryPaginationLoading,
    final List<SubPlanDtoModel> availableSubPlans,
    final int currentSubPlanPage,
    final bool hasMoreSubPlans,
    final bool isSubPlanPaginationLoading,
    final List<BrandDtoModel> availableBrands,
    final int currentBrandPage,
    final bool hasMoreBrands,
    final bool isBrandPaginationLoading,
    final List<ProductItemModel> allProducts,
    final List<ProductItemModel> filteredProducts,
    final int currentPage,
    final int totalCount,
    final bool isPaginationLoading,
    final bool hasMoreData,
  }) = _$ProductStateImpl;

  @override
  ProductRequestStatus get status;
  @override
  String get errorMessage; // AppBar
  @override
  bool get isSearchActive;
  @override
  String get searchQuery; // Choice Chips
  @override
  List<ProductChipModel> get chips;
  @override
  int get selectedChipIndex; // -1 means no chip is selected by default
  @override
  String? get selectedCategoryId;
  @override
  String? get selectedBrandId;
  @override
  String? get selectedSubPlanId;
  @override
  String? get selectedSubPlanName;
  @override
  bool get isOnlyAvailable;
  @override
  ProductChipModel? get activeFilterChip; // Dynamic Filter Data
  @override
  List<CategoryDtoModel> get availableCategories;
  @override
  int get currentCategoryPage;
  @override
  bool get hasMoreCategories;
  @override
  bool get isCategoryPaginationLoading;
  @override
  List<SubPlanDtoModel> get availableSubPlans;
  @override
  int get currentSubPlanPage;
  @override
  bool get hasMoreSubPlans;
  @override
  bool get isSubPlanPaginationLoading;
  @override
  List<BrandDtoModel> get availableBrands;
  @override
  int get currentBrandPage;
  @override
  bool get hasMoreBrands;
  @override
  bool get isBrandPaginationLoading; // Product List
  @override
  List<ProductItemModel> get allProducts;
  @override
  List<ProductItemModel> get filteredProducts; // Pagination
  @override
  int get currentPage;
  @override
  int get totalCount;
  @override
  bool get isPaginationLoading;
  @override
  bool get hasMoreData;

  /// Create a copy of ProductState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductStateImplCopyWith<_$ProductStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
