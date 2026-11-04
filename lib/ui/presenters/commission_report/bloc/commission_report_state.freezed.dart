// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'commission_report_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CommissionReportState {
  List<CommissionReportEntry> get entries => throw _privateConstructorUsedError;
  CommissionReportStatus get status => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  List<ReportSummaryMetric> get summaryMetrics =>
      throw _privateConstructorUsedError;
  List<int> get years => throw _privateConstructorUsedError;
  int? get selectedYear => throw _privateConstructorUsedError;
  int? get selectedMonth => throw _privateConstructorUsedError;
  String? get selectedStoreId => throw _privateConstructorUsedError;
  List<BranchInfo> get storeOptions => throw _privateConstructorUsedError;
  bool get isStoreOptionsLoading => throw _privateConstructorUsedError;
  String get storeOptionsError => throw _privateConstructorUsedError;
  String get searchQuery => throw _privateConstructorUsedError;
  bool get isSearchActive => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  bool get hasMoreData => throw _privateConstructorUsedError;
  bool get isPaginationLoading => throw _privateConstructorUsedError;
  String get paginationErrorMessage => throw _privateConstructorUsedError;

  /// Create a copy of CommissionReportState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommissionReportStateCopyWith<CommissionReportState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommissionReportStateCopyWith<$Res> {
  factory $CommissionReportStateCopyWith(
    CommissionReportState value,
    $Res Function(CommissionReportState) then,
  ) = _$CommissionReportStateCopyWithImpl<$Res, CommissionReportState>;
  @useResult
  $Res call({
    List<CommissionReportEntry> entries,
    CommissionReportStatus status,
    String errorMessage,
    List<ReportSummaryMetric> summaryMetrics,
    List<int> years,
    int? selectedYear,
    int? selectedMonth,
    String? selectedStoreId,
    List<BranchInfo> storeOptions,
    bool isStoreOptionsLoading,
    String storeOptionsError,
    String searchQuery,
    bool isSearchActive,
    int currentPage,
    int totalCount,
    bool hasMoreData,
    bool isPaginationLoading,
    String paginationErrorMessage,
  });
}

/// @nodoc
class _$CommissionReportStateCopyWithImpl<
  $Res,
  $Val extends CommissionReportState
