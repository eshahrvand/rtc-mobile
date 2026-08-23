// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_dto_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TransactionResponseDtoModel _$TransactionResponseDtoModelFromJson(
  Map<String, dynamic> json,
) {
  return _TransactionResponseDtoModel.fromJson(json);
}

/// @nodoc
mixin _$TransactionResponseDtoModel {
  int get count => throw _privateConstructorUsedError;
  String? get next => throw _privateConstructorUsedError;
  String? get previous => throw _privateConstructorUsedError;
  List<TransactionDtoModel> get results => throw _privateConstructorUsedError;

  /// Serializes this TransactionResponseDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TransactionResponseDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionResponseDtoModelCopyWith<TransactionResponseDtoModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionResponseDtoModelCopyWith<$Res> {
  factory $TransactionResponseDtoModelCopyWith(
    TransactionResponseDtoModel value,
    $Res Function(TransactionResponseDtoModel) then,
  ) =
      _$TransactionResponseDtoModelCopyWithImpl<
        $Res,
        TransactionResponseDtoModel
      >;
  @useResult
  $Res call({
    int count,
    String? next,
    String? previous,
    List<TransactionDtoModel> results,
  });
}

/// @nodoc
class _$TransactionResponseDtoModelCopyWithImpl<
  $Res,
  $Val extends TransactionResponseDtoModel
>
    implements $TransactionResponseDtoModelCopyWith<$Res> {
  _$TransactionResponseDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionResponseDtoModel
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
                      as List<TransactionDtoModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TransactionResponseDtoModelImplCopyWith<$Res>
    implements $TransactionResponseDtoModelCopyWith<$Res> {
  factory _$$TransactionResponseDtoModelImplCopyWith(
    _$TransactionResponseDtoModelImpl value,
    $Res Function(_$TransactionResponseDtoModelImpl) then,
  ) = __$$TransactionResponseDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int count,
    String? next,
    String? previous,
    List<TransactionDtoModel> results,
  });
}

/// @nodoc
class __$$TransactionResponseDtoModelImplCopyWithImpl<$Res>
    extends
        _$TransactionResponseDtoModelCopyWithImpl<
          $Res,
          _$TransactionResponseDtoModelImpl
        >
    implements _$$TransactionResponseDtoModelImplCopyWith<$Res> {
  __$$TransactionResponseDtoModelImplCopyWithImpl(
    _$TransactionResponseDtoModelImpl _value,
    $Res Function(_$TransactionResponseDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransactionResponseDtoModel
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
      _$TransactionResponseDtoModelImpl(
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
                  as List<TransactionDtoModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionResponseDtoModelImpl
    implements _TransactionResponseDtoModel {
  const _$TransactionResponseDtoModelImpl({
    required this.count,
    this.next,
    this.previous,
    required final List<TransactionDtoModel> results,
  }) : _results = results;

  factory _$TransactionResponseDtoModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$TransactionResponseDtoModelImplFromJson(json);

  @override
  final int count;
  @override
  final String? next;
  @override
  final String? previous;
  final List<TransactionDtoModel> _results;
  @override
  List<TransactionDtoModel> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  String toString() {
    return 'TransactionResponseDtoModel(count: $count, next: $next, previous: $previous, results: $results)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionResponseDtoModelImpl &&
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

  /// Create a copy of TransactionResponseDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionResponseDtoModelImplCopyWith<_$TransactionResponseDtoModelImpl>
  get copyWith =>
      __$$TransactionResponseDtoModelImplCopyWithImpl<
        _$TransactionResponseDtoModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionResponseDtoModelImplToJson(this);
  }
}

abstract class _TransactionResponseDtoModel
    implements TransactionResponseDtoModel {
  const factory _TransactionResponseDtoModel({
    required final int count,
    final String? next,
    final String? previous,
    required final List<TransactionDtoModel> results,
  }) = _$TransactionResponseDtoModelImpl;

  factory _TransactionResponseDtoModel.fromJson(Map<String, dynamic> json) =
      _$TransactionResponseDtoModelImpl.fromJson;

  @override
  int get count;
  @override
  String? get next;
  @override
  String? get previous;
  @override
  List<TransactionDtoModel> get results;

  /// Create a copy of TransactionResponseDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionResponseDtoModelImplCopyWith<_$TransactionResponseDtoModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

TransactionDtoModel _$TransactionDtoModelFromJson(Map<String, dynamic> json) {
  return _TransactionDtoModel.fromJson(json);
}

/// @nodoc
mixin _$TransactionDtoModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_id')
  String? get orderId => throw _privateConstructorUsedError;
  String get amount => throw _privateConstructorUsedError;
  @JsonKey(name: 'transaction_type')
  String get transactionType => throw _privateConstructorUsedError;
  @JsonKey(name: 'sub_plan')
  WalletSubPlanDtoModel? get subPlan => throw _privateConstructorUsedError;
  CustomerShortDtoModel? get customer => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'pocket_balance_after')
  String? get pocketBalanceAfter => throw _privateConstructorUsedError;

  /// Serializes this TransactionDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TransactionDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionDtoModelCopyWith<TransactionDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionDtoModelCopyWith<$Res> {
  factory $TransactionDtoModelCopyWith(
    TransactionDtoModel value,
    $Res Function(TransactionDtoModel) then,
  ) = _$TransactionDtoModelCopyWithImpl<$Res, TransactionDtoModel>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'order_id') String? orderId,
    String amount,
    @JsonKey(name: 'transaction_type') String transactionType,
    @JsonKey(name: 'sub_plan') WalletSubPlanDtoModel? subPlan,
    CustomerShortDtoModel? customer,
    @JsonKey(name: 'created_at') String createdAt,
    @JsonKey(name: 'pocket_balance_after') String? pocketBalanceAfter,
  });

  $WalletSubPlanDtoModelCopyWith<$Res>? get subPlan;
  $CustomerShortDtoModelCopyWith<$Res>? get customer;
}

