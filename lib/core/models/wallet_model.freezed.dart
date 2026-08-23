// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WalletSummaryModel _$WalletSummaryModelFromJson(Map<String, dynamic> json) {
  return _WalletSummaryModel.fromJson(json);
}

/// @nodoc
mixin _$WalletSummaryModel {
  String get totalBalance => throw _privateConstructorUsedError;
  double get totalBalanceRaw => throw _privateConstructorUsedError;
  String get totalCredit => throw _privateConstructorUsedError;
  String get remainingCredit => throw _privateConstructorUsedError;
  List<PocketModel> get pockets => throw _privateConstructorUsedError;

  /// Serializes this WalletSummaryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WalletSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletSummaryModelCopyWith<WalletSummaryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletSummaryModelCopyWith<$Res> {
  factory $WalletSummaryModelCopyWith(
    WalletSummaryModel value,
    $Res Function(WalletSummaryModel) then,
  ) = _$WalletSummaryModelCopyWithImpl<$Res, WalletSummaryModel>;
  @useResult
  $Res call({
    String totalBalance,
    double totalBalanceRaw,
    String totalCredit,
    String remainingCredit,
    List<PocketModel> pockets,
  });
}

/// @nodoc
class _$WalletSummaryModelCopyWithImpl<$Res, $Val extends WalletSummaryModel>
    implements $WalletSummaryModelCopyWith<$Res> {
  _$WalletSummaryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalBalance = null,
    Object? totalBalanceRaw = null,
    Object? totalCredit = null,
    Object? remainingCredit = null,
    Object? pockets = null,
  }) {
    return _then(
      _value.copyWith(
            totalBalance: null == totalBalance
                ? _value.totalBalance
                : totalBalance // ignore: cast_nullable_to_non_nullable
                      as String,
            totalBalanceRaw: null == totalBalanceRaw
                ? _value.totalBalanceRaw
                : totalBalanceRaw // ignore: cast_nullable_to_non_nullable
                      as double,
            totalCredit: null == totalCredit
                ? _value.totalCredit
                : totalCredit // ignore: cast_nullable_to_non_nullable
                      as String,
            remainingCredit: null == remainingCredit
                ? _value.remainingCredit
                : remainingCredit // ignore: cast_nullable_to_non_nullable
                      as String,
            pockets: null == pockets
                ? _value.pockets
                : pockets // ignore: cast_nullable_to_non_nullable
                      as List<PocketModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WalletSummaryModelImplCopyWith<$Res>
    implements $WalletSummaryModelCopyWith<$Res> {
  factory _$$WalletSummaryModelImplCopyWith(
    _$WalletSummaryModelImpl value,
    $Res Function(_$WalletSummaryModelImpl) then,
  ) = __$$WalletSummaryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String totalBalance,
    double totalBalanceRaw,
    String totalCredit,
    String remainingCredit,
    List<PocketModel> pockets,
  });
}

/// @nodoc
class __$$WalletSummaryModelImplCopyWithImpl<$Res>
    extends _$WalletSummaryModelCopyWithImpl<$Res, _$WalletSummaryModelImpl>
    implements _$$WalletSummaryModelImplCopyWith<$Res> {
  __$$WalletSummaryModelImplCopyWithImpl(
    _$WalletSummaryModelImpl _value,
    $Res Function(_$WalletSummaryModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalBalance = null,
    Object? totalBalanceRaw = null,
    Object? totalCredit = null,
    Object? remainingCredit = null,
    Object? pockets = null,
  }) {
    return _then(
      _$WalletSummaryModelImpl(
        totalBalance: null == totalBalance
            ? _value.totalBalance
            : totalBalance // ignore: cast_nullable_to_non_nullable
                  as String,
        totalBalanceRaw: null == totalBalanceRaw
            ? _value.totalBalanceRaw
            : totalBalanceRaw // ignore: cast_nullable_to_non_nullable
                  as double,
        totalCredit: null == totalCredit
            ? _value.totalCredit
            : totalCredit // ignore: cast_nullable_to_non_nullable
                  as String,
        remainingCredit: null == remainingCredit
            ? _value.remainingCredit
            : remainingCredit // ignore: cast_nullable_to_non_nullable
                  as String,
        pockets: null == pockets
            ? _value._pockets
            : pockets // ignore: cast_nullable_to_non_nullable
                  as List<PocketModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WalletSummaryModelImpl implements _WalletSummaryModel {
  const _$WalletSummaryModelImpl({
    required this.totalBalance,
    this.totalBalanceRaw = 0.0,
    required this.totalCredit,
    required this.remainingCredit,
    required final List<PocketModel> pockets,
  }) : _pockets = pockets;

  factory _$WalletSummaryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WalletSummaryModelImplFromJson(json);

  @override
  final String totalBalance;
  @override
  @JsonKey()
  final double totalBalanceRaw;
  @override
  final String totalCredit;
  @override
  final String remainingCredit;
  final List<PocketModel> _pockets;
  @override
  List<PocketModel> get pockets {
    if (_pockets is EqualUnmodifiableListView) return _pockets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pockets);
  }

  @override
  String toString() {
    return 'WalletSummaryModel(totalBalance: $totalBalance, totalBalanceRaw: $totalBalanceRaw, totalCredit: $totalCredit, remainingCredit: $remainingCredit, pockets: $pockets)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletSummaryModelImpl &&
            (identical(other.totalBalance, totalBalance) ||
                other.totalBalance == totalBalance) &&
            (identical(other.totalBalanceRaw, totalBalanceRaw) ||
                other.totalBalanceRaw == totalBalanceRaw) &&
            (identical(other.totalCredit, totalCredit) ||
                other.totalCredit == totalCredit) &&
            (identical(other.remainingCredit, remainingCredit) ||
                other.remainingCredit == remainingCredit) &&
            const DeepCollectionEquality().equals(other._pockets, _pockets));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalBalance,
    totalBalanceRaw,
    totalCredit,
    remainingCredit,
    const DeepCollectionEquality().hash(_pockets),
  );

  /// Create a copy of WalletSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletSummaryModelImplCopyWith<_$WalletSummaryModelImpl> get copyWith =>
      __$$WalletSummaryModelImplCopyWithImpl<_$WalletSummaryModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WalletSummaryModelImplToJson(this);
  }
}

abstract class _WalletSummaryModel implements WalletSummaryModel {
  const factory _WalletSummaryModel({
    required final String totalBalance,
    final double totalBalanceRaw,
    required final String totalCredit,
    required final String remainingCredit,
    required final List<PocketModel> pockets,
  }) = _$WalletSummaryModelImpl;

  factory _WalletSummaryModel.fromJson(Map<String, dynamic> json) =
      _$WalletSummaryModelImpl.fromJson;

  @override
  String get totalBalance;
  @override
  double get totalBalanceRaw;
  @override
  String get totalCredit;
  @override
  String get remainingCredit;
  @override
  List<PocketModel> get pockets;

  /// Create a copy of WalletSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletSummaryModelImplCopyWith<_$WalletSummaryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PocketModel _$PocketModelFromJson(Map<String, dynamic> json) {
  return _PocketModel.fromJson(json);
}

/// @nodoc
mixin _$PocketModel {
  String get id => throw _privateConstructorUsedError;
  String get bankName => throw _privateConstructorUsedError;
  String get planName => throw _privateConstructorUsedError;
  String get balance => throw _privateConstructorUsedError;
  double get balanceRaw => throw _privateConstructorUsedError;
  String get logoPath => throw _privateConstructorUsedError;

  /// Serializes this PocketModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PocketModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PocketModelCopyWith<PocketModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PocketModelCopyWith<$Res> {
  factory $PocketModelCopyWith(
    PocketModel value,
    $Res Function(PocketModel) then,
  ) = _$PocketModelCopyWithImpl<$Res, PocketModel>;
  @useResult
  $Res call({
    String id,
    String bankName,
    String planName,
    String balance,
    double balanceRaw,
    String logoPath,
  });
}

/// @nodoc
class _$PocketModelCopyWithImpl<$Res, $Val extends PocketModel>
    implements $PocketModelCopyWith<$Res> {
  _$PocketModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PocketModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bankName = null,
    Object? planName = null,
    Object? balance = null,
    Object? balanceRaw = null,
    Object? logoPath = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            bankName: null == bankName
                ? _value.bankName
                : bankName // ignore: cast_nullable_to_non_nullable
                      as String,
            planName: null == planName
                ? _value.planName
                : planName // ignore: cast_nullable_to_non_nullable
                      as String,
            balance: null == balance
                ? _value.balance
                : balance // ignore: cast_nullable_to_non_nullable
                      as String,
            balanceRaw: null == balanceRaw
                ? _value.balanceRaw
                : balanceRaw // ignore: cast_nullable_to_non_nullable
                      as double,
            logoPath: null == logoPath
                ? _value.logoPath
                : logoPath // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PocketModelImplCopyWith<$Res>
    implements $PocketModelCopyWith<$Res> {
  factory _$$PocketModelImplCopyWith(
    _$PocketModelImpl value,
    $Res Function(_$PocketModelImpl) then,
  ) = __$$PocketModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String bankName,
    String planName,
    String balance,
    double balanceRaw,
    String logoPath,
  });
}

/// @nodoc
class __$$PocketModelImplCopyWithImpl<$Res>
    extends _$PocketModelCopyWithImpl<$Res, _$PocketModelImpl>
    implements _$$PocketModelImplCopyWith<$Res> {
  __$$PocketModelImplCopyWithImpl(
    _$PocketModelImpl _value,
    $Res Function(_$PocketModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PocketModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bankName = null,
    Object? planName = null,
    Object? balance = null,
    Object? balanceRaw = null,
    Object? logoPath = null,
  }) {
    return _then(
      _$PocketModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        bankName: null == bankName
            ? _value.bankName
            : bankName // ignore: cast_nullable_to_non_nullable
                  as String,
        planName: null == planName
            ? _value.planName
            : planName // ignore: cast_nullable_to_non_nullable
                  as String,
        balance: null == balance
            ? _value.balance
            : balance // ignore: cast_nullable_to_non_nullable
                  as String,
        balanceRaw: null == balanceRaw
            ? _value.balanceRaw
            : balanceRaw // ignore: cast_nullable_to_non_nullable
                  as double,
        logoPath: null == logoPath
            ? _value.logoPath
            : logoPath // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PocketModelImpl implements _PocketModel {
  const _$PocketModelImpl({
    required this.id,
    required this.bankName,
    required this.planName,
    required this.balance,
    this.balanceRaw = 0.0,
    required this.logoPath,
  });

  factory _$PocketModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PocketModelImplFromJson(json);

  @override
  final String id;
  @override
  final String bankName;
  @override
  final String planName;
  @override
  final String balance;
  @override
  @JsonKey()
  final double balanceRaw;
  @override
  final String logoPath;

  @override
  String toString() {
    return 'PocketModel(id: $id, bankName: $bankName, planName: $planName, balance: $balance, balanceRaw: $balanceRaw, logoPath: $logoPath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PocketModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.planName, planName) ||
                other.planName == planName) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.balanceRaw, balanceRaw) ||
                other.balanceRaw == balanceRaw) &&
            (identical(other.logoPath, logoPath) ||
                other.logoPath == logoPath));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    bankName,
    planName,
    balance,
    balanceRaw,
    logoPath,
  );

  /// Create a copy of PocketModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PocketModelImplCopyWith<_$PocketModelImpl> get copyWith =>
      __$$PocketModelImplCopyWithImpl<_$PocketModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PocketModelImplToJson(this);
  }
}

