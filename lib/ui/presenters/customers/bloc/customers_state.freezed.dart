// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customers_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CustomersState {
  CustomersRequestStatus get status => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError; // Screen mode
  CustomersStep get step => throw _privateConstructorUsedError; // Customer List
  List<CustomerItemModel> get allCustomers =>
      throw _privateConstructorUsedError;
  List<CustomerItemModel> get filteredCustomers =>
      throw _privateConstructorUsedError;
  String get searchQuery =>
      throw _privateConstructorUsedError; // Customer Detail
  CustomerDetailModel? get selectedCustomer =>
      throw _privateConstructorUsedError;
  int get selectedTabIndex => throw _privateConstructorUsedError; // Pagination
  int get currentPage => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  bool get isPaginationLoading => throw _privateConstructorUsedError;
  bool get hasMoreData => throw _privateConstructorUsedError;

  /// Create a copy of CustomersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomersStateCopyWith<CustomersState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomersStateCopyWith<$Res> {
  factory $CustomersStateCopyWith(
    CustomersState value,
    $Res Function(CustomersState) then,
  ) = _$CustomersStateCopyWithImpl<$Res, CustomersState>;
  @useResult
  $Res call({
    CustomersRequestStatus status,
    String errorMessage,
    CustomersStep step,
    List<CustomerItemModel> allCustomers,
    List<CustomerItemModel> filteredCustomers,
    String searchQuery,
    CustomerDetailModel? selectedCustomer,
    int selectedTabIndex,
    int currentPage,
    int totalCount,
    bool isPaginationLoading,
    bool hasMoreData,
  });
}

/// @nodoc
class _$CustomersStateCopyWithImpl<$Res, $Val extends CustomersState>
    implements $CustomersStateCopyWith<$Res> {
  _$CustomersStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomersState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? errorMessage = null,
    Object? step = null,
    Object? allCustomers = null,
    Object? filteredCustomers = null,
    Object? searchQuery = null,
    Object? selectedCustomer = freezed,
    Object? selectedTabIndex = null,
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
                      as CustomersRequestStatus,
            errorMessage: null == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String,
            step: null == step
                ? _value.step
                : step // ignore: cast_nullable_to_non_nullable
                      as CustomersStep,
            allCustomers: null == allCustomers
                ? _value.allCustomers
                : allCustomers // ignore: cast_nullable_to_non_nullable
                      as List<CustomerItemModel>,
            filteredCustomers: null == filteredCustomers
                ? _value.filteredCustomers
                : filteredCustomers // ignore: cast_nullable_to_non_nullable
                      as List<CustomerItemModel>,
            searchQuery: null == searchQuery
                ? _value.searchQuery
                : searchQuery // ignore: cast_nullable_to_non_nullable
                      as String,
            selectedCustomer: freezed == selectedCustomer
                ? _value.selectedCustomer
                : selectedCustomer // ignore: cast_nullable_to_non_nullable
                      as CustomerDetailModel?,
            selectedTabIndex: null == selectedTabIndex
                ? _value.selectedTabIndex
                : selectedTabIndex // ignore: cast_nullable_to_non_nullable
                      as int,
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
abstract class _$$CustomersStateImplCopyWith<$Res>
    implements $CustomersStateCopyWith<$Res> {
  factory _$$CustomersStateImplCopyWith(
    _$CustomersStateImpl value,
    $Res Function(_$CustomersStateImpl) then,
  ) = __$$CustomersStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    CustomersRequestStatus status,
    String errorMessage,
    CustomersStep step,
    List<CustomerItemModel> allCustomers,
    List<CustomerItemModel> filteredCustomers,
    String searchQuery,
    CustomerDetailModel? selectedCustomer,
    int selectedTabIndex,
    int currentPage,
    int totalCount,
    bool isPaginationLoading,
    bool hasMoreData,
  });
}

