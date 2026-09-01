// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_dto_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WalletDtoModel _$WalletDtoModelFromJson(Map<String, dynamic> json) {
  return _WalletDtoModel.fromJson(json);
}

/// @nodoc
mixin _$WalletDtoModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _parseStringToDouble)
  double get balance => throw _privateConstructorUsedError;
  @JsonKey(name: 'credit_limit', fromJson: _parseStringToDouble)
  double get creditLimit => throw _privateConstructorUsedError;
  @JsonKey(name: 'remaining_credit', fromJson: _parseStringToDouble)
  double get remainingCredit => throw _privateConstructorUsedError;
  List<PocketDtoModel> get pockets => throw _privateConstructorUsedError;

  /// Serializes this WalletDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WalletDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletDtoModelCopyWith<WalletDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletDtoModelCopyWith<$Res> {
  factory $WalletDtoModelCopyWith(
    WalletDtoModel value,
    $Res Function(WalletDtoModel) then,
  ) = _$WalletDtoModelCopyWithImpl<$Res, WalletDtoModel>;
  @useResult
  $Res call({
    String id,
    @JsonKey(fromJson: _parseStringToDouble) double balance,
    @JsonKey(name: 'credit_limit', fromJson: _parseStringToDouble)
    double creditLimit,
    @JsonKey(name: 'remaining_credit', fromJson: _parseStringToDouble)
    double remainingCredit,
    List<PocketDtoModel> pockets,
  });
}

/// @nodoc
class _$WalletDtoModelCopyWithImpl<$Res, $Val extends WalletDtoModel>
    implements $WalletDtoModelCopyWith<$Res> {
  _$WalletDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? balance = null,
    Object? creditLimit = null,
    Object? remainingCredit = null,
    Object? pockets = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            balance: null == balance
                ? _value.balance
                : balance // ignore: cast_nullable_to_non_nullable
                      as double,
            creditLimit: null == creditLimit
                ? _value.creditLimit
                : creditLimit // ignore: cast_nullable_to_non_nullable
                      as double,
            remainingCredit: null == remainingCredit
                ? _value.remainingCredit
                : remainingCredit // ignore: cast_nullable_to_non_nullable
                      as double,
            pockets: null == pockets
                ? _value.pockets
                : pockets // ignore: cast_nullable_to_non_nullable
                      as List<PocketDtoModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WalletDtoModelImplCopyWith<$Res>
    implements $WalletDtoModelCopyWith<$Res> {
  factory _$$WalletDtoModelImplCopyWith(
    _$WalletDtoModelImpl value,
    $Res Function(_$WalletDtoModelImpl) then,
  ) = __$$WalletDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(fromJson: _parseStringToDouble) double balance,
    @JsonKey(name: 'credit_limit', fromJson: _parseStringToDouble)
    double creditLimit,
    @JsonKey(name: 'remaining_credit', fromJson: _parseStringToDouble)
    double remainingCredit,
    List<PocketDtoModel> pockets,
  });
}

/// @nodoc
class __$$WalletDtoModelImplCopyWithImpl<$Res>
    extends _$WalletDtoModelCopyWithImpl<$Res, _$WalletDtoModelImpl>
    implements _$$WalletDtoModelImplCopyWith<$Res> {
  __$$WalletDtoModelImplCopyWithImpl(
    _$WalletDtoModelImpl _value,
    $Res Function(_$WalletDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? balance = null,
    Object? creditLimit = null,
    Object? remainingCredit = null,
    Object? pockets = null,
  }) {
    return _then(
      _$WalletDtoModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        balance: null == balance
            ? _value.balance
            : balance // ignore: cast_nullable_to_non_nullable
                  as double,
        creditLimit: null == creditLimit
            ? _value.creditLimit
            : creditLimit // ignore: cast_nullable_to_non_nullable
                  as double,
        remainingCredit: null == remainingCredit
            ? _value.remainingCredit
            : remainingCredit // ignore: cast_nullable_to_non_nullable
                  as double,
        pockets: null == pockets
            ? _value._pockets
            : pockets // ignore: cast_nullable_to_non_nullable
                  as List<PocketDtoModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WalletDtoModelImpl implements _WalletDtoModel {
  const _$WalletDtoModelImpl({
    required this.id,
    @JsonKey(fromJson: _parseStringToDouble) required this.balance,
    @JsonKey(name: 'credit_limit', fromJson: _parseStringToDouble)
    required this.creditLimit,
    @JsonKey(name: 'remaining_credit', fromJson: _parseStringToDouble)
    required this.remainingCredit,
    required final List<PocketDtoModel> pockets,
  }) : _pockets = pockets;

  factory _$WalletDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WalletDtoModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(fromJson: _parseStringToDouble)
  final double balance;
  @override
  @JsonKey(name: 'credit_limit', fromJson: _parseStringToDouble)
  final double creditLimit;
  @override
  @JsonKey(name: 'remaining_credit', fromJson: _parseStringToDouble)
  final double remainingCredit;
  final List<PocketDtoModel> _pockets;
  @override
  List<PocketDtoModel> get pockets {
    if (_pockets is EqualUnmodifiableListView) return _pockets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pockets);
  }

  @override
  String toString() {
    return 'WalletDtoModel(id: $id, balance: $balance, creditLimit: $creditLimit, remainingCredit: $remainingCredit, pockets: $pockets)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletDtoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.creditLimit, creditLimit) ||
                other.creditLimit == creditLimit) &&
            (identical(other.remainingCredit, remainingCredit) ||
                other.remainingCredit == remainingCredit) &&
            const DeepCollectionEquality().equals(other._pockets, _pockets));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    balance,
    creditLimit,
    remainingCredit,
    const DeepCollectionEquality().hash(_pockets),
  );

  /// Create a copy of WalletDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletDtoModelImplCopyWith<_$WalletDtoModelImpl> get copyWith =>
      __$$WalletDtoModelImplCopyWithImpl<_$WalletDtoModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WalletDtoModelImplToJson(this);
  }
}

