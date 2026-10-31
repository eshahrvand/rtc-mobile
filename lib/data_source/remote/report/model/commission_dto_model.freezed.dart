// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'commission_dto_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CommissionReportResponse _$CommissionReportResponseFromJson(
  Map<String, dynamic> json,
) {
  return _CommissionReportResponse.fromJson(json);
}

/// @nodoc
mixin _$CommissionReportResponse {
  int get count => throw _privateConstructorUsedError;
  String? get next => throw _privateConstructorUsedError;
  String? get previous => throw _privateConstructorUsedError;
  List<CommissionEntryDtoModel> get results =>
      throw _privateConstructorUsedError;

  /// Serializes this CommissionReportResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommissionReportResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommissionReportResponseCopyWith<CommissionReportResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommissionReportResponseCopyWith<$Res> {
  factory $CommissionReportResponseCopyWith(
    CommissionReportResponse value,
    $Res Function(CommissionReportResponse) then,
  ) = _$CommissionReportResponseCopyWithImpl<$Res, CommissionReportResponse>;
  @useResult
  $Res call({
    int count,
    String? next,
    String? previous,
    List<CommissionEntryDtoModel> results,
  });
}

/// @nodoc
class _$CommissionReportResponseCopyWithImpl<
  $Res,
  $Val extends CommissionReportResponse
>
    implements $CommissionReportResponseCopyWith<$Res> {
  _$CommissionReportResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommissionReportResponse
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
                      as List<CommissionEntryDtoModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CommissionReportResponseImplCopyWith<$Res>
    implements $CommissionReportResponseCopyWith<$Res> {
  factory _$$CommissionReportResponseImplCopyWith(
    _$CommissionReportResponseImpl value,
    $Res Function(_$CommissionReportResponseImpl) then,
  ) = __$$CommissionReportResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int count,
    String? next,
    String? previous,
    List<CommissionEntryDtoModel> results,
  });
}

/// @nodoc
class __$$CommissionReportResponseImplCopyWithImpl<$Res>
    extends
        _$CommissionReportResponseCopyWithImpl<
          $Res,
          _$CommissionReportResponseImpl
        >
    implements _$$CommissionReportResponseImplCopyWith<$Res> {
  __$$CommissionReportResponseImplCopyWithImpl(
    _$CommissionReportResponseImpl _value,
    $Res Function(_$CommissionReportResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommissionReportResponse
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
      _$CommissionReportResponseImpl(
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
                  as List<CommissionEntryDtoModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CommissionReportResponseImpl implements _CommissionReportResponse {
  const _$CommissionReportResponseImpl({
    required this.count,
    this.next,
    this.previous,
    required final List<CommissionEntryDtoModel> results,
  }) : _results = results;

  factory _$CommissionReportResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommissionReportResponseImplFromJson(json);

  @override
  final int count;
  @override
  final String? next;
  @override
  final String? previous;
  final List<CommissionEntryDtoModel> _results;
  @override
  List<CommissionEntryDtoModel> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  String toString() {
    return 'CommissionReportResponse(count: $count, next: $next, previous: $previous, results: $results)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommissionReportResponseImpl &&
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

  /// Create a copy of CommissionReportResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommissionReportResponseImplCopyWith<_$CommissionReportResponseImpl>
  get copyWith =>
      __$$CommissionReportResponseImplCopyWithImpl<
        _$CommissionReportResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommissionReportResponseImplToJson(this);
  }
}

abstract class _CommissionReportResponse implements CommissionReportResponse {
  const factory _CommissionReportResponse({
    required final int count,
    final String? next,
    final String? previous,
    required final List<CommissionEntryDtoModel> results,
  }) = _$CommissionReportResponseImpl;

  factory _CommissionReportResponse.fromJson(Map<String, dynamic> json) =
      _$CommissionReportResponseImpl.fromJson;

  @override
  int get count;
  @override
  String? get next;
  @override
  String? get previous;
  @override
  List<CommissionEntryDtoModel> get results;

  /// Create a copy of CommissionReportResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommissionReportResponseImplCopyWith<_$CommissionReportResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

CommissionEntryDtoModel _$CommissionEntryDtoModelFromJson(
  Map<String, dynamic> json,
) {
  return _CommissionEntryDtoModel.fromJson(json);
}

/// @nodoc
mixin _$CommissionEntryDtoModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_total')
  double get orderTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'approved_at')
  String? get approvedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'disbursed_at')
  String? get disbursedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_first_name')
  String? get customerFirstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_last_name')
  String? get customerLastName => throw _privateConstructorUsedError;
  @JsonKey(name: 'plan_name')
  String? get planName => throw _privateConstructorUsedError;
  @JsonKey(name: 'sub_plan_duration')
  int? get subPlanDuration => throw _privateConstructorUsedError;

  /// Serializes this CommissionEntryDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommissionEntryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommissionEntryDtoModelCopyWith<CommissionEntryDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommissionEntryDtoModelCopyWith<$Res> {
  factory $CommissionEntryDtoModelCopyWith(
    CommissionEntryDtoModel value,
    $Res Function(CommissionEntryDtoModel) then,
  ) = _$CommissionEntryDtoModelCopyWithImpl<$Res, CommissionEntryDtoModel>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'order_total') double orderTotal,
    @JsonKey(name: 'approved_at') String? approvedAt,
    @JsonKey(name: 'disbursed_at') String? disbursedAt,
    @JsonKey(name: 'customer_first_name') String? customerFirstName,
    @JsonKey(name: 'customer_last_name') String? customerLastName,
    @JsonKey(name: 'plan_name') String? planName,
    @JsonKey(name: 'sub_plan_duration') int? subPlanDuration,
  });
}