/// @nodoc
class __$$CustomersStateImplCopyWithImpl<$Res>
    extends _$CustomersStateCopyWithImpl<$Res, _$CustomersStateImpl>
    implements _$$CustomersStateImplCopyWith<$Res> {
  __$$CustomersStateImplCopyWithImpl(
    _$CustomersStateImpl _value,
    $Res Function(_$CustomersStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CustomersState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? errorMessage = null,
    Object? step = null,
    Object? allCustomers = null,
    Object? filteredCustomers = null,
    Object? searchQuery = null,
    Object? selectedCustomer = freezed,
    Object? selectedTabIndex = null,
    Object? currentPage = null,
    Object? totalCount = null,
    Object? isPaginationLoading = null,
    Object? hasMoreData = null,
  }) {
    return _then(
      _$CustomersStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as CustomersRequestStatus,
        errorMessage: null == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String,
        step: null == step
            ? _value.step
            : step // ignore: cast_nullable_to_non_nullable
                  as CustomersStep,
        allCustomers: null == allCustomers
            ? _value._allCustomers
            : allCustomers // ignore: cast_nullable_to_non_nullable
                  as List<CustomerItemModel>,
        filteredCustomers: null == filteredCustomers
            ? _value._filteredCustomers
            : filteredCustomers // ignore: cast_nullable_to_non_nullable
                  as List<CustomerItemModel>,
        searchQuery: null == searchQuery
            ? _value.searchQuery
            : searchQuery // ignore: cast_nullable_to_non_nullable
                  as String,
        selectedCustomer: freezed == selectedCustomer
            ? _value.selectedCustomer
            : selectedCustomer // ignore: cast_nullable_to_non_nullable
                  as CustomerDetailModel?,
        selectedTabIndex: null == selectedTabIndex
            ? _value.selectedTabIndex
            : selectedTabIndex // ignore: cast_nullable_to_non_nullable
                  as int,
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

class _$CustomersStateImpl implements _CustomersState {
  const _$CustomersStateImpl({
    this.status = CustomersRequestStatus.initial,
    this.errorMessage = '',
    this.step = CustomersStep.customerList,
    final List<CustomerItemModel> allCustomers = const [],
    final List<CustomerItemModel> filteredCustomers = const [],
    this.searchQuery = '',
    this.selectedCustomer,
    this.selectedTabIndex = 0,
    this.currentPage = 1,
    this.totalCount = 0,
    this.isPaginationLoading = false,
    this.hasMoreData = true,
  }) : _allCustomers = allCustomers,
       _filteredCustomers = filteredCustomers;

  @override
  @JsonKey()
  final CustomersRequestStatus status;
  @override
  @JsonKey()
  final String errorMessage;
  // Screen mode
  @override
  @JsonKey()
  final CustomersStep step;
  // Customer List
  final List<CustomerItemModel> _allCustomers;
  // Customer List
  @override
  @JsonKey()
  List<CustomerItemModel> get allCustomers {
    if (_allCustomers is EqualUnmodifiableListView) return _allCustomers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allCustomers);
  }

  final List<CustomerItemModel> _filteredCustomers;
  @override
  @JsonKey()
  List<CustomerItemModel> get filteredCustomers {
    if (_filteredCustomers is EqualUnmodifiableListView)
      return _filteredCustomers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredCustomers);
  }

  @override
  @JsonKey()
  final String searchQuery;
  // Customer Detail
  @override
  final CustomerDetailModel? selectedCustomer;
  @override
  @JsonKey()
  final int selectedTabIndex;
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
    return 'CustomersState(status: $status, errorMessage: $errorMessage, step: $step, allCustomers: $allCustomers, filteredCustomers: $filteredCustomers, searchQuery: $searchQuery, selectedCustomer: $selectedCustomer, selectedTabIndex: $selectedTabIndex, currentPage: $currentPage, totalCount: $totalCount, isPaginationLoading: $isPaginationLoading, hasMoreData: $hasMoreData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomersStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.step, step) || other.step == step) &&
            const DeepCollectionEquality().equals(
              other._allCustomers,
              _allCustomers,
            ) &&
            const DeepCollectionEquality().equals(
              other._filteredCustomers,
              _filteredCustomers,
            ) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.selectedCustomer, selectedCustomer) ||
                other.selectedCustomer == selectedCustomer) &&
            (identical(other.selectedTabIndex, selectedTabIndex) ||
                other.selectedTabIndex == selectedTabIndex) &&
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
  int get hashCode => Object.hash(
    runtimeType,
    status,
    errorMessage,
    step,
    const DeepCollectionEquality().hash(_allCustomers),
    const DeepCollectionEquality().hash(_filteredCustomers),
    searchQuery,
    selectedCustomer,
    selectedTabIndex,
    currentPage,
    totalCount,
    isPaginationLoading,
    hasMoreData,
  );

  /// Create a copy of CustomersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomersStateImplCopyWith<_$CustomersStateImpl> get copyWith =>
      __$$CustomersStateImplCopyWithImpl<_$CustomersStateImpl>(
        this,
        _$identity,
      );
}

abstract class _CustomersState implements CustomersState {
  const factory _CustomersState({
    final CustomersRequestStatus status,
    final String errorMessage,
    final CustomersStep step,
    final List<CustomerItemModel> allCustomers,
    final List<CustomerItemModel> filteredCustomers,
    final String searchQuery,
    final CustomerDetailModel? selectedCustomer,
    final int selectedTabIndex,
    final int currentPage,
    final int totalCount,
    final bool isPaginationLoading,
    final bool hasMoreData,
  }) = _$CustomersStateImpl;

  @override
  CustomersRequestStatus get status;
  @override
  String get errorMessage; // Screen mode
  @override
  CustomersStep get step; // Customer List
  @override
  List<CustomerItemModel> get allCustomers;
  @override
  List<CustomerItemModel> get filteredCustomers;
  @override
  String get searchQuery; // Customer Detail
  @override
  CustomerDetailModel? get selectedCustomer;
  @override
  int get selectedTabIndex; // Pagination
  @override
  int get currentPage;
  @override
  int get totalCount;
  @override
  bool get isPaginationLoading;
  @override
  bool get hasMoreData;

  /// Create a copy of CustomersState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomersStateImplCopyWith<_$CustomersStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
