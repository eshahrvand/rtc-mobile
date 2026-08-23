// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ReportState {
  ReportStep get step => throw _privateConstructorUsedError;
  ReportRequestStatus get status => throw _privateConstructorUsedError;
  List<ReportItemModel> get items => throw _privateConstructorUsedError;
  List<ReportItemModel> get filteredItems => throw _privateConstructorUsedError;
  List<ReportSummaryMetric> get summaryMetrics =>
      throw _privateConstructorUsedError;
  String get searchQuery => throw _privateConstructorUsedError;
  bool get isSearchActive => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError; // Filters
  String? get selectedPlanId => throw _privateConstructorUsedError;
  String? get selectedCategoryId => throw _privateConstructorUsedError;
  String? get selectedParentCategoryId => throw _privateConstructorUsedError;
  Jalali? get startDate => throw _privateConstructorUsedError;
  Jalali? get endDate => throw _privateConstructorUsedError;
  String? get dateOptionId => throw _privateConstructorUsedError; // Filter Data
  List<SubPlanDtoModel> get subPlans => throw _privateConstructorUsedError;
  List<CategoryDtoModel> get categories =>
      throw _privateConstructorUsedError; // Filter Pagination
  int get currentCategoryPage => throw _privateConstructorUsedError;
  bool get hasMoreCategories => throw _privateConstructorUsedError;
  bool get isCategoryPaginationLoading => throw _privateConstructorUsedError;
  int get currentSubPlanPage => throw _privateConstructorUsedError;
  bool get hasMoreSubPlans => throw _privateConstructorUsedError;
  bool get isSubPlanPaginationLoading =>
      throw _privateConstructorUsedError; // Pagination
  int get currentPage => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  bool get hasMoreData => throw _privateConstructorUsedError;
  bool get isPaginationLoading => throw _privateConstructorUsedError;

  /// Create a copy of ReportState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReportStateCopyWith<ReportState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportStateCopyWith<$Res> {
  factory $ReportStateCopyWith(
    ReportState value,
    $Res Function(ReportState) then,
  ) = _$ReportStateCopyWithImpl<$Res, ReportState>;
  @useResult
  $Res call({
    ReportStep step,
    ReportRequestStatus status,
    List<ReportItemModel> items,
    List<ReportItemModel> filteredItems,
    List<ReportSummaryMetric> summaryMetrics,
    String searchQuery,
    bool isSearchActive,
    String errorMessage,
    String? selectedPlanId,
    String? selectedCategoryId,
    String? selectedParentCategoryId,
    Jalali? startDate,
    Jalali? endDate,
    String? dateOptionId,
    List<SubPlanDtoModel> subPlans,
    List<CategoryDtoModel> categories,
    int currentCategoryPage,
    bool hasMoreCategories,
    bool isCategoryPaginationLoading,
    int currentSubPlanPage,
    bool hasMoreSubPlans,
    bool isSubPlanPaginationLoading,
    int currentPage,
    int totalCount,
    bool hasMoreData,
    bool isPaginationLoading,
  });
}