/// @nodoc
class _$TransactionDtoModelCopyWithImpl<$Res, $Val extends TransactionDtoModel>
    implements $TransactionDtoModelCopyWith<$Res> {
  _$TransactionDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderId = freezed,
    Object? amount = null,
    Object? transactionType = null,
    Object? subPlan = freezed,
    Object? customer = freezed,
    Object? createdAt = null,
    Object? pocketBalanceAfter = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            orderId: freezed == orderId
                ? _value.orderId
                : orderId // ignore: cast_nullable_to_non_nullable
                      as String?,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as String,
            transactionType: null == transactionType
                ? _value.transactionType
                : transactionType // ignore: cast_nullable_to_non_nullable
                      as String,
            subPlan: freezed == subPlan
                ? _value.subPlan
                : subPlan // ignore: cast_nullable_to_non_nullable
                      as WalletSubPlanDtoModel?,
            customer: freezed == customer
                ? _value.customer
                : customer // ignore: cast_nullable_to_non_nullable
                      as CustomerShortDtoModel?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
            pocketBalanceAfter: freezed == pocketBalanceAfter
                ? _value.pocketBalanceAfter
                : pocketBalanceAfter // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of TransactionDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WalletSubPlanDtoModelCopyWith<$Res>? get subPlan {
    if (_value.subPlan == null) {
      return null;
    }

    return $WalletSubPlanDtoModelCopyWith<$Res>(_value.subPlan!, (value) {
      return _then(_value.copyWith(subPlan: value) as $Val);
    });
  }

  /// Create a copy of TransactionDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomerShortDtoModelCopyWith<$Res>? get customer {
    if (_value.customer == null) {
      return null;
    }

    return $CustomerShortDtoModelCopyWith<$Res>(_value.customer!, (value) {
      return _then(_value.copyWith(customer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TransactionDtoModelImplCopyWith<$Res>
    implements $TransactionDtoModelCopyWith<$Res> {
  factory _$$TransactionDtoModelImplCopyWith(
    _$TransactionDtoModelImpl value,
    $Res Function(_$TransactionDtoModelImpl) then,
  ) = __$$TransactionDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'order_id') String? orderId,
    String amount,
    @JsonKey(name: 'transaction_type') String transactionType,
    @JsonKey(name: 'sub_plan') WalletSubPlanDtoModel? subPlan,
    CustomerShortDtoModel? customer,
    @JsonKey(name: 'created_at') String createdAt,
    @JsonKey(name: 'pocket_balance_after') String? pocketBalanceAfter,
  });

  @override
  $WalletSubPlanDtoModelCopyWith<$Res>? get subPlan;
  @override
  $CustomerShortDtoModelCopyWith<$Res>? get customer;
}

/// @nodoc
class __$$TransactionDtoModelImplCopyWithImpl<$Res>
    extends _$TransactionDtoModelCopyWithImpl<$Res, _$TransactionDtoModelImpl>
    implements _$$TransactionDtoModelImplCopyWith<$Res> {
  __$$TransactionDtoModelImplCopyWithImpl(
    _$TransactionDtoModelImpl _value,
    $Res Function(_$TransactionDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransactionDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderId = freezed,
    Object? amount = null,
    Object? transactionType = null,
    Object? subPlan = freezed,
    Object? customer = freezed,
    Object? createdAt = null,
    Object? pocketBalanceAfter = freezed,
  }) {
    return _then(
      _$TransactionDtoModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        orderId: freezed == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as String?,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as String,
        transactionType: null == transactionType
            ? _value.transactionType
            : transactionType // ignore: cast_nullable_to_non_nullable
                  as String,
        subPlan: freezed == subPlan
            ? _value.subPlan
            : subPlan // ignore: cast_nullable_to_non_nullable
                  as WalletSubPlanDtoModel?,
        customer: freezed == customer
            ? _value.customer
            : customer // ignore: cast_nullable_to_non_nullable
                  as CustomerShortDtoModel?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
        pocketBalanceAfter: freezed == pocketBalanceAfter
            ? _value.pocketBalanceAfter
            : pocketBalanceAfter // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionDtoModelImpl implements _TransactionDtoModel {
  const _$TransactionDtoModelImpl({
    required this.id,
    @JsonKey(name: 'order_id') this.orderId,
    required this.amount,
    @JsonKey(name: 'transaction_type') required this.transactionType,
    @JsonKey(name: 'sub_plan') this.subPlan,
    this.customer,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'pocket_balance_after') this.pocketBalanceAfter,
  });

  factory _$TransactionDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionDtoModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'order_id')
  final String? orderId;
  @override
  final String amount;
  @override
  @JsonKey(name: 'transaction_type')
  final String transactionType;
  @override
  @JsonKey(name: 'sub_plan')
  final WalletSubPlanDtoModel? subPlan;
  @override
  final CustomerShortDtoModel? customer;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;
  @override
  @JsonKey(name: 'pocket_balance_after')
  final String? pocketBalanceAfter;

  @override
  String toString() {
    return 'TransactionDtoModel(id: $id, orderId: $orderId, amount: $amount, transactionType: $transactionType, subPlan: $subPlan, customer: $customer, createdAt: $createdAt, pocketBalanceAfter: $pocketBalanceAfter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionDtoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.transactionType, transactionType) ||
                other.transactionType == transactionType) &&
            (identical(other.subPlan, subPlan) || other.subPlan == subPlan) &&
            (identical(other.customer, customer) ||
                other.customer == customer) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.pocketBalanceAfter, pocketBalanceAfter) ||
                other.pocketBalanceAfter == pocketBalanceAfter));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    orderId,
    amount,
    transactionType,
    subPlan,
    customer,
    createdAt,
    pocketBalanceAfter,
  );

  /// Create a copy of TransactionDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionDtoModelImplCopyWith<_$TransactionDtoModelImpl> get copyWith =>
      __$$TransactionDtoModelImplCopyWithImpl<_$TransactionDtoModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionDtoModelImplToJson(this);
  }
}

