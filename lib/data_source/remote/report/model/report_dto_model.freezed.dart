// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_dto_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ReportSummaryDtoModel _$ReportSummaryDtoModelFromJson(
  Map<String, dynamic> json,
) {
  return _ReportSummaryDtoModel.fromJson(json);
}

/// @nodoc
mixin _$ReportSummaryDtoModel {
  @JsonKey(name: 'total_sales_amount')
  double? get totalSalesAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_orders')
  int? get totalOrders => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_line_items')
  int? get totalLineItems => throw _privateConstructorUsedError;
  @JsonKey(name: 'unique_customers')
  int? get uniqueCustomers => throw _privateConstructorUsedError;
  @JsonKey(name: 'avg_order_amount')
  double? get avgOrderAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'avg_items_per_order')
  double? get avgItemsPerOrder => throw _privateConstructorUsedError;
  @JsonKey(name: 'avg_sales_per_agent')
  double? get avgSalesPerAgent => throw _privateConstructorUsedError;
  @JsonKey(name: 'avg_sales_per_category')
  double? get avgSalesPerCategory => throw _privateConstructorUsedError;
  @JsonKey(name: 'avg_sales_per_subplan')
  double? get avgSalesPerSubplan => throw _privateConstructorUsedError;

  /// Serializes this ReportSummaryDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReportSummaryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReportSummaryDtoModelCopyWith<ReportSummaryDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportSummaryDtoModelCopyWith<$Res> {
  factory $ReportSummaryDtoModelCopyWith(
    ReportSummaryDtoModel value,
    $Res Function(ReportSummaryDtoModel) then,
  ) = _$ReportSummaryDtoModelCopyWithImpl<$Res, ReportSummaryDtoModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'total_sales_amount') double? totalSalesAmount,
    @JsonKey(name: 'total_orders') int? totalOrders,
    @JsonKey(name: 'total_line_items') int? totalLineItems,
    @JsonKey(name: 'unique_customers') int? uniqueCustomers,
    @JsonKey(name: 'avg_order_amount') double? avgOrderAmount,
    @JsonKey(name: 'avg_items_per_order') double? avgItemsPerOrder,
    @JsonKey(name: 'avg_sales_per_agent') double? avgSalesPerAgent,
    @JsonKey(name: 'avg_sales_per_category') double? avgSalesPerCategory,
    @JsonKey(name: 'avg_sales_per_subplan') double? avgSalesPerSubplan,
  });
}

/// @nodoc
class _$ReportSummaryDtoModelCopyWithImpl<
  $Res,
  $Val extends ReportSummaryDtoModel
>
    implements $ReportSummaryDtoModelCopyWith<$Res> {
  _$ReportSummaryDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReportSummaryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalSalesAmount = freezed,
    Object? totalOrders = freezed,
    Object? totalLineItems = freezed,
    Object? uniqueCustomers = freezed,
    Object? avgOrderAmount = freezed,
    Object? avgItemsPerOrder = freezed,
    Object? avgSalesPerAgent = freezed,
    Object? avgSalesPerCategory = freezed,
    Object? avgSalesPerSubplan = freezed,
  }) {
    return _then(
      _value.copyWith(
            totalSalesAmount: freezed == totalSalesAmount
                ? _value.totalSalesAmount
                : totalSalesAmount // ignore: cast_nullable_to_non_nullable
                      as double?,
            totalOrders: freezed == totalOrders
                ? _value.totalOrders
                : totalOrders // ignore: cast_nullable_to_non_nullable
                      as int?,
            totalLineItems: freezed == totalLineItems
                ? _value.totalLineItems
                : totalLineItems // ignore: cast_nullable_to_non_nullable
                      as int?,
            uniqueCustomers: freezed == uniqueCustomers
                ? _value.uniqueCustomers
                : uniqueCustomers // ignore: cast_nullable_to_non_nullable
                      as int?,
            avgOrderAmount: freezed == avgOrderAmount
                ? _value.avgOrderAmount
                : avgOrderAmount // ignore: cast_nullable_to_non_nullable
                      as double?,
            avgItemsPerOrder: freezed == avgItemsPerOrder
                ? _value.avgItemsPerOrder
                : avgItemsPerOrder // ignore: cast_nullable_to_non_nullable
                      as double?,
            avgSalesPerAgent: freezed == avgSalesPerAgent
                ? _value.avgSalesPerAgent
                : avgSalesPerAgent // ignore: cast_nullable_to_non_nullable
                      as double?,
            avgSalesPerCategory: freezed == avgSalesPerCategory
                ? _value.avgSalesPerCategory
                : avgSalesPerCategory // ignore: cast_nullable_to_non_nullable
                      as double?,
            avgSalesPerSubplan: freezed == avgSalesPerSubplan
                ? _value.avgSalesPerSubplan
                : avgSalesPerSubplan // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReportSummaryDtoModelImplCopyWith<$Res>
    implements $ReportSummaryDtoModelCopyWith<$Res> {
  factory _$$ReportSummaryDtoModelImplCopyWith(
    _$ReportSummaryDtoModelImpl value,
    $Res Function(_$ReportSummaryDtoModelImpl) then,
  ) = __$$ReportSummaryDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'total_sales_amount') double? totalSalesAmount,
    @JsonKey(name: 'total_orders') int? totalOrders,
    @JsonKey(name: 'total_line_items') int? totalLineItems,
    @JsonKey(name: 'unique_customers') int? uniqueCustomers,
    @JsonKey(name: 'avg_order_amount') double? avgOrderAmount,
    @JsonKey(name: 'avg_items_per_order') double? avgItemsPerOrder,
    @JsonKey(name: 'avg_sales_per_agent') double? avgSalesPerAgent,
    @JsonKey(name: 'avg_sales_per_category') double? avgSalesPerCategory,
    @JsonKey(name: 'avg_sales_per_subplan') double? avgSalesPerSubplan,
  });
}