/// @nodoc
class _$CommissionEntryDtoModelCopyWithImpl<
  $Res,
  $Val extends CommissionEntryDtoModel
>
    implements $CommissionEntryDtoModelCopyWith<$Res> {
  _$CommissionEntryDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommissionEntryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderTotal = null,
    Object? approvedAt = freezed,
    Object? disbursedAt = freezed,
    Object? customerFirstName = freezed,
    Object? customerLastName = freezed,
    Object? planName = freezed,
    Object? subPlanDuration = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            orderTotal: null == orderTotal
                ? _value.orderTotal
                : orderTotal // ignore: cast_nullable_to_non_nullable
                      as double,
            approvedAt: freezed == approvedAt
                ? _value.approvedAt
                : approvedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            disbursedAt: freezed == disbursedAt
                ? _value.disbursedAt
                : disbursedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            customerFirstName: freezed == customerFirstName
                ? _value.customerFirstName
                : customerFirstName // ignore: cast_nullable_to_non_nullable
                      as String?,
            customerLastName: freezed == customerLastName
                ? _value.customerLastName
                : customerLastName // ignore: cast_nullable_to_non_nullable
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
abstract class _$$CommissionEntryDtoModelImplCopyWith<$Res>
    implements $CommissionEntryDtoModelCopyWith<$Res> {
  factory _$$CommissionEntryDtoModelImplCopyWith(
    _$CommissionEntryDtoModelImpl value,
    $Res Function(_$CommissionEntryDtoModelImpl) then,
  ) = __$$CommissionEntryDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'order_total') double orderTotal,
    @JsonKey(name: 'approved_at') String? approvedAt,
    @JsonKey(name: 'disbursed_at') String? disbursedAt,
    @JsonKey(name: 'customer_first_name') String? customerFirstName,
    @JsonKey(name: 'customer_last_name') String? customerLastName,
    @JsonKey(name: 'plan_name') String? planName,
    @JsonKey(name: 'sub_plan_duration') int? subPlanDuration,
  });
}