/// @nodoc
class _$ReportStateCopyWithImpl<$Res, $Val extends ReportState>
    implements $ReportStateCopyWith<$Res> {
  _$ReportStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReportState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? step = null,
    Object? status = null,
    Object? items = null,
    Object? filteredItems = null,
    Object? summaryMetrics = null,
    Object? searchQuery = null,
    Object? isSearchActive = null,
    Object? errorMessage = null,
    Object? selectedPlanId = freezed,
    Object? selectedCategoryId = freezed,
    Object? selectedParentCategoryId = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? dateOptionId = freezed,
    Object? subPlans = null,
    Object? categories = null,
    Object? currentCategoryPage = null,
    Object? hasMoreCategories = null,
    Object? isCategoryPaginationLoading = null,
    Object? currentSubPlanPage = null,
    Object? hasMoreSubPlans = null,
    Object? isSubPlanPaginationLoading = null,
    Object? currentPage = null,
    Object? totalCount = null,
    Object? hasMoreData = null,
    Object? isPaginationLoading = null,
  }) {
    return _then(
      _value.copyWith(
            step: null == step
                ? _value.step
                : step // ignore: cast_nullable_to_non_nullable
                      as ReportStep,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ReportRequestStatus,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<ReportItemModel>,
            filteredItems: null == filteredItems
                ? _value.filteredItems
                : filteredItems // ignore: cast_nullable_to_non_nullable
                      as List<ReportItemModel>,
            summaryMetrics: null == summaryMetrics
                ? _value.summaryMetrics
                : summaryMetrics // ignore: cast_nullable_to_non_nullable
                      as List<ReportSummaryMetric>,
            searchQuery: null == searchQuery
                ? _value.searchQuery
                : searchQuery // ignore: cast_nullable_to_non_nullable
                      as String,
            isSearchActive: null == isSearchActive
                ? _value.isSearchActive
                : isSearchActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            errorMessage: null == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String,
            selectedPlanId: freezed == selectedPlanId
                ? _value.selectedPlanId
                : selectedPlanId // ignore: cast_nullable_to_non_nullable
                      as String?,
            selectedCategoryId: freezed == selectedCategoryId
                ? _value.selectedCategoryId
                : selectedCategoryId // ignore: cast_nullable_to_non_nullable
                      as String?,
            selectedParentCategoryId: freezed == selectedParentCategoryId
                ? _value.selectedParentCategoryId
                : selectedParentCategoryId // ignore: cast_nullable_to_non_nullable
                      as String?,
            startDate: freezed == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as Jalali?,
            endDate: freezed == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as Jalali?,
            dateOptionId: freezed == dateOptionId
                ? _value.dateOptionId
                : dateOptionId // ignore: cast_nullable_to_non_nullable
                      as String?,
            subPlans: null == subPlans
                ? _value.subPlans
                : subPlans // ignore: cast_nullable_to_non_nullable
                      as List<SubPlanDtoModel>,
            categories: null == categories
                ? _value.categories
                : categories // ignore: cast_nullable_to_non_nullable
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
            currentPage: null == currentPage
                ? _value.currentPage
                : currentPage // ignore: cast_nullable_to_non_nullable
                      as int,
            totalCount: null == totalCount
                ? _value.totalCount
                : totalCount // ignore: cast_nullable_to_non_nullable
                      as int,
            hasMoreData: null == hasMoreData
                ? _value.hasMoreData
                : hasMoreData // ignore: cast_nullable_to_non_nullable
                      as bool,
            isPaginationLoading: null == isPaginationLoading
                ? _value.isPaginationLoading
                : isPaginationLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReportStateImplCopyWith<$Res>
    implements $ReportStateCopyWith<$Res> {
  factory _$$ReportStateImplCopyWith(
    _$ReportStateImpl value,
    $Res Function(_$ReportStateImpl) then,
  ) = __$$ReportStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ReportStep step,
    ReportRequestStatus status,
    List<ReportItemModel> items,
    List<ReportItemModel> filteredItems,
    List<ReportSummaryMetric> summaryMetrics,
    String searchQuery,
    bool isSearchActive,
    String errorMessage,
    String? selectedPlanId,
    String? selectedCategoryId,
    String? selectedParentCategoryId,
    Jalali? startDate,
    Jalali? endDate,
    String? dateOptionId,
    List<SubPlanDtoModel> subPlans,
    List<CategoryDtoModel> categories,
    int currentCategoryPage,
    bool hasMoreCategories,
    bool isCategoryPaginationLoading,
    int currentSubPlanPage,
    bool hasMoreSubPlans,
    bool isSubPlanPaginationLoading,
    int currentPage,
    int totalCount,
    bool hasMoreData,
    bool isPaginationLoading,
  });
}

/// @nodoc
class __$$ReportStateImplCopyWithImpl<$Res>
    extends _$ReportStateCopyWithImpl<$Res, _$ReportStateImpl>
    implements _$$ReportStateImplCopyWith<$Res> {
  __$$ReportStateImplCopyWithImpl(
    _$ReportStateImpl _value,
    $Res Function(_$ReportStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReportState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? step = null,
    Object? status = null,
    Object? items = null,
    Object? filteredItems = null,
    Object? summaryMetrics = null,
    Object? searchQuery = null,
    Object? isSearchActive = null,
    Object? errorMessage = null,
    Object? selectedPlanId = freezed,
    Object? selectedCategoryId = freezed,
    Object? selectedParentCategoryId = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? dateOptionId = freezed,
    Object? subPlans = null,
    Object? categories = null,
    Object? currentCategoryPage = null,
    Object? hasMoreCategories = null,
    Object? isCategoryPaginationLoading = null,
    Object? currentSubPlanPage = null,
    Object? hasMoreSubPlans = null,
    Object? isSubPlanPaginationLoading = null,
    Object? currentPage = null,
    Object? totalCount = null,
    Object? hasMoreData = null,
    Object? isPaginationLoading = null,
  }) {
    return _then(
      _$ReportStateImpl(
        step: null == step
            ? _value.step
            : step // ignore: cast_nullable_to_non_nullable
                  as ReportStep,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ReportRequestStatus,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<ReportItemModel>,
        filteredItems: null == filteredItems
            ? _value._filteredItems
            : filteredItems // ignore: cast_nullable_to_non_nullable
                  as List<ReportItemModel>,
        summaryMetrics: null == summaryMetrics
            ? _value._summaryMetrics
            : summaryMetrics // ignore: cast_nullable_to_non_nullable
                  as List<ReportSummaryMetric>,
        searchQuery: null == searchQuery
            ? _value.searchQuery
            : searchQuery // ignore: cast_nullable_to_non_nullable
                  as String,
        isSearchActive: null == isSearchActive
            ? _value.isSearchActive
            : isSearchActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        errorMessage: null == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String,
        selectedPlanId: freezed == selectedPlanId
            ? _value.selectedPlanId
            : selectedPlanId // ignore: cast_nullable_to_non_nullable
                  as String?,
        selectedCategoryId: freezed == selectedCategoryId
            ? _value.selectedCategoryId
            : selectedCategoryId // ignore: cast_nullable_to_non_nullable
                  as String?,
        selectedParentCategoryId: freezed == selectedParentCategoryId
            ? _value.selectedParentCategoryId
            : selectedParentCategoryId // ignore: cast_nullable_to_non_nullable
                  as String?,
        startDate: freezed == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as Jalali?,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as Jalali?,
        dateOptionId: freezed == dateOptionId
            ? _value.dateOptionId
            : dateOptionId // ignore: cast_nullable_to_non_nullable
                  as String?,
        subPlans: null == subPlans
            ? _value._subPlans
            : subPlans // ignore: cast_nullable_to_non_nullable
                  as List<SubPlanDtoModel>,
        categories: null == categories
            ? _value._categories
            : categories // ignore: cast_nullable_to_non_nullable
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
        currentPage: null == currentPage
            ? _value.currentPage
            : currentPage // ignore: cast_nullable_to_non_nullable
                  as int,
        totalCount: null == totalCount
            ? _value.totalCount
            : totalCount // ignore: cast_nullable_to_non_nullable
                  as int,
        hasMoreData: null == hasMoreData
            ? _value.hasMoreData
            : hasMoreData // ignore: cast_nullable_to_non_nullable
                  as bool,
        isPaginationLoading: null == isPaginationLoading
            ? _value.isPaginationLoading
            : isPaginationLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$ReportStateImpl implements _ReportState {
  const _$ReportStateImpl({
    this.step = ReportStep.sales,
    this.status = ReportRequestStatus.initial,
    final List<ReportItemModel> items = const [],
    final List<ReportItemModel> filteredItems = const [],
    final List<ReportSummaryMetric> summaryMetrics = const [],
    this.searchQuery = '',
    this.isSearchActive = false,
    this.errorMessage = '',
    this.selectedPlanId,
    this.selectedCategoryId,
    this.selectedParentCategoryId,
    this.startDate,
    this.endDate,
    this.dateOptionId,
    final List<SubPlanDtoModel> subPlans = const [],
    final List<CategoryDtoModel> categories = const [],
    this.currentCategoryPage = 1,
    this.hasMoreCategories = false,
    this.isCategoryPaginationLoading = false,
    this.currentSubPlanPage = 1,
    this.hasMoreSubPlans = false,
    this.isSubPlanPaginationLoading = false,
    this.currentPage = 1,
    this.totalCount = 0,
    this.hasMoreData = false,
    this.isPaginationLoading = false,
  }) : _items = items,
       _filteredItems = filteredItems,
       _summaryMetrics = summaryMetrics,
       _subPlans = subPlans,
       _categories = categories;

  @override
  @JsonKey()
  final ReportStep step;
  @override
  @JsonKey()
  final ReportRequestStatus status;
  final List<ReportItemModel> _items;
  @override
  @JsonKey()
  List<ReportItemModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  final List<ReportItemModel> _filteredItems;
  @override
  @JsonKey()
  List<ReportItemModel> get filteredItems {
    if (_filteredItems is EqualUnmodifiableListView) return _filteredItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredItems);
  }

  final List<ReportSummaryMetric> _summaryMetrics;
  @override
  @JsonKey()
  List<ReportSummaryMetric> get summaryMetrics {
    if (_summaryMetrics is EqualUnmodifiableListView) return _summaryMetrics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_summaryMetrics);
  }

  @override
  @JsonKey()
  final String searchQuery;
  @override
  @JsonKey()
  final bool isSearchActive;
  @override
  @JsonKey()
  final String errorMessage;
  // Filters
  @override
  final String? selectedPlanId;
  @override
  final String? selectedCategoryId;
  @override
  final String? selectedParentCategoryId;
  @override
  final Jalali? startDate;
  @override
  final Jalali? endDate;
  @override
  final String? dateOptionId;
  // Filter Data
  final List<SubPlanDtoModel> _subPlans;
  // Filter Data
  @override
  @JsonKey()
  List<SubPlanDtoModel> get subPlans {
    if (_subPlans is EqualUnmodifiableListView) return _subPlans;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subPlans);
  }

  final List<CategoryDtoModel> _categories;
  @override
  @JsonKey()
  List<CategoryDtoModel> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  // Filter Pagination
  @override
  @JsonKey()
  final int currentCategoryPage;
  @override
  @JsonKey()
  final bool hasMoreCategories;
  @override
  @JsonKey()
  final bool isCategoryPaginationLoading;
  @override
  @JsonKey()
  final int currentSubPlanPage;
  @override
  @JsonKey()
  final bool hasMoreSubPlans;
  @override
  @JsonKey()
  final bool isSubPlanPaginationLoading;
  // Pagination
  @override
  @JsonKey()
  final int currentPage;
  @override
  @JsonKey()
  final int totalCount;
  @override
  @JsonKey()
  final bool hasMoreData;
  @override
  @JsonKey()
  final bool isPaginationLoading;

  @override
  String toString() {
    return 'ReportState(step: $step, status: $status, items: $items, filteredItems: $filteredItems, summaryMetrics: $summaryMetrics, searchQuery: $searchQuery, isSearchActive: $isSearchActive, errorMessage: $errorMessage, selectedPlanId: $selectedPlanId, selectedCategoryId: $selectedCategoryId, selectedParentCategoryId: $selectedParentCategoryId, startDate: $startDate, endDate: $endDate, dateOptionId: $dateOptionId, subPlans: $subPlans, categories: $categories, currentCategoryPage: $currentCategoryPage, hasMoreCategories: $hasMoreCategories, isCategoryPaginationLoading: $isCategoryPaginationLoading, currentSubPlanPage: $currentSubPlanPage, hasMoreSubPlans: $hasMoreSubPlans, isSubPlanPaginationLoading: $isSubPlanPaginationLoading, currentPage: $currentPage, totalCount: $totalCount, hasMoreData: $hasMoreData, isPaginationLoading: $isPaginationLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportStateImpl &&
            (identical(other.step, step) || other.step == step) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            const DeepCollectionEquality().equals(
              other._filteredItems,
              _filteredItems,
            ) &&
            const DeepCollectionEquality().equals(
              other._summaryMetrics,
              _summaryMetrics,
            ) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.isSearchActive, isSearchActive) ||
                other.isSearchActive == isSearchActive) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.selectedPlanId, selectedPlanId) ||
                other.selectedPlanId == selectedPlanId) &&
            (identical(other.selectedCategoryId, selectedCategoryId) ||
                other.selectedCategoryId == selectedCategoryId) &&
            (identical(
                  other.selectedParentCategoryId,
                  selectedParentCategoryId,
                ) ||
                other.selectedParentCategoryId == selectedParentCategoryId) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.dateOptionId, dateOptionId) ||
                other.dateOptionId == dateOptionId) &&
            const DeepCollectionEquality().equals(other._subPlans, _subPlans) &&
            const DeepCollectionEquality().equals(
              other._categories,
              _categories,
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
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.hasMoreData, hasMoreData) ||
                other.hasMoreData == hasMoreData) &&
            (identical(other.isPaginationLoading, isPaginationLoading) ||
                other.isPaginationLoading == isPaginationLoading));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    step,
    status,
    const DeepCollectionEquality().hash(_items),
    const DeepCollectionEquality().hash(_filteredItems),
    const DeepCollectionEquality().hash(_summaryMetrics),
    searchQuery,
    isSearchActive,
    errorMessage,
    selectedPlanId,
    selectedCategoryId,
    selectedParentCategoryId,
    startDate,
    endDate,
    dateOptionId,
    const DeepCollectionEquality().hash(_subPlans),
    const DeepCollectionEquality().hash(_categories),
    currentCategoryPage,
    hasMoreCategories,
    isCategoryPaginationLoading,
    currentSubPlanPage,
    hasMoreSubPlans,
    isSubPlanPaginationLoading,
    currentPage,
    totalCount,
    hasMoreData,
    isPaginationLoading,
  ]);

  /// Create a copy of ReportState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportStateImplCopyWith<_$ReportStateImpl> get copyWith =>
      __$$ReportStateImplCopyWithImpl<_$ReportStateImpl>(this, _$identity);
}