/// @nodoc
class __$$ReportSummaryDtoModelImplCopyWithImpl<$Res>
    extends
        _$ReportSummaryDtoModelCopyWithImpl<$Res, _$ReportSummaryDtoModelImpl>
    implements _$$ReportSummaryDtoModelImplCopyWith<$Res> {
  __$$ReportSummaryDtoModelImplCopyWithImpl(
    _$ReportSummaryDtoModelImpl _value,
    $Res Function(_$ReportSummaryDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReportSummaryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalSalesAmount = freezed,
    Object? totalOrders = freezed,
    Object? totalLineItems = freezed,
    Object? uniqueCustomers = freezed,
    Object? avgOrderAmount = freezed,
    Object? avgItemsPerOrder = freezed,
    Object? avgSalesPerAgent = freezed,
    Object? avgSalesPerCategory = freezed,
    Object? avgSalesPerSubplan = freezed,
  }) {
    return _then(
      _$ReportSummaryDtoModelImpl(
        totalSalesAmount: freezed == totalSalesAmount
            ? _value.totalSalesAmount
            : totalSalesAmount // ignore: cast_nullable_to_non_nullable
                  as double?,
        totalOrders: freezed == totalOrders
            ? _value.totalOrders
            : totalOrders // ignore: cast_nullable_to_non_nullable
                  as int?,
        totalLineItems: freezed == totalLineItems
            ? _value.totalLineItems
            : totalLineItems // ignore: cast_nullable_to_non_nullable
                  as int?,
        uniqueCustomers: freezed == uniqueCustomers
            ? _value.uniqueCustomers
            : uniqueCustomers // ignore: cast_nullable_to_non_nullable
                  as int?,
        avgOrderAmount: freezed == avgOrderAmount
            ? _value.avgOrderAmount
            : avgOrderAmount // ignore: cast_nullable_to_non_nullable
                  as double?,
        avgItemsPerOrder: freezed == avgItemsPerOrder
            ? _value.avgItemsPerOrder
            : avgItemsPerOrder // ignore: cast_nullable_to_non_nullable
                  as double?,
        avgSalesPerAgent: freezed == avgSalesPerAgent
            ? _value.avgSalesPerAgent
            : avgSalesPerAgent // ignore: cast_nullable_to_non_nullable
                  as double?,
        avgSalesPerCategory: freezed == avgSalesPerCategory
            ? _value.avgSalesPerCategory
            : avgSalesPerCategory // ignore: cast_nullable_to_non_nullable
                  as double?,
        avgSalesPerSubplan: freezed == avgSalesPerSubplan
            ? _value.avgSalesPerSubplan
            : avgSalesPerSubplan // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ReportSummaryDtoModelImpl implements _ReportSummaryDtoModel {
  const _$ReportSummaryDtoModelImpl({
    @JsonKey(name: 'total_sales_amount') this.totalSalesAmount,
    @JsonKey(name: 'total_orders') this.totalOrders,
    @JsonKey(name: 'total_line_items') this.totalLineItems,
    @JsonKey(name: 'unique_customers') this.uniqueCustomers,
    @JsonKey(name: 'avg_order_amount') this.avgOrderAmount,
    @JsonKey(name: 'avg_items_per_order') this.avgItemsPerOrder,
    @JsonKey(name: 'avg_sales_per_agent') this.avgSalesPerAgent,
    @JsonKey(name: 'avg_sales_per_category') this.avgSalesPerCategory,
    @JsonKey(name: 'avg_sales_per_subplan') this.avgSalesPerSubplan,
  });

  factory _$ReportSummaryDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReportSummaryDtoModelImplFromJson(json);

  @override
  @JsonKey(name: 'total_sales_amount')
  final double? totalSalesAmount;
  @override
  @JsonKey(name: 'total_orders')
  final int? totalOrders;
  @override
  @JsonKey(name: 'total_line_items')
  final int? totalLineItems;
  @override
  @JsonKey(name: 'unique_customers')
  final int? uniqueCustomers;
  @override
  @JsonKey(name: 'avg_order_amount')
  final double? avgOrderAmount;
  @override
  @JsonKey(name: 'avg_items_per_order')
  final double? avgItemsPerOrder;
  @override
  @JsonKey(name: 'avg_sales_per_agent')
  final double? avgSalesPerAgent;
  @override
  @JsonKey(name: 'avg_sales_per_category')
  final double? avgSalesPerCategory;
  @override
  @JsonKey(name: 'avg_sales_per_subplan')
  final double? avgSalesPerSubplan;

  @override
  String toString() {
    return 'ReportSummaryDtoModel(totalSalesAmount: $totalSalesAmount, totalOrders: $totalOrders, totalLineItems: $totalLineItems, uniqueCustomers: $uniqueCustomers, avgOrderAmount: $avgOrderAmount, avgItemsPerOrder: $avgItemsPerOrder, avgSalesPerAgent: $avgSalesPerAgent, avgSalesPerCategory: $avgSalesPerCategory, avgSalesPerSubplan: $avgSalesPerSubplan)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportSummaryDtoModelImpl &&
            (identical(other.totalSalesAmount, totalSalesAmount) ||
                other.totalSalesAmount == totalSalesAmount) &&
            (identical(other.totalOrders, totalOrders) ||
                other.totalOrders == totalOrders) &&
            (identical(other.totalLineItems, totalLineItems) ||
                other.totalLineItems == totalLineItems) &&
            (identical(other.uniqueCustomers, uniqueCustomers) ||
                other.uniqueCustomers == uniqueCustomers) &&
            (identical(other.avgOrderAmount, avgOrderAmount) ||
                other.avgOrderAmount == avgOrderAmount) &&
            (identical(other.avgItemsPerOrder, avgItemsPerOrder) ||
                other.avgItemsPerOrder == avgItemsPerOrder) &&
            (identical(other.avgSalesPerAgent, avgSalesPerAgent) ||
                other.avgSalesPerAgent == avgSalesPerAgent) &&
            (identical(other.avgSalesPerCategory, avgSalesPerCategory) ||
                other.avgSalesPerCategory == avgSalesPerCategory) &&
            (identical(other.avgSalesPerSubplan, avgSalesPerSubplan) ||
                other.avgSalesPerSubplan == avgSalesPerSubplan));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalSalesAmount,
    totalOrders,
    totalLineItems,
    uniqueCustomers,
    avgOrderAmount,
    avgItemsPerOrder,
    avgSalesPerAgent,
    avgSalesPerCategory,
    avgSalesPerSubplan,
  );

  /// Create a copy of ReportSummaryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportSummaryDtoModelImplCopyWith<_$ReportSummaryDtoModelImpl>
  get copyWith =>
      __$$ReportSummaryDtoModelImplCopyWithImpl<_$ReportSummaryDtoModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ReportSummaryDtoModelImplToJson(this);
  }
}

abstract class _ReportSummaryDtoModel implements ReportSummaryDtoModel {
  const factory _ReportSummaryDtoModel({
    @JsonKey(name: 'total_sales_amount') final double? totalSalesAmount,
    @JsonKey(name: 'total_orders') final int? totalOrders,
    @JsonKey(name: 'total_line_items') final int? totalLineItems,
    @JsonKey(name: 'unique_customers') final int? uniqueCustomers,
    @JsonKey(name: 'avg_order_amount') final double? avgOrderAmount,
    @JsonKey(name: 'avg_items_per_order') final double? avgItemsPerOrder,
    @JsonKey(name: 'avg_sales_per_agent') final double? avgSalesPerAgent,
    @JsonKey(name: 'avg_sales_per_category') final double? avgSalesPerCategory,
    @JsonKey(name: 'avg_sales_per_subplan') final double? avgSalesPerSubplan,
  }) = _$ReportSummaryDtoModelImpl;

  factory _ReportSummaryDtoModel.fromJson(Map<String, dynamic> json) =
      _$ReportSummaryDtoModelImpl.fromJson;

  @override
  @JsonKey(name: 'total_sales_amount')
  double? get totalSalesAmount;
  @override
  @JsonKey(name: 'total_orders')
  int? get totalOrders;
  @override
  @JsonKey(name: 'total_line_items')
  int? get totalLineItems;
  @override
  @JsonKey(name: 'unique_customers')
  int? get uniqueCustomers;
  @override
  @JsonKey(name: 'avg_order_amount')
  double? get avgOrderAmount;
  @override
  @JsonKey(name: 'avg_items_per_order')
  double? get avgItemsPerOrder;
  @override
  @JsonKey(name: 'avg_sales_per_agent')
  double? get avgSalesPerAgent;
  @override
  @JsonKey(name: 'avg_sales_per_category')
  double? get avgSalesPerCategory;
  @override
  @JsonKey(name: 'avg_sales_per_subplan')
  double? get avgSalesPerSubplan;

  /// Create a copy of ReportSummaryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReportSummaryDtoModelImplCopyWith<_$ReportSummaryDtoModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

SalesOverviewResponse _$SalesOverviewResponseFromJson(
  Map<String, dynamic> json,
) {
  return _SalesOverviewResponse.fromJson(json);
}

/// @nodoc
mixin _$SalesOverviewResponse {
  int get count => throw _privateConstructorUsedError;
  String? get next => throw _privateConstructorUsedError;
  String? get previous => throw _privateConstructorUsedError;
  List<SalesOverviewDtoModel> get results => throw _privateConstructorUsedError;

  /// Serializes this SalesOverviewResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SalesOverviewResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SalesOverviewResponseCopyWith<SalesOverviewResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SalesOverviewResponseCopyWith<$Res> {
  factory $SalesOverviewResponseCopyWith(
    SalesOverviewResponse value,
    $Res Function(SalesOverviewResponse) then,
  ) = _$SalesOverviewResponseCopyWithImpl<$Res, SalesOverviewResponse>;
  @useResult
  $Res call({
    int count,
    String? next,
    String? previous,
    List<SalesOverviewDtoModel> results,
  });
}

/// @nodoc
class _$SalesOverviewResponseCopyWithImpl<
  $Res,
  $Val extends SalesOverviewResponse
>
    implements $SalesOverviewResponseCopyWith<$Res> {
  _$SalesOverviewResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SalesOverviewResponse
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
                      as List<SalesOverviewDtoModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SalesOverviewResponseImplCopyWith<$Res>
    implements $SalesOverviewResponseCopyWith<$Res> {
  factory _$$SalesOverviewResponseImplCopyWith(
    _$SalesOverviewResponseImpl value,
    $Res Function(_$SalesOverviewResponseImpl) then,
  ) = __$$SalesOverviewResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int count,
    String? next,
    String? previous,
    List<SalesOverviewDtoModel> results,
  });
}

/// @nodoc
class __$$SalesOverviewResponseImplCopyWithImpl<$Res>
    extends
        _$SalesOverviewResponseCopyWithImpl<$Res, _$SalesOverviewResponseImpl>
    implements _$$SalesOverviewResponseImplCopyWith<$Res> {
  __$$SalesOverviewResponseImplCopyWithImpl(
    _$SalesOverviewResponseImpl _value,
    $Res Function(_$SalesOverviewResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SalesOverviewResponse
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
      _$SalesOverviewResponseImpl(
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
                  as List<SalesOverviewDtoModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SalesOverviewResponseImpl implements _SalesOverviewResponse {
  const _$SalesOverviewResponseImpl({
    required this.count,
    this.next,
    this.previous,
    required final List<SalesOverviewDtoModel> results,
  }) : _results = results;

  factory _$SalesOverviewResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SalesOverviewResponseImplFromJson(json);

  @override
  final int count;
  @override
  final String? next;
  @override
  final String? previous;
  final List<SalesOverviewDtoModel> _results;
  @override
  List<SalesOverviewDtoModel> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  String toString() {
    return 'SalesOverviewResponse(count: $count, next: $next, previous: $previous, results: $results)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SalesOverviewResponseImpl &&
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

  /// Create a copy of SalesOverviewResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SalesOverviewResponseImplCopyWith<_$SalesOverviewResponseImpl>
  get copyWith =>
      __$$SalesOverviewResponseImplCopyWithImpl<_$SalesOverviewResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SalesOverviewResponseImplToJson(this);
  }
}

abstract class _SalesOverviewResponse implements SalesOverviewResponse {
  const factory _SalesOverviewResponse({
    required final int count,
    final String? next,
    final String? previous,
    required final List<SalesOverviewDtoModel> results,
  }) = _$SalesOverviewResponseImpl;

  factory _SalesOverviewResponse.fromJson(Map<String, dynamic> json) =
      _$SalesOverviewResponseImpl.fromJson;

  @override
  int get count;
  @override
  String? get next;
  @override
  String? get previous;
  @override
  List<SalesOverviewDtoModel> get results;

  /// Create a copy of SalesOverviewResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SalesOverviewResponseImplCopyWith<_$SalesOverviewResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

SalesOverviewDtoModel _$SalesOverviewDtoModelFromJson(
  Map<String, dynamic> json,
) {
  return _SalesOverviewDtoModel.fromJson(json);
}

/// @nodoc
mixin _$SalesOverviewDtoModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'agent_id')
  String? get agentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_total')
  double? get orderTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'line_item_count')
  int? get lineItemCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'agent_first_name')
  String? get agentFirstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'agent_last_name')
  String? get agentLastName => throw _privateConstructorUsedError;
  @JsonKey(name: 'agent_code')
  String? get agentCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'regional_manager_first_name')
  String? get regionalManagerFirstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'regional_manager_last_name')
  String? get regionalManagerLastName => throw _privateConstructorUsedError;
  @JsonKey(name: 'regional_manager_code')
  String? get regionalManagerCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'province_name')
  String? get provinceName => throw _privateConstructorUsedError;
  @JsonKey(name: 'city_name')
  String? get cityName => throw _privateConstructorUsedError;
  @JsonKey(name: 'plan_name')
  String? get planName => throw _privateConstructorUsedError;
  @JsonKey(name: 'sub_plan_duration')
  int? get subPlanDuration => throw _privateConstructorUsedError;

  /// Serializes this SalesOverviewDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SalesOverviewDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SalesOverviewDtoModelCopyWith<SalesOverviewDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SalesOverviewDtoModelCopyWith<$Res> {
  factory $SalesOverviewDtoModelCopyWith(
    SalesOverviewDtoModel value,
    $Res Function(SalesOverviewDtoModel) then,
  ) = _$SalesOverviewDtoModelCopyWithImpl<$Res, SalesOverviewDtoModel>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'agent_id') String? agentId,
    @JsonKey(name: 'order_total') double? orderTotal,
    @JsonKey(name: 'line_item_count') int? lineItemCount,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'agent_first_name') String? agentFirstName,
    @JsonKey(name: 'agent_last_name') String? agentLastName,
    @JsonKey(name: 'agent_code') String? agentCode,
    @JsonKey(name: 'regional_manager_first_name')
    String? regionalManagerFirstName,
    @JsonKey(name: 'regional_manager_last_name')
    String? regionalManagerLastName,
    @JsonKey(name: 'regional_manager_code') String? regionalManagerCode,
    @JsonKey(name: 'province_name') String? provinceName,
    @JsonKey(name: 'city_name') String? cityName,
    @JsonKey(name: 'plan_name') String? planName,
    @JsonKey(name: 'sub_plan_duration') int? subPlanDuration,
  });
}

