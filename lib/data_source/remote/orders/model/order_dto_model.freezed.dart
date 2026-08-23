// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_dto_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OrderListResponse _$OrderListResponseFromJson(Map<String, dynamic> json) {
  return _OrderListResponse.fromJson(json);
}

/// @nodoc
mixin _$OrderListResponse {
  int get count => throw _privateConstructorUsedError;
  String? get next => throw _privateConstructorUsedError;
  String? get previous => throw _privateConstructorUsedError;
  List<OrderDtoModel> get results => throw _privateConstructorUsedError;

  /// Serializes this OrderListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderListResponseCopyWith<OrderListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderListResponseCopyWith<$Res> {
  factory $OrderListResponseCopyWith(
    OrderListResponse value,
    $Res Function(OrderListResponse) then,
  ) = _$OrderListResponseCopyWithImpl<$Res, OrderListResponse>;
  @useResult
  $Res call({
    int count,
    String? next,
    String? previous,
    List<OrderDtoModel> results,
  });
}

/// @nodoc
class _$OrderListResponseCopyWithImpl<$Res, $Val extends OrderListResponse>
    implements $OrderListResponseCopyWith<$Res> {
  _$OrderListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderListResponse
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
                      as List<OrderDtoModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderListResponseImplCopyWith<$Res>
    implements $OrderListResponseCopyWith<$Res> {
  factory _$$OrderListResponseImplCopyWith(
    _$OrderListResponseImpl value,
    $Res Function(_$OrderListResponseImpl) then,
  ) = __$$OrderListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int count,
    String? next,
    String? previous,
    List<OrderDtoModel> results,
  });
}

/// @nodoc
class __$$OrderListResponseImplCopyWithImpl<$Res>
    extends _$OrderListResponseCopyWithImpl<$Res, _$OrderListResponseImpl>
    implements _$$OrderListResponseImplCopyWith<$Res> {
  __$$OrderListResponseImplCopyWithImpl(
    _$OrderListResponseImpl _value,
    $Res Function(_$OrderListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderListResponse
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
      _$OrderListResponseImpl(
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
                  as List<OrderDtoModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderListResponseImpl implements _OrderListResponse {
  const _$OrderListResponseImpl({
    required this.count,
    this.next,
    this.previous,
    required final List<OrderDtoModel> results,
  }) : _results = results;

  factory _$OrderListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderListResponseImplFromJson(json);

  @override
  final int count;
  @override
  final String? next;
  @override
  final String? previous;
  final List<OrderDtoModel> _results;
  @override
  List<OrderDtoModel> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  String toString() {
    return 'OrderListResponse(count: $count, next: $next, previous: $previous, results: $results)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderListResponseImpl &&
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

  /// Create a copy of OrderListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderListResponseImplCopyWith<_$OrderListResponseImpl> get copyWith =>
      __$$OrderListResponseImplCopyWithImpl<_$OrderListResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderListResponseImplToJson(this);
  }
}

abstract class _OrderListResponse implements OrderListResponse {
  const factory _OrderListResponse({
    required final int count,
    final String? next,
    final String? previous,
    required final List<OrderDtoModel> results,
  }) = _$OrderListResponseImpl;

  factory _OrderListResponse.fromJson(Map<String, dynamic> json) =
      _$OrderListResponseImpl.fromJson;

  @override
  int get count;
  @override
  String? get next;
  @override
  String? get previous;
  @override
  List<OrderDtoModel> get results;

  /// Create a copy of OrderListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderListResponseImplCopyWith<_$OrderListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderDtoModel _$OrderDtoModelFromJson(Map<String, dynamic> json) {
  return _OrderDtoModel.fromJson(json);
}

/// @nodoc
mixin _$OrderDtoModel {
  String get id => throw _privateConstructorUsedError;
  CustomerDtoModel get customer => throw _privateConstructorUsedError;
  @JsonKey(name: 'sub_plan')
  WalletSubPlanDtoModel get subPlan => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;
  List<OrderLineDtoModel>? get lines => throw _privateConstructorUsedError;
  List<OrderDocumentDetailDtoModel>? get documents =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'rejection_note')
  String? get rejectionNote => throw _privateConstructorUsedError;
  @JsonKey(name: 'settlement_tracking_code')
  String? get settlementTrackingCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'delivery_to_agent')
  bool? get deliveryToAgent => throw _privateConstructorUsedError;
  OrderAgentDtoModel? get agent => throw _privateConstructorUsedError;
  List<PaymentDtoModel>? get payments => throw _privateConstructorUsedError;
  @JsonKey(name: 'remaining_time')
  RemainingTimeDtoModel? get remainingTime =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'disbursement_records')
  List<DisbursementRecordDtoModel>? get disbursementRecords =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'settlement_records')
  List<SettlementRecordDtoModel>? get settlementRecords =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'assigned_sales_reviewer')
  String? get assignedSalesReviewer => throw _privateConstructorUsedError;
  @JsonKey(name: 'assigned_finance_reviewer')
  String? get assignedFinanceReviewer => throw _privateConstructorUsedError;

  /// Serializes this OrderDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderDtoModelCopyWith<OrderDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderDtoModelCopyWith<$Res> {
  factory $OrderDtoModelCopyWith(
    OrderDtoModel value,
    $Res Function(OrderDtoModel) then,
  ) = _$OrderDtoModelCopyWithImpl<$Res, OrderDtoModel>;
  @useResult
  $Res call({
    String id,
    CustomerDtoModel customer,
    @JsonKey(name: 'sub_plan') WalletSubPlanDtoModel subPlan,
    String status,
    double total,
    @JsonKey(name: 'created_at') String createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    List<OrderLineDtoModel>? lines,
    List<OrderDocumentDetailDtoModel>? documents,
    @JsonKey(name: 'rejection_note') String? rejectionNote,
    @JsonKey(name: 'settlement_tracking_code') String? settlementTrackingCode,
    @JsonKey(name: 'delivery_to_agent') bool? deliveryToAgent,
    OrderAgentDtoModel? agent,
    List<PaymentDtoModel>? payments,
    @JsonKey(name: 'remaining_time') RemainingTimeDtoModel? remainingTime,
    @JsonKey(name: 'disbursement_records')
    List<DisbursementRecordDtoModel>? disbursementRecords,
    @JsonKey(name: 'settlement_records')
    List<SettlementRecordDtoModel>? settlementRecords,
    @JsonKey(name: 'assigned_sales_reviewer') String? assignedSalesReviewer,
    @JsonKey(name: 'assigned_finance_reviewer') String? assignedFinanceReviewer,
  });

  $CustomerDtoModelCopyWith<$Res> get customer;
  $WalletSubPlanDtoModelCopyWith<$Res> get subPlan;
  $OrderAgentDtoModelCopyWith<$Res>? get agent;
  $RemainingTimeDtoModelCopyWith<$Res>? get remainingTime;
}