abstract class _PocketModel implements PocketModel {
  const factory _PocketModel({
    required final String id,
    required final String bankName,
    required final String planName,
    required final String balance,
    final double balanceRaw,
    required final String logoPath,
  }) = _$PocketModelImpl;

  factory _PocketModel.fromJson(Map<String, dynamic> json) =
      _$PocketModelImpl.fromJson;

  @override
  String get id;
  @override
  String get bankName;
  @override
  String get planName;
  @override
  String get balance;
  @override
  double get balanceRaw;
  @override
  String get logoPath;

  /// Create a copy of PocketModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PocketModelImplCopyWith<_$PocketModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) {
  return _TransactionModel.fromJson(json);
}

/// @nodoc
mixin _$TransactionModel {
  String get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get amount => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  String get time => throw _privateConstructorUsedError;
  bool get isCredit => throw _privateConstructorUsedError;
  String get fromAccount => throw _privateConstructorUsedError;
  String get toAccount => throw _privateConstructorUsedError;

  /// Serializes this TransactionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionModelCopyWith<TransactionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionModelCopyWith<$Res> {
  factory $TransactionModelCopyWith(
    TransactionModel value,
    $Res Function(TransactionModel) then,
  ) = _$TransactionModelCopyWithImpl<$Res, TransactionModel>;
  @useResult
  $Res call({
    String id,
    String type,
    String amount,
    String date,
    String time,
    bool isCredit,
    String fromAccount,
    String toAccount,
  });
}