/// @nodoc
class __$$CommissionEntryDtoModelImplCopyWithImpl<$Res>
    extends
        _$CommissionEntryDtoModelCopyWithImpl<
          $Res,
          _$CommissionEntryDtoModelImpl
        >
    implements _$$CommissionEntryDtoModelImplCopyWith<$Res> {
  __$$CommissionEntryDtoModelImplCopyWithImpl(
    _$CommissionEntryDtoModelImpl _value,
    $Res Function(_$CommissionEntryDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommissionEntryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderTotal = null,
    Object? approvedAt = freezed,
    Object? disbursedAt = freezed,
    Object? customerFirstName = freezed,
    Object? customerLastName = freezed,
    Object? planName = freezed,
    Object? subPlanDuration = freezed,
  }) {
    return _then(
      _$CommissionEntryDtoModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        orderTotal: null == orderTotal
            ? _value.orderTotal
            : orderTotal // ignore: cast_nullable_to_non_nullable
                  as double,
        approvedAt: freezed == approvedAt
            ? _value.approvedAt
            : approvedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        disbursedAt: freezed == disbursedAt
            ? _value.disbursedAt
            : disbursedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        customerFirstName: freezed == customerFirstName
            ? _value.customerFirstName
            : customerFirstName // ignore: cast_nullable_to_non_nullable
                  as String?,
        customerLastName: freezed == customerLastName
            ? _value.customerLastName
            : customerLastName // ignore: cast_nullable_to_non_nullable
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
class _$CommissionEntryDtoModelImpl implements _CommissionEntryDtoModel {
  const _$CommissionEntryDtoModelImpl({
    required this.id,
    @JsonKey(name: 'order_total') required this.orderTotal,
    @JsonKey(name: 'approved_at') this.approvedAt,
    @JsonKey(name: 'disbursed_at') this.disbursedAt,
    @JsonKey(name: 'customer_first_name') this.customerFirstName,
    @JsonKey(name: 'customer_last_name') this.customerLastName,
    @JsonKey(name: 'plan_name') this.planName,
    @JsonKey(name: 'sub_plan_duration') this.subPlanDuration,
  });

  factory _$CommissionEntryDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommissionEntryDtoModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'order_total')
  final double orderTotal;
  @override
  @JsonKey(name: 'approved_at')
  final String? approvedAt;
  @override
  @JsonKey(name: 'disbursed_at')
  final String? disbursedAt;
  @override
  @JsonKey(name: 'customer_first_name')
  final String? customerFirstName;
  @override
  @JsonKey(name: 'customer_last_name')
  final String? customerLastName;
  @override
  @JsonKey(name: 'plan_name')
  final String? planName;
  @override
  @JsonKey(name: 'sub_plan_duration')
  final int? subPlanDuration;

  @override
  String toString() {
    return 'CommissionEntryDtoModel(id: $id, orderTotal: $orderTotal, approvedAt: $approvedAt, disbursedAt: $disbursedAt, customerFirstName: $customerFirstName, customerLastName: $customerLastName, planName: $planName, subPlanDuration: $subPlanDuration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommissionEntryDtoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.orderTotal, orderTotal) ||
                other.orderTotal == orderTotal) &&
            (identical(other.approvedAt, approvedAt) ||
                other.approvedAt == approvedAt) &&
            (identical(other.disbursedAt, disbursedAt) ||
                other.disbursedAt == disbursedAt) &&
            (identical(other.customerFirstName, customerFirstName) ||
                other.customerFirstName == customerFirstName) &&
            (identical(other.customerLastName, customerLastName) ||
                other.customerLastName == customerLastName) &&
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
    orderTotal,
    approvedAt,
    disbursedAt,
    customerFirstName,
    customerLastName,
    planName,
    subPlanDuration,
  );

  /// Create a copy of CommissionEntryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommissionEntryDtoModelImplCopyWith<_$CommissionEntryDtoModelImpl>
  get copyWith =>
      __$$CommissionEntryDtoModelImplCopyWithImpl<
        _$CommissionEntryDtoModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommissionEntryDtoModelImplToJson(this);
  }
}