/// @nodoc
class _$OrderDtoModelCopyWithImpl<$Res, $Val extends OrderDtoModel>
    implements $OrderDtoModelCopyWith<$Res> {
  _$OrderDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? customer = null,
    Object? subPlan = null,
    Object? status = null,
    Object? total = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? lines = freezed,
    Object? documents = freezed,
    Object? rejectionNote = freezed,
    Object? settlementTrackingCode = freezed,
    Object? deliveryToAgent = freezed,
    Object? agent = freezed,
    Object? payments = freezed,
    Object? remainingTime = freezed,
    Object? disbursementRecords = freezed,
    Object? settlementRecords = freezed,
    Object? assignedSalesReviewer = freezed,
    Object? assignedFinanceReviewer = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            customer: null == customer
                ? _value.customer
                : customer // ignore: cast_nullable_to_non_nullable
                      as CustomerDtoModel,
            subPlan: null == subPlan
                ? _value.subPlan
                : subPlan // ignore: cast_nullable_to_non_nullable
                      as WalletSubPlanDtoModel,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as double,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            lines: freezed == lines
                ? _value.lines
                : lines // ignore: cast_nullable_to_non_nullable
                      as List<OrderLineDtoModel>?,
            documents: freezed == documents
                ? _value.documents
                : documents // ignore: cast_nullable_to_non_nullable
                      as List<OrderDocumentDetailDtoModel>?,
            rejectionNote: freezed == rejectionNote
                ? _value.rejectionNote
                : rejectionNote // ignore: cast_nullable_to_non_nullable
                      as String?,
            settlementTrackingCode: freezed == settlementTrackingCode
                ? _value.settlementTrackingCode
                : settlementTrackingCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            deliveryToAgent: freezed == deliveryToAgent
                ? _value.deliveryToAgent
                : deliveryToAgent // ignore: cast_nullable_to_non_nullable
                      as bool?,
            agent: freezed == agent
                ? _value.agent
                : agent // ignore: cast_nullable_to_non_nullable
                      as OrderAgentDtoModel?,
            payments: freezed == payments
                ? _value.payments
                : payments // ignore: cast_nullable_to_non_nullable
                      as List<PaymentDtoModel>?,
            remainingTime: freezed == remainingTime
                ? _value.remainingTime
                : remainingTime // ignore: cast_nullable_to_non_nullable
                      as RemainingTimeDtoModel?,
            disbursementRecords: freezed == disbursementRecords
                ? _value.disbursementRecords
                : disbursementRecords // ignore: cast_nullable_to_non_nullable
                      as List<DisbursementRecordDtoModel>?,
            settlementRecords: freezed == settlementRecords
                ? _value.settlementRecords
                : settlementRecords // ignore: cast_nullable_to_non_nullable
                      as List<SettlementRecordDtoModel>?,
            assignedSalesReviewer: freezed == assignedSalesReviewer
                ? _value.assignedSalesReviewer
                : assignedSalesReviewer // ignore: cast_nullable_to_non_nullable
                      as String?,
            assignedFinanceReviewer: freezed == assignedFinanceReviewer
                ? _value.assignedFinanceReviewer
                : assignedFinanceReviewer // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of OrderDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomerDtoModelCopyWith<$Res> get customer {
    return $CustomerDtoModelCopyWith<$Res>(_value.customer, (value) {
      return _then(_value.copyWith(customer: value) as $Val);
    });
  }

  /// Create a copy of OrderDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WalletSubPlanDtoModelCopyWith<$Res> get subPlan {
    return $WalletSubPlanDtoModelCopyWith<$Res>(_value.subPlan, (value) {
      return _then(_value.copyWith(subPlan: value) as $Val);
    });
  }

  /// Create a copy of OrderDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OrderAgentDtoModelCopyWith<$Res>? get agent {
    if (_value.agent == null) {
      return null;
    }

    return $OrderAgentDtoModelCopyWith<$Res>(_value.agent!, (value) {
      return _then(_value.copyWith(agent: value) as $Val);
    });
  }

  /// Create a copy of OrderDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RemainingTimeDtoModelCopyWith<$Res>? get remainingTime {
    if (_value.remainingTime == null) {
      return null;
    }

    return $RemainingTimeDtoModelCopyWith<$Res>(_value.remainingTime!, (value) {
      return _then(_value.copyWith(remainingTime: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrderDtoModelImplCopyWith<$Res>
    implements $OrderDtoModelCopyWith<$Res> {
  factory _$$OrderDtoModelImplCopyWith(
    _$OrderDtoModelImpl value,
    $Res Function(_$OrderDtoModelImpl) then,
  ) = __$$OrderDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    CustomerDtoModel customer,
    @JsonKey(name: 'sub_plan') WalletSubPlanDtoModel subPlan,
    String status,
    double total,
    @JsonKey(name: 'created_at') String createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    List<OrderLineDtoModel>? lines,
    List<OrderDocumentDetailDtoModel>? documents,
    @JsonKey(name: 'rejection_note') String? rejectionNote,
    @JsonKey(name: 'settlement_tracking_code') String? settlementTrackingCode,
    @JsonKey(name: 'delivery_to_agent') bool? deliveryToAgent,
    OrderAgentDtoModel? agent,
    List<PaymentDtoModel>? payments,
    @JsonKey(name: 'remaining_time') RemainingTimeDtoModel? remainingTime,
    @JsonKey(name: 'disbursement_records')
    List<DisbursementRecordDtoModel>? disbursementRecords,
    @JsonKey(name: 'settlement_records')
    List<SettlementRecordDtoModel>? settlementRecords,
    @JsonKey(name: 'assigned_sales_reviewer') String? assignedSalesReviewer,
    @JsonKey(name: 'assigned_finance_reviewer') String? assignedFinanceReviewer,
  });

  @override
  $CustomerDtoModelCopyWith<$Res> get customer;
  @override
  $WalletSubPlanDtoModelCopyWith<$Res> get subPlan;
  @override
  $OrderAgentDtoModelCopyWith<$Res>? get agent;
  @override
  $RemainingTimeDtoModelCopyWith<$Res>? get remainingTime;
}

/// @nodoc
class __$$OrderDtoModelImplCopyWithImpl<$Res>
    extends _$OrderDtoModelCopyWithImpl<$Res, _$OrderDtoModelImpl>
    implements _$$OrderDtoModelImplCopyWith<$Res> {
  __$$OrderDtoModelImplCopyWithImpl(
    _$OrderDtoModelImpl _value,
    $Res Function(_$OrderDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? customer = null,
    Object? subPlan = null,
    Object? status = null,
    Object? total = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? lines = freezed,
    Object? documents = freezed,
    Object? rejectionNote = freezed,
    Object? settlementTrackingCode = freezed,
    Object? deliveryToAgent = freezed,
    Object? agent = freezed,
    Object? payments = freezed,
    Object? remainingTime = freezed,
    Object? disbursementRecords = freezed,
    Object? settlementRecords = freezed,
    Object? assignedSalesReviewer = freezed,
    Object? assignedFinanceReviewer = freezed,
  }) {
    return _then(
      _$OrderDtoModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        customer: null == customer
            ? _value.customer
            : customer // ignore: cast_nullable_to_non_nullable
                  as CustomerDtoModel,
        subPlan: null == subPlan
            ? _value.subPlan
            : subPlan // ignore: cast_nullable_to_non_nullable
                  as WalletSubPlanDtoModel,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as double,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        lines: freezed == lines
            ? _value._lines
            : lines // ignore: cast_nullable_to_non_nullable
                  as List<OrderLineDtoModel>?,
        documents: freezed == documents
            ? _value._documents
            : documents // ignore: cast_nullable_to_non_nullable
                  as List<OrderDocumentDetailDtoModel>?,
        rejectionNote: freezed == rejectionNote
            ? _value.rejectionNote
            : rejectionNote // ignore: cast_nullable_to_non_nullable
                  as String?,
        settlementTrackingCode: freezed == settlementTrackingCode
            ? _value.settlementTrackingCode
            : settlementTrackingCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        deliveryToAgent: freezed == deliveryToAgent
            ? _value.deliveryToAgent
            : deliveryToAgent // ignore: cast_nullable_to_non_nullable
                  as bool?,
        agent: freezed == agent
            ? _value.agent
            : agent // ignore: cast_nullable_to_non_nullable
                  as OrderAgentDtoModel?,
        payments: freezed == payments
            ? _value._payments
            : payments // ignore: cast_nullable_to_non_nullable
                  as List<PaymentDtoModel>?,
        remainingTime: freezed == remainingTime
            ? _value.remainingTime
            : remainingTime // ignore: cast_nullable_to_non_nullable
                  as RemainingTimeDtoModel?,
        disbursementRecords: freezed == disbursementRecords
            ? _value._disbursementRecords
            : disbursementRecords // ignore: cast_nullable_to_non_nullable
                  as List<DisbursementRecordDtoModel>?,
        settlementRecords: freezed == settlementRecords
            ? _value._settlementRecords
            : settlementRecords // ignore: cast_nullable_to_non_nullable
                  as List<SettlementRecordDtoModel>?,
        assignedSalesReviewer: freezed == assignedSalesReviewer
            ? _value.assignedSalesReviewer
            : assignedSalesReviewer // ignore: cast_nullable_to_non_nullable
                  as String?,
        assignedFinanceReviewer: freezed == assignedFinanceReviewer
            ? _value.assignedFinanceReviewer
            : assignedFinanceReviewer // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderDtoModelImpl implements _OrderDtoModel {
  const _$OrderDtoModelImpl({
    required this.id,
    required this.customer,
    @JsonKey(name: 'sub_plan') required this.subPlan,
    required this.status,
    required this.total,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'updated_at') this.updatedAt,
    final List<OrderLineDtoModel>? lines,
    final List<OrderDocumentDetailDtoModel>? documents,
    @JsonKey(name: 'rejection_note') this.rejectionNote,
    @JsonKey(name: 'settlement_tracking_code') this.settlementTrackingCode,
    @JsonKey(name: 'delivery_to_agent') this.deliveryToAgent,
    this.agent,
    final List<PaymentDtoModel>? payments,
    @JsonKey(name: 'remaining_time') this.remainingTime,
    @JsonKey(name: 'disbursement_records')
    final List<DisbursementRecordDtoModel>? disbursementRecords,
    @JsonKey(name: 'settlement_records')
    final List<SettlementRecordDtoModel>? settlementRecords,
    @JsonKey(name: 'assigned_sales_reviewer') this.assignedSalesReviewer,
    @JsonKey(name: 'assigned_finance_reviewer') this.assignedFinanceReviewer,
  }) : _lines = lines,
       _documents = documents,
       _payments = payments,
       _disbursementRecords = disbursementRecords,
       _settlementRecords = settlementRecords;

  factory _$OrderDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderDtoModelImplFromJson(json);

  @override
  final String id;
  @override
  final CustomerDtoModel customer;
  @override
  @JsonKey(name: 'sub_plan')
  final WalletSubPlanDtoModel subPlan;
  @override
  final String status;
  @override
  final double total;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  final List<OrderLineDtoModel>? _lines;
  @override
  List<OrderLineDtoModel>? get lines {
    final value = _lines;
    if (value == null) return null;
    if (_lines is EqualUnmodifiableListView) return _lines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<OrderDocumentDetailDtoModel>? _documents;
  @override
  List<OrderDocumentDetailDtoModel>? get documents {
    final value = _documents;
    if (value == null) return null;
    if (_documents is EqualUnmodifiableListView) return _documents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'rejection_note')
  final String? rejectionNote;
  @override
  @JsonKey(name: 'settlement_tracking_code')
  final String? settlementTrackingCode;
  @override
  @JsonKey(name: 'delivery_to_agent')
  final bool? deliveryToAgent;
  @override
  final OrderAgentDtoModel? agent;
  final List<PaymentDtoModel>? _payments;
  @override
  List<PaymentDtoModel>? get payments {
    final value = _payments;
    if (value == null) return null;
    if (_payments is EqualUnmodifiableListView) return _payments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'remaining_time')
  final RemainingTimeDtoModel? remainingTime;
  final List<DisbursementRecordDtoModel>? _disbursementRecords;
  @override
  @JsonKey(name: 'disbursement_records')
  List<DisbursementRecordDtoModel>? get disbursementRecords {
    final value = _disbursementRecords;
    if (value == null) return null;
    if (_disbursementRecords is EqualUnmodifiableListView)
      return _disbursementRecords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<SettlementRecordDtoModel>? _settlementRecords;
  @override
  @JsonKey(name: 'settlement_records')
  List<SettlementRecordDtoModel>? get settlementRecords {
    final value = _settlementRecords;
    if (value == null) return null;
    if (_settlementRecords is EqualUnmodifiableListView)
      return _settlementRecords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'assigned_sales_reviewer')
  final String? assignedSalesReviewer;
  @override
  @JsonKey(name: 'assigned_finance_reviewer')
  final String? assignedFinanceReviewer;

  @override
  String toString() {
    return 'OrderDtoModel(id: $id, customer: $customer, subPlan: $subPlan, status: $status, total: $total, createdAt: $createdAt, updatedAt: $updatedAt, lines: $lines, documents: $documents, rejectionNote: $rejectionNote, settlementTrackingCode: $settlementTrackingCode, deliveryToAgent: $deliveryToAgent, agent: $agent, payments: $payments, remainingTime: $remainingTime, disbursementRecords: $disbursementRecords, settlementRecords: $settlementRecords, assignedSalesReviewer: $assignedSalesReviewer, assignedFinanceReviewer: $assignedFinanceReviewer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderDtoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.customer, customer) ||
                other.customer == customer) &&
            (identical(other.subPlan, subPlan) || other.subPlan == subPlan) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._lines, _lines) &&
            const DeepCollectionEquality().equals(
              other._documents,
              _documents,
            ) &&
            (identical(other.rejectionNote, rejectionNote) ||
                other.rejectionNote == rejectionNote) &&
            (identical(other.settlementTrackingCode, settlementTrackingCode) ||
                other.settlementTrackingCode == settlementTrackingCode) &&
            (identical(other.deliveryToAgent, deliveryToAgent) ||
                other.deliveryToAgent == deliveryToAgent) &&
            (identical(other.agent, agent) || other.agent == agent) &&
            const DeepCollectionEquality().equals(other._payments, _payments) &&
            (identical(other.remainingTime, remainingTime) ||
                other.remainingTime == remainingTime) &&
            const DeepCollectionEquality().equals(
              other._disbursementRecords,
              _disbursementRecords,
            ) &&
            const DeepCollectionEquality().equals(
              other._settlementRecords,
              _settlementRecords,
            ) &&
            (identical(other.assignedSalesReviewer, assignedSalesReviewer) ||
                other.assignedSalesReviewer == assignedSalesReviewer) &&
            (identical(
                  other.assignedFinanceReviewer,
                  assignedFinanceReviewer,
                ) ||
                other.assignedFinanceReviewer == assignedFinanceReviewer));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    customer,
    subPlan,
    status,
    total,
    createdAt,
    updatedAt,
    const DeepCollectionEquality().hash(_lines),
    const DeepCollectionEquality().hash(_documents),
    rejectionNote,
    settlementTrackingCode,
    deliveryToAgent,
    agent,
    const DeepCollectionEquality().hash(_payments),
    remainingTime,
    const DeepCollectionEquality().hash(_disbursementRecords),
    const DeepCollectionEquality().hash(_settlementRecords),
    assignedSalesReviewer,
    assignedFinanceReviewer,
  ]);

  /// Create a copy of OrderDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderDtoModelImplCopyWith<_$OrderDtoModelImpl> get copyWith =>
      __$$OrderDtoModelImplCopyWithImpl<_$OrderDtoModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderDtoModelImplToJson(this);
  }
}

abstract class _OrderDtoModel implements OrderDtoModel {
  const factory _OrderDtoModel({
    required final String id,
    required final CustomerDtoModel customer,
    @JsonKey(name: 'sub_plan') required final WalletSubPlanDtoModel subPlan,
    required final String status,
    required final double total,
    @JsonKey(name: 'created_at') required final String createdAt,
    @JsonKey(name: 'updated_at') final String? updatedAt,
    final List<OrderLineDtoModel>? lines,
    final List<OrderDocumentDetailDtoModel>? documents,
    @JsonKey(name: 'rejection_note') final String? rejectionNote,
    @JsonKey(name: 'settlement_tracking_code')
    final String? settlementTrackingCode,
    @JsonKey(name: 'delivery_to_agent') final bool? deliveryToAgent,
    final OrderAgentDtoModel? agent,
    final List<PaymentDtoModel>? payments,
    @JsonKey(name: 'remaining_time') final RemainingTimeDtoModel? remainingTime,
    @JsonKey(name: 'disbursement_records')
    final List<DisbursementRecordDtoModel>? disbursementRecords,
    @JsonKey(name: 'settlement_records')
    final List<SettlementRecordDtoModel>? settlementRecords,
    @JsonKey(name: 'assigned_sales_reviewer')
    final String? assignedSalesReviewer,
    @JsonKey(name: 'assigned_finance_reviewer')
    final String? assignedFinanceReviewer,
  }) = _$OrderDtoModelImpl;

  factory _OrderDtoModel.fromJson(Map<String, dynamic> json) =
      _$OrderDtoModelImpl.fromJson;