>
    implements $CommissionReportStateCopyWith<$Res> {
  _$CommissionReportStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommissionReportState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entries = null,
    Object? status = null,
    Object? errorMessage = null,
    Object? summaryMetrics = null,
    Object? years = null,
    Object? selectedYear = freezed,
    Object? selectedMonth = freezed,
    Object? selectedStoreId = freezed,
    Object? storeOptions = null,
    Object? isStoreOptionsLoading = null,
    Object? storeOptionsError = null,
    Object? searchQuery = null,
    Object? isSearchActive = null,
    Object? currentPage = null,
    Object? totalCount = null,
    Object? hasMoreData = null,
    Object? isPaginationLoading = null,
    Object? paginationErrorMessage = null,
  }) {
    return _then(
      _value.copyWith(
            entries: null == entries
                ? _value.entries
                : entries // ignore: cast_nullable_to_non_nullable
                      as List<CommissionReportEntry>,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as CommissionReportStatus,
            errorMessage: null == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String,
            summaryMetrics: null == summaryMetrics
                ? _value.summaryMetrics
                : summaryMetrics // ignore: cast_nullable_to_non_nullable
                      as List<ReportSummaryMetric>,
            years: null == years
                ? _value.years
                : years // ignore: cast_nullable_to_non_nullable
                      as List<int>,
            selectedYear: freezed == selectedYear
                ? _value.selectedYear
                : selectedYear // ignore: cast_nullable_to_non_nullable
                      as int?,
            selectedMonth: freezed == selectedMonth
                ? _value.selectedMonth
                : selectedMonth // ignore: cast_nullable_to_non_nullable
                      as int?,
            selectedStoreId: freezed == selectedStoreId
                ? _value.selectedStoreId
                : selectedStoreId // ignore: cast_nullable_to_non_nullable
                      as String?,
            storeOptions: null == storeOptions
                ? _value.storeOptions
                : storeOptions // ignore: cast_nullable_to_non_nullable
                      as List<BranchInfo>,
            isStoreOptionsLoading: null == isStoreOptionsLoading
                ? _value.isStoreOptionsLoading
                : isStoreOptionsLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            storeOptionsError: null == storeOptionsError
                ? _value.storeOptionsError
                : storeOptionsError // ignore: cast_nullable_to_non_nullable
                      as String,
            searchQuery: null == searchQuery
                ? _value.searchQuery
                : searchQuery // ignore: cast_nullable_to_non_nullable
                      as String,
            isSearchActive: null == isSearchActive
                ? _value.isSearchActive
                : isSearchActive // ignore: cast_nullable_to_non_nullable
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
            paginationErrorMessage: null == paginationErrorMessage
                ? _value.paginationErrorMessage
                : paginationErrorMessage // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CommissionReportStateImplCopyWith<$Res>
    implements $CommissionReportStateCopyWith<$Res> {
  factory _$$CommissionReportStateImplCopyWith(
    _$CommissionReportStateImpl value,
    $Res Function(_$CommissionReportStateImpl) then,
  ) = __$$CommissionReportStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<CommissionReportEntry> entries,
    CommissionReportStatus status,
    String errorMessage,
    List<ReportSummaryMetric> summaryMetrics,
    List<int> years,
    int? selectedYear,
    int? selectedMonth,
    String? selectedStoreId,
    List<BranchInfo> storeOptions,
    bool isStoreOptionsLoading,
    String storeOptionsError,
    String searchQuery,
    bool isSearchActive,
    int currentPage,
    int totalCount,
    bool hasMoreData,
    bool isPaginationLoading,
    String paginationErrorMessage,
  });
}

/// @nodoc
class __$$CommissionReportStateImplCopyWithImpl<$Res>
    extends
        _$CommissionReportStateCopyWithImpl<$Res, _$CommissionReportStateImpl>
    implements _$$CommissionReportStateImplCopyWith<$Res> {
  __$$CommissionReportStateImplCopyWithImpl(
    _$CommissionReportStateImpl _value,
    $Res Function(_$CommissionReportStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommissionReportState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entries = null,
    Object? status = null,
    Object? errorMessage = null,
    Object? summaryMetrics = null,
    Object? years = null,
    Object? selectedYear = freezed,
    Object? selectedMonth = freezed,
    Object? selectedStoreId = freezed,
    Object? storeOptions = null,
    Object? isStoreOptionsLoading = null,
    Object? storeOptionsError = null,
    Object? searchQuery = null,
    Object? isSearchActive = null,
    Object? currentPage = null,
    Object? totalCount = null,
    Object? hasMoreData = null,
    Object? isPaginationLoading = null,
    Object? paginationErrorMessage = null,
  }) {
    return _then(
      _$CommissionReportStateImpl(
        entries: null == entries
            ? _value._entries
            : entries // ignore: cast_nullable_to_non_nullable
                  as List<CommissionReportEntry>,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as CommissionReportStatus,
        errorMessage: null == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String,
        summaryMetrics: null == summaryMetrics
            ? _value._summaryMetrics
            : summaryMetrics // ignore: cast_nullable_to_non_nullable
                  as List<ReportSummaryMetric>,
        years: null == years
            ? _value._years
            : years // ignore: cast_nullable_to_non_nullable
                  as List<int>,
        selectedYear: freezed == selectedYear
            ? _value.selectedYear
            : selectedYear // ignore: cast_nullable_to_non_nullable
                  as int?,
        selectedMonth: freezed == selectedMonth
            ? _value.selectedMonth
            : selectedMonth // ignore: cast_nullable_to_non_nullable
                  as int?,
        selectedStoreId: freezed == selectedStoreId
            ? _value.selectedStoreId
            : selectedStoreId // ignore: cast_nullable_to_non_nullable
                  as String?,
        storeOptions: null == storeOptions
            ? _value._storeOptions
            : storeOptions // ignore: cast_nullable_to_non_nullable
                  as List<BranchInfo>,
        isStoreOptionsLoading: null == isStoreOptionsLoading
            ? _value.isStoreOptionsLoading
            : isStoreOptionsLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        storeOptionsError: null == storeOptionsError
            ? _value.storeOptionsError
            : storeOptionsError // ignore: cast_nullable_to_non_nullable
                  as String,
        searchQuery: null == searchQuery
            ? _value.searchQuery
            : searchQuery // ignore: cast_nullable_to_non_nullable
                  as String,
        isSearchActive: null == isSearchActive
            ? _value.isSearchActive
            : isSearchActive // ignore: cast_nullable_to_non_nullable
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
        paginationErrorMessage: null == paginationErrorMessage
            ? _value.paginationErrorMessage
            : paginationErrorMessage // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$CommissionReportStateImpl implements _CommissionReportState {
  const _$CommissionReportStateImpl({
    final List<CommissionReportEntry> entries = const [],
    this.status = CommissionReportStatus.initial,
    this.errorMessage = '',
    final List<ReportSummaryMetric> summaryMetrics = const [],
    final List<int> years = const [],
    this.selectedYear,
    this.selectedMonth,
    this.selectedStoreId,
    final List<BranchInfo> storeOptions = const [],
    this.isStoreOptionsLoading = false,
    this.storeOptionsError = '',
    this.searchQuery = '',
    this.isSearchActive = false,
    this.currentPage = 1,
    this.totalCount = 0,
    this.hasMoreData = false,
    this.isPaginationLoading = false,
    this.paginationErrorMessage = '',
  }) : _entries = entries,
       _summaryMetrics = summaryMetrics,
       _years = years,
       _storeOptions = storeOptions;

  final List<CommissionReportEntry> _entries;
  @override
  @JsonKey()
  List<CommissionReportEntry> get entries {
    if (_entries is EqualUnmodifiableListView) return _entries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_entries);
  }

  @override
  @JsonKey()
  final CommissionReportStatus status;
  @override
  @JsonKey()
  final String errorMessage;
  final List<ReportSummaryMetric> _summaryMetrics;
  @override
  @JsonKey()
  List<ReportSummaryMetric> get summaryMetrics {
    if (_summaryMetrics is EqualUnmodifiableListView) return _summaryMetrics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_summaryMetrics);
  }

  final List<int> _years;
  @override
  @JsonKey()
  List<int> get years {
    if (_years is EqualUnmodifiableListView) return _years;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_years);
  }

  @override
  final int? selectedYear;
  @override
  final int? selectedMonth;
  @override
  final String? selectedStoreId;
  final List<BranchInfo> _storeOptions;
  @override
  @JsonKey()
  List<BranchInfo> get storeOptions {
    if (_storeOptions is EqualUnmodifiableListView) return _storeOptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_storeOptions);
  }

  @override
  @JsonKey()
  final bool isStoreOptionsLoading;
  @override
  @JsonKey()
  final String storeOptionsError;
  @override
  @JsonKey()
  final String searchQuery;
  @override
  @JsonKey()
  final bool isSearchActive;
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
  @JsonKey()
  final String paginationErrorMessage;

  @override
  String toString() {
    return 'CommissionReportState(entries: $entries, status: $status, errorMessage: $errorMessage, summaryMetrics: $summaryMetrics, years: $years, selectedYear: $selectedYear, selectedMonth: $selectedMonth, selectedStoreId: $selectedStoreId, storeOptions: $storeOptions, isStoreOptionsLoading: $isStoreOptionsLoading, storeOptionsError: $storeOptionsError, searchQuery: $searchQuery, isSearchActive: $isSearchActive, currentPage: $currentPage, totalCount: $totalCount, hasMoreData: $hasMoreData, isPaginationLoading: $isPaginationLoading, paginationErrorMessage: $paginationErrorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommissionReportStateImpl &&
            const DeepCollectionEquality().equals(other._entries, _entries) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality().equals(
              other._summaryMetrics,
              _summaryMetrics,
            ) &&
            const DeepCollectionEquality().equals(other._years, _years) &&
            (identical(other.selectedYear, selectedYear) ||
                other.selectedYear == selectedYear) &&
            (identical(other.selectedMonth, selectedMonth) ||
                other.selectedMonth == selectedMonth) &&
            (identical(other.selectedStoreId, selectedStoreId) ||
                other.selectedStoreId == selectedStoreId) &&
            const DeepCollectionEquality().equals(
              other._storeOptions,
              _storeOptions,
            ) &&
            (identical(other.isStoreOptionsLoading, isStoreOptionsLoading) ||
                other.isStoreOptionsLoading == isStoreOptionsLoading) &&
            (identical(other.storeOptionsError, storeOptionsError) ||
                other.storeOptionsError == storeOptionsError) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.isSearchActive, isSearchActive) ||
                other.isSearchActive == isSearchActive) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.hasMoreData, hasMoreData) ||
                other.hasMoreData == hasMoreData) &&
            (identical(other.isPaginationLoading, isPaginationLoading) ||
                other.isPaginationLoading == isPaginationLoading) &&
            (identical(other.paginationErrorMessage, paginationErrorMessage) ||
                other.paginationErrorMessage == paginationErrorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_entries),
    status,
    errorMessage,
    const DeepCollectionEquality().hash(_summaryMetrics),
    const DeepCollectionEquality().hash(_years),
    selectedYear,
    selectedMonth,
    selectedStoreId,
    const DeepCollectionEquality().hash(_storeOptions),
    isStoreOptionsLoading,
    storeOptionsError,
    searchQuery,
    isSearchActive,
    currentPage,
    totalCount,
    hasMoreData,
    isPaginationLoading,
    paginationErrorMessage,
  );

  /// Create a copy of CommissionReportState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommissionReportStateImplCopyWith<_$CommissionReportStateImpl>
  get copyWith =>
      __$$CommissionReportStateImplCopyWithImpl<_$CommissionReportStateImpl>(
        this,
        _$identity,
      );
}