abstract class _CommissionEntryDtoModel implements CommissionEntryDtoModel {
  const factory _CommissionEntryDtoModel({
    required final String id,
    @JsonKey(name: 'order_total') required final double orderTotal,
    @JsonKey(name: 'approved_at') final String? approvedAt,
    @JsonKey(name: 'disbursed_at') final String? disbursedAt,
    @JsonKey(name: 'customer_first_name') final String? customerFirstName,
    @JsonKey(name: 'customer_last_name') final String? customerLastName,
    @JsonKey(name: 'plan_name') final String? planName,
    @JsonKey(name: 'sub_plan_duration') final int? subPlanDuration,
  }) = _$CommissionEntryDtoModelImpl;

  factory _CommissionEntryDtoModel.fromJson(Map<String, dynamic> json) =
      _$CommissionEntryDtoModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'order_total')
  double get orderTotal;
  @override
  @JsonKey(name: 'approved_at')
  String? get approvedAt;
  @override
  @JsonKey(name: 'disbursed_at')
  String? get disbursedAt;
  @override
  @JsonKey(name: 'customer_first_name')
  String? get customerFirstName;
  @override
  @JsonKey(name: 'customer_last_name')
  String? get customerLastName;
  @override
  @JsonKey(name: 'plan_name')
  String? get planName;
  @override
  @JsonKey(name: 'sub_plan_duration')
  int? get subPlanDuration;

  /// Create a copy of CommissionEntryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommissionEntryDtoModelImplCopyWith<_$CommissionEntryDtoModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

CommissionSummaryDtoModel _$CommissionSummaryDtoModelFromJson(
  Map<String, dynamic> json,
) {
  return _CommissionSummaryDtoModel.fromJson(json);
}

/// @nodoc
mixin _$CommissionSummaryDtoModel {
  int get year => throw _privateConstructorUsedError;
  int get month => throw _privateConstructorUsedError;
  @JsonKey(name: 'monthly_sales_total')
  double get monthlySalesTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'commission_rate_cash')
  double get commissionRateCash => throw _privateConstructorUsedError;
  @JsonKey(name: 'commission_rate_product')
  double get commissionRateProduct => throw _privateConstructorUsedError;
  @JsonKey(name: 'commission_amount_cash')
  double get commissionAmountCash => throw _privateConstructorUsedError;
  @JsonKey(name: 'commission_amount_product')
  double get commissionAmountProduct => throw _privateConstructorUsedError;
  @JsonKey(name: 'next_tier_rate_cash')
  double get nextTierRateCash => throw _privateConstructorUsedError;
  @JsonKey(name: 'next_tier_rate_product')
  double get nextTierRateProduct => throw _privateConstructorUsedError;
  @JsonKey(name: 'distance_to_next_tier')
  double get distanceToNextTier => throw _privateConstructorUsedError;

  /// Serializes this CommissionSummaryDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommissionSummaryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommissionSummaryDtoModelCopyWith<CommissionSummaryDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommissionSummaryDtoModelCopyWith<$Res> {
  factory $CommissionSummaryDtoModelCopyWith(
    CommissionSummaryDtoModel value,
    $Res Function(CommissionSummaryDtoModel) then,
  ) = _$CommissionSummaryDtoModelCopyWithImpl<$Res, CommissionSummaryDtoModel>;
  @useResult
  $Res call({
    int year,
    int month,
    @JsonKey(name: 'monthly_sales_total') double monthlySalesTotal,
    @JsonKey(name: 'commission_rate_cash') double commissionRateCash,
    @JsonKey(name: 'commission_rate_product') double commissionRateProduct,
    @JsonKey(name: 'commission_amount_cash') double commissionAmountCash,
    @JsonKey(name: 'commission_amount_product') double commissionAmountProduct,
    @JsonKey(name: 'next_tier_rate_cash') double nextTierRateCash,
    @JsonKey(name: 'next_tier_rate_product') double nextTierRateProduct,
    @JsonKey(name: 'distance_to_next_tier') double distanceToNextTier,
  });
}