abstract class _ReportState implements ReportState {
  const factory _ReportState({
    final ReportStep step,
    final ReportRequestStatus status,
    final List<ReportItemModel> items,
    final List<ReportItemModel> filteredItems,
    final List<ReportSummaryMetric> summaryMetrics,
    final String searchQuery,
    final bool isSearchActive,
    final String errorMessage,
    final String? selectedPlanId,
    final String? selectedCategoryId,
    final String? selectedParentCategoryId,
    final Jalali? startDate,
    final Jalali? endDate,
    final String? dateOptionId,
    final List<SubPlanDtoModel> subPlans,
    final List<CategoryDtoModel> categories,
    final int currentCategoryPage,
    final bool hasMoreCategories,
    final bool isCategoryPaginationLoading,
    final int currentSubPlanPage,
    final bool hasMoreSubPlans,
    final bool isSubPlanPaginationLoading,
    final int currentPage,
    final int totalCount,
    final bool hasMoreData,
    final bool isPaginationLoading,
  }) = _$ReportStateImpl;

  @override
  ReportStep get step;
  @override
  ReportRequestStatus get status;
  @override
  List<ReportItemModel> get items;
  @override
  List<ReportItemModel> get filteredItems;
  @override
  List<ReportSummaryMetric> get summaryMetrics;
  @override
  String get searchQuery;
  @override
  bool get isSearchActive;
  @override
  String get errorMessage; // Filters
  @override
  String? get selectedPlanId;
  @override
  String? get selectedCategoryId;
  @override
  String? get selectedParentCategoryId;
  @override
  Jalali? get startDate;
  @override
  Jalali? get endDate;
  @override
  String? get dateOptionId; // Filter Data
  @override
  List<SubPlanDtoModel> get subPlans;
  @override
  List<CategoryDtoModel> get categories; // Filter Pagination
  @override
  int get currentCategoryPage;
  @override
  bool get hasMoreCategories;
  @override
  bool get isCategoryPaginationLoading;
  @override
  int get currentSubPlanPage;
  @override
  bool get hasMoreSubPlans;
  @override
  bool get isSubPlanPaginationLoading; // Pagination
  @override
  int get currentPage;
  @override
  int get totalCount;
  @override
  bool get hasMoreData;
  @override
  bool get isPaginationLoading;

  /// Create a copy of ReportState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReportStateImplCopyWith<_$ReportStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