/// @nodoc
class _$SalesOverviewDtoModelCopyWithImpl<
  $Res,
  $Val extends SalesOverviewDtoModel
>
    implements $SalesOverviewDtoModelCopyWith<$Res> {
  _$SalesOverviewDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SalesOverviewDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? agentId = freezed,
    Object? orderTotal = freezed,
    Object? lineItemCount = freezed,
    Object? createdAt = freezed,
    Object? agentFirstName = freezed,
    Object? agentLastName = freezed,
    Object? agentCode = freezed,
    Object? regionalManagerFirstName = freezed,
    Object? regionalManagerLastName = freezed,
    Object? regionalManagerCode = freezed,
    Object? provinceName = freezed,
    Object? cityName = freezed,
    Object? planName = freezed,
    Object? subPlanDuration = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            agentId: freezed == agentId
                ? _value.agentId
                : agentId // ignore: cast_nullable_to_non_nullable
                      as String?,
            orderTotal: freezed == orderTotal
                ? _value.orderTotal
                : orderTotal // ignore: cast_nullable_to_non_nullable
                      as double?,
            lineItemCount: freezed == lineItemCount
                ? _value.lineItemCount
                : lineItemCount // ignore: cast_nullable_to_non_nullable
                      as int?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            agentFirstName: freezed == agentFirstName
                ? _value.agentFirstName
                : agentFirstName // ignore: cast_nullable_to_non_nullable
                      as String?,
            agentLastName: freezed == agentLastName
                ? _value.agentLastName
                : agentLastName // ignore: cast_nullable_to_non_nullable
                      as String?,
            agentCode: freezed == agentCode
                ? _value.agentCode
                : agentCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            regionalManagerFirstName: freezed == regionalManagerFirstName
                ? _value.regionalManagerFirstName
                : regionalManagerFirstName // ignore: cast_nullable_to_non_nullable
                      as String?,
            regionalManagerLastName: freezed == regionalManagerLastName
                ? _value.regionalManagerLastName
                : regionalManagerLastName // ignore: cast_nullable_to_non_nullable
                      as String?,
            regionalManagerCode: freezed == regionalManagerCode
                ? _value.regionalManagerCode
                : regionalManagerCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            provinceName: freezed == provinceName
                ? _value.provinceName
                : provinceName // ignore: cast_nullable_to_non_nullable
                      as String?,
            cityName: freezed == cityName
                ? _value.cityName
                : cityName // ignore: cast_nullable_to_non_nullable
                      as String?,
            planName: freezed == planName
                ? _value.planName
                : planName // ignore: cast_nullable_to_non_nullable
                      as String?,
            subPlanDuration: freezed == subPlanDuration
                ? _value.subPlanDuration
                : subPlanDuration // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SalesOverviewDtoModelImplCopyWith<$Res>
    implements $SalesOverviewDtoModelCopyWith<$Res> {
  factory _$$SalesOverviewDtoModelImplCopyWith(
    _$SalesOverviewDtoModelImpl value,
    $Res Function(_$SalesOverviewDtoModelImpl) then,
  ) = __$$SalesOverviewDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'agent_id') String? agentId,
    @JsonKey(name: 'order_total') double? orderTotal,
    @JsonKey(name: 'line_item_count') int? lineItemCount,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'agent_first_name') String? agentFirstName,
    @JsonKey(name: 'agent_last_name') String? agentLastName,
    @JsonKey(name: 'agent_code') String? agentCode,
    @JsonKey(name: 'regional_manager_first_name')
    String? regionalManagerFirstName,
    @JsonKey(name: 'regional_manager_last_name')
    String? regionalManagerLastName,
    @JsonKey(name: 'regional_manager_code') String? regionalManagerCode,
    @JsonKey(name: 'province_name') String? provinceName,
    @JsonKey(name: 'city_name') String? cityName,
    @JsonKey(name: 'plan_name') String? planName,
    @JsonKey(name: 'sub_plan_duration') int? subPlanDuration,
  });
}