/// @nodoc
class _$CommissionSummaryDtoModelCopyWithImpl<
  $Res,
  $Val extends CommissionSummaryDtoModel
>
    implements $CommissionSummaryDtoModelCopyWith<$Res> {
  _$CommissionSummaryDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommissionSummaryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? month = null,
    Object? monthlySalesTotal = null,
    Object? commissionRateCash = null,
    Object? commissionRateProduct = null,
    Object? commissionAmountCash = null,
    Object? commissionAmountProduct = null,
    Object? nextTierRateCash = null,
    Object? nextTierRateProduct = null,
    Object? distanceToNextTier = null,
  }) {
    return _then(
      _value.copyWith(
            year: null == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as int,
            month: null == month
                ? _value.month
                : month // ignore: cast_nullable_to_non_nullable
                      as int,
            monthlySalesTotal: null == monthlySalesTotal
                ? _value.monthlySalesTotal
                : monthlySalesTotal // ignore: cast_nullable_to_non_nullable
                      as double,
            commissionRateCash: null == commissionRateCash
                ? _value.commissionRateCash
                : commissionRateCash // ignore: cast_nullable_to_non_nullable
                      as double,
            commissionRateProduct: null == commissionRateProduct
                ? _value.commissionRateProduct
                : commissionRateProduct // ignore: cast_nullable_to_non_nullable
                      as double,
            commissionAmountCash: null == commissionAmountCash
                ? _value.commissionAmountCash
                : commissionAmountCash // ignore: cast_nullable_to_non_nullable
                      as double,
            commissionAmountProduct: null == commissionAmountProduct
                ? _value.commissionAmountProduct
                : commissionAmountProduct // ignore: cast_nullable_to_non_nullable
                      as double,
            nextTierRateCash: null == nextTierRateCash
                ? _value.nextTierRateCash
                : nextTierRateCash // ignore: cast_nullable_to_non_nullable
                      as double,
            nextTierRateProduct: null == nextTierRateProduct
                ? _value.nextTierRateProduct
                : nextTierRateProduct // ignore: cast_nullable_to_non_nullable
                      as double,
            distanceToNextTier: null == distanceToNextTier
                ? _value.distanceToNextTier
                : distanceToNextTier // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CommissionSummaryDtoModelImplCopyWith<$Res>
    implements $CommissionSummaryDtoModelCopyWith<$Res> {
  factory _$$CommissionSummaryDtoModelImplCopyWith(
    _$CommissionSummaryDtoModelImpl value,
    $Res Function(_$CommissionSummaryDtoModelImpl) then,
  ) = __$$CommissionSummaryDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int year,
    int month,
    @JsonKey(name: 'monthly_sales_total') double monthlySalesTotal,
    @JsonKey(name: 'commission_rate_cash') double commissionRateCash,
    @JsonKey(name: 'commission_rate_product') double commissionRateProduct,
    @JsonKey(name: 'commission_amount_cash') double commissionAmountCash,
    @JsonKey(name: 'commission_amount_product') double commissionAmountProduct,
    @JsonKey(name: 'next_tier_rate_cash') double nextTierRateCash,
    @JsonKey(name: 'next_tier_rate_product') double nextTierRateProduct,
    @JsonKey(name: 'distance_to_next_tier') double distanceToNextTier,
  });
}

/// @nodoc
class __$$CommissionSummaryDtoModelImplCopyWithImpl<$Res>
    extends
        _$CommissionSummaryDtoModelCopyWithImpl<
          $Res,
          _$CommissionSummaryDtoModelImpl
        >
    implements _$$CommissionSummaryDtoModelImplCopyWith<$Res> {
  __$$CommissionSummaryDtoModelImplCopyWithImpl(
    _$CommissionSummaryDtoModelImpl _value,
    $Res Function(_$CommissionSummaryDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommissionSummaryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? month = null,
    Object? monthlySalesTotal = null,
    Object? commissionRateCash = null,
    Object? commissionRateProduct = null,
    Object? commissionAmountCash = null,
    Object? commissionAmountProduct = null,
    Object? nextTierRateCash = null,
    Object? nextTierRateProduct = null,
    Object? distanceToNextTier = null,
  }) {
    return _then(
      _$CommissionSummaryDtoModelImpl(
        year: null == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int,
        month: null == month
            ? _value.month
            : month // ignore: cast_nullable_to_non_nullable
                  as int,
        monthlySalesTotal: null == monthlySalesTotal
            ? _value.monthlySalesTotal
            : monthlySalesTotal // ignore: cast_nullable_to_non_nullable
                  as double,
        commissionRateCash: null == commissionRateCash
            ? _value.commissionRateCash
            : commissionRateCash // ignore: cast_nullable_to_non_nullable
                  as double,
        commissionRateProduct: null == commissionRateProduct
            ? _value.commissionRateProduct
            : commissionRateProduct // ignore: cast_nullable_to_non_nullable
                  as double,
        commissionAmountCash: null == commissionAmountCash
            ? _value.commissionAmountCash
            : commissionAmountCash // ignore: cast_nullable_to_non_nullable
                  as double,
        commissionAmountProduct: null == commissionAmountProduct
            ? _value.commissionAmountProduct
            : commissionAmountProduct // ignore: cast_nullable_to_non_nullable
                  as double,
        nextTierRateCash: null == nextTierRateCash
            ? _value.nextTierRateCash
            : nextTierRateCash // ignore: cast_nullable_to_non_nullable
                  as double,
        nextTierRateProduct: null == nextTierRateProduct
            ? _value.nextTierRateProduct
            : nextTierRateProduct // ignore: cast_nullable_to_non_nullable
                  as double,
        distanceToNextTier: null == distanceToNextTier
            ? _value.distanceToNextTier
            : distanceToNextTier // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CommissionSummaryDtoModelImpl implements _CommissionSummaryDtoModel {
  const _$CommissionSummaryDtoModelImpl({
    required this.year,
    required this.month,
    @JsonKey(name: 'monthly_sales_total') required this.monthlySalesTotal,
    @JsonKey(name: 'commission_rate_cash') required this.commissionRateCash,
    @JsonKey(name: 'commission_rate_product')
    required this.commissionRateProduct,
    @JsonKey(name: 'commission_amount_cash') required this.commissionAmountCash,
    @JsonKey(name: 'commission_amount_product')
    required this.commissionAmountProduct,
    @JsonKey(name: 'next_tier_rate_cash') required this.nextTierRateCash,
    @JsonKey(name: 'next_tier_rate_product') required this.nextTierRateProduct,
    @JsonKey(name: 'distance_to_next_tier') required this.distanceToNextTier,
  });

  factory _$CommissionSummaryDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommissionSummaryDtoModelImplFromJson(json);

  @override
  final int year;
  @override
  final int month;
  @override
  @JsonKey(name: 'monthly_sales_total')
  final double monthlySalesTotal;
  @override
  @JsonKey(name: 'commission_rate_cash')
  final double commissionRateCash;
  @override
  @JsonKey(name: 'commission_rate_product')
  final double commissionRateProduct;
  @override
  @JsonKey(name: 'commission_amount_cash')
  final double commissionAmountCash;
  @override
  @JsonKey(name: 'commission_amount_product')
  final double commissionAmountProduct;
  @override
  @JsonKey(name: 'next_tier_rate_cash')
  final double nextTierRateCash;
  @override
  @JsonKey(name: 'next_tier_rate_product')
  final double nextTierRateProduct;
  @override
  @JsonKey(name: 'distance_to_next_tier')
  final double distanceToNextTier;

  @override
  String toString() {
    return 'CommissionSummaryDtoModel(year: $year, month: $month, monthlySalesTotal: $monthlySalesTotal, commissionRateCash: $commissionRateCash, commissionRateProduct: $commissionRateProduct, commissionAmountCash: $commissionAmountCash, commissionAmountProduct: $commissionAmountProduct, nextTierRateCash: $nextTierRateCash, nextTierRateProduct: $nextTierRateProduct, distanceToNextTier: $distanceToNextTier)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommissionSummaryDtoModelImpl &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.monthlySalesTotal, monthlySalesTotal) ||
                other.monthlySalesTotal == monthlySalesTotal) &&
            (identical(other.commissionRateCash, commissionRateCash) ||
                other.commissionRateCash == commissionRateCash) &&
            (identical(other.commissionRateProduct, commissionRateProduct) ||
                other.commissionRateProduct == commissionRateProduct) &&
            (identical(other.commissionAmountCash, commissionAmountCash) ||
                other.commissionAmountCash == commissionAmountCash) &&
            (identical(
                  other.commissionAmountProduct,
                  commissionAmountProduct,
                ) ||
                other.commissionAmountProduct == commissionAmountProduct) &&
            (identical(other.nextTierRateCash, nextTierRateCash) ||
                other.nextTierRateCash == nextTierRateCash) &&
            (identical(other.nextTierRateProduct, nextTierRateProduct) ||
                other.nextTierRateProduct == nextTierRateProduct) &&
            (identical(other.distanceToNextTier, distanceToNextTier) ||
                other.distanceToNextTier == distanceToNextTier));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    year,
    month,
    monthlySalesTotal,
    commissionRateCash,
    commissionRateProduct,
    commissionAmountCash,
    commissionAmountProduct,
    nextTierRateCash,
    nextTierRateProduct,
    distanceToNextTier,
  );

  /// Create a copy of CommissionSummaryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommissionSummaryDtoModelImplCopyWith<_$CommissionSummaryDtoModelImpl>
  get copyWith =>
      __$$CommissionSummaryDtoModelImplCopyWithImpl<
        _$CommissionSummaryDtoModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommissionSummaryDtoModelImplToJson(this);
  }
}

abstract class _CommissionSummaryDtoModel implements CommissionSummaryDtoModel {
  const factory _CommissionSummaryDtoModel({
    required final int year,
    required final int month,
    @JsonKey(name: 'monthly_sales_total')
    required final double monthlySalesTotal,
    @JsonKey(name: 'commission_rate_cash')
    required final double commissionRateCash,
    @JsonKey(name: 'commission_rate_product')
    required final double commissionRateProduct,
    @JsonKey(name: 'commission_amount_cash')
    required final double commissionAmountCash,
    @JsonKey(name: 'commission_amount_product')
    required final double commissionAmountProduct,
    @JsonKey(name: 'next_tier_rate_cash')
    required final double nextTierRateCash,
    @JsonKey(name: 'next_tier_rate_product')
    required final double nextTierRateProduct,
    @JsonKey(name: 'distance_to_next_tier')
    required final double distanceToNextTier,
  }) = _$CommissionSummaryDtoModelImpl;

  factory _CommissionSummaryDtoModel.fromJson(Map<String, dynamic> json) =
      _$CommissionSummaryDtoModelImpl.fromJson;

  @override
  int get year;
  @override
  int get month;
  @override
  @JsonKey(name: 'monthly_sales_total')
  double get monthlySalesTotal;
  @override
  @JsonKey(name: 'commission_rate_cash')
  double get commissionRateCash;
  @override
  @JsonKey(name: 'commission_rate_product')
  double get commissionRateProduct;
  @override
  @JsonKey(name: 'commission_amount_cash')
  double get commissionAmountCash;
  @override
  @JsonKey(name: 'commission_amount_product')
  double get commissionAmountProduct;
  @override
  @JsonKey(name: 'next_tier_rate_cash')
  double get nextTierRateCash;
  @override
  @JsonKey(name: 'next_tier_rate_product')
  double get nextTierRateProduct;
  @override
  @JsonKey(name: 'distance_to_next_tier')
  double get distanceToNextTier;

  /// Create a copy of CommissionSummaryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommissionSummaryDtoModelImplCopyWith<_$CommissionSummaryDtoModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