abstract class _WalletDtoModel implements WalletDtoModel {
  const factory _WalletDtoModel({
    required final String id,
    @JsonKey(fromJson: _parseStringToDouble) required final double balance,
    @JsonKey(name: 'credit_limit', fromJson: _parseStringToDouble)
    required final double creditLimit,
    @JsonKey(name: 'remaining_credit', fromJson: _parseStringToDouble)
    required final double remainingCredit,
    required final List<PocketDtoModel> pockets,
  }) = _$WalletDtoModelImpl;

  factory _WalletDtoModel.fromJson(Map<String, dynamic> json) =
      _$WalletDtoModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(fromJson: _parseStringToDouble)
  double get balance;
  @override
  @JsonKey(name: 'credit_limit', fromJson: _parseStringToDouble)
  double get creditLimit;
  @override
  @JsonKey(name: 'remaining_credit', fromJson: _parseStringToDouble)
  double get remainingCredit;
  @override
  List<PocketDtoModel> get pockets;

  /// Create a copy of WalletDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletDtoModelImplCopyWith<_$WalletDtoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PocketDtoModel _$PocketDtoModelFromJson(Map<String, dynamic> json) {
  return _PocketDtoModel.fromJson(json);
}

/// @nodoc
mixin _$PocketDtoModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'sub_plan')
  WalletSubPlanDtoModel get subPlan => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _parseStringToDouble)
  double get balance => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;

  /// Serializes this PocketDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PocketDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PocketDtoModelCopyWith<PocketDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PocketDtoModelCopyWith<$Res> {
  factory $PocketDtoModelCopyWith(
    PocketDtoModel value,
    $Res Function(PocketDtoModel) then,
  ) = _$PocketDtoModelCopyWithImpl<$Res, PocketDtoModel>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'sub_plan') WalletSubPlanDtoModel subPlan,
    @JsonKey(fromJson: _parseStringToDouble) double balance,
    @JsonKey(name: 'created_at') String createdAt,
  });

  $WalletSubPlanDtoModelCopyWith<$Res> get subPlan;
}