  @override
  String get id;
  @override
  CustomerDtoModel get customer;
  @override
  @JsonKey(name: 'sub_plan')
  WalletSubPlanDtoModel get subPlan;
  @override
  String get status;
  @override
  double get total;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;
  @override
  List<OrderLineDtoModel>? get lines;
  @override
  List<OrderDocumentDetailDtoModel>? get documents;
  @override
  @JsonKey(name: 'rejection_note')
  String? get rejectionNote;
  @override
  @JsonKey(name: 'settlement_tracking_code')
  String? get settlementTrackingCode;
  @override
  @JsonKey(name: 'delivery_to_agent')
  bool? get deliveryToAgent;
  @override
  OrderAgentDtoModel? get agent;
  @override
  List<PaymentDtoModel>? get payments;
  @override
  @JsonKey(name: 'remaining_time')
  RemainingTimeDtoModel? get remainingTime;
  @override
  @JsonKey(name: 'disbursement_records')
  List<DisbursementRecordDtoModel>? get disbursementRecords;
  @override
  @JsonKey(name: 'settlement_records')
  List<SettlementRecordDtoModel>? get settlementRecords;
  @override
  @JsonKey(name: 'assigned_sales_reviewer')
  String? get assignedSalesReviewer;
  @override
  @JsonKey(name: 'assigned_finance_reviewer')
  String? get assignedFinanceReviewer;

  /// Create a copy of OrderDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderDtoModelImplCopyWith<_$OrderDtoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DisbursementRecordDtoModel _$DisbursementRecordDtoModelFromJson(
  Map<String, dynamic> json,
) {
  return _DisbursementRecordDtoModel.fromJson(json);
}

/// @nodoc
mixin _$DisbursementRecordDtoModel {
  String? get gateway => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String? get reference => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'gateway_metadata')
  Map<String, dynamic>? get gatewayMetadata =>
      throw _privateConstructorUsedError;

  /// Serializes this DisbursementRecordDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DisbursementRecordDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DisbursementRecordDtoModelCopyWith<DisbursementRecordDtoModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DisbursementRecordDtoModelCopyWith<$Res> {
  factory $DisbursementRecordDtoModelCopyWith(
    DisbursementRecordDtoModel value,
    $Res Function(DisbursementRecordDtoModel) then,
  ) =
      _$DisbursementRecordDtoModelCopyWithImpl<
        $Res,
        DisbursementRecordDtoModel
      >;
  @useResult
  $Res call({
    String? gateway,
    double amount,
    String? reference,
    String? status,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'gateway_metadata') Map<String, dynamic>? gatewayMetadata,
  });
}

/// @nodoc
class _$DisbursementRecordDtoModelCopyWithImpl<
  $Res,
  $Val extends DisbursementRecordDtoModel
>
    implements $DisbursementRecordDtoModelCopyWith<$Res> {
  _$DisbursementRecordDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DisbursementRecordDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gateway = freezed,
    Object? amount = null,
    Object? reference = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
    Object? gatewayMetadata = freezed,
  }) {
    return _then(
      _value.copyWith(
            gateway: freezed == gateway
                ? _value.gateway
                : gateway // ignore: cast_nullable_to_non_nullable
                      as String?,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            reference: freezed == reference
                ? _value.reference
                : reference // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            gatewayMetadata: freezed == gatewayMetadata
                ? _value.gatewayMetadata
                : gatewayMetadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DisbursementRecordDtoModelImplCopyWith<$Res>
    implements $DisbursementRecordDtoModelCopyWith<$Res> {
  factory _$$DisbursementRecordDtoModelImplCopyWith(
    _$DisbursementRecordDtoModelImpl value,
    $Res Function(_$DisbursementRecordDtoModelImpl) then,
  ) = __$$DisbursementRecordDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? gateway,
    double amount,
    String? reference,
    String? status,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'gateway_metadata') Map<String, dynamic>? gatewayMetadata,
  });
}

/// @nodoc
class __$$DisbursementRecordDtoModelImplCopyWithImpl<$Res>
    extends
        _$DisbursementRecordDtoModelCopyWithImpl<
          $Res,
          _$DisbursementRecordDtoModelImpl
        >
    implements _$$DisbursementRecordDtoModelImplCopyWith<$Res> {
  __$$DisbursementRecordDtoModelImplCopyWithImpl(
    _$DisbursementRecordDtoModelImpl _value,
    $Res Function(_$DisbursementRecordDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DisbursementRecordDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gateway = freezed,
    Object? amount = null,
    Object? reference = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
    Object? gatewayMetadata = freezed,
  }) {
    return _then(
      _$DisbursementRecordDtoModelImpl(
        gateway: freezed == gateway
            ? _value.gateway
            : gateway // ignore: cast_nullable_to_non_nullable
                  as String?,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        reference: freezed == reference
            ? _value.reference
            : reference // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        gatewayMetadata: freezed == gatewayMetadata
            ? _value._gatewayMetadata
            : gatewayMetadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DisbursementRecordDtoModelImpl implements _DisbursementRecordDtoModel {
  const _$DisbursementRecordDtoModelImpl({
    this.gateway,
    required this.amount,
    this.reference,
    this.status,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'gateway_metadata')
    final Map<String, dynamic>? gatewayMetadata,
  }) : _gatewayMetadata = gatewayMetadata;

  factory _$DisbursementRecordDtoModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$DisbursementRecordDtoModelImplFromJson(json);

  @override
  final String? gateway;
  @override
  final double amount;
  @override
  final String? reference;
  @override
  final String? status;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  final Map<String, dynamic>? _gatewayMetadata;
  @override
  @JsonKey(name: 'gateway_metadata')
  Map<String, dynamic>? get gatewayMetadata {
    final value = _gatewayMetadata;
    if (value == null) return null;
    if (_gatewayMetadata is EqualUnmodifiableMapView) return _gatewayMetadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'DisbursementRecordDtoModel(gateway: $gateway, amount: $amount, reference: $reference, status: $status, createdAt: $createdAt, gatewayMetadata: $gatewayMetadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DisbursementRecordDtoModelImpl &&
            (identical(other.gateway, gateway) || other.gateway == gateway) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.reference, reference) ||
                other.reference == reference) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(
              other._gatewayMetadata,
              _gatewayMetadata,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    gateway,
    amount,
    reference,
    status,
    createdAt,
    const DeepCollectionEquality().hash(_gatewayMetadata),
  );

  /// Create a copy of DisbursementRecordDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DisbursementRecordDtoModelImplCopyWith<_$DisbursementRecordDtoModelImpl>
  get copyWith =>
      __$$DisbursementRecordDtoModelImplCopyWithImpl<
        _$DisbursementRecordDtoModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DisbursementRecordDtoModelImplToJson(this);
  }
}

abstract class _DisbursementRecordDtoModel
    implements DisbursementRecordDtoModel {
  const factory _DisbursementRecordDtoModel({
    final String? gateway,
    required final double amount,
    final String? reference,
    final String? status,
    @JsonKey(name: 'created_at') final String? createdAt,
    @JsonKey(name: 'gateway_metadata')
    final Map<String, dynamic>? gatewayMetadata,
  }) = _$DisbursementRecordDtoModelImpl;

  factory _DisbursementRecordDtoModel.fromJson(Map<String, dynamic> json) =
      _$DisbursementRecordDtoModelImpl.fromJson;

  @override
  String? get gateway;
  @override
  double get amount;
  @override
  String? get reference;
  @override
  String? get status;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'gateway_metadata')
  Map<String, dynamic>? get gatewayMetadata;

  /// Create a copy of DisbursementRecordDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DisbursementRecordDtoModelImplCopyWith<_$DisbursementRecordDtoModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

SettlementRecordDtoModel _$SettlementRecordDtoModelFromJson(
  Map<String, dynamic> json,
) {
  return _SettlementRecordDtoModel.fromJson(json);
}

/// @nodoc
mixin _$SettlementRecordDtoModel {
  String? get id => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_type')
  String? get paymentType => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'tracking_code')
  String? get trackingCode => throw _privateConstructorUsedError;
  String? get gateway => throw _privateConstructorUsedError;
  String? get reference => throw _privateConstructorUsedError;

  /// Serializes this SettlementRecordDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SettlementRecordDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SettlementRecordDtoModelCopyWith<SettlementRecordDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettlementRecordDtoModelCopyWith<$Res> {
  factory $SettlementRecordDtoModelCopyWith(
    SettlementRecordDtoModel value,
    $Res Function(SettlementRecordDtoModel) then,
  ) = _$SettlementRecordDtoModelCopyWithImpl<$Res, SettlementRecordDtoModel>;
  @useResult
  $Res call({
    String? id,
    double amount,
    @JsonKey(name: 'payment_type') String? paymentType,
    String? status,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'tracking_code') String? trackingCode,
    String? gateway,
    String? reference,
  });
}

/// @nodoc
class _$SettlementRecordDtoModelCopyWithImpl<
  $Res,
  $Val extends SettlementRecordDtoModel
>
    implements $SettlementRecordDtoModelCopyWith<$Res> {
  _$SettlementRecordDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SettlementRecordDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? amount = null,
    Object? paymentType = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
    Object? trackingCode = freezed,
    Object? gateway = freezed,
    Object? reference = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            paymentType: freezed == paymentType
                ? _value.paymentType
                : paymentType // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            trackingCode: freezed == trackingCode
                ? _value.trackingCode
                : trackingCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            gateway: freezed == gateway
                ? _value.gateway
                : gateway // ignore: cast_nullable_to_non_nullable
                      as String?,
            reference: freezed == reference
                ? _value.reference
                : reference // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SettlementRecordDtoModelImplCopyWith<$Res>
    implements $SettlementRecordDtoModelCopyWith<$Res> {
  factory _$$SettlementRecordDtoModelImplCopyWith(
    _$SettlementRecordDtoModelImpl value,
    $Res Function(_$SettlementRecordDtoModelImpl) then,
  ) = __$$SettlementRecordDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    double amount,
    @JsonKey(name: 'payment_type') String? paymentType,
    String? status,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'tracking_code') String? trackingCode,
    String? gateway,
    String? reference,
  });
}

/// @nodoc
class __$$SettlementRecordDtoModelImplCopyWithImpl<$Res>
    extends
        _$SettlementRecordDtoModelCopyWithImpl<
          $Res,
          _$SettlementRecordDtoModelImpl
        >
    implements _$$SettlementRecordDtoModelImplCopyWith<$Res> {
  __$$SettlementRecordDtoModelImplCopyWithImpl(
    _$SettlementRecordDtoModelImpl _value,
    $Res Function(_$SettlementRecordDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SettlementRecordDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? amount = null,
    Object? paymentType = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
    Object? trackingCode = freezed,
    Object? gateway = freezed,
    Object? reference = freezed,
  }) {
    return _then(
      _$SettlementRecordDtoModelImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        paymentType: freezed == paymentType
            ? _value.paymentType
            : paymentType // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        trackingCode: freezed == trackingCode
            ? _value.trackingCode
            : trackingCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        gateway: freezed == gateway
            ? _value.gateway
            : gateway // ignore: cast_nullable_to_non_nullable
                  as String?,
        reference: freezed == reference
            ? _value.reference
            : reference // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SettlementRecordDtoModelImpl implements _SettlementRecordDtoModel {
  const _$SettlementRecordDtoModelImpl({
    this.id,
    required this.amount,
    @JsonKey(name: 'payment_type') this.paymentType,
    this.status,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'tracking_code') this.trackingCode,
    this.gateway,
    this.reference,
  });

  factory _$SettlementRecordDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SettlementRecordDtoModelImplFromJson(json);

  @override
  final String? id;
  @override
  final double amount;
  @override
  @JsonKey(name: 'payment_type')
  final String? paymentType;
  @override
  final String? status;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'tracking_code')
  final String? trackingCode;
  @override
  final String? gateway;
  @override
  final String? reference;

  @override
  String toString() {
    return 'SettlementRecordDtoModel(id: $id, amount: $amount, paymentType: $paymentType, status: $status, createdAt: $createdAt, trackingCode: $trackingCode, gateway: $gateway, reference: $reference)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettlementRecordDtoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.paymentType, paymentType) ||
                other.paymentType == paymentType) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.trackingCode, trackingCode) ||
                other.trackingCode == trackingCode) &&
            (identical(other.gateway, gateway) || other.gateway == gateway) &&
            (identical(other.reference, reference) ||
                other.reference == reference));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    amount,
    paymentType,
    status,
    createdAt,
    trackingCode,
    gateway,
    reference,
  );

  /// Create a copy of SettlementRecordDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SettlementRecordDtoModelImplCopyWith<_$SettlementRecordDtoModelImpl>
  get copyWith =>
      __$$SettlementRecordDtoModelImplCopyWithImpl<
        _$SettlementRecordDtoModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SettlementRecordDtoModelImplToJson(this);
  }
}