abstract class _TransactionDtoModel implements TransactionDtoModel {
  const factory _TransactionDtoModel({
    required final String id,
    @JsonKey(name: 'order_id') final String? orderId,
    required final String amount,
    @JsonKey(name: 'transaction_type') required final String transactionType,
    @JsonKey(name: 'sub_plan') final WalletSubPlanDtoModel? subPlan,
    final CustomerShortDtoModel? customer,
    @JsonKey(name: 'created_at') required final String createdAt,
    @JsonKey(name: 'pocket_balance_after') final String? pocketBalanceAfter,
  }) = _$TransactionDtoModelImpl;

  factory _TransactionDtoModel.fromJson(Map<String, dynamic> json) =
      _$TransactionDtoModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'order_id')
  String? get orderId;
  @override
  String get amount;
  @override
  @JsonKey(name: 'transaction_type')
  String get transactionType;
  @override
  @JsonKey(name: 'sub_plan')
  WalletSubPlanDtoModel? get subPlan;
  @override
  CustomerShortDtoModel? get customer;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;
  @override
  @JsonKey(name: 'pocket_balance_after')
  String? get pocketBalanceAfter;

  /// Create a copy of TransactionDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionDtoModelImplCopyWith<_$TransactionDtoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CustomerShortDtoModel _$CustomerShortDtoModelFromJson(
  Map<String, dynamic> json,
) {
  return _CustomerShortDtoModel.fromJson(json);
}