/// @nodoc
class _$PocketDtoModelCopyWithImpl<$Res, $Val extends PocketDtoModel>
    implements $PocketDtoModelCopyWith<$Res> {
  _$PocketDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PocketDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? subPlan = null,
    Object? balance = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            subPlan: null == subPlan
                ? _value.subPlan
                : subPlan // ignore: cast_nullable_to_non_nullable
                      as WalletSubPlanDtoModel,
            balance: null == balance
                ? _value.balance
                : balance // ignore: cast_nullable_to_non_nullable
                      as double,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }

  /// Create a copy of PocketDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WalletSubPlanDtoModelCopyWith<$Res> get subPlan {
    return $WalletSubPlanDtoModelCopyWith<$Res>(_value.subPlan, (value) {
      return _then(_value.copyWith(subPlan: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PocketDtoModelImplCopyWith<$Res>
    implements $PocketDtoModelCopyWith<$Res> {
  factory _$$PocketDtoModelImplCopyWith(
    _$PocketDtoModelImpl value,
    $Res Function(_$PocketDtoModelImpl) then,
  ) = __$$PocketDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'sub_plan') WalletSubPlanDtoModel subPlan,
    @JsonKey(fromJson: _parseStringToDouble) double balance,
    @JsonKey(name: 'created_at') String createdAt,
  });

  @override
  $WalletSubPlanDtoModelCopyWith<$Res> get subPlan;
}

/// @nodoc
class __$$PocketDtoModelImplCopyWithImpl<$Res>
    extends _$PocketDtoModelCopyWithImpl<$Res, _$PocketDtoModelImpl>
    implements _$$PocketDtoModelImplCopyWith<$Res> {
  __$$PocketDtoModelImplCopyWithImpl(
    _$PocketDtoModelImpl _value,
    $Res Function(_$PocketDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PocketDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? subPlan = null,
    Object? balance = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$PocketDtoModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        subPlan: null == subPlan
            ? _value.subPlan
            : subPlan // ignore: cast_nullable_to_non_nullable
                  as WalletSubPlanDtoModel,
        balance: null == balance
            ? _value.balance
            : balance // ignore: cast_nullable_to_non_nullable
                  as double,
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
class _$PocketDtoModelImpl implements _PocketDtoModel {
  const _$PocketDtoModelImpl({
    required this.id,
    @JsonKey(name: 'sub_plan') required this.subPlan,
    @JsonKey(fromJson: _parseStringToDouble) required this.balance,
    @JsonKey(name: 'created_at') required this.createdAt,
  });

  factory _$PocketDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PocketDtoModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'sub_plan')
  final WalletSubPlanDtoModel subPlan;
  @override
  @JsonKey(fromJson: _parseStringToDouble)
  final double balance;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;

  @override
  String toString() {
    return 'PocketDtoModel(id: $id, subPlan: $subPlan, balance: $balance, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PocketDtoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.subPlan, subPlan) || other.subPlan == subPlan) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, subPlan, balance, createdAt);

  /// Create a copy of PocketDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PocketDtoModelImplCopyWith<_$PocketDtoModelImpl> get copyWith =>
      __$$PocketDtoModelImplCopyWithImpl<_$PocketDtoModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PocketDtoModelImplToJson(this);
  }
}

abstract class _PocketDtoModel implements PocketDtoModel {
  const factory _PocketDtoModel({
    required final String id,
    @JsonKey(name: 'sub_plan') required final WalletSubPlanDtoModel subPlan,
    @JsonKey(fromJson: _parseStringToDouble) required final double balance,
    @JsonKey(name: 'created_at') required final String createdAt,
  }) = _$PocketDtoModelImpl;

  factory _PocketDtoModel.fromJson(Map<String, dynamic> json) =
      _$PocketDtoModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'sub_plan')
  WalletSubPlanDtoModel get subPlan;
  @override
  @JsonKey(fromJson: _parseStringToDouble)
  double get balance;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;

  /// Create a copy of PocketDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PocketDtoModelImplCopyWith<_$PocketDtoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WalletSubPlanDtoModel _$WalletSubPlanDtoModelFromJson(
  Map<String, dynamic> json,
) {
  return _WalletSubPlanDtoModel.fromJson(json);
}

/// @nodoc
mixin _$WalletSubPlanDtoModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'repayment_duration_months')
  int get repaymentDurationMonths => throw _privateConstructorUsedError;
  @JsonKey(name: 'credit_plan')
  CreditPlanSummaryDtoModel? get creditPlan =>
      throw _privateConstructorUsedError;

  /// Serializes this WalletSubPlanDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WalletSubPlanDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletSubPlanDtoModelCopyWith<WalletSubPlanDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletSubPlanDtoModelCopyWith<$Res> {
  factory $WalletSubPlanDtoModelCopyWith(
    WalletSubPlanDtoModel value,
    $Res Function(WalletSubPlanDtoModel) then,
  ) = _$WalletSubPlanDtoModelCopyWithImpl<$Res, WalletSubPlanDtoModel>;
  @useResult
  $Res call({
    String id,
    String name,
    @JsonKey(name: 'repayment_duration_months') int repaymentDurationMonths,
    @JsonKey(name: 'credit_plan') CreditPlanSummaryDtoModel? creditPlan,
  });

  $CreditPlanSummaryDtoModelCopyWith<$Res>? get creditPlan;
}

/// @nodoc
class _$WalletSubPlanDtoModelCopyWithImpl<
  $Res,
  $Val extends WalletSubPlanDtoModel