abstract class _SettlementRecordDtoModel implements SettlementRecordDtoModel {
  const factory _SettlementRecordDtoModel({
    final String? id,
    required final double amount,
    @JsonKey(name: 'payment_type') final String? paymentType,
    final String? status,
    @JsonKey(name: 'created_at') final String? createdAt,
    @JsonKey(name: 'tracking_code') final String? trackingCode,
    final String? gateway,
    final String? reference,
  }) = _$SettlementRecordDtoModelImpl;

  factory _SettlementRecordDtoModel.fromJson(Map<String, dynamic> json) =
      _$SettlementRecordDtoModelImpl.fromJson;

  @override
  String? get id;
  @override
  double get amount;
  @override
  @JsonKey(name: 'payment_type')
  String? get paymentType;
  @override
  String? get status;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'tracking_code')
  String? get trackingCode;
  @override
  String? get gateway;
  @override
  String? get reference;

  /// Create a copy of SettlementRecordDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SettlementRecordDtoModelImplCopyWith<_$SettlementRecordDtoModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

PaymentDtoModel _$PaymentDtoModelFromJson(Map<String, dynamic> json) {
  return _PaymentDtoModel.fromJson(json);
}

/// @nodoc
mixin _$PaymentDtoModel {
  String? get id => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_type')
  String? get paymentType => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'tracking_code')
  String? get trackingCode => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;

  /// Serializes this PaymentDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentDtoModelCopyWith<PaymentDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentDtoModelCopyWith<$Res> {
  factory $PaymentDtoModelCopyWith(
    PaymentDtoModel value,
    $Res Function(PaymentDtoModel) then,
  ) = _$PaymentDtoModelCopyWithImpl<$Res, PaymentDtoModel>;
  @useResult
  $Res call({
    String? id,
    double amount,
    @JsonKey(name: 'payment_type') String? paymentType,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'tracking_code') String? trackingCode,
    String? status,
  });
}

/// @nodoc
class _$PaymentDtoModelCopyWithImpl<$Res, $Val extends PaymentDtoModel>
    implements $PaymentDtoModelCopyWith<$Res> {
  _$PaymentDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? amount = null,
    Object? paymentType = freezed,
    Object? createdAt = freezed,
    Object? trackingCode = freezed,
    Object? status = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            paymentType: freezed == paymentType
                ? _value.paymentType
                : paymentType // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            trackingCode: freezed == trackingCode
                ? _value.trackingCode
                : trackingCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaymentDtoModelImplCopyWith<$Res>
    implements $PaymentDtoModelCopyWith<$Res> {
  factory _$$PaymentDtoModelImplCopyWith(
    _$PaymentDtoModelImpl value,
    $Res Function(_$PaymentDtoModelImpl) then,
  ) = __$$PaymentDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    double amount,
    @JsonKey(name: 'payment_type') String? paymentType,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'tracking_code') String? trackingCode,
    String? status,
  });
}

/// @nodoc
class __$$PaymentDtoModelImplCopyWithImpl<$Res>
    extends _$PaymentDtoModelCopyWithImpl<$Res, _$PaymentDtoModelImpl>
    implements _$$PaymentDtoModelImplCopyWith<$Res> {
  __$$PaymentDtoModelImplCopyWithImpl(
    _$PaymentDtoModelImpl _value,
    $Res Function(_$PaymentDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaymentDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? amount = null,
    Object? paymentType = freezed,
    Object? createdAt = freezed,
    Object? trackingCode = freezed,
    Object? status = freezed,
  }) {
    return _then(
      _$PaymentDtoModelImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        paymentType: freezed == paymentType
            ? _value.paymentType
            : paymentType // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        trackingCode: freezed == trackingCode
            ? _value.trackingCode
            : trackingCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentDtoModelImpl implements _PaymentDtoModel {
  const _$PaymentDtoModelImpl({
    this.id,
    required this.amount,
    @JsonKey(name: 'payment_type') this.paymentType,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'tracking_code') this.trackingCode,
    this.status,
  });

  factory _$PaymentDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentDtoModelImplFromJson(json);

  @override
  final String? id;
  @override
  final double amount;
  @override
  @JsonKey(name: 'payment_type')
  final String? paymentType;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'tracking_code')
  final String? trackingCode;
  @override
  final String? status;

  @override
  String toString() {
    return 'PaymentDtoModel(id: $id, amount: $amount, paymentType: $paymentType, createdAt: $createdAt, trackingCode: $trackingCode, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentDtoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.paymentType, paymentType) ||
                other.paymentType == paymentType) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.trackingCode, trackingCode) ||
                other.trackingCode == trackingCode) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    amount,
    paymentType,
    createdAt,
    trackingCode,
    status,
  );

  /// Create a copy of PaymentDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentDtoModelImplCopyWith<_$PaymentDtoModelImpl> get copyWith =>
      __$$PaymentDtoModelImplCopyWithImpl<_$PaymentDtoModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentDtoModelImplToJson(this);
  }
}

abstract class _PaymentDtoModel implements PaymentDtoModel {
  const factory _PaymentDtoModel({
    final String? id,
    required final double amount,
    @JsonKey(name: 'payment_type') final String? paymentType,
    @JsonKey(name: 'created_at') final String? createdAt,
    @JsonKey(name: 'tracking_code') final String? trackingCode,
    final String? status,
  }) = _$PaymentDtoModelImpl;

  factory _PaymentDtoModel.fromJson(Map<String, dynamic> json) =
      _$PaymentDtoModelImpl.fromJson;

  @override
  String? get id;
  @override
  double get amount;
  @override
  @JsonKey(name: 'payment_type')
  String? get paymentType;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'tracking_code')
  String? get trackingCode;
  @override
  String? get status;

  /// Create a copy of PaymentDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentDtoModelImplCopyWith<_$PaymentDtoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderAgentDtoModel _$OrderAgentDtoModelFromJson(Map<String, dynamic> json) {
  return _OrderAgentDtoModel.fromJson(json);
}

/// @nodoc
mixin _$OrderAgentDtoModel {
  String get id => throw _privateConstructorUsedError;
  String get mobile => throw _privateConstructorUsedError;
  @JsonKey(name: 'first_name')
  String? get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_name')
  String? get lastName => throw _privateConstructorUsedError;

  /// Serializes this OrderAgentDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderAgentDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderAgentDtoModelCopyWith<OrderAgentDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderAgentDtoModelCopyWith<$Res> {
  factory $OrderAgentDtoModelCopyWith(
    OrderAgentDtoModel value,
    $Res Function(OrderAgentDtoModel) then,
  ) = _$OrderAgentDtoModelCopyWithImpl<$Res, OrderAgentDtoModel>;
  @useResult
  $Res call({
    String id,
    String mobile,
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'last_name') String? lastName,
  });
}

/// @nodoc
class _$OrderAgentDtoModelCopyWithImpl<$Res, $Val extends OrderAgentDtoModel>
    implements $OrderAgentDtoModelCopyWith<$Res> {
  _$OrderAgentDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderAgentDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? mobile = null,
    Object? firstName = freezed,
    Object? lastName = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            mobile: null == mobile
                ? _value.mobile
                : mobile // ignore: cast_nullable_to_non_nullable
                      as String,
            firstName: freezed == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastName: freezed == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderAgentDtoModelImplCopyWith<$Res>
    implements $OrderAgentDtoModelCopyWith<$Res> {
  factory _$$OrderAgentDtoModelImplCopyWith(
    _$OrderAgentDtoModelImpl value,
    $Res Function(_$OrderAgentDtoModelImpl) then,
  ) = __$$OrderAgentDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String mobile,
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'last_name') String? lastName,
  });
}

/// @nodoc
class __$$OrderAgentDtoModelImplCopyWithImpl<$Res>
    extends _$OrderAgentDtoModelCopyWithImpl<$Res, _$OrderAgentDtoModelImpl>
    implements _$$OrderAgentDtoModelImplCopyWith<$Res> {
  __$$OrderAgentDtoModelImplCopyWithImpl(
    _$OrderAgentDtoModelImpl _value,
    $Res Function(_$OrderAgentDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderAgentDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? mobile = null,
    Object? firstName = freezed,
    Object? lastName = freezed,
  }) {
    return _then(
      _$OrderAgentDtoModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        mobile: null == mobile
            ? _value.mobile
            : mobile // ignore: cast_nullable_to_non_nullable
                  as String,
        firstName: freezed == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastName: freezed == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderAgentDtoModelImpl implements _OrderAgentDtoModel {
  const _$OrderAgentDtoModelImpl({
    required this.id,
    required this.mobile,
    @JsonKey(name: 'first_name') this.firstName,
    @JsonKey(name: 'last_name') this.lastName,
  });

  factory _$OrderAgentDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderAgentDtoModelImplFromJson(json);

  @override
  final String id;
  @override
  final String mobile;
  @override
  @JsonKey(name: 'first_name')
  final String? firstName;
  @override
  @JsonKey(name: 'last_name')
  final String? lastName;

  @override
  String toString() {
    return 'OrderAgentDtoModel(id: $id, mobile: $mobile, firstName: $firstName, lastName: $lastName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderAgentDtoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.mobile, mobile) || other.mobile == mobile) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, mobile, firstName, lastName);

  /// Create a copy of OrderAgentDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderAgentDtoModelImplCopyWith<_$OrderAgentDtoModelImpl> get copyWith =>
      __$$OrderAgentDtoModelImplCopyWithImpl<_$OrderAgentDtoModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderAgentDtoModelImplToJson(this);
  }
}

abstract class _OrderAgentDtoModel implements OrderAgentDtoModel {
  const factory _OrderAgentDtoModel({
    required final String id,
    required final String mobile,
    @JsonKey(name: 'first_name') final String? firstName,
    @JsonKey(name: 'last_name') final String? lastName,
  }) = _$OrderAgentDtoModelImpl;

  factory _OrderAgentDtoModel.fromJson(Map<String, dynamic> json) =
      _$OrderAgentDtoModelImpl.fromJson;

  @override
  String get id;
  @override
  String get mobile;
  @override
  @JsonKey(name: 'first_name')
  String? get firstName;
  @override
  @JsonKey(name: 'last_name')
  String? get lastName;

  /// Create a copy of OrderAgentDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderAgentDtoModelImplCopyWith<_$OrderAgentDtoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderDocumentDetailDtoModel _$OrderDocumentDetailDtoModelFromJson(
  Map<String, dynamic> json,
) {
  return _OrderDocumentDetailDtoModel.fromJson(json);
}

/// @nodoc
mixin _$OrderDocumentDetailDtoModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'document_type')
  String get documentType => throw _privateConstructorUsedError;
  OrderFileDtoModel get file => throw _privateConstructorUsedError;
  @JsonKey(name: 'uploaded_by_id')
  String? get uploadedById => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;

  /// Serializes this OrderDocumentDetailDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderDocumentDetailDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderDocumentDetailDtoModelCopyWith<OrderDocumentDetailDtoModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderDocumentDetailDtoModelCopyWith<$Res> {
  factory $OrderDocumentDetailDtoModelCopyWith(
    OrderDocumentDetailDtoModel value,
    $Res Function(OrderDocumentDetailDtoModel) then,
  ) =
      _$OrderDocumentDetailDtoModelCopyWithImpl<
        $Res,
        OrderDocumentDetailDtoModel
      >;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'document_type') String documentType,
    OrderFileDtoModel file,
    @JsonKey(name: 'uploaded_by_id') String? uploadedById,
    @JsonKey(name: 'created_at') String createdAt,
  });

  $OrderFileDtoModelCopyWith<$Res> get file;
}

/// @nodoc
class _$OrderDocumentDetailDtoModelCopyWithImpl<
  $Res,
  $Val extends OrderDocumentDetailDtoModel