/// @nodoc
class __$$SalesOverviewDtoModelImplCopyWithImpl<$Res>
    extends
        _$SalesOverviewDtoModelCopyWithImpl<$Res, _$SalesOverviewDtoModelImpl>
    implements _$$SalesOverviewDtoModelImplCopyWith<$Res> {
  __$$SalesOverviewDtoModelImplCopyWithImpl(
    _$SalesOverviewDtoModelImpl _value,
    $Res Function(_$SalesOverviewDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SalesOverviewDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? agentId = freezed,
    Object? orderTotal = freezed,
    Object? lineItemCount = freezed,
    Object? createdAt = freezed,
    Object? agentFirstName = freezed,
    Object? agentLastName = freezed,
    Object? agentCode = freezed,
    Object? regionalManagerFirstName = freezed,
    Object? regionalManagerLastName = freezed,
    Object? regionalManagerCode = freezed,
    Object? provinceName = freezed,
    Object? cityName = freezed,
    Object? planName = freezed,
    Object? subPlanDuration = freezed,
  }) {
    return _then(
      _$SalesOverviewDtoModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        agentId: freezed == agentId
            ? _value.agentId
            : agentId // ignore: cast_nullable_to_non_nullable
                  as String?,
        orderTotal: freezed == orderTotal
            ? _value.orderTotal
            : orderTotal // ignore: cast_nullable_to_non_nullable
                  as double?,
        lineItemCount: freezed == lineItemCount
            ? _value.lineItemCount
            : lineItemCount // ignore: cast_nullable_to_non_nullable
                  as int?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        agentFirstName: freezed == agentFirstName
            ? _value.agentFirstName
            : agentFirstName // ignore: cast_nullable_to_non_nullable
                  as String?,
        agentLastName: freezed == agentLastName
            ? _value.agentLastName
            : agentLastName // ignore: cast_nullable_to_non_nullable
                  as String?,
        agentCode: freezed == agentCode
            ? _value.agentCode
            : agentCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        regionalManagerFirstName: freezed == regionalManagerFirstName
            ? _value.regionalManagerFirstName
            : regionalManagerFirstName // ignore: cast_nullable_to_non_nullable
                  as String?,
        regionalManagerLastName: freezed == regionalManagerLastName
            ? _value.regionalManagerLastName
            : regionalManagerLastName // ignore: cast_nullable_to_non_nullable
                  as String?,
        regionalManagerCode: freezed == regionalManagerCode
            ? _value.regionalManagerCode
            : regionalManagerCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        provinceName: freezed == provinceName
            ? _value.provinceName
            : provinceName // ignore: cast_nullable_to_non_nullable
                  as String?,
        cityName: freezed == cityName
            ? _value.cityName
            : cityName // ignore: cast_nullable_to_non_nullable
                  as String?,
        planName: freezed == planName
            ? _value.planName
            : planName // ignore: cast_nullable_to_non_nullable
                  as String?,
        subPlanDuration: freezed == subPlanDuration
            ? _value.subPlanDuration
            : subPlanDuration // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SalesOverviewDtoModelImpl implements _SalesOverviewDtoModel {
  const _$SalesOverviewDtoModelImpl({
    required this.id,
    @JsonKey(name: 'agent_id') this.agentId,
    @JsonKey(name: 'order_total') this.orderTotal,
    @JsonKey(name: 'line_item_count') this.lineItemCount,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'agent_first_name') this.agentFirstName,
    @JsonKey(name: 'agent_last_name') this.agentLastName,
    @JsonKey(name: 'agent_code') this.agentCode,
    @JsonKey(name: 'regional_manager_first_name') this.regionalManagerFirstName,
    @JsonKey(name: 'regional_manager_last_name') this.regionalManagerLastName,
    @JsonKey(name: 'regional_manager_code') this.regionalManagerCode,
    @JsonKey(name: 'province_name') this.provinceName,
    @JsonKey(name: 'city_name') this.cityName,
    @JsonKey(name: 'plan_name') this.planName,
    @JsonKey(name: 'sub_plan_duration') this.subPlanDuration,
  });

  factory _$SalesOverviewDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SalesOverviewDtoModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'agent_id')
  final String? agentId;
  @override
  @JsonKey(name: 'order_total')
  final double? orderTotal;
  @override
  @JsonKey(name: 'line_item_count')
  final int? lineItemCount;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'agent_first_name')
  final String? agentFirstName;
  @override
  @JsonKey(name: 'agent_last_name')
  final String? agentLastName;
  @override
  @JsonKey(name: 'agent_code')
  final String? agentCode;
  @override
  @JsonKey(name: 'regional_manager_first_name')
  final String? regionalManagerFirstName;
  @override
  @JsonKey(name: 'regional_manager_last_name')
  final String? regionalManagerLastName;
  @override
  @JsonKey(name: 'regional_manager_code')
  final String? regionalManagerCode;
  @override
  @JsonKey(name: 'province_name')
  final String? provinceName;
  @override
  @JsonKey(name: 'city_name')
  final String? cityName;
  @override
  @JsonKey(name: 'plan_name')
  final String? planName;
  @override
  @JsonKey(name: 'sub_plan_duration')
  final int? subPlanDuration;

  @override
  String toString() {
    return 'SalesOverviewDtoModel(id: $id, agentId: $agentId, orderTotal: $orderTotal, lineItemCount: $lineItemCount, createdAt: $createdAt, agentFirstName: $agentFirstName, agentLastName: $agentLastName, agentCode: $agentCode, regionalManagerFirstName: $regionalManagerFirstName, regionalManagerLastName: $regionalManagerLastName, regionalManagerCode: $regionalManagerCode, provinceName: $provinceName, cityName: $cityName, planName: $planName, subPlanDuration: $subPlanDuration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SalesOverviewDtoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.agentId, agentId) || other.agentId == agentId) &&
            (identical(other.orderTotal, orderTotal) ||
                other.orderTotal == orderTotal) &&
            (identical(other.lineItemCount, lineItemCount) ||
                other.lineItemCount == lineItemCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.agentFirstName, agentFirstName) ||
                other.agentFirstName == agentFirstName) &&
            (identical(other.agentLastName, agentLastName) ||
                other.agentLastName == agentLastName) &&
            (identical(other.agentCode, agentCode) ||
                other.agentCode == agentCode) &&
            (identical(
                  other.regionalManagerFirstName,
                  regionalManagerFirstName,
                ) ||
                other.regionalManagerFirstName == regionalManagerFirstName) &&
            (identical(
                  other.regionalManagerLastName,
                  regionalManagerLastName,
                ) ||
                other.regionalManagerLastName == regionalManagerLastName) &&
            (identical(other.regionalManagerCode, regionalManagerCode) ||
                other.regionalManagerCode == regionalManagerCode) &&
            (identical(other.provinceName, provinceName) ||
                other.provinceName == provinceName) &&
            (identical(other.cityName, cityName) ||
                other.cityName == cityName) &&
            (identical(other.planName, planName) ||
                other.planName == planName) &&
            (identical(other.subPlanDuration, subPlanDuration) ||
                other.subPlanDuration == subPlanDuration));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    agentId,
    orderTotal,
    lineItemCount,
    createdAt,
    agentFirstName,
    agentLastName,
    agentCode,
    regionalManagerFirstName,
    regionalManagerLastName,
    regionalManagerCode,
    provinceName,
    cityName,
    planName,
    subPlanDuration,
  );

  /// Create a copy of SalesOverviewDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SalesOverviewDtoModelImplCopyWith<_$SalesOverviewDtoModelImpl>
  get copyWith =>
      __$$SalesOverviewDtoModelImplCopyWithImpl<_$SalesOverviewDtoModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SalesOverviewDtoModelImplToJson(this);
  }
}

abstract class _SalesOverviewDtoModel implements SalesOverviewDtoModel {
  const factory _SalesOverviewDtoModel({
    required final String id,
    @JsonKey(name: 'agent_id') final String? agentId,
    @JsonKey(name: 'order_total') final double? orderTotal,
    @JsonKey(name: 'line_item_count') final int? lineItemCount,
    @JsonKey(name: 'created_at') final String? createdAt,
    @JsonKey(name: 'agent_first_name') final String? agentFirstName,
    @JsonKey(name: 'agent_last_name') final String? agentLastName,
    @JsonKey(name: 'agent_code') final String? agentCode,
    @JsonKey(name: 'regional_manager_first_name')
    final String? regionalManagerFirstName,
    @JsonKey(name: 'regional_manager_last_name')
    final String? regionalManagerLastName,
    @JsonKey(name: 'regional_manager_code') final String? regionalManagerCode,
    @JsonKey(name: 'province_name') final String? provinceName,
    @JsonKey(name: 'city_name') final String? cityName,
    @JsonKey(name: 'plan_name') final String? planName,
    @JsonKey(name: 'sub_plan_duration') final int? subPlanDuration,
  }) = _$SalesOverviewDtoModelImpl;

  factory _SalesOverviewDtoModel.fromJson(Map<String, dynamic> json) =
      _$SalesOverviewDtoModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'agent_id')
  String? get agentId;
  @override
  @JsonKey(name: 'order_total')
  double? get orderTotal;
  @override
  @JsonKey(name: 'line_item_count')
  int? get lineItemCount;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'agent_first_name')
  String? get agentFirstName;
  @override
  @JsonKey(name: 'agent_last_name')
  String? get agentLastName;
  @override
  @JsonKey(name: 'agent_code')
  String? get agentCode;
  @override
  @JsonKey(name: 'regional_manager_first_name')
  String? get regionalManagerFirstName;
  @override
  @JsonKey(name: 'regional_manager_last_name')
  String? get regionalManagerLastName;
  @override
  @JsonKey(name: 'regional_manager_code')
  String? get regionalManagerCode;
  @override
  @JsonKey(name: 'province_name')
  String? get provinceName;
  @override
  @JsonKey(name: 'city_name')
  String? get cityName;
  @override
  @JsonKey(name: 'plan_name')
  String? get planName;
  @override
  @JsonKey(name: 'sub_plan_duration')
  int? get subPlanDuration;

  /// Create a copy of SalesOverviewDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SalesOverviewDtoModelImplCopyWith<_$SalesOverviewDtoModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

SalesByPlanResponse _$SalesByPlanResponseFromJson(Map<String, dynamic> json) {
  return _SalesByPlanResponse.fromJson(json);
}

/// @nodoc
mixin _$SalesByPlanResponse {
  int get count => throw _privateConstructorUsedError;
  String? get next => throw _privateConstructorUsedError;
  String? get previous => throw _privateConstructorUsedError;
  List<SalesByPlanDtoModel> get results => throw _privateConstructorUsedError;

  /// Serializes this SalesByPlanResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SalesByPlanResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SalesByPlanResponseCopyWith<SalesByPlanResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SalesByPlanResponseCopyWith<$Res> {
  factory $SalesByPlanResponseCopyWith(
    SalesByPlanResponse value,
    $Res Function(SalesByPlanResponse) then,
  ) = _$SalesByPlanResponseCopyWithImpl<$Res, SalesByPlanResponse>;
  @useResult
  $Res call({
    int count,
    String? next,
    String? previous,
    List<SalesByPlanDtoModel> results,
  });
}

/// @nodoc
class _$SalesByPlanResponseCopyWithImpl<$Res, $Val extends SalesByPlanResponse>
    implements $SalesByPlanResponseCopyWith<$Res> {
  _$SalesByPlanResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SalesByPlanResponse
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
                      as List<SalesByPlanDtoModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SalesByPlanResponseImplCopyWith<$Res>
    implements $SalesByPlanResponseCopyWith<$Res> {
  factory _$$SalesByPlanResponseImplCopyWith(
    _$SalesByPlanResponseImpl value,
    $Res Function(_$SalesByPlanResponseImpl) then,
  ) = __$$SalesByPlanResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int count,
    String? next,
    String? previous,
    List<SalesByPlanDtoModel> results,
  });
}