/// @nodoc
mixin _$CustomerShortDtoModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'first_name')
  String get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_name')
  String get lastName => throw _privateConstructorUsedError;

  /// Serializes this CustomerShortDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CustomerShortDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomerShortDtoModelCopyWith<CustomerShortDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerShortDtoModelCopyWith<$Res> {
  factory $CustomerShortDtoModelCopyWith(
    CustomerShortDtoModel value,
    $Res Function(CustomerShortDtoModel) then,
  ) = _$CustomerShortDtoModelCopyWithImpl<$Res, CustomerShortDtoModel>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'first_name') String firstName,
    @JsonKey(name: 'last_name') String lastName,
  });
}

/// @nodoc
class _$CustomerShortDtoModelCopyWithImpl<
  $Res,
  $Val extends CustomerShortDtoModel
>
    implements $CustomerShortDtoModelCopyWith<$Res> {
  _$CustomerShortDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomerShortDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            firstName: null == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String,
            lastName: null == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CustomerShortDtoModelImplCopyWith<$Res>
    implements $CustomerShortDtoModelCopyWith<$Res> {
  factory _$$CustomerShortDtoModelImplCopyWith(
    _$CustomerShortDtoModelImpl value,
    $Res Function(_$CustomerShortDtoModelImpl) then,
  ) = __$$CustomerShortDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'first_name') String firstName,
    @JsonKey(name: 'last_name') String lastName,
  });
}

/// @nodoc
class __$$CustomerShortDtoModelImplCopyWithImpl<$Res>
    extends
        _$CustomerShortDtoModelCopyWithImpl<$Res, _$CustomerShortDtoModelImpl>
    implements _$$CustomerShortDtoModelImplCopyWith<$Res> {
  __$$CustomerShortDtoModelImplCopyWithImpl(
    _$CustomerShortDtoModelImpl _value,
    $Res Function(_$CustomerShortDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CustomerShortDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
  }) {
    return _then(
      _$CustomerShortDtoModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        firstName: null == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String,
        lastName: null == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomerShortDtoModelImpl implements _CustomerShortDtoModel {
  const _$CustomerShortDtoModelImpl({
    required this.id,
    @JsonKey(name: 'first_name') required this.firstName,
    @JsonKey(name: 'last_name') required this.lastName,
  });

  factory _$CustomerShortDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerShortDtoModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'first_name')
  final String firstName;
  @override
  @JsonKey(name: 'last_name')
  final String lastName;

  @override
  String toString() {
    return 'CustomerShortDtoModel(id: $id, firstName: $firstName, lastName: $lastName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerShortDtoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, firstName, lastName);

  /// Create a copy of CustomerShortDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerShortDtoModelImplCopyWith<_$CustomerShortDtoModelImpl>
  get copyWith =>
      __$$CustomerShortDtoModelImplCopyWithImpl<_$CustomerShortDtoModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerShortDtoModelImplToJson(this);
  }
}

abstract class _CustomerShortDtoModel implements CustomerShortDtoModel {
  const factory _CustomerShortDtoModel({
    required final String id,
    @JsonKey(name: 'first_name') required final String firstName,
    @JsonKey(name: 'last_name') required final String lastName,
  }) = _$CustomerShortDtoModelImpl;

  factory _CustomerShortDtoModel.fromJson(Map<String, dynamic> json) =
      _$CustomerShortDtoModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'first_name')
  String get firstName;
  @override
  @JsonKey(name: 'last_name')
  String get lastName;

  /// Create a copy of CustomerShortDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomerShortDtoModelImplCopyWith<_$CustomerShortDtoModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