/// @nodoc
class _$TransactionModelCopyWithImpl<$Res, $Val extends TransactionModel>
    implements $TransactionModelCopyWith<$Res> {
  _$TransactionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? amount = null,
    Object? date = null,
    Object? time = null,
    Object? isCredit = null,
    Object? fromAccount = null,
    Object? toAccount = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as String,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String,
            time: null == time
                ? _value.time
                : time // ignore: cast_nullable_to_non_nullable
                      as String,
            isCredit: null == isCredit
                ? _value.isCredit
                : isCredit // ignore: cast_nullable_to_non_nullable
                      as bool,
            fromAccount: null == fromAccount
                ? _value.fromAccount
                : fromAccount // ignore: cast_nullable_to_non_nullable
                      as String,
            toAccount: null == toAccount
                ? _value.toAccount
                : toAccount // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TransactionModelImplCopyWith<$Res>
    implements $TransactionModelCopyWith<$Res> {
  factory _$$TransactionModelImplCopyWith(
    _$TransactionModelImpl value,
    $Res Function(_$TransactionModelImpl) then,
  ) = __$$TransactionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String type,
    String amount,
    String date,
    String time,
    bool isCredit,
    String fromAccount,
    String toAccount,
  });
}

/// @nodoc
class __$$TransactionModelImplCopyWithImpl<$Res>
    extends _$TransactionModelCopyWithImpl<$Res, _$TransactionModelImpl>
    implements _$$TransactionModelImplCopyWith<$Res> {
  __$$TransactionModelImplCopyWithImpl(
    _$TransactionModelImpl _value,
    $Res Function(_$TransactionModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? amount = null,
    Object? date = null,
    Object? time = null,
    Object? isCredit = null,
    Object? fromAccount = null,
    Object? toAccount = null,
  }) {
    return _then(
      _$TransactionModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
        time: null == time
            ? _value.time
            : time // ignore: cast_nullable_to_non_nullable
                  as String,
        isCredit: null == isCredit
            ? _value.isCredit
            : isCredit // ignore: cast_nullable_to_non_nullable
                  as bool,
        fromAccount: null == fromAccount
            ? _value.fromAccount
            : fromAccount // ignore: cast_nullable_to_non_nullable
                  as String,
        toAccount: null == toAccount
            ? _value.toAccount
            : toAccount // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionModelImpl implements _TransactionModel {
  const _$TransactionModelImpl({
    required this.id,
    required this.type,
    required this.amount,
    required this.date,
    required this.time,
    required this.isCredit,
    required this.fromAccount,
    required this.toAccount,
  });

  factory _$TransactionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionModelImplFromJson(json);

  @override
  final String id;
  @override
  final String type;
  @override
  final String amount;
  @override
  final String date;
  @override
  final String time;
  @override
  final bool isCredit;
  @override
  final String fromAccount;
  @override
  final String toAccount;

  @override
  String toString() {
    return 'TransactionModel(id: $id, type: $type, amount: $amount, date: $date, time: $time, isCredit: $isCredit, fromAccount: $fromAccount, toAccount: $toAccount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.isCredit, isCredit) ||
                other.isCredit == isCredit) &&
            (identical(other.fromAccount, fromAccount) ||
                other.fromAccount == fromAccount) &&
            (identical(other.toAccount, toAccount) ||
                other.toAccount == toAccount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    amount,
    date,
    time,
    isCredit,
    fromAccount,
    toAccount,
  );

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionModelImplCopyWith<_$TransactionModelImpl> get copyWith =>
      __$$TransactionModelImplCopyWithImpl<_$TransactionModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionModelImplToJson(this);
  }
}

abstract class _TransactionModel implements TransactionModel {
  const factory _TransactionModel({
    required final String id,
    required final String type,
    required final String amount,
    required final String date,
    required final String time,
    required final bool isCredit,
    required final String fromAccount,
    required final String toAccount,
  }) = _$TransactionModelImpl;

  factory _TransactionModel.fromJson(Map<String, dynamic> json) =
      _$TransactionModelImpl.fromJson;

  @override
  String get id;
  @override
  String get type;
  @override
  String get amount;
  @override
  String get date;
  @override
  String get time;
  @override
  bool get isCredit;
  @override
  String get fromAccount;
  @override
  String get toAccount;

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionModelImplCopyWith<_$TransactionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