>
    implements $OrderDocumentDetailDtoModelCopyWith<$Res> {
  _$OrderDocumentDetailDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderDocumentDetailDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? documentType = null,
    Object? file = null,
    Object? uploadedById = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            documentType: null == documentType
                ? _value.documentType
                : documentType // ignore: cast_nullable_to_non_nullable
                      as String,
            file: null == file
                ? _value.file
                : file // ignore: cast_nullable_to_non_nullable
                      as OrderFileDtoModel,
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

  /// Create a copy of OrderDocumentDetailDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OrderFileDtoModelCopyWith<$Res> get file {
    return $OrderFileDtoModelCopyWith<$Res>(_value.file, (value) {
      return _then(_value.copyWith(file: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrderDocumentDetailDtoModelImplCopyWith<$Res>
    implements $OrderDocumentDetailDtoModelCopyWith<$Res> {
  factory _$$OrderDocumentDetailDtoModelImplCopyWith(
    _$OrderDocumentDetailDtoModelImpl value,
    $Res Function(_$OrderDocumentDetailDtoModelImpl) then,
  ) = __$$OrderDocumentDetailDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'document_type') String documentType,
    OrderFileDtoModel file,
    @JsonKey(name: 'uploaded_by_id') String? uploadedById,
    @JsonKey(name: 'created_at') String createdAt,
  });

  @override
  $OrderFileDtoModelCopyWith<$Res> get file;
}

/// @nodoc
class __$$OrderDocumentDetailDtoModelImplCopyWithImpl<$Res>
    extends
        _$OrderDocumentDetailDtoModelCopyWithImpl<
          $Res,
          _$OrderDocumentDetailDtoModelImpl
        >
    implements _$$OrderDocumentDetailDtoModelImplCopyWith<$Res> {
  __$$OrderDocumentDetailDtoModelImplCopyWithImpl(
    _$OrderDocumentDetailDtoModelImpl _value,
    $Res Function(_$OrderDocumentDetailDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderDocumentDetailDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? documentType = null,
    Object? file = null,
    Object? uploadedById = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _$OrderDocumentDetailDtoModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        documentType: null == documentType
            ? _value.documentType
            : documentType // ignore: cast_nullable_to_non_nullable
                  as String,
        file: null == file
            ? _value.file
            : file // ignore: cast_nullable_to_non_nullable
                  as OrderFileDtoModel,
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
class _$OrderDocumentDetailDtoModelImpl
    implements _OrderDocumentDetailDtoModel {
  const _$OrderDocumentDetailDtoModelImpl({
    required this.id,
    @JsonKey(name: 'document_type') required this.documentType,
    required this.file,
    @JsonKey(name: 'uploaded_by_id') this.uploadedById,
    @JsonKey(name: 'created_at') required this.createdAt,
  });

  factory _$OrderDocumentDetailDtoModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$OrderDocumentDetailDtoModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'document_type')
  final String documentType;
  @override
  final OrderFileDtoModel file;
  @override
  @JsonKey(name: 'uploaded_by_id')
  final String? uploadedById;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;

  @override
  String toString() {
    return 'OrderDocumentDetailDtoModel(id: $id, documentType: $documentType, file: $file, uploadedById: $uploadedById, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderDocumentDetailDtoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.documentType, documentType) ||
                other.documentType == documentType) &&
            (identical(other.file, file) || other.file == file) &&
            (identical(other.uploadedById, uploadedById) ||
                other.uploadedById == uploadedById) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, documentType, file, uploadedById, createdAt);

  /// Create a copy of OrderDocumentDetailDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderDocumentDetailDtoModelImplCopyWith<_$OrderDocumentDetailDtoModelImpl>
  get copyWith =>
      __$$OrderDocumentDetailDtoModelImplCopyWithImpl<
        _$OrderDocumentDetailDtoModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderDocumentDetailDtoModelImplToJson(this);
  }
}

abstract class _OrderDocumentDetailDtoModel
    implements OrderDocumentDetailDtoModel {
  const factory _OrderDocumentDetailDtoModel({
    required final String id,
    @JsonKey(name: 'document_type') required final String documentType,
    required final OrderFileDtoModel file,
    @JsonKey(name: 'uploaded_by_id') final String? uploadedById,
    @JsonKey(name: 'created_at') required final String createdAt,
  }) = _$OrderDocumentDetailDtoModelImpl;

  factory _OrderDocumentDetailDtoModel.fromJson(Map<String, dynamic> json) =
      _$OrderDocumentDetailDtoModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'document_type')
  String get documentType;
  @override
  OrderFileDtoModel get file;
  @override
  @JsonKey(name: 'uploaded_by_id')
  String? get uploadedById;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;

  /// Create a copy of OrderDocumentDetailDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderDocumentDetailDtoModelImplCopyWith<_$OrderDocumentDetailDtoModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

OrderFileDtoModel _$OrderFileDtoModelFromJson(Map<String, dynamic> json) {
  return _OrderFileDtoModel.fromJson(json);
}

/// @nodoc
mixin _$OrderFileDtoModel {
  String get id => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  @JsonKey(name: 'original_name')
  String get originalName => throw _privateConstructorUsedError;
  @JsonKey(name: 'mime_type')
  String get mimeType => throw _privateConstructorUsedError;
  @JsonKey(name: 'size_bytes')
  int? get sizeBytes => throw _privateConstructorUsedError;
  String get file => throw _privateConstructorUsedError;

  /// Serializes this OrderFileDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderFileDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderFileDtoModelCopyWith<OrderFileDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderFileDtoModelCopyWith<$Res> {
  factory $OrderFileDtoModelCopyWith(
    OrderFileDtoModel value,
    $Res Function(OrderFileDtoModel) then,
  ) = _$OrderFileDtoModelCopyWithImpl<$Res, OrderFileDtoModel>;
  @useResult
  $Res call({
    String id,
    String category,
    @JsonKey(name: 'original_name') String originalName,
    @JsonKey(name: 'mime_type') String mimeType,
    @JsonKey(name: 'size_bytes') int? sizeBytes,
    String file,
  });
}

/// @nodoc
class _$OrderFileDtoModelCopyWithImpl<$Res, $Val extends OrderFileDtoModel>
    implements $OrderFileDtoModelCopyWith<$Res> {
  _$OrderFileDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderFileDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? category = null,
    Object? originalName = null,
    Object? mimeType = null,
    Object? sizeBytes = freezed,
    Object? file = null,
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
            sizeBytes: freezed == sizeBytes
                ? _value.sizeBytes
                : sizeBytes // ignore: cast_nullable_to_non_nullable
                      as int?,
            file: null == file
                ? _value.file
                : file // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderFileDtoModelImplCopyWith<$Res>
    implements $OrderFileDtoModelCopyWith<$Res> {
  factory _$$OrderFileDtoModelImplCopyWith(
    _$OrderFileDtoModelImpl value,
    $Res Function(_$OrderFileDtoModelImpl) then,
  ) = __$$OrderFileDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String category,
    @JsonKey(name: 'original_name') String originalName,
    @JsonKey(name: 'mime_type') String mimeType,
    @JsonKey(name: 'size_bytes') int? sizeBytes,
    String file,
  });
}

/// @nodoc
class __$$OrderFileDtoModelImplCopyWithImpl<$Res>
    extends _$OrderFileDtoModelCopyWithImpl<$Res, _$OrderFileDtoModelImpl>
    implements _$$OrderFileDtoModelImplCopyWith<$Res> {
  __$$OrderFileDtoModelImplCopyWithImpl(
    _$OrderFileDtoModelImpl _value,
    $Res Function(_$OrderFileDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderFileDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? category = null,
    Object? originalName = null,
    Object? mimeType = null,
    Object? sizeBytes = freezed,
    Object? file = null,
  }) {
    return _then(
      _$OrderFileDtoModelImpl(
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
        sizeBytes: freezed == sizeBytes
            ? _value.sizeBytes
            : sizeBytes // ignore: cast_nullable_to_non_nullable
                  as int?,
        file: null == file
            ? _value.file
            : file // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderFileDtoModelImpl implements _OrderFileDtoModel {
  const _$OrderFileDtoModelImpl({
    required this.id,
    required this.category,
    @JsonKey(name: 'original_name') required this.originalName,
    @JsonKey(name: 'mime_type') required this.mimeType,
    @JsonKey(name: 'size_bytes') this.sizeBytes,
    required this.file,
  });

  factory _$OrderFileDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderFileDtoModelImplFromJson(json);

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
  final int? sizeBytes;
  @override
  final String file;

  @override
  String toString() {
    return 'OrderFileDtoModel(id: $id, category: $category, originalName: $originalName, mimeType: $mimeType, sizeBytes: $sizeBytes, file: $file)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderFileDtoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.originalName, originalName) ||
                other.originalName == originalName) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType) &&
            (identical(other.sizeBytes, sizeBytes) ||
                other.sizeBytes == sizeBytes) &&
            (identical(other.file, file) || other.file == file));
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
    file,
  );

  /// Create a copy of OrderFileDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderFileDtoModelImplCopyWith<_$OrderFileDtoModelImpl> get copyWith =>
      __$$OrderFileDtoModelImplCopyWithImpl<_$OrderFileDtoModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderFileDtoModelImplToJson(this);
  }
}

abstract class _OrderFileDtoModel implements OrderFileDtoModel {
  const factory _OrderFileDtoModel({
    required final String id,
    required final String category,
    @JsonKey(name: 'original_name') required final String originalName,
    @JsonKey(name: 'mime_type') required final String mimeType,
    @JsonKey(name: 'size_bytes') final int? sizeBytes,
    required final String file,
  }) = _$OrderFileDtoModelImpl;

  factory _OrderFileDtoModel.fromJson(Map<String, dynamic> json) =
      _$OrderFileDtoModelImpl.fromJson;

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
  int? get sizeBytes;
  @override
  String get file;

  /// Create a copy of OrderFileDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderFileDtoModelImplCopyWith<_$OrderFileDtoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderLineDtoModel _$OrderLineDtoModelFromJson(Map<String, dynamic> json) {
  return _OrderLineDtoModel.fromJson(json);
}

/// @nodoc
mixin _$OrderLineDtoModel {
  String get id => throw _privateConstructorUsedError;
  OrderProductSummaryDtoModel get product => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'unit_price_at_creation')
  double get unitPriceAtCreation => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_pct_at_creation')
  double? get discountPctAtCreation => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_amount_at_creation')
  double? get discountAmountAtCreation => throw _privateConstructorUsedError;
  @JsonKey(name: 'line_total')
  double get lineTotal => throw _privateConstructorUsedError;

  /// Serializes this OrderLineDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderLineDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderLineDtoModelCopyWith<OrderLineDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderLineDtoModelCopyWith<$Res> {
  factory $OrderLineDtoModelCopyWith(
    OrderLineDtoModel value,
    $Res Function(OrderLineDtoModel) then,
  ) = _$OrderLineDtoModelCopyWithImpl<$Res, OrderLineDtoModel>;
  @useResult
  $Res call({
    String id,
    OrderProductSummaryDtoModel product,
    int quantity,
    @JsonKey(name: 'unit_price_at_creation') double unitPriceAtCreation,
    @JsonKey(name: 'discount_pct_at_creation') double? discountPctAtCreation,
    @JsonKey(name: 'discount_amount_at_creation')
    double? discountAmountAtCreation,
    @JsonKey(name: 'line_total') double lineTotal,
  });

  $OrderProductSummaryDtoModelCopyWith<$Res> get product;
}