/// @nodoc
class __$$SalesByPlanResponseImplCopyWithImpl<$Res>
    extends _$SalesByPlanResponseCopyWithImpl<$Res, _$SalesByPlanResponseImpl>
    implements _$$SalesByPlanResponseImplCopyWith<$Res> {
  __$$SalesByPlanResponseImplCopyWithImpl(
    _$SalesByPlanResponseImpl _value,
    $Res Function(_$SalesByPlanResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SalesByPlanResponse
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
      _$SalesByPlanResponseImpl(
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
                  as List<SalesByPlanDtoModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SalesByPlanResponseImpl implements _SalesByPlanResponse {
  const _$SalesByPlanResponseImpl({
    required this.count,
    this.next,
    this.previous,
    required final List<SalesByPlanDtoModel> results,
  }) : _results = results;

  factory _$SalesByPlanResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SalesByPlanResponseImplFromJson(json);

  @override
  final int count;
  @override
  final String? next;
  @override
  final String? previous;
  final List<SalesByPlanDtoModel> _results;
  @override
  List<SalesByPlanDtoModel> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  String toString() {
    return 'SalesByPlanResponse(count: $count, next: $next, previous: $previous, results: $results)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SalesByPlanResponseImpl &&
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

  /// Create a copy of SalesByPlanResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SalesByPlanResponseImplCopyWith<_$SalesByPlanResponseImpl> get copyWith =>
      __$$SalesByPlanResponseImplCopyWithImpl<_$SalesByPlanResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SalesByPlanResponseImplToJson(this);
  }
}

abstract class _SalesByPlanResponse implements SalesByPlanResponse {
  const factory _SalesByPlanResponse({
    required final int count,
    final String? next,
    final String? previous,
    required final List<SalesByPlanDtoModel> results,
  }) = _$SalesByPlanResponseImpl;

  factory _SalesByPlanResponse.fromJson(Map<String, dynamic> json) =
      _$SalesByPlanResponseImpl.fromJson;

  @override
  int get count;
  @override
  String? get next;
  @override
  String? get previous;
  @override
  List<SalesByPlanDtoModel> get results;

  /// Create a copy of SalesByPlanResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SalesByPlanResponseImplCopyWith<_$SalesByPlanResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SalesByPlanDtoModel _$SalesByPlanDtoModelFromJson(Map<String, dynamic> json) {
  return _SalesByPlanDtoModel.fromJson(json);
}

/// @nodoc
mixin _$SalesByPlanDtoModel {
  @JsonKey(name: 'sub_plan_id')
  String get subPlanId => throw _privateConstructorUsedError;
  @JsonKey(name: 'plan_name')
  String? get planName => throw _privateConstructorUsedError;
  @JsonKey(name: 'sub_plan_duration')
  int? get subPlanDuration => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_line_items')
  int? get totalLineItems => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_orders')
  int? get totalOrders => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_sales_amount')
  double? get totalSalesAmount => throw _privateConstructorUsedError;

  /// Serializes this SalesByPlanDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SalesByPlanDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SalesByPlanDtoModelCopyWith<SalesByPlanDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SalesByPlanDtoModelCopyWith<$Res> {
  factory $SalesByPlanDtoModelCopyWith(
    SalesByPlanDtoModel value,
    $Res Function(SalesByPlanDtoModel) then,
  ) = _$SalesByPlanDtoModelCopyWithImpl<$Res, SalesByPlanDtoModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'sub_plan_id') String subPlanId,
    @JsonKey(name: 'plan_name') String? planName,
    @JsonKey(name: 'sub_plan_duration') int? subPlanDuration,
    @JsonKey(name: 'total_line_items') int? totalLineItems,
    @JsonKey(name: 'total_orders') int? totalOrders,
    @JsonKey(name: 'total_sales_amount') double? totalSalesAmount,
  });
}

/// @nodoc
class _$SalesByPlanDtoModelCopyWithImpl<$Res, $Val extends SalesByPlanDtoModel>
    implements $SalesByPlanDtoModelCopyWith<$Res> {
  _$SalesByPlanDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SalesByPlanDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subPlanId = null,
    Object? planName = freezed,
    Object? subPlanDuration = freezed,
    Object? totalLineItems = freezed,
    Object? totalOrders = freezed,
    Object? totalSalesAmount = freezed,
  }) {
    return _then(
      _value.copyWith(
            subPlanId: null == subPlanId
                ? _value.subPlanId
                : subPlanId // ignore: cast_nullable_to_non_nullable
                      as String,
            planName: freezed == planName
                ? _value.planName
                : planName // ignore: cast_nullable_to_non_nullable
                      as String?,
            subPlanDuration: freezed == subPlanDuration
                ? _value.subPlanDuration
                : subPlanDuration // ignore: cast_nullable_to_non_nullable
                      as int?,
            totalLineItems: freezed == totalLineItems
                ? _value.totalLineItems
                : totalLineItems // ignore: cast_nullable_to_non_nullable
                      as int?,
            totalOrders: freezed == totalOrders
                ? _value.totalOrders
                : totalOrders // ignore: cast_nullable_to_non_nullable
                      as int?,
            totalSalesAmount: freezed == totalSalesAmount
                ? _value.totalSalesAmount
                : totalSalesAmount // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SalesByPlanDtoModelImplCopyWith<$Res>
    implements $SalesByPlanDtoModelCopyWith<$Res> {
  factory _$$SalesByPlanDtoModelImplCopyWith(
    _$SalesByPlanDtoModelImpl value,
    $Res Function(_$SalesByPlanDtoModelImpl) then,
  ) = __$$SalesByPlanDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'sub_plan_id') String subPlanId,
    @JsonKey(name: 'plan_name') String? planName,
    @JsonKey(name: 'sub_plan_duration') int? subPlanDuration,
    @JsonKey(name: 'total_line_items') int? totalLineItems,
    @JsonKey(name: 'total_orders') int? totalOrders,
    @JsonKey(name: 'total_sales_amount') double? totalSalesAmount,
  });
}