>
    implements $WalletSubPlanDtoModelCopyWith<$Res> {
  _$WalletSubPlanDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletSubPlanDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? repaymentDurationMonths = null,
    Object? creditPlan = freezed,
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
            repaymentDurationMonths: null == repaymentDurationMonths
                ? _value.repaymentDurationMonths
                : repaymentDurationMonths // ignore: cast_nullable_to_non_nullable
                      as int,
            creditPlan: freezed == creditPlan
                ? _value.creditPlan
                : creditPlan // ignore: cast_nullable_to_non_nullable
                      as CreditPlanSummaryDtoModel?,
          )
          as $Val,
    );
  }

  /// Create a copy of WalletSubPlanDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CreditPlanSummaryDtoModelCopyWith<$Res>? get creditPlan {
    if (_value.creditPlan == null) {
      return null;
    }

    return $CreditPlanSummaryDtoModelCopyWith<$Res>(_value.creditPlan!, (
      value,
    ) {
      return _then(_value.copyWith(creditPlan: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WalletSubPlanDtoModelImplCopyWith<$Res>
    implements $WalletSubPlanDtoModelCopyWith<$Res> {
  factory _$$WalletSubPlanDtoModelImplCopyWith(
    _$WalletSubPlanDtoModelImpl value,
    $Res Function(_$WalletSubPlanDtoModelImpl) then,
  ) = __$$WalletSubPlanDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    @JsonKey(name: 'repayment_duration_months') int repaymentDurationMonths,
    @JsonKey(name: 'credit_plan') CreditPlanSummaryDtoModel? creditPlan,
  });

  @override
  $CreditPlanSummaryDtoModelCopyWith<$Res>? get creditPlan;
}

/// @nodoc
class __$$WalletSubPlanDtoModelImplCopyWithImpl<$Res>
    extends
        _$WalletSubPlanDtoModelCopyWithImpl<$Res, _$WalletSubPlanDtoModelImpl>
    implements _$$WalletSubPlanDtoModelImplCopyWith<$Res> {
  __$$WalletSubPlanDtoModelImplCopyWithImpl(
    _$WalletSubPlanDtoModelImpl _value,
    $Res Function(_$WalletSubPlanDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletSubPlanDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? repaymentDurationMonths = null,
    Object? creditPlan = freezed,
  }) {
    return _then(
      _$WalletSubPlanDtoModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        repaymentDurationMonths: null == repaymentDurationMonths
            ? _value.repaymentDurationMonths
            : repaymentDurationMonths // ignore: cast_nullable_to_non_nullable
                  as int,
        creditPlan: freezed == creditPlan
            ? _value.creditPlan
            : creditPlan // ignore: cast_nullable_to_non_nullable
                  as CreditPlanSummaryDtoModel?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WalletSubPlanDtoModelImpl implements _WalletSubPlanDtoModel {
  const _$WalletSubPlanDtoModelImpl({
    required this.id,
    required this.name,
    @JsonKey(name: 'repayment_duration_months')
    required this.repaymentDurationMonths,
    @JsonKey(name: 'credit_plan') this.creditPlan,
  });

  factory _$WalletSubPlanDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WalletSubPlanDtoModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey(name: 'repayment_duration_months')
  final int repaymentDurationMonths;
  @override
  @JsonKey(name: 'credit_plan')
  final CreditPlanSummaryDtoModel? creditPlan;

  @override
  String toString() {
    return 'WalletSubPlanDtoModel(id: $id, name: $name, repaymentDurationMonths: $repaymentDurationMonths, creditPlan: $creditPlan)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletSubPlanDtoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(
                  other.repaymentDurationMonths,
                  repaymentDurationMonths,
                ) ||
                other.repaymentDurationMonths == repaymentDurationMonths) &&
            (identical(other.creditPlan, creditPlan) ||
                other.creditPlan == creditPlan));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, repaymentDurationMonths, creditPlan);

  /// Create a copy of WalletSubPlanDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletSubPlanDtoModelImplCopyWith<_$WalletSubPlanDtoModelImpl>
  get copyWith =>
      __$$WalletSubPlanDtoModelImplCopyWithImpl<_$WalletSubPlanDtoModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WalletSubPlanDtoModelImplToJson(this);
  }
}

abstract class _WalletSubPlanDtoModel implements WalletSubPlanDtoModel {
  const factory _WalletSubPlanDtoModel({
    required final String id,
    required final String name,
    @JsonKey(name: 'repayment_duration_months')
    required final int repaymentDurationMonths,
    @JsonKey(name: 'credit_plan') final CreditPlanSummaryDtoModel? creditPlan,
  }) = _$WalletSubPlanDtoModelImpl;

  factory _WalletSubPlanDtoModel.fromJson(Map<String, dynamic> json) =
      _$WalletSubPlanDtoModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'repayment_duration_months')
  int get repaymentDurationMonths;
  @override
  @JsonKey(name: 'credit_plan')
  CreditPlanSummaryDtoModel? get creditPlan;

  /// Create a copy of WalletSubPlanDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletSubPlanDtoModelImplCopyWith<_$WalletSubPlanDtoModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