/// @nodoc
class _$OrderLineDtoModelCopyWithImpl<$Res, $Val extends OrderLineDtoModel>
    implements $OrderLineDtoModelCopyWith<$Res> {
  _$OrderLineDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderLineDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? product = null,
    Object? quantity = null,
    Object? unitPriceAtCreation = null,
    Object? discountPctAtCreation = freezed,
    Object? discountAmountAtCreation = freezed,
    Object? lineTotal = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            product: null == product
                ? _value.product
                : product // ignore: cast_nullable_to_non_nullable
                      as OrderProductSummaryDtoModel,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
            unitPriceAtCreation: null == unitPriceAtCreation
                ? _value.unitPriceAtCreation
                : unitPriceAtCreation // ignore: cast_nullable_to_non_nullable
                      as double,
            discountPctAtCreation: freezed == discountPctAtCreation
                ? _value.discountPctAtCreation
                : discountPctAtCreation // ignore: cast_nullable_to_non_nullable
                      as double?,
            discountAmountAtCreation: freezed == discountAmountAtCreation
                ? _value.discountAmountAtCreation
                : discountAmountAtCreation // ignore: cast_nullable_to_non_nullable
                      as double?,
            lineTotal: null == lineTotal
                ? _value.lineTotal
                : lineTotal // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }

  /// Create a copy of OrderLineDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OrderProductSummaryDtoModelCopyWith<$Res> get product {
    return $OrderProductSummaryDtoModelCopyWith<$Res>(_value.product, (value) {
      return _then(_value.copyWith(product: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrderLineDtoModelImplCopyWith<$Res>
    implements $OrderLineDtoModelCopyWith<$Res> {
  factory _$$OrderLineDtoModelImplCopyWith(
    _$OrderLineDtoModelImpl value,
    $Res Function(_$OrderLineDtoModelImpl) then,
  ) = __$$OrderLineDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    OrderProductSummaryDtoModel product,
    int quantity,
    @JsonKey(name: 'unit_price_at_creation') double unitPriceAtCreation,
    @JsonKey(name: 'discount_pct_at_creation') double? discountPctAtCreation,
    @JsonKey(name: 'discount_amount_at_creation')
    double? discountAmountAtCreation,
    @JsonKey(name: 'line_total') double lineTotal,
  });

  @override
  $OrderProductSummaryDtoModelCopyWith<$Res> get product;
}

/// @nodoc
class __$$OrderLineDtoModelImplCopyWithImpl<$Res>
    extends _$OrderLineDtoModelCopyWithImpl<$Res, _$OrderLineDtoModelImpl>
    implements _$$OrderLineDtoModelImplCopyWith<$Res> {
  __$$OrderLineDtoModelImplCopyWithImpl(
    _$OrderLineDtoModelImpl _value,
    $Res Function(_$OrderLineDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderLineDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? product = null,
    Object? quantity = null,
    Object? unitPriceAtCreation = null,
    Object? discountPctAtCreation = freezed,
    Object? discountAmountAtCreation = freezed,
    Object? lineTotal = null,
  }) {
    return _then(
      _$OrderLineDtoModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        product: null == product
            ? _value.product
            : product // ignore: cast_nullable_to_non_nullable
                  as OrderProductSummaryDtoModel,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
        unitPriceAtCreation: null == unitPriceAtCreation
            ? _value.unitPriceAtCreation
            : unitPriceAtCreation // ignore: cast_nullable_to_non_nullable
                  as double,
        discountPctAtCreation: freezed == discountPctAtCreation
            ? _value.discountPctAtCreation
            : discountPctAtCreation // ignore: cast_nullable_to_non_nullable
                  as double?,
        discountAmountAtCreation: freezed == discountAmountAtCreation
            ? _value.discountAmountAtCreation
            : discountAmountAtCreation // ignore: cast_nullable_to_non_nullable
                  as double?,
        lineTotal: null == lineTotal
            ? _value.lineTotal
            : lineTotal // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderLineDtoModelImpl implements _OrderLineDtoModel {
  const _$OrderLineDtoModelImpl({
    required this.id,
    required this.product,
    required this.quantity,
    @JsonKey(name: 'unit_price_at_creation') required this.unitPriceAtCreation,
    @JsonKey(name: 'discount_pct_at_creation') this.discountPctAtCreation,
    @JsonKey(name: 'discount_amount_at_creation') this.discountAmountAtCreation,
    @JsonKey(name: 'line_total') required this.lineTotal,
  });

  factory _$OrderLineDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderLineDtoModelImplFromJson(json);

  @override
  final String id;
  @override
  final OrderProductSummaryDtoModel product;
  @override
  final int quantity;
  @override
  @JsonKey(name: 'unit_price_at_creation')
  final double unitPriceAtCreation;
  @override
  @JsonKey(name: 'discount_pct_at_creation')
  final double? discountPctAtCreation;
  @override
  @JsonKey(name: 'discount_amount_at_creation')
  final double? discountAmountAtCreation;
  @override
  @JsonKey(name: 'line_total')
  final double lineTotal;

  @override
  String toString() {
    return 'OrderLineDtoModel(id: $id, product: $product, quantity: $quantity, unitPriceAtCreation: $unitPriceAtCreation, discountPctAtCreation: $discountPctAtCreation, discountAmountAtCreation: $discountAmountAtCreation, lineTotal: $lineTotal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderLineDtoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.product, product) || other.product == product) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitPriceAtCreation, unitPriceAtCreation) ||
                other.unitPriceAtCreation == unitPriceAtCreation) &&
            (identical(other.discountPctAtCreation, discountPctAtCreation) ||
                other.discountPctAtCreation == discountPctAtCreation) &&
            (identical(
                  other.discountAmountAtCreation,
                  discountAmountAtCreation,
                ) ||
                other.discountAmountAtCreation == discountAmountAtCreation) &&
            (identical(other.lineTotal, lineTotal) ||
                other.lineTotal == lineTotal));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    product,
    quantity,
    unitPriceAtCreation,
    discountPctAtCreation,
    discountAmountAtCreation,
    lineTotal,
  );

  /// Create a copy of OrderLineDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderLineDtoModelImplCopyWith<_$OrderLineDtoModelImpl> get copyWith =>
      __$$OrderLineDtoModelImplCopyWithImpl<_$OrderLineDtoModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderLineDtoModelImplToJson(this);
  }
}

abstract class _OrderLineDtoModel implements OrderLineDtoModel {
  const factory _OrderLineDtoModel({
    required final String id,
    required final OrderProductSummaryDtoModel product,
    required final int quantity,
    @JsonKey(name: 'unit_price_at_creation')
    required final double unitPriceAtCreation,
    @JsonKey(name: 'discount_pct_at_creation')
    final double? discountPctAtCreation,
    @JsonKey(name: 'discount_amount_at_creation')
    final double? discountAmountAtCreation,
    @JsonKey(name: 'line_total') required final double lineTotal,
  }) = _$OrderLineDtoModelImpl;

  factory _OrderLineDtoModel.fromJson(Map<String, dynamic> json) =
      _$OrderLineDtoModelImpl.fromJson;

  @override
  String get id;
  @override
  OrderProductSummaryDtoModel get product;
  @override
  int get quantity;
  @override
  @JsonKey(name: 'unit_price_at_creation')
  double get unitPriceAtCreation;
  @override
  @JsonKey(name: 'discount_pct_at_creation')
  double? get discountPctAtCreation;
  @override
  @JsonKey(name: 'discount_amount_at_creation')
  double? get discountAmountAtCreation;
  @override
  @JsonKey(name: 'line_total')
  double get lineTotal;

  /// Create a copy of OrderLineDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderLineDtoModelImplCopyWith<_$OrderLineDtoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderProductSummaryDtoModel _$OrderProductSummaryDtoModelFromJson(
  Map<String, dynamic> json,
) {
  return _OrderProductSummaryDtoModel.fromJson(json);
}

/// @nodoc
mixin _$OrderProductSummaryDtoModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get sku => throw _privateConstructorUsedError;
  @JsonKey(name: 'featured_image')
  ImageDtoModel? get featuredImage => throw _privateConstructorUsedError;

  /// Serializes this OrderProductSummaryDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderProductSummaryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderProductSummaryDtoModelCopyWith<OrderProductSummaryDtoModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderProductSummaryDtoModelCopyWith<$Res> {
  factory $OrderProductSummaryDtoModelCopyWith(
    OrderProductSummaryDtoModel value,
    $Res Function(OrderProductSummaryDtoModel) then,
  ) =
      _$OrderProductSummaryDtoModelCopyWithImpl<
        $Res,
        OrderProductSummaryDtoModel
      >;
  @useResult
  $Res call({
    String id,
    String name,
    String sku,
    @JsonKey(name: 'featured_image') ImageDtoModel? featuredImage,
  });

  $ImageDtoModelCopyWith<$Res>? get featuredImage;
}

/// @nodoc
class _$OrderProductSummaryDtoModelCopyWithImpl<
  $Res,
  $Val extends OrderProductSummaryDtoModel
>
    implements $OrderProductSummaryDtoModelCopyWith<$Res> {
  _$OrderProductSummaryDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderProductSummaryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? sku = null,
    Object? featuredImage = freezed,
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
            featuredImage: freezed == featuredImage
                ? _value.featuredImage
                : featuredImage // ignore: cast_nullable_to_non_nullable
                      as ImageDtoModel?,
          )
          as $Val,
    );
  }

  /// Create a copy of OrderProductSummaryDtoModel
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
abstract class _$$OrderProductSummaryDtoModelImplCopyWith<$Res>
    implements $OrderProductSummaryDtoModelCopyWith<$Res> {
  factory _$$OrderProductSummaryDtoModelImplCopyWith(
    _$OrderProductSummaryDtoModelImpl value,
    $Res Function(_$OrderProductSummaryDtoModelImpl) then,
  ) = __$$OrderProductSummaryDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String sku,
    @JsonKey(name: 'featured_image') ImageDtoModel? featuredImage,
  });

  @override
  $ImageDtoModelCopyWith<$Res>? get featuredImage;
}