/// @nodoc
class __$$SalesByPlanDtoModelImplCopyWithImpl<$Res>
    extends _$SalesByPlanDtoModelCopyWithImpl<$Res, _$SalesByPlanDtoModelImpl>
    implements _$$SalesByPlanDtoModelImplCopyWith<$Res> {
  __$$SalesByPlanDtoModelImplCopyWithImpl(
    _$SalesByPlanDtoModelImpl _value,
    $Res Function(_$SalesByPlanDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SalesByPlanDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subPlanId = null,
    Object? planName = freezed,
    Object? subPlanDuration = freezed,
    Object? totalLineItems = freezed,
    Object? totalOrders = freezed,
    Object? totalSalesAmount = freezed,
  }) {
    return _then(
      _$SalesByPlanDtoModelImpl(
        subPlanId: null == subPlanId
            ? _value.subPlanId
            : subPlanId // ignore: cast_nullable_to_non_nullable
                  as String,
        planName: freezed == planName
            ? _value.planName
            : planName // ignore: cast_nullable_to_non_nullable
                  as String?,
        subPlanDuration: freezed == subPlanDuration
            ? _value.subPlanDuration
            : subPlanDuration // ignore: cast_nullable_to_non_nullable
                  as int?,
        totalLineItems: freezed == totalLineItems
            ? _value.totalLineItems
            : totalLineItems // ignore: cast_nullable_to_non_nullable
                  as int?,
        totalOrders: freezed == totalOrders
            ? _value.totalOrders
            : totalOrders // ignore: cast_nullable_to_non_nullable
                  as int?,
        totalSalesAmount: freezed == totalSalesAmount
            ? _value.totalSalesAmount
            : totalSalesAmount // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SalesByPlanDtoModelImpl implements _SalesByPlanDtoModel {
  const _$SalesByPlanDtoModelImpl({
    @JsonKey(name: 'sub_plan_id') required this.subPlanId,
    @JsonKey(name: 'plan_name') this.planName,
    @JsonKey(name: 'sub_plan_duration') this.subPlanDuration,
    @JsonKey(name: 'total_line_items') this.totalLineItems,
    @JsonKey(name: 'total_orders') this.totalOrders,
    @JsonKey(name: 'total_sales_amount') this.totalSalesAmount,
  });

  factory _$SalesByPlanDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SalesByPlanDtoModelImplFromJson(json);

  @override
  @JsonKey(name: 'sub_plan_id')
  final String subPlanId;
  @override
  @JsonKey(name: 'plan_name')
  final String? planName;
  @override
  @JsonKey(name: 'sub_plan_duration')
  final int? subPlanDuration;
  @override
  @JsonKey(name: 'total_line_items')
  final int? totalLineItems;
  @override
  @JsonKey(name: 'total_orders')
  final int? totalOrders;
  @override
  @JsonKey(name: 'total_sales_amount')
  final double? totalSalesAmount;

  @override
  String toString() {
    return 'SalesByPlanDtoModel(subPlanId: $subPlanId, planName: $planName, subPlanDuration: $subPlanDuration, totalLineItems: $totalLineItems, totalOrders: $totalOrders, totalSalesAmount: $totalSalesAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SalesByPlanDtoModelImpl &&
            (identical(other.subPlanId, subPlanId) ||
                other.subPlanId == subPlanId) &&
            (identical(other.planName, planName) ||
                other.planName == planName) &&
            (identical(other.subPlanDuration, subPlanDuration) ||
                other.subPlanDuration == subPlanDuration) &&
            (identical(other.totalLineItems, totalLineItems) ||
                other.totalLineItems == totalLineItems) &&
            (identical(other.totalOrders, totalOrders) ||
                other.totalOrders == totalOrders) &&
            (identical(other.totalSalesAmount, totalSalesAmount) ||
                other.totalSalesAmount == totalSalesAmount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    subPlanId,
    planName,
    subPlanDuration,
    totalLineItems,
    totalOrders,
    totalSalesAmount,
  );

  /// Create a copy of SalesByPlanDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SalesByPlanDtoModelImplCopyWith<_$SalesByPlanDtoModelImpl> get copyWith =>
      __$$SalesByPlanDtoModelImplCopyWithImpl<_$SalesByPlanDtoModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SalesByPlanDtoModelImplToJson(this);
  }
}

abstract class _SalesByPlanDtoModel implements SalesByPlanDtoModel {
  const factory _SalesByPlanDtoModel({
    @JsonKey(name: 'sub_plan_id') required final String subPlanId,
    @JsonKey(name: 'plan_name') final String? planName,
    @JsonKey(name: 'sub_plan_duration') final int? subPlanDuration,
    @JsonKey(name: 'total_line_items') final int? totalLineItems,
    @JsonKey(name: 'total_orders') final int? totalOrders,
    @JsonKey(name: 'total_sales_amount') final double? totalSalesAmount,
  }) = _$SalesByPlanDtoModelImpl;

  factory _SalesByPlanDtoModel.fromJson(Map<String, dynamic> json) =
      _$SalesByPlanDtoModelImpl.fromJson;

  @override
  @JsonKey(name: 'sub_plan_id')
  String get subPlanId;
  @override
  @JsonKey(name: 'plan_name')
  String? get planName;
  @override
  @JsonKey(name: 'sub_plan_duration')
  int? get subPlanDuration;
  @override
  @JsonKey(name: 'total_line_items')
  int? get totalLineItems;
  @override
  @JsonKey(name: 'total_orders')
  int? get totalOrders;
  @override
  @JsonKey(name: 'total_sales_amount')
  double? get totalSalesAmount;

  /// Create a copy of SalesByPlanDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SalesByPlanDtoModelImplCopyWith<_$SalesByPlanDtoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SalesByCategoryResponse _$SalesByCategoryResponseFromJson(
  Map<String, dynamic> json,
) {
  return _SalesByCategoryResponse.fromJson(json);
}

/// @nodoc
mixin _$SalesByCategoryResponse {
  int get count => throw _privateConstructorUsedError;
  String? get next => throw _privateConstructorUsedError;
  String? get previous => throw _privateConstructorUsedError;
  List<SalesByCategoryDtoModel> get results =>
      throw _privateConstructorUsedError;

  /// Serializes this SalesByCategoryResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SalesByCategoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SalesByCategoryResponseCopyWith<SalesByCategoryResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SalesByCategoryResponseCopyWith<$Res> {
  factory $SalesByCategoryResponseCopyWith(
    SalesByCategoryResponse value,
    $Res Function(SalesByCategoryResponse) then,
  ) = _$SalesByCategoryResponseCopyWithImpl<$Res, SalesByCategoryResponse>;
  @useResult
  $Res call({
    int count,
    String? next,
    String? previous,
    List<SalesByCategoryDtoModel> results,
  });
}

/// @nodoc
class _$SalesByCategoryResponseCopyWithImpl<
  $Res,
  $Val extends SalesByCategoryResponse
>
    implements $SalesByCategoryResponseCopyWith<$Res> {
  _$SalesByCategoryResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SalesByCategoryResponse
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
                      as List<SalesByCategoryDtoModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SalesByCategoryResponseImplCopyWith<$Res>
    implements $SalesByCategoryResponseCopyWith<$Res> {
  factory _$$SalesByCategoryResponseImplCopyWith(
    _$SalesByCategoryResponseImpl value,
    $Res Function(_$SalesByCategoryResponseImpl) then,
  ) = __$$SalesByCategoryResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int count,
    String? next,
    String? previous,
    List<SalesByCategoryDtoModel> results,
  });
}

/// @nodoc
class __$$SalesByCategoryResponseImplCopyWithImpl<$Res>
    extends
        _$SalesByCategoryResponseCopyWithImpl<
          $Res,
          _$SalesByCategoryResponseImpl
        >
    implements _$$SalesByCategoryResponseImplCopyWith<$Res> {
  __$$SalesByCategoryResponseImplCopyWithImpl(
    _$SalesByCategoryResponseImpl _value,
    $Res Function(_$SalesByCategoryResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SalesByCategoryResponse
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
      _$SalesByCategoryResponseImpl(
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
                  as List<SalesByCategoryDtoModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SalesByCategoryResponseImpl implements _SalesByCategoryResponse {
  const _$SalesByCategoryResponseImpl({
    required this.count,
    this.next,
    this.previous,
    required final List<SalesByCategoryDtoModel> results,
  }) : _results = results;

  factory _$SalesByCategoryResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SalesByCategoryResponseImplFromJson(json);

  @override
  final int count;
  @override
  final String? next;
  @override
  final String? previous;
  final List<SalesByCategoryDtoModel> _results;
  @override
  List<SalesByCategoryDtoModel> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  String toString() {
    return 'SalesByCategoryResponse(count: $count, next: $next, previous: $previous, results: $results)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SalesByCategoryResponseImpl &&
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

  /// Create a copy of SalesByCategoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SalesByCategoryResponseImplCopyWith<_$SalesByCategoryResponseImpl>
  get copyWith =>
      __$$SalesByCategoryResponseImplCopyWithImpl<
        _$SalesByCategoryResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SalesByCategoryResponseImplToJson(this);
  }
}

abstract class _SalesByCategoryResponse implements SalesByCategoryResponse {
  const factory _SalesByCategoryResponse({
    required final int count,
    final String? next,
    final String? previous,
    required final List<SalesByCategoryDtoModel> results,
  }) = _$SalesByCategoryResponseImpl;

  factory _SalesByCategoryResponse.fromJson(Map<String, dynamic> json) =
      _$SalesByCategoryResponseImpl.fromJson;

  @override
  int get count;
  @override
  String? get next;
  @override
  String? get previous;
  @override
  List<SalesByCategoryDtoModel> get results;

  /// Create a copy of SalesByCategoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SalesByCategoryResponseImplCopyWith<_$SalesByCategoryResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

SalesByCategoryDtoModel _$SalesByCategoryDtoModelFromJson(
  Map<String, dynamic> json,
) {
  return _SalesByCategoryDtoModel.fromJson(json);
}

/// @nodoc
mixin _$SalesByCategoryDtoModel {
  @JsonKey(name: 'category_id')
  String get categoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_name')
  String? get categoryName => throw _privateConstructorUsedError;
  @JsonKey(name: 'parent_category_name')
  String? get parentCategoryName => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_count')
  int? get productCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_line_items')
  int? get totalLineItems => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_orders')
  int? get totalOrders => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_sales_amount')
  double? get totalSalesAmount => throw _privateConstructorUsedError;

  /// Serializes this SalesByCategoryDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SalesByCategoryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SalesByCategoryDtoModelCopyWith<SalesByCategoryDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SalesByCategoryDtoModelCopyWith<$Res> {
  factory $SalesByCategoryDtoModelCopyWith(
    SalesByCategoryDtoModel value,
    $Res Function(SalesByCategoryDtoModel) then,
  ) = _$SalesByCategoryDtoModelCopyWithImpl<$Res, SalesByCategoryDtoModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'category_id') String categoryId,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'parent_category_name') String? parentCategoryName,
    @JsonKey(name: 'product_count') int? productCount,
    @JsonKey(name: 'total_line_items') int? totalLineItems,
    @JsonKey(name: 'total_orders') int? totalOrders,
    @JsonKey(name: 'total_sales_amount') double? totalSalesAmount,
  });
}

/// @nodoc
class _$SalesByCategoryDtoModelCopyWithImpl<
  $Res,
  $Val extends SalesByCategoryDtoModel
>
    implements $SalesByCategoryDtoModelCopyWith<$Res> {
  _$SalesByCategoryDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SalesByCategoryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? categoryName = freezed,
    Object? parentCategoryName = freezed,
    Object? productCount = freezed,
    Object? totalLineItems = freezed,
    Object? totalOrders = freezed,
    Object? totalSalesAmount = freezed,
  }) {
    return _then(
      _value.copyWith(
            categoryId: null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryName: freezed == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
                      as String?,
            parentCategoryName: freezed == parentCategoryName
                ? _value.parentCategoryName
                : parentCategoryName // ignore: cast_nullable_to_non_nullable
                      as String?,
            productCount: freezed == productCount
                ? _value.productCount
                : productCount // ignore: cast_nullable_to_non_nullable
                      as int?,
            totalLineItems: freezed == totalLineItems
                ? _value.totalLineItems
                : totalLineItems // ignore: cast_nullable_to_non_nullable
                      as int?,
            totalOrders: freezed == totalOrders
                ? _value.totalOrders
                : totalOrders // ignore: cast_nullable_to_non_nullable
                      as int?,
            totalSalesAmount: freezed == totalSalesAmount
                ? _value.totalSalesAmount
                : totalSalesAmount // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SalesByCategoryDtoModelImplCopyWith<$Res>
    implements $SalesByCategoryDtoModelCopyWith<$Res> {
  factory _$$SalesByCategoryDtoModelImplCopyWith(
    _$SalesByCategoryDtoModelImpl value,
    $Res Function(_$SalesByCategoryDtoModelImpl) then,
  ) = __$$SalesByCategoryDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'category_id') String categoryId,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'parent_category_name') String? parentCategoryName,
    @JsonKey(name: 'product_count') int? productCount,
    @JsonKey(name: 'total_line_items') int? totalLineItems,
    @JsonKey(name: 'total_orders') int? totalOrders,
    @JsonKey(name: 'total_sales_amount') double? totalSalesAmount,
  });
}

/// @nodoc
class __$$SalesByCategoryDtoModelImplCopyWithImpl<$Res>
    extends
        _$SalesByCategoryDtoModelCopyWithImpl<
          $Res,
          _$SalesByCategoryDtoModelImpl
        >
    implements _$$SalesByCategoryDtoModelImplCopyWith<$Res> {
  __$$SalesByCategoryDtoModelImplCopyWithImpl(
    _$SalesByCategoryDtoModelImpl _value,
    $Res Function(_$SalesByCategoryDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SalesByCategoryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? categoryName = freezed,
    Object? parentCategoryName = freezed,
    Object? productCount = freezed,
    Object? totalLineItems = freezed,
    Object? totalOrders = freezed,
    Object? totalSalesAmount = freezed,
  }) {
    return _then(
      _$SalesByCategoryDtoModelImpl(
        categoryId: null == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryName: freezed == categoryName
            ? _value.categoryName
            : categoryName // ignore: cast_nullable_to_non_nullable
                  as String?,
        parentCategoryName: freezed == parentCategoryName
            ? _value.parentCategoryName
            : parentCategoryName // ignore: cast_nullable_to_non_nullable
                  as String?,
        productCount: freezed == productCount
            ? _value.productCount
            : productCount // ignore: cast_nullable_to_non_nullable
                  as int?,
        totalLineItems: freezed == totalLineItems
            ? _value.totalLineItems
            : totalLineItems // ignore: cast_nullable_to_non_nullable
                  as int?,
        totalOrders: freezed == totalOrders
            ? _value.totalOrders
            : totalOrders // ignore: cast_nullable_to_non_nullable
                  as int?,
        totalSalesAmount: freezed == totalSalesAmount
            ? _value.totalSalesAmount
            : totalSalesAmount // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SalesByCategoryDtoModelImpl implements _SalesByCategoryDtoModel {
  const _$SalesByCategoryDtoModelImpl({
    @JsonKey(name: 'category_id') required this.categoryId,
    @JsonKey(name: 'category_name') this.categoryName,
    @JsonKey(name: 'parent_category_name') this.parentCategoryName,
    @JsonKey(name: 'product_count') this.productCount,
    @JsonKey(name: 'total_line_items') this.totalLineItems,
    @JsonKey(name: 'total_orders') this.totalOrders,
    @JsonKey(name: 'total_sales_amount') this.totalSalesAmount,
  });

  factory _$SalesByCategoryDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SalesByCategoryDtoModelImplFromJson(json);

  @override
  @JsonKey(name: 'category_id')
  final String categoryId;
  @override
  @JsonKey(name: 'category_name')
  final String? categoryName;
  @override
  @JsonKey(name: 'parent_category_name')
  final String? parentCategoryName;
  @override
  @JsonKey(name: 'product_count')
  final int? productCount;
  @override
  @JsonKey(name: 'total_line_items')
  final int? totalLineItems;
  @override
  @JsonKey(name: 'total_orders')
  final int? totalOrders;
  @override
  @JsonKey(name: 'total_sales_amount')
  final double? totalSalesAmount;

  @override
  String toString() {
    return 'SalesByCategoryDtoModel(categoryId: $categoryId, categoryName: $categoryName, parentCategoryName: $parentCategoryName, productCount: $productCount, totalLineItems: $totalLineItems, totalOrders: $totalOrders, totalSalesAmount: $totalSalesAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SalesByCategoryDtoModelImpl &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.parentCategoryName, parentCategoryName) ||
                other.parentCategoryName == parentCategoryName) &&
            (identical(other.productCount, productCount) ||
                other.productCount == productCount) &&
            (identical(other.totalLineItems, totalLineItems) ||
                other.totalLineItems == totalLineItems) &&
            (identical(other.totalOrders, totalOrders) ||
                other.totalOrders == totalOrders) &&
            (identical(other.totalSalesAmount, totalSalesAmount) ||
                other.totalSalesAmount == totalSalesAmount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    categoryId,
    categoryName,
    parentCategoryName,
    productCount,
    totalLineItems,
    totalOrders,
    totalSalesAmount,
  );

  /// Create a copy of SalesByCategoryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SalesByCategoryDtoModelImplCopyWith<_$SalesByCategoryDtoModelImpl>
  get copyWith =>
      __$$SalesByCategoryDtoModelImplCopyWithImpl<
        _$SalesByCategoryDtoModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SalesByCategoryDtoModelImplToJson(this);
  }
}

abstract class _SalesByCategoryDtoModel implements SalesByCategoryDtoModel {
  const factory _SalesByCategoryDtoModel({
    @JsonKey(name: 'category_id') required final String categoryId,
    @JsonKey(name: 'category_name') final String? categoryName,
    @JsonKey(name: 'parent_category_name') final String? parentCategoryName,
    @JsonKey(name: 'product_count') final int? productCount,
    @JsonKey(name: 'total_line_items') final int? totalLineItems,
    @JsonKey(name: 'total_orders') final int? totalOrders,
    @JsonKey(name: 'total_sales_amount') final double? totalSalesAmount,
  }) = _$SalesByCategoryDtoModelImpl;

  factory _SalesByCategoryDtoModel.fromJson(Map<String, dynamic> json) =
      _$SalesByCategoryDtoModelImpl.fromJson;

  @override
  @JsonKey(name: 'category_id')
  String get categoryId;
  @override
  @JsonKey(name: 'category_name')
  String? get categoryName;
  @override
  @JsonKey(name: 'parent_category_name')
  String? get parentCategoryName;
  @override
  @JsonKey(name: 'product_count')
  int? get productCount;
  @override
  @JsonKey(name: 'total_line_items')
  int? get totalLineItems;
  @override
  @JsonKey(name: 'total_orders')
  int? get totalOrders;
  @override
  @JsonKey(name: 'total_sales_amount')
  double? get totalSalesAmount;

  /// Create a copy of SalesByCategoryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SalesByCategoryDtoModelImplCopyWith<_$SalesByCategoryDtoModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

SalesByProductResponse _$SalesByProductResponseFromJson(
  Map<String, dynamic> json,
) {
  return _SalesByProductResponse.fromJson(json);
}

/// @nodoc
mixin _$SalesByProductResponse {
  int get count => throw _privateConstructorUsedError;
  String? get next => throw _privateConstructorUsedError;
  String? get previous => throw _privateConstructorUsedError;
  List<SalesByProductDtoModel> get results =>
      throw _privateConstructorUsedError;

  /// Serializes this SalesByProductResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SalesByProductResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SalesByProductResponseCopyWith<SalesByProductResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SalesByProductResponseCopyWith<$Res> {
  factory $SalesByProductResponseCopyWith(
    SalesByProductResponse value,
    $Res Function(SalesByProductResponse) then,
  ) = _$SalesByProductResponseCopyWithImpl<$Res, SalesByProductResponse>;
  @useResult
  $Res call({
    int count,
    String? next,
    String? previous,
    List<SalesByProductDtoModel> results,
  });
}

/// @nodoc
class _$SalesByProductResponseCopyWithImpl<
  $Res,
  $Val extends SalesByProductResponse
>
    implements $SalesByProductResponseCopyWith<$Res> {
  _$SalesByProductResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SalesByProductResponse
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
                      as List<SalesByProductDtoModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SalesByProductResponseImplCopyWith<$Res>
    implements $SalesByProductResponseCopyWith<$Res> {
  factory _$$SalesByProductResponseImplCopyWith(
    _$SalesByProductResponseImpl value,
    $Res Function(_$SalesByProductResponseImpl) then,
  ) = __$$SalesByProductResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int count,
    String? next,
    String? previous,
    List<SalesByProductDtoModel> results,
  });
}

/// @nodoc
class __$$SalesByProductResponseImplCopyWithImpl<$Res>
    extends
        _$SalesByProductResponseCopyWithImpl<$Res, _$SalesByProductResponseImpl>
    implements _$$SalesByProductResponseImplCopyWith<$Res> {
  __$$SalesByProductResponseImplCopyWithImpl(
    _$SalesByProductResponseImpl _value,
    $Res Function(_$SalesByProductResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SalesByProductResponse
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
      _$SalesByProductResponseImpl(
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
                  as List<SalesByProductDtoModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SalesByProductResponseImpl implements _SalesByProductResponse {
  const _$SalesByProductResponseImpl({
    required this.count,
    this.next,
    this.previous,
    required final List<SalesByProductDtoModel> results,
  }) : _results = results;

  factory _$SalesByProductResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SalesByProductResponseImplFromJson(json);

  @override
  final int count;
  @override
  final String? next;
  @override
  final String? previous;
  final List<SalesByProductDtoModel> _results;
  @override
  List<SalesByProductDtoModel> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  String toString() {
    return 'SalesByProductResponse(count: $count, next: $next, previous: $previous, results: $results)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SalesByProductResponseImpl &&
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

  /// Create a copy of SalesByProductResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SalesByProductResponseImplCopyWith<_$SalesByProductResponseImpl>
  get copyWith =>
      __$$SalesByProductResponseImplCopyWithImpl<_$SalesByProductResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SalesByProductResponseImplToJson(this);
  }
}

abstract class _SalesByProductResponse implements SalesByProductResponse {
  const factory _SalesByProductResponse({
    required final int count,
    final String? next,
    final String? previous,
    required final List<SalesByProductDtoModel> results,
  }) = _$SalesByProductResponseImpl;

  factory _SalesByProductResponse.fromJson(Map<String, dynamic> json) =
      _$SalesByProductResponseImpl.fromJson;

  @override
  int get count;
  @override
  String? get next;
  @override
  String? get previous;
  @override
  List<SalesByProductDtoModel> get results;

  /// Create a copy of SalesByProductResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SalesByProductResponseImplCopyWith<_$SalesByProductResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

SalesByProductDtoModel _$SalesByProductDtoModelFromJson(
  Map<String, dynamic> json,
) {
  return _SalesByProductDtoModel.fromJson(json);
}

/// @nodoc
mixin _$SalesByProductDtoModel {
  @JsonKey(name: 'product_id')
  String get productId => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_name')
  String? get productName => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_sku')
  String? get productSku => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_name')
  String? get categoryName => throw _privateConstructorUsedError;
  @JsonKey(name: 'base_price')
  String? get basePrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'stock_qty')
  int? get stockQty => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_orders')
  int? get totalOrders => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_sales_amount')
  double? get totalSalesAmount => throw _privateConstructorUsedError;

  /// Serializes this SalesByProductDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SalesByProductDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SalesByProductDtoModelCopyWith<SalesByProductDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SalesByProductDtoModelCopyWith<$Res> {
  factory $SalesByProductDtoModelCopyWith(
    SalesByProductDtoModel value,
    $Res Function(SalesByProductDtoModel) then,
  ) = _$SalesByProductDtoModelCopyWithImpl<$Res, SalesByProductDtoModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'product_id') String productId,
    @JsonKey(name: 'product_name') String? productName,
    @JsonKey(name: 'product_sku') String? productSku,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'base_price') String? basePrice,
    @JsonKey(name: 'stock_qty') int? stockQty,
    @JsonKey(name: 'total_orders') int? totalOrders,
    @JsonKey(name: 'total_sales_amount') double? totalSalesAmount,
  });
}

/// @nodoc
class _$SalesByProductDtoModelCopyWithImpl<
  $Res,
  $Val extends SalesByProductDtoModel
>
    implements $SalesByProductDtoModelCopyWith<$Res> {
  _$SalesByProductDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SalesByProductDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? productName = freezed,
    Object? productSku = freezed,
    Object? categoryName = freezed,
    Object? basePrice = freezed,
    Object? stockQty = freezed,
    Object? totalOrders = freezed,
    Object? totalSalesAmount = freezed,
  }) {
    return _then(
      _value.copyWith(
            productId: null == productId
                ? _value.productId
                : productId // ignore: cast_nullable_to_non_nullable
                      as String,
            productName: freezed == productName
                ? _value.productName
                : productName // ignore: cast_nullable_to_non_nullable
                      as String?,
            productSku: freezed == productSku
                ? _value.productSku
                : productSku // ignore: cast_nullable_to_non_nullable
                      as String?,
            categoryName: freezed == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
                      as String?,
            basePrice: freezed == basePrice
                ? _value.basePrice
                : basePrice // ignore: cast_nullable_to_non_nullable
                      as String?,
            stockQty: freezed == stockQty
                ? _value.stockQty
                : stockQty // ignore: cast_nullable_to_non_nullable
                      as int?,
            totalOrders: freezed == totalOrders
                ? _value.totalOrders
                : totalOrders // ignore: cast_nullable_to_non_nullable
                      as int?,
            totalSalesAmount: freezed == totalSalesAmount
                ? _value.totalSalesAmount
                : totalSalesAmount // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SalesByProductDtoModelImplCopyWith<$Res>
    implements $SalesByProductDtoModelCopyWith<$Res> {
  factory _$$SalesByProductDtoModelImplCopyWith(
    _$SalesByProductDtoModelImpl value,
    $Res Function(_$SalesByProductDtoModelImpl) then,
  ) = __$$SalesByProductDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'product_id') String productId,
    @JsonKey(name: 'product_name') String? productName,
    @JsonKey(name: 'product_sku') String? productSku,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'base_price') String? basePrice,
    @JsonKey(name: 'stock_qty') int? stockQty,
    @JsonKey(name: 'total_orders') int? totalOrders,
    @JsonKey(name: 'total_sales_amount') double? totalSalesAmount,
  });
}

/// @nodoc
class __$$SalesByProductDtoModelImplCopyWithImpl<$Res>
    extends
        _$SalesByProductDtoModelCopyWithImpl<$Res, _$SalesByProductDtoModelImpl>
    implements _$$SalesByProductDtoModelImplCopyWith<$Res> {
  __$$SalesByProductDtoModelImplCopyWithImpl(
    _$SalesByProductDtoModelImpl _value,
    $Res Function(_$SalesByProductDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SalesByProductDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? productName = freezed,
    Object? productSku = freezed,
    Object? categoryName = freezed,
    Object? basePrice = freezed,
    Object? stockQty = freezed,
    Object? totalOrders = freezed,
    Object? totalSalesAmount = freezed,
  }) {
    return _then(
      _$SalesByProductDtoModelImpl(
        productId: null == productId
            ? _value.productId
            : productId // ignore: cast_nullable_to_non_nullable
                  as String,
        productName: freezed == productName
            ? _value.productName
            : productName // ignore: cast_nullable_to_non_nullable
                  as String?,
        productSku: freezed == productSku
            ? _value.productSku
            : productSku // ignore: cast_nullable_to_non_nullable
                  as String?,
        categoryName: freezed == categoryName
            ? _value.categoryName
            : categoryName // ignore: cast_nullable_to_non_nullable
                  as String?,
        basePrice: freezed == basePrice
            ? _value.basePrice
            : basePrice // ignore: cast_nullable_to_non_nullable
                  as String?,
        stockQty: freezed == stockQty
            ? _value.stockQty
            : stockQty // ignore: cast_nullable_to_non_nullable
                  as int?,
        totalOrders: freezed == totalOrders
            ? _value.totalOrders
            : totalOrders // ignore: cast_nullable_to_non_nullable
                  as int?,
        totalSalesAmount: freezed == totalSalesAmount
            ? _value.totalSalesAmount
            : totalSalesAmount // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SalesByProductDtoModelImpl implements _SalesByProductDtoModel {
  const _$SalesByProductDtoModelImpl({
    @JsonKey(name: 'product_id') required this.productId,
    @JsonKey(name: 'product_name') this.productName,
    @JsonKey(name: 'product_sku') this.productSku,
    @JsonKey(name: 'category_name') this.categoryName,
    @JsonKey(name: 'base_price') this.basePrice,
    @JsonKey(name: 'stock_qty') this.stockQty,
    @JsonKey(name: 'total_orders') this.totalOrders,
    @JsonKey(name: 'total_sales_amount') this.totalSalesAmount,
  });

  factory _$SalesByProductDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SalesByProductDtoModelImplFromJson(json);

  @override
  @JsonKey(name: 'product_id')
  final String productId;
  @override
  @JsonKey(name: 'product_name')
  final String? productName;
  @override
  @JsonKey(name: 'product_sku')
  final String? productSku;
  @override
  @JsonKey(name: 'category_name')
  final String? categoryName;
  @override
  @JsonKey(name: 'base_price')
  final String? basePrice;
  @override
  @JsonKey(name: 'stock_qty')
  final int? stockQty;
  @override
  @JsonKey(name: 'total_orders')
  final int? totalOrders;
  @override
  @JsonKey(name: 'total_sales_amount')
  final double? totalSalesAmount;

  @override
  String toString() {
    return 'SalesByProductDtoModel(productId: $productId, productName: $productName, productSku: $productSku, categoryName: $categoryName, basePrice: $basePrice, stockQty: $stockQty, totalOrders: $totalOrders, totalSalesAmount: $totalSalesAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SalesByProductDtoModelImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.productSku, productSku) ||
                other.productSku == productSku) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.basePrice, basePrice) ||
                other.basePrice == basePrice) &&
            (identical(other.stockQty, stockQty) ||
                other.stockQty == stockQty) &&
            (identical(other.totalOrders, totalOrders) ||
                other.totalOrders == totalOrders) &&
            (identical(other.totalSalesAmount, totalSalesAmount) ||
                other.totalSalesAmount == totalSalesAmount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    productId,
    productName,
    productSku,
    categoryName,
    basePrice,
    stockQty,
    totalOrders,
    totalSalesAmount,
  );

  /// Create a copy of SalesByProductDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SalesByProductDtoModelImplCopyWith<_$SalesByProductDtoModelImpl>
  get copyWith =>
      __$$SalesByProductDtoModelImplCopyWithImpl<_$SalesByProductDtoModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SalesByProductDtoModelImplToJson(this);
  }
}

abstract class _SalesByProductDtoModel implements SalesByProductDtoModel {
  const factory _SalesByProductDtoModel({
    @JsonKey(name: 'product_id') required final String productId,
    @JsonKey(name: 'product_name') final String? productName,
    @JsonKey(name: 'product_sku') final String? productSku,
    @JsonKey(name: 'category_name') final String? categoryName,
    @JsonKey(name: 'base_price') final String? basePrice,
    @JsonKey(name: 'stock_qty') final int? stockQty,
    @JsonKey(name: 'total_orders') final int? totalOrders,
    @JsonKey(name: 'total_sales_amount') final double? totalSalesAmount,
  }) = _$SalesByProductDtoModelImpl;

  factory _SalesByProductDtoModel.fromJson(Map<String, dynamic> json) =
      _$SalesByProductDtoModelImpl.fromJson;

  @override
  @JsonKey(name: 'product_id')
  String get productId;
  @override
  @JsonKey(name: 'product_name')
  String? get productName;
  @override
  @JsonKey(name: 'product_sku')
  String? get productSku;
  @override
  @JsonKey(name: 'category_name')
  String? get categoryName;
  @override
  @JsonKey(name: 'base_price')
  String? get basePrice;
  @override
  @JsonKey(name: 'stock_qty')
  int? get stockQty;
  @override
  @JsonKey(name: 'total_orders')
  int? get totalOrders;
  @override
  @JsonKey(name: 'total_sales_amount')
  double? get totalSalesAmount;

  /// Create a copy of SalesByProductDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SalesByProductDtoModelImplCopyWith<_$SalesByProductDtoModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