abstract class _CommissionReportState implements CommissionReportState {
  const factory _CommissionReportState({
    final List<CommissionReportEntry> entries,
    final CommissionReportStatus status,
    final String errorMessage,
    final List<ReportSummaryMetric> summaryMetrics,
    final List<int> years,
    final int? selectedYear,
    final int? selectedMonth,
    final String? selectedStoreId,
    final List<BranchInfo> storeOptions,
    final bool isStoreOptionsLoading,
    final String storeOptionsError,
    final String searchQuery,
    final bool isSearchActive,
    final int currentPage,
    final int totalCount,
    final bool hasMoreData,
    final bool isPaginationLoading,
    final String paginationErrorMessage,
  }) = _$CommissionReportStateImpl;

  @override
  List<CommissionReportEntry> get entries;
  @override
  CommissionReportStatus get status;
  @override
  String get errorMessage;
  @override
  List<ReportSummaryMetric> get summaryMetrics;
  @override
  List<int> get years;
  @override
  int? get selectedYear;
  @override
  int? get selectedMonth;
  @override
  String? get selectedStoreId;
  @override
  List<BranchInfo> get storeOptions;
  @override
  bool get isStoreOptionsLoading;
  @override
  String get storeOptionsError;
  @override
  String get searchQuery;
  @override
  bool get isSearchActive;
  @override
  int get currentPage;
  @override
  int get totalCount;
  @override
  bool get hasMoreData;
  @override
  bool get isPaginationLoading;
  @override
  String get paginationErrorMessage;

  /// Create a copy of CommissionReportState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommissionReportStateImplCopyWith<_$CommissionReportStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}