/// @nodoc
class __$$OrderProductSummaryDtoModelImplCopyWithImpl<$Res>
    extends
        _$OrderProductSummaryDtoModelCopyWithImpl<
          $Res,
          _$OrderProductSummaryDtoModelImpl
        >
    implements _$$OrderProductSummaryDtoModelImplCopyWith<$Res> {
  __$$OrderProductSummaryDtoModelImplCopyWithImpl(
    _$OrderProductSummaryDtoModelImpl _value,
    $Res Function(_$OrderProductSummaryDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderProductSummaryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? sku = null,
    Object? featuredImage = freezed,
  }) {
    return _then(
      _$OrderProductSummaryDtoModelImpl(
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
        featuredImage: freezed == featuredImage
            ? _value.featuredImage
            : featuredImage // ignore: cast_nullable_to_non_nullable
                  as ImageDtoModel?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderProductSummaryDtoModelImpl
    implements _OrderProductSummaryDtoModel {
  const _$OrderProductSummaryDtoModelImpl({
    required this.id,
    required this.name,
    required this.sku,
    @JsonKey(name: 'featured_image') this.featuredImage,
  });

  factory _$OrderProductSummaryDtoModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$OrderProductSummaryDtoModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String sku;
  @override
  @JsonKey(name: 'featured_image')
  final ImageDtoModel? featuredImage;

  @override
  String toString() {
    return 'OrderProductSummaryDtoModel(id: $id, name: $name, sku: $sku, featuredImage: $featuredImage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderProductSummaryDtoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.sku, sku) || other.sku == sku) &&
            (identical(other.featuredImage, featuredImage) ||
                other.featuredImage == featuredImage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, sku, featuredImage);

  /// Create a copy of OrderProductSummaryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderProductSummaryDtoModelImplCopyWith<_$OrderProductSummaryDtoModelImpl>
  get copyWith =>
      __$$OrderProductSummaryDtoModelImplCopyWithImpl<
        _$OrderProductSummaryDtoModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderProductSummaryDtoModelImplToJson(this);
  }
}

abstract class _OrderProductSummaryDtoModel
    implements OrderProductSummaryDtoModel {
  const factory _OrderProductSummaryDtoModel({
    required final String id,
    required final String name,
    required final String sku,
    @JsonKey(name: 'featured_image') final ImageDtoModel? featuredImage,
  }) = _$OrderProductSummaryDtoModelImpl;

  factory _OrderProductSummaryDtoModel.fromJson(Map<String, dynamic> json) =
      _$OrderProductSummaryDtoModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get sku;
  @override
  @JsonKey(name: 'featured_image')
  ImageDtoModel? get featuredImage;

  /// Create a copy of OrderProductSummaryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderProductSummaryDtoModelImplCopyWith<_$OrderProductSummaryDtoModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

OrderCreateRequest _$OrderCreateRequestFromJson(Map<String, dynamic> json) {
  return _OrderCreateRequest.fromJson(json);
}

/// @nodoc
mixin _$OrderCreateRequest {
  @JsonKey(name: 'customer')
  String get customerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'sub_plan')
  String get subPlanId => throw _privateConstructorUsedError;
  List<OrderLineRequest> get lines => throw _privateConstructorUsedError;
  List<OrderDocumentRequest> get documents =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'delivery_to_agent')
  bool get deliveryToAgent => throw _privateConstructorUsedError;

  /// Serializes this OrderCreateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderCreateRequestCopyWith<OrderCreateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderCreateRequestCopyWith<$Res> {
  factory $OrderCreateRequestCopyWith(
    OrderCreateRequest value,
    $Res Function(OrderCreateRequest) then,
  ) = _$OrderCreateRequestCopyWithImpl<$Res, OrderCreateRequest>;
  @useResult
  $Res call({
    @JsonKey(name: 'customer') String customerId,
    @JsonKey(name: 'sub_plan') String subPlanId,
    List<OrderLineRequest> lines,
    List<OrderDocumentRequest> documents,
    @JsonKey(name: 'delivery_to_agent') bool deliveryToAgent,
  });
}

/// @nodoc
class _$OrderCreateRequestCopyWithImpl<$Res, $Val extends OrderCreateRequest>
    implements $OrderCreateRequestCopyWith<$Res> {
  _$OrderCreateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerId = null,
    Object? subPlanId = null,
    Object? lines = null,
    Object? documents = null,
    Object? deliveryToAgent = null,
  }) {
    return _then(
      _value.copyWith(
            customerId: null == customerId
                ? _value.customerId
                : customerId // ignore: cast_nullable_to_non_nullable
                      as String,
            subPlanId: null == subPlanId
                ? _value.subPlanId
                : subPlanId // ignore: cast_nullable_to_non_nullable
                      as String,
            lines: null == lines
                ? _value.lines
                : lines // ignore: cast_nullable_to_non_nullable
                      as List<OrderLineRequest>,
            documents: null == documents
                ? _value.documents
                : documents // ignore: cast_nullable_to_non_nullable
                      as List<OrderDocumentRequest>,
            deliveryToAgent: null == deliveryToAgent
                ? _value.deliveryToAgent
                : deliveryToAgent // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderCreateRequestImplCopyWith<$Res>
    implements $OrderCreateRequestCopyWith<$Res> {
  factory _$$OrderCreateRequestImplCopyWith(
    _$OrderCreateRequestImpl value,
    $Res Function(_$OrderCreateRequestImpl) then,
  ) = __$$OrderCreateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'customer') String customerId,
    @JsonKey(name: 'sub_plan') String subPlanId,
    List<OrderLineRequest> lines,
    List<OrderDocumentRequest> documents,
    @JsonKey(name: 'delivery_to_agent') bool deliveryToAgent,
  });
}

/// @nodoc
class __$$OrderCreateRequestImplCopyWithImpl<$Res>
    extends _$OrderCreateRequestCopyWithImpl<$Res, _$OrderCreateRequestImpl>
    implements _$$OrderCreateRequestImplCopyWith<$Res> {
  __$$OrderCreateRequestImplCopyWithImpl(
    _$OrderCreateRequestImpl _value,
    $Res Function(_$OrderCreateRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerId = null,
    Object? subPlanId = null,
    Object? lines = null,
    Object? documents = null,
    Object? deliveryToAgent = null,
  }) {
    return _then(
      _$OrderCreateRequestImpl(
        customerId: null == customerId
            ? _value.customerId
            : customerId // ignore: cast_nullable_to_non_nullable
                  as String,
        subPlanId: null == subPlanId
            ? _value.subPlanId
            : subPlanId // ignore: cast_nullable_to_non_nullable
                  as String,
        lines: null == lines
            ? _value._lines
            : lines // ignore: cast_nullable_to_non_nullable
                  as List<OrderLineRequest>,
        documents: null == documents
            ? _value._documents
            : documents // ignore: cast_nullable_to_non_nullable
                  as List<OrderDocumentRequest>,
        deliveryToAgent: null == deliveryToAgent
            ? _value.deliveryToAgent
            : deliveryToAgent // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderCreateRequestImpl implements _OrderCreateRequest {
  const _$OrderCreateRequestImpl({
    @JsonKey(name: 'customer') required this.customerId,
    @JsonKey(name: 'sub_plan') required this.subPlanId,
    required final List<OrderLineRequest> lines,
    required final List<OrderDocumentRequest> documents,
    @JsonKey(name: 'delivery_to_agent') required this.deliveryToAgent,
  }) : _lines = lines,
       _documents = documents;

  factory _$OrderCreateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderCreateRequestImplFromJson(json);

  @override
  @JsonKey(name: 'customer')
  final String customerId;
  @override
  @JsonKey(name: 'sub_plan')
  final String subPlanId;
  final List<OrderLineRequest> _lines;
  @override
  List<OrderLineRequest> get lines {
    if (_lines is EqualUnmodifiableListView) return _lines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lines);
  }

  final List<OrderDocumentRequest> _documents;
  @override
  List<OrderDocumentRequest> get documents {
    if (_documents is EqualUnmodifiableListView) return _documents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_documents);
  }

  @override
  @JsonKey(name: 'delivery_to_agent')
  final bool deliveryToAgent;

  @override
  String toString() {
    return 'OrderCreateRequest(customerId: $customerId, subPlanId: $subPlanId, lines: $lines, documents: $documents, deliveryToAgent: $deliveryToAgent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderCreateRequestImpl &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.subPlanId, subPlanId) ||
                other.subPlanId == subPlanId) &&
            const DeepCollectionEquality().equals(other._lines, _lines) &&
            const DeepCollectionEquality().equals(
              other._documents,
              _documents,
            ) &&
            (identical(other.deliveryToAgent, deliveryToAgent) ||
                other.deliveryToAgent == deliveryToAgent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    customerId,
    subPlanId,
    const DeepCollectionEquality().hash(_lines),
    const DeepCollectionEquality().hash(_documents),
    deliveryToAgent,
  );

  /// Create a copy of OrderCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderCreateRequestImplCopyWith<_$OrderCreateRequestImpl> get copyWith =>
      __$$OrderCreateRequestImplCopyWithImpl<_$OrderCreateRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderCreateRequestImplToJson(this);
  }
}

abstract class _OrderCreateRequest implements OrderCreateRequest {
  const factory _OrderCreateRequest({
    @JsonKey(name: 'customer') required final String customerId,
    @JsonKey(name: 'sub_plan') required final String subPlanId,
    required final List<OrderLineRequest> lines,
    required final List<OrderDocumentRequest> documents,
    @JsonKey(name: 'delivery_to_agent') required final bool deliveryToAgent,
  }) = _$OrderCreateRequestImpl;

  factory _OrderCreateRequest.fromJson(Map<String, dynamic> json) =
      _$OrderCreateRequestImpl.fromJson;

  @override
  @JsonKey(name: 'customer')
  String get customerId;
  @override
  @JsonKey(name: 'sub_plan')
  String get subPlanId;
  @override
  List<OrderLineRequest> get lines;
  @override
  List<OrderDocumentRequest> get documents;
  @override
  @JsonKey(name: 'delivery_to_agent')
  bool get deliveryToAgent;

  /// Create a copy of OrderCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderCreateRequestImplCopyWith<_$OrderCreateRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderLineRequest _$OrderLineRequestFromJson(Map<String, dynamic> json) {
  return _OrderLineRequest.fromJson(json);
}

/// @nodoc
mixin _$OrderLineRequest {
  @JsonKey(name: 'product')
  String get productId => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;

  /// Serializes this OrderLineRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderLineRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderLineRequestCopyWith<OrderLineRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderLineRequestCopyWith<$Res> {
  factory $OrderLineRequestCopyWith(
    OrderLineRequest value,
    $Res Function(OrderLineRequest) then,
  ) = _$OrderLineRequestCopyWithImpl<$Res, OrderLineRequest>;
  @useResult
  $Res call({@JsonKey(name: 'product') String productId, int quantity});
}

/// @nodoc
class _$OrderLineRequestCopyWithImpl<$Res, $Val extends OrderLineRequest>
    implements $OrderLineRequestCopyWith<$Res> {
  _$OrderLineRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderLineRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? productId = null, Object? quantity = null}) {
    return _then(
      _value.copyWith(
            productId: null == productId
                ? _value.productId
                : productId // ignore: cast_nullable_to_non_nullable
                      as String,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderLineRequestImplCopyWith<$Res>
    implements $OrderLineRequestCopyWith<$Res> {
  factory _$$OrderLineRequestImplCopyWith(
    _$OrderLineRequestImpl value,
    $Res Function(_$OrderLineRequestImpl) then,
  ) = __$$OrderLineRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'product') String productId, int quantity});
}

/// @nodoc
class __$$OrderLineRequestImplCopyWithImpl<$Res>
    extends _$OrderLineRequestCopyWithImpl<$Res, _$OrderLineRequestImpl>
    implements _$$OrderLineRequestImplCopyWith<$Res> {
  __$$OrderLineRequestImplCopyWithImpl(
    _$OrderLineRequestImpl _value,
    $Res Function(_$OrderLineRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderLineRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? productId = null, Object? quantity = null}) {
    return _then(
      _$OrderLineRequestImpl(
        productId: null == productId
            ? _value.productId
            : productId // ignore: cast_nullable_to_non_nullable
                  as String,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderLineRequestImpl implements _OrderLineRequest {
  const _$OrderLineRequestImpl({
    @JsonKey(name: 'product') required this.productId,
    required this.quantity,
  });

  factory _$OrderLineRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderLineRequestImplFromJson(json);

  @override
  @JsonKey(name: 'product')
  final String productId;
  @override
  final int quantity;

  @override
  String toString() {
    return 'OrderLineRequest(productId: $productId, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderLineRequestImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, productId, quantity);

  /// Create a copy of OrderLineRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderLineRequestImplCopyWith<_$OrderLineRequestImpl> get copyWith =>
      __$$OrderLineRequestImplCopyWithImpl<_$OrderLineRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderLineRequestImplToJson(this);
  }
}

abstract class _OrderLineRequest implements OrderLineRequest {
  const factory _OrderLineRequest({
    @JsonKey(name: 'product') required final String productId,
    required final int quantity,
  }) = _$OrderLineRequestImpl;

  factory _OrderLineRequest.fromJson(Map<String, dynamic> json) =
      _$OrderLineRequestImpl.fromJson;

  @override
  @JsonKey(name: 'product')
  String get productId;
  @override
  int get quantity;

  /// Create a copy of OrderLineRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderLineRequestImplCopyWith<_$OrderLineRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderDocumentRequest _$OrderDocumentRequestFromJson(Map<String, dynamic> json) {
  return _OrderDocumentRequest.fromJson(json);
}

/// @nodoc
mixin _$OrderDocumentRequest {
  @JsonKey(name: 'document_type')
  String get documentType => throw _privateConstructorUsedError;
  @JsonKey(name: 'file')
  String get fileId => throw _privateConstructorUsedError;

  /// Serializes this OrderDocumentRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderDocumentRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderDocumentRequestCopyWith<OrderDocumentRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderDocumentRequestCopyWith<$Res> {
  factory $OrderDocumentRequestCopyWith(
    OrderDocumentRequest value,
    $Res Function(OrderDocumentRequest) then,
  ) = _$OrderDocumentRequestCopyWithImpl<$Res, OrderDocumentRequest>;
  @useResult
  $Res call({
    @JsonKey(name: 'document_type') String documentType,
    @JsonKey(name: 'file') String fileId,
  });
}

/// @nodoc
class _$OrderDocumentRequestCopyWithImpl<
  $Res,
  $Val extends OrderDocumentRequest
>
    implements $OrderDocumentRequestCopyWith<$Res> {
  _$OrderDocumentRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderDocumentRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? documentType = null, Object? fileId = null}) {
    return _then(
      _value.copyWith(
            documentType: null == documentType
                ? _value.documentType
                : documentType // ignore: cast_nullable_to_non_nullable
                      as String,
            fileId: null == fileId
                ? _value.fileId
                : fileId // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderDocumentRequestImplCopyWith<$Res>
    implements $OrderDocumentRequestCopyWith<$Res> {
  factory _$$OrderDocumentRequestImplCopyWith(
    _$OrderDocumentRequestImpl value,
    $Res Function(_$OrderDocumentRequestImpl) then,
  ) = __$$OrderDocumentRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'document_type') String documentType,
    @JsonKey(name: 'file') String fileId,
  });
}

/// @nodoc
class __$$OrderDocumentRequestImplCopyWithImpl<$Res>
    extends _$OrderDocumentRequestCopyWithImpl<$Res, _$OrderDocumentRequestImpl>
    implements _$$OrderDocumentRequestImplCopyWith<$Res> {
  __$$OrderDocumentRequestImplCopyWithImpl(
    _$OrderDocumentRequestImpl _value,
    $Res Function(_$OrderDocumentRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderDocumentRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? documentType = null, Object? fileId = null}) {
    return _then(
      _$OrderDocumentRequestImpl(
        documentType: null == documentType
            ? _value.documentType
            : documentType // ignore: cast_nullable_to_non_nullable
                  as String,
        fileId: null == fileId
            ? _value.fileId
            : fileId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderDocumentRequestImpl implements _OrderDocumentRequest {
  const _$OrderDocumentRequestImpl({
    @JsonKey(name: 'document_type') required this.documentType,
    @JsonKey(name: 'file') required this.fileId,
  });

  factory _$OrderDocumentRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderDocumentRequestImplFromJson(json);

  @override
  @JsonKey(name: 'document_type')
  final String documentType;
  @override
  @JsonKey(name: 'file')
  final String fileId;

  @override
  String toString() {
    return 'OrderDocumentRequest(documentType: $documentType, fileId: $fileId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderDocumentRequestImpl &&
            (identical(other.documentType, documentType) ||
                other.documentType == documentType) &&
            (identical(other.fileId, fileId) || other.fileId == fileId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, documentType, fileId);

  /// Create a copy of OrderDocumentRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderDocumentRequestImplCopyWith<_$OrderDocumentRequestImpl>
  get copyWith =>
      __$$OrderDocumentRequestImplCopyWithImpl<_$OrderDocumentRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderDocumentRequestImplToJson(this);
  }
}

abstract class _OrderDocumentRequest implements OrderDocumentRequest {
  const factory _OrderDocumentRequest({
    @JsonKey(name: 'document_type') required final String documentType,
    @JsonKey(name: 'file') required final String fileId,
  }) = _$OrderDocumentRequestImpl;

  factory _OrderDocumentRequest.fromJson(Map<String, dynamic> json) =
      _$OrderDocumentRequestImpl.fromJson;

  @override
  @JsonKey(name: 'document_type')
  String get documentType;
  @override
  @JsonKey(name: 'file')
  String get fileId;

  /// Create a copy of OrderDocumentRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderDocumentRequestImplCopyWith<_$OrderDocumentRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

OrderDocumentResponse _$OrderDocumentResponseFromJson(
  Map<String, dynamic> json,
) {
  return _OrderDocumentResponse.fromJson(json);
}

/// @nodoc
mixin _$OrderDocumentResponse {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'document_type')
  String get documentType => throw _privateConstructorUsedError;
  OrderFileDtoModel get file => throw _privateConstructorUsedError;
  @JsonKey(name: 'uploaded_by_id')
  String get uploadedById => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;

  /// Serializes this OrderDocumentResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderDocumentResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderDocumentResponseCopyWith<OrderDocumentResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderDocumentResponseCopyWith<$Res> {
  factory $OrderDocumentResponseCopyWith(
    OrderDocumentResponse value,
    $Res Function(OrderDocumentResponse) then,
  ) = _$OrderDocumentResponseCopyWithImpl<$Res, OrderDocumentResponse>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'document_type') String documentType,
    OrderFileDtoModel file,
    @JsonKey(name: 'uploaded_by_id') String uploadedById,
    @JsonKey(name: 'created_at') String createdAt,
  });

  $OrderFileDtoModelCopyWith<$Res> get file;
}

/// @nodoc
class _$OrderDocumentResponseCopyWithImpl<
  $Res,
  $Val extends OrderDocumentResponse
>
    implements $OrderDocumentResponseCopyWith<$Res> {
  _$OrderDocumentResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderDocumentResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? documentType = null,
    Object? file = null,
    Object? uploadedById = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            documentType: null == documentType
                ? _value.documentType
                : documentType // ignore: cast_nullable_to_non_nullable
                      as String,
            file: null == file
                ? _value.file
                : file // ignore: cast_nullable_to_non_nullable
                      as OrderFileDtoModel,
            uploadedById: null == uploadedById
                ? _value.uploadedById
                : uploadedById // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }

  /// Create a copy of OrderDocumentResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OrderFileDtoModelCopyWith<$Res> get file {
    return $OrderFileDtoModelCopyWith<$Res>(_value.file, (value) {
      return _then(_value.copyWith(file: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrderDocumentResponseImplCopyWith<$Res>
    implements $OrderDocumentResponseCopyWith<$Res> {
  factory _$$OrderDocumentResponseImplCopyWith(
    _$OrderDocumentResponseImpl value,
    $Res Function(_$OrderDocumentResponseImpl) then,
  ) = __$$OrderDocumentResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'document_type') String documentType,
    OrderFileDtoModel file,
    @JsonKey(name: 'uploaded_by_id') String uploadedById,
    @JsonKey(name: 'created_at') String createdAt,
  });

  @override
  $OrderFileDtoModelCopyWith<$Res> get file;
}

/// @nodoc
class __$$OrderDocumentResponseImplCopyWithImpl<$Res>
    extends
        _$OrderDocumentResponseCopyWithImpl<$Res, _$OrderDocumentResponseImpl>
    implements _$$OrderDocumentResponseImplCopyWith<$Res> {
  __$$OrderDocumentResponseImplCopyWithImpl(
    _$OrderDocumentResponseImpl _value,
    $Res Function(_$OrderDocumentResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderDocumentResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? documentType = null,
    Object? file = null,
    Object? uploadedById = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$OrderDocumentResponseImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        documentType: null == documentType
            ? _value.documentType
            : documentType // ignore: cast_nullable_to_non_nullable
                  as String,
        file: null == file
            ? _value.file
            : file // ignore: cast_nullable_to_non_nullable
                  as OrderFileDtoModel,
        uploadedById: null == uploadedById
            ? _value.uploadedById
            : uploadedById // ignore: cast_nullable_to_non_nullable
                  as String,
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
class _$OrderDocumentResponseImpl implements _OrderDocumentResponse {
  const _$OrderDocumentResponseImpl({
    required this.id,
    @JsonKey(name: 'document_type') required this.documentType,
    required this.file,
    @JsonKey(name: 'uploaded_by_id') required this.uploadedById,
    @JsonKey(name: 'created_at') required this.createdAt,
  });

  factory _$OrderDocumentResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderDocumentResponseImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'document_type')
  final String documentType;
  @override
  final OrderFileDtoModel file;
  @override
  @JsonKey(name: 'uploaded_by_id')
  final String uploadedById;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;

  @override
  String toString() {
    return 'OrderDocumentResponse(id: $id, documentType: $documentType, file: $file, uploadedById: $uploadedById, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderDocumentResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.documentType, documentType) ||
                other.documentType == documentType) &&
            (identical(other.file, file) || other.file == file) &&
            (identical(other.uploadedById, uploadedById) ||
                other.uploadedById == uploadedById) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, documentType, file, uploadedById, createdAt);

  /// Create a copy of OrderDocumentResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderDocumentResponseImplCopyWith<_$OrderDocumentResponseImpl>
  get copyWith =>
      __$$OrderDocumentResponseImplCopyWithImpl<_$OrderDocumentResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderDocumentResponseImplToJson(this);
  }
}

abstract class _OrderDocumentResponse implements OrderDocumentResponse {
  const factory _OrderDocumentResponse({
    required final String id,
    @JsonKey(name: 'document_type') required final String documentType,
    required final OrderFileDtoModel file,
    @JsonKey(name: 'uploaded_by_id') required final String uploadedById,
    @JsonKey(name: 'created_at') required final String createdAt,
  }) = _$OrderDocumentResponseImpl;

  factory _OrderDocumentResponse.fromJson(Map<String, dynamic> json) =
      _$OrderDocumentResponseImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'document_type')
  String get documentType;
  @override
  OrderFileDtoModel get file;
  @override
  @JsonKey(name: 'uploaded_by_id')
  String get uploadedById;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;

  /// Create a copy of OrderDocumentResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderDocumentResponseImplCopyWith<_$OrderDocumentResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

RemainingTimeDtoModel _$RemainingTimeDtoModelFromJson(
  Map<String, dynamic> json,
) {
  return _RemainingTimeDtoModel.fromJson(json);
}

/// @nodoc
mixin _$RemainingTimeDtoModel {
  int get days => throw _privateConstructorUsedError;
  int get hours => throw _privateConstructorUsedError;
  int get minutes => throw _privateConstructorUsedError;
  int get seconds => throw _privateConstructorUsedError;

  /// Serializes this RemainingTimeDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RemainingTimeDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RemainingTimeDtoModelCopyWith<RemainingTimeDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RemainingTimeDtoModelCopyWith<$Res> {
  factory $RemainingTimeDtoModelCopyWith(
    RemainingTimeDtoModel value,
    $Res Function(RemainingTimeDtoModel) then,
  ) = _$RemainingTimeDtoModelCopyWithImpl<$Res, RemainingTimeDtoModel>;
  @useResult
  $Res call({int days, int hours, int minutes, int seconds});
}

/// @nodoc
class _$RemainingTimeDtoModelCopyWithImpl<
  $Res,
  $Val extends RemainingTimeDtoModel
>
    implements $RemainingTimeDtoModelCopyWith<$Res> {
  _$RemainingTimeDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RemainingTimeDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? days = null,
    Object? hours = null,
    Object? minutes = null,
    Object? seconds = null,
  }) {
    return _then(
      _value.copyWith(
            days: null == days
                ? _value.days
                : days // ignore: cast_nullable_to_non_nullable
                      as int,
            hours: null == hours
                ? _value.hours
                : hours // ignore: cast_nullable_to_non_nullable
                      as int,
            minutes: null == minutes
                ? _value.minutes
                : minutes // ignore: cast_nullable_to_non_nullable
                      as int,
            seconds: null == seconds
                ? _value.seconds
                : seconds // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RemainingTimeDtoModelImplCopyWith<$Res>
    implements $RemainingTimeDtoModelCopyWith<$Res> {
  factory _$$RemainingTimeDtoModelImplCopyWith(
    _$RemainingTimeDtoModelImpl value,
    $Res Function(_$RemainingTimeDtoModelImpl) then,
  ) = __$$RemainingTimeDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int days, int hours, int minutes, int seconds});
}

/// @nodoc
class __$$RemainingTimeDtoModelImplCopyWithImpl<$Res>
    extends
        _$RemainingTimeDtoModelCopyWithImpl<$Res, _$RemainingTimeDtoModelImpl>
    implements _$$RemainingTimeDtoModelImplCopyWith<$Res> {
  __$$RemainingTimeDtoModelImplCopyWithImpl(
    _$RemainingTimeDtoModelImpl _value,
    $Res Function(_$RemainingTimeDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RemainingTimeDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? days = null,
    Object? hours = null,
    Object? minutes = null,
    Object? seconds = null,
  }) {
    return _then(
      _$RemainingTimeDtoModelImpl(
        days: null == days
            ? _value.days
            : days // ignore: cast_nullable_to_non_nullable
                  as int,
        hours: null == hours
            ? _value.hours
            : hours // ignore: cast_nullable_to_non_nullable
                  as int,
        minutes: null == minutes
            ? _value.minutes
            : minutes // ignore: cast_nullable_to_non_nullable
                  as int,
        seconds: null == seconds
            ? _value.seconds
            : seconds // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RemainingTimeDtoModelImpl implements _RemainingTimeDtoModel {
  const _$RemainingTimeDtoModelImpl({
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });

  factory _$RemainingTimeDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RemainingTimeDtoModelImplFromJson(json);

  @override
  final int days;
  @override
  final int hours;
  @override
  final int minutes;
  @override
  final int seconds;

  @override
  String toString() {
    return 'RemainingTimeDtoModel(days: $days, hours: $hours, minutes: $minutes, seconds: $seconds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemainingTimeDtoModelImpl &&
            (identical(other.days, days) || other.days == days) &&
            (identical(other.hours, hours) || other.hours == hours) &&
            (identical(other.minutes, minutes) || other.minutes == minutes) &&
            (identical(other.seconds, seconds) || other.seconds == seconds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, days, hours, minutes, seconds);

  /// Create a copy of RemainingTimeDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RemainingTimeDtoModelImplCopyWith<_$RemainingTimeDtoModelImpl>
  get copyWith =>
      __$$RemainingTimeDtoModelImplCopyWithImpl<_$RemainingTimeDtoModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RemainingTimeDtoModelImplToJson(this);
  }
}

abstract class _RemainingTimeDtoModel implements RemainingTimeDtoModel {
  const factory _RemainingTimeDtoModel({
    required final int days,
    required final int hours,
    required final int minutes,
    required final int seconds,
  }) = _$RemainingTimeDtoModelImpl;

  factory _RemainingTimeDtoModel.fromJson(Map<String, dynamic> json) =
      _$RemainingTimeDtoModelImpl.fromJson;

  @override
  int get days;
  @override
  int get hours;
  @override
  int get minutes;
  @override
  int get seconds;

  /// Create a copy of RemainingTimeDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RemainingTimeDtoModelImplCopyWith<_$RemainingTimeDtoModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
