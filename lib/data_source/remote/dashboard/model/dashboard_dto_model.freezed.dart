// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_dto_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DashboardSummaryDtoModel _$DashboardSummaryDtoModelFromJson(
  Map<String, dynamic> json,
) {
  return _DashboardSummaryDtoModel.fromJson(json);
}

/// @nodoc
mixin _$DashboardSummaryDtoModel {
  @JsonKey(name: 'wallet_balance', fromJson: _parseStringToDouble)
  double get walletBalance => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_count')
  int get orderCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_count_delta')
  int get orderCountDelta => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_sales_amount')
  double get totalSalesAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_sales_delta_pct')
  double? get totalSalesDeltaPct => throw _privateConstructorUsedError;
  @JsonKey(name: 'active_orders')
  int get activeOrders => throw _privateConstructorUsedError;

  /// Serializes this DashboardSummaryDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DashboardSummaryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardSummaryDtoModelCopyWith<DashboardSummaryDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardSummaryDtoModelCopyWith<$Res> {
  factory $DashboardSummaryDtoModelCopyWith(
    DashboardSummaryDtoModel value,
    $Res Function(DashboardSummaryDtoModel) then,
  ) = _$DashboardSummaryDtoModelCopyWithImpl<$Res, DashboardSummaryDtoModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'wallet_balance', fromJson: _parseStringToDouble)
    double walletBalance,
    @JsonKey(name: 'order_count') int orderCount,
    @JsonKey(name: 'order_count_delta') int orderCountDelta,
    @JsonKey(name: 'total_sales_amount') double totalSalesAmount,
    @JsonKey(name: 'total_sales_delta_pct') double? totalSalesDeltaPct,
    @JsonKey(name: 'active_orders') int activeOrders,
  });
}

/// @nodoc
class _$DashboardSummaryDtoModelCopyWithImpl<
  $Res,
  $Val extends DashboardSummaryDtoModel
>
    implements $DashboardSummaryDtoModelCopyWith<$Res> {
  _$DashboardSummaryDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardSummaryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? walletBalance = null,
    Object? orderCount = null,
    Object? orderCountDelta = null,
    Object? totalSalesAmount = null,
    Object? totalSalesDeltaPct = freezed,
    Object? activeOrders = null,
  }) {
    return _then(
      _value.copyWith(
            walletBalance: null == walletBalance
                ? _value.walletBalance
                : walletBalance // ignore: cast_nullable_to_non_nullable
                      as double,
            orderCount: null == orderCount
                ? _value.orderCount
                : orderCount // ignore: cast_nullable_to_non_nullable
                      as int,
            orderCountDelta: null == orderCountDelta
                ? _value.orderCountDelta
                : orderCountDelta // ignore: cast_nullable_to_non_nullable
                      as int,
            totalSalesAmount: null == totalSalesAmount
                ? _value.totalSalesAmount
                : totalSalesAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            totalSalesDeltaPct: freezed == totalSalesDeltaPct
                ? _value.totalSalesDeltaPct
                : totalSalesDeltaPct // ignore: cast_nullable_to_non_nullable
                      as double?,
            activeOrders: null == activeOrders
                ? _value.activeOrders
                : activeOrders // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DashboardSummaryDtoModelImplCopyWith<$Res>
    implements $DashboardSummaryDtoModelCopyWith<$Res> {
  factory _$$DashboardSummaryDtoModelImplCopyWith(
    _$DashboardSummaryDtoModelImpl value,
    $Res Function(_$DashboardSummaryDtoModelImpl) then,
  ) = __$$DashboardSummaryDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'wallet_balance', fromJson: _parseStringToDouble)
    double walletBalance,
    @JsonKey(name: 'order_count') int orderCount,
    @JsonKey(name: 'order_count_delta') int orderCountDelta,
    @JsonKey(name: 'total_sales_amount') double totalSalesAmount,
    @JsonKey(name: 'total_sales_delta_pct') double? totalSalesDeltaPct,
    @JsonKey(name: 'active_orders') int activeOrders,
  });
}

/// @nodoc
class __$$DashboardSummaryDtoModelImplCopyWithImpl<$Res>
    extends
        _$DashboardSummaryDtoModelCopyWithImpl<
          $Res,
          _$DashboardSummaryDtoModelImpl
        >
    implements _$$DashboardSummaryDtoModelImplCopyWith<$Res> {
  __$$DashboardSummaryDtoModelImplCopyWithImpl(
    _$DashboardSummaryDtoModelImpl _value,
    $Res Function(_$DashboardSummaryDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DashboardSummaryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? walletBalance = null,
    Object? orderCount = null,
    Object? orderCountDelta = null,
    Object? totalSalesAmount = null,
    Object? totalSalesDeltaPct = freezed,
    Object? activeOrders = null,
  }) {
    return _then(
      _$DashboardSummaryDtoModelImpl(
        walletBalance: null == walletBalance
            ? _value.walletBalance
            : walletBalance // ignore: cast_nullable_to_non_nullable
                  as double,
        orderCount: null == orderCount
            ? _value.orderCount
            : orderCount // ignore: cast_nullable_to_non_nullable
                  as int,
        orderCountDelta: null == orderCountDelta
            ? _value.orderCountDelta
            : orderCountDelta // ignore: cast_nullable_to_non_nullable
                  as int,
        totalSalesAmount: null == totalSalesAmount
            ? _value.totalSalesAmount
            : totalSalesAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        totalSalesDeltaPct: freezed == totalSalesDeltaPct
            ? _value.totalSalesDeltaPct
            : totalSalesDeltaPct // ignore: cast_nullable_to_non_nullable
                  as double?,
        activeOrders: null == activeOrders
            ? _value.activeOrders
            : activeOrders // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardSummaryDtoModelImpl implements _DashboardSummaryDtoModel {
  const _$DashboardSummaryDtoModelImpl({
    @JsonKey(name: 'wallet_balance', fromJson: _parseStringToDouble)
    required this.walletBalance,
    @JsonKey(name: 'order_count') required this.orderCount,
    @JsonKey(name: 'order_count_delta') required this.orderCountDelta,
    @JsonKey(name: 'total_sales_amount') required this.totalSalesAmount,
    @JsonKey(name: 'total_sales_delta_pct') this.totalSalesDeltaPct,
    @JsonKey(name: 'active_orders') required this.activeOrders,
  });

  factory _$DashboardSummaryDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardSummaryDtoModelImplFromJson(json);

  @override
  @JsonKey(name: 'wallet_balance', fromJson: _parseStringToDouble)
  final double walletBalance;
  @override
  @JsonKey(name: 'order_count')
  final int orderCount;
  @override
  @JsonKey(name: 'order_count_delta')
  final int orderCountDelta;
  @override
  @JsonKey(name: 'total_sales_amount')
  final double totalSalesAmount;
  @override
  @JsonKey(name: 'total_sales_delta_pct')
  final double? totalSalesDeltaPct;
  @override
  @JsonKey(name: 'active_orders')
  final int activeOrders;

  @override
  String toString() {
    return 'DashboardSummaryDtoModel(walletBalance: $walletBalance, orderCount: $orderCount, orderCountDelta: $orderCountDelta, totalSalesAmount: $totalSalesAmount, totalSalesDeltaPct: $totalSalesDeltaPct, activeOrders: $activeOrders)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardSummaryDtoModelImpl &&
            (identical(other.walletBalance, walletBalance) ||
                other.walletBalance == walletBalance) &&
            (identical(other.orderCount, orderCount) ||
                other.orderCount == orderCount) &&
            (identical(other.orderCountDelta, orderCountDelta) ||
                other.orderCountDelta == orderCountDelta) &&
            (identical(other.totalSalesAmount, totalSalesAmount) ||
                other.totalSalesAmount == totalSalesAmount) &&
            (identical(other.totalSalesDeltaPct, totalSalesDeltaPct) ||
                other.totalSalesDeltaPct == totalSalesDeltaPct) &&
            (identical(other.activeOrders, activeOrders) ||
                other.activeOrders == activeOrders));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    walletBalance,
    orderCount,
    orderCountDelta,
    totalSalesAmount,
    totalSalesDeltaPct,
    activeOrders,
  );

  /// Create a copy of DashboardSummaryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardSummaryDtoModelImplCopyWith<_$DashboardSummaryDtoModelImpl>
  get copyWith =>
      __$$DashboardSummaryDtoModelImplCopyWithImpl<
        _$DashboardSummaryDtoModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardSummaryDtoModelImplToJson(this);
  }
}

abstract class _DashboardSummaryDtoModel implements DashboardSummaryDtoModel {
  const factory _DashboardSummaryDtoModel({
    @JsonKey(name: 'wallet_balance', fromJson: _parseStringToDouble)
    required final double walletBalance,
    @JsonKey(name: 'order_count') required final int orderCount,
    @JsonKey(name: 'order_count_delta') required final int orderCountDelta,
    @JsonKey(name: 'total_sales_amount') required final double totalSalesAmount,
    @JsonKey(name: 'total_sales_delta_pct') final double? totalSalesDeltaPct,
    @JsonKey(name: 'active_orders') required final int activeOrders,
  }) = _$DashboardSummaryDtoModelImpl;

  factory _DashboardSummaryDtoModel.fromJson(Map<String, dynamic> json) =
      _$DashboardSummaryDtoModelImpl.fromJson;

  @override
  @JsonKey(name: 'wallet_balance', fromJson: _parseStringToDouble)
  double get walletBalance;
  @override
  @JsonKey(name: 'order_count')
  int get orderCount;
  @override
  @JsonKey(name: 'order_count_delta')
  int get orderCountDelta;
  @override
  @JsonKey(name: 'total_sales_amount')
  double get totalSalesAmount;
  @override
  @JsonKey(name: 'total_sales_delta_pct')
  double? get totalSalesDeltaPct;
  @override
  @JsonKey(name: 'active_orders')
  int get activeOrders;

  /// Create a copy of DashboardSummaryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardSummaryDtoModelImplCopyWith<_$DashboardSummaryDtoModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

WalletStatusDtoModel _$WalletStatusDtoModelFromJson(Map<String, dynamic> json) {
  return _WalletStatusDtoModel.fromJson(json);
}

/// @nodoc
mixin _$WalletStatusDtoModel {
  String get bucket => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  double get percentage => throw _privateConstructorUsedError;

  /// Serializes this WalletStatusDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WalletStatusDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletStatusDtoModelCopyWith<WalletStatusDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletStatusDtoModelCopyWith<$Res> {
  factory $WalletStatusDtoModelCopyWith(
    WalletStatusDtoModel value,
    $Res Function(WalletStatusDtoModel) then,
  ) = _$WalletStatusDtoModelCopyWithImpl<$Res, WalletStatusDtoModel>;
  @useResult
  $Res call({String bucket, int count, double percentage});
}

/// @nodoc
class _$WalletStatusDtoModelCopyWithImpl<
  $Res,
  $Val extends WalletStatusDtoModel
>
    implements $WalletStatusDtoModelCopyWith<$Res> {
  _$WalletStatusDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletStatusDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bucket = null,
    Object? count = null,
    Object? percentage = null,
  }) {
    return _then(
      _value.copyWith(
            bucket: null == bucket
                ? _value.bucket
                : bucket // ignore: cast_nullable_to_non_nullable
                      as String,
            count: null == count
                ? _value.count
                : count // ignore: cast_nullable_to_non_nullable
                      as int,
            percentage: null == percentage
                ? _value.percentage
                : percentage // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WalletStatusDtoModelImplCopyWith<$Res>
    implements $WalletStatusDtoModelCopyWith<$Res> {
  factory _$$WalletStatusDtoModelImplCopyWith(
    _$WalletStatusDtoModelImpl value,
    $Res Function(_$WalletStatusDtoModelImpl) then,
  ) = __$$WalletStatusDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String bucket, int count, double percentage});
}

/// @nodoc
class __$$WalletStatusDtoModelImplCopyWithImpl<$Res>
    extends _$WalletStatusDtoModelCopyWithImpl<$Res, _$WalletStatusDtoModelImpl>
    implements _$$WalletStatusDtoModelImplCopyWith<$Res> {
  __$$WalletStatusDtoModelImplCopyWithImpl(
    _$WalletStatusDtoModelImpl _value,
    $Res Function(_$WalletStatusDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletStatusDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bucket = null,
    Object? count = null,
    Object? percentage = null,
  }) {
    return _then(
      _$WalletStatusDtoModelImpl(
        bucket: null == bucket
            ? _value.bucket
            : bucket // ignore: cast_nullable_to_non_nullable
                  as String,
        count: null == count
            ? _value.count
            : count // ignore: cast_nullable_to_non_nullable
                  as int,
        percentage: null == percentage
            ? _value.percentage
            : percentage // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WalletStatusDtoModelImpl implements _WalletStatusDtoModel {
  const _$WalletStatusDtoModelImpl({
    required this.bucket,
    required this.count,
    required this.percentage,
  });

  factory _$WalletStatusDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WalletStatusDtoModelImplFromJson(json);

  @override
  final String bucket;
  @override
  final int count;
  @override
  final double percentage;

  @override
  String toString() {
    return 'WalletStatusDtoModel(bucket: $bucket, count: $count, percentage: $percentage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletStatusDtoModelImpl &&
            (identical(other.bucket, bucket) || other.bucket == bucket) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, bucket, count, percentage);

  /// Create a copy of WalletStatusDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletStatusDtoModelImplCopyWith<_$WalletStatusDtoModelImpl>
  get copyWith =>
      __$$WalletStatusDtoModelImplCopyWithImpl<_$WalletStatusDtoModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WalletStatusDtoModelImplToJson(this);
  }
}

abstract class _WalletStatusDtoModel implements WalletStatusDtoModel {
  const factory _WalletStatusDtoModel({
    required final String bucket,
    required final int count,
    required final double percentage,
  }) = _$WalletStatusDtoModelImpl;

  factory _WalletStatusDtoModel.fromJson(Map<String, dynamic> json) =
      _$WalletStatusDtoModelImpl.fromJson;

  @override
  String get bucket;
  @override
  int get count;
  @override
  double get percentage;

  /// Create a copy of WalletStatusDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletStatusDtoModelImplCopyWith<_$WalletStatusDtoModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

DailyChartDtoModel _$DailyChartDtoModelFromJson(Map<String, dynamic> json) {
  return _DailyChartDtoModel.fromJson(json);
}

/// @nodoc
mixin _$DailyChartDtoModel {
  String get date => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_sales_amount')
  double get totalSalesAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'previous_total_sales_amount')
  double get previousTotalSalesAmount => throw _privateConstructorUsedError;

  /// Serializes this DailyChartDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyChartDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyChartDtoModelCopyWith<DailyChartDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyChartDtoModelCopyWith<$Res> {
  factory $DailyChartDtoModelCopyWith(
    DailyChartDtoModel value,
    $Res Function(DailyChartDtoModel) then,
  ) = _$DailyChartDtoModelCopyWithImpl<$Res, DailyChartDtoModel>;
  @useResult
  $Res call({
    String date,
    @JsonKey(name: 'total_sales_amount') double totalSalesAmount,
    @JsonKey(name: 'previous_total_sales_amount')
    double previousTotalSalesAmount,
  });
}

/// @nodoc
class _$DailyChartDtoModelCopyWithImpl<$Res, $Val extends DailyChartDtoModel>
    implements $DailyChartDtoModelCopyWith<$Res> {
  _$DailyChartDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyChartDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? totalSalesAmount = null,
    Object? previousTotalSalesAmount = null,
  }) {
    return _then(
      _value.copyWith(
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String,
            totalSalesAmount: null == totalSalesAmount
                ? _value.totalSalesAmount
                : totalSalesAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            previousTotalSalesAmount: null == previousTotalSalesAmount
                ? _value.previousTotalSalesAmount
                : previousTotalSalesAmount // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DailyChartDtoModelImplCopyWith<$Res>
    implements $DailyChartDtoModelCopyWith<$Res> {
  factory _$$DailyChartDtoModelImplCopyWith(
    _$DailyChartDtoModelImpl value,
    $Res Function(_$DailyChartDtoModelImpl) then,
  ) = __$$DailyChartDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String date,
    @JsonKey(name: 'total_sales_amount') double totalSalesAmount,
    @JsonKey(name: 'previous_total_sales_amount')
    double previousTotalSalesAmount,
  });
}

/// @nodoc
class __$$DailyChartDtoModelImplCopyWithImpl<$Res>
    extends _$DailyChartDtoModelCopyWithImpl<$Res, _$DailyChartDtoModelImpl>
    implements _$$DailyChartDtoModelImplCopyWith<$Res> {
  __$$DailyChartDtoModelImplCopyWithImpl(
    _$DailyChartDtoModelImpl _value,
    $Res Function(_$DailyChartDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DailyChartDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? totalSalesAmount = null,
    Object? previousTotalSalesAmount = null,
  }) {
    return _then(
      _$DailyChartDtoModelImpl(
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
        totalSalesAmount: null == totalSalesAmount
            ? _value.totalSalesAmount
            : totalSalesAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        previousTotalSalesAmount: null == previousTotalSalesAmount
            ? _value.previousTotalSalesAmount
            : previousTotalSalesAmount // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyChartDtoModelImpl implements _DailyChartDtoModel {
  const _$DailyChartDtoModelImpl({
    required this.date,
    @JsonKey(name: 'total_sales_amount') required this.totalSalesAmount,
    @JsonKey(name: 'previous_total_sales_amount')
    required this.previousTotalSalesAmount,
  });

  factory _$DailyChartDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyChartDtoModelImplFromJson(json);

  @override
  final String date;
  @override
  @JsonKey(name: 'total_sales_amount')
  final double totalSalesAmount;
  @override
  @JsonKey(name: 'previous_total_sales_amount')
  final double previousTotalSalesAmount;

  @override
  String toString() {
    return 'DailyChartDtoModel(date: $date, totalSalesAmount: $totalSalesAmount, previousTotalSalesAmount: $previousTotalSalesAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyChartDtoModelImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.totalSalesAmount, totalSalesAmount) ||
                other.totalSalesAmount == totalSalesAmount) &&
            (identical(
                  other.previousTotalSalesAmount,
                  previousTotalSalesAmount,
                ) ||
                other.previousTotalSalesAmount == previousTotalSalesAmount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    date,
    totalSalesAmount,
    previousTotalSalesAmount,
  );

  /// Create a copy of DailyChartDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyChartDtoModelImplCopyWith<_$DailyChartDtoModelImpl> get copyWith =>
      __$$DailyChartDtoModelImplCopyWithImpl<_$DailyChartDtoModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyChartDtoModelImplToJson(this);
  }
}

abstract class _DailyChartDtoModel implements DailyChartDtoModel {
  const factory _DailyChartDtoModel({
    required final String date,
    @JsonKey(name: 'total_sales_amount') required final double totalSalesAmount,
    @JsonKey(name: 'previous_total_sales_amount')
    required final double previousTotalSalesAmount,
  }) = _$DailyChartDtoModelImpl;

  factory _DailyChartDtoModel.fromJson(Map<String, dynamic> json) =
      _$DailyChartDtoModelImpl.fromJson;

  @override
  String get date;
  @override
  @JsonKey(name: 'total_sales_amount')
  double get totalSalesAmount;
  @override
  @JsonKey(name: 'previous_total_sales_amount')
  double get previousTotalSalesAmount;

  /// Create a copy of DailyChartDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyChartDtoModelImplCopyWith<_$DailyChartDtoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CategoryChartDtoModel _$CategoryChartDtoModelFromJson(
  Map<String, dynamic> json,
) {
  return _CategoryChartDtoModel.fromJson(json);
}

/// @nodoc
mixin _$CategoryChartDtoModel {
  @JsonKey(name: 'category_id')
  String get categoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_name')
  String get categoryName => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_orders')
  int get totalOrders => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_sales_amount')
  double get totalSalesAmount => throw _privateConstructorUsedError;
  double get percentage => throw _privateConstructorUsedError;

  /// Serializes this CategoryChartDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CategoryChartDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CategoryChartDtoModelCopyWith<CategoryChartDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryChartDtoModelCopyWith<$Res> {
  factory $CategoryChartDtoModelCopyWith(
    CategoryChartDtoModel value,
    $Res Function(CategoryChartDtoModel) then,
  ) = _$CategoryChartDtoModelCopyWithImpl<$Res, CategoryChartDtoModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'category_id') String categoryId,
    @JsonKey(name: 'category_name') String categoryName,
    @JsonKey(name: 'total_orders') int totalOrders,
    @JsonKey(name: 'total_sales_amount') double totalSalesAmount,
    double percentage,
  });
}

/// @nodoc
class _$CategoryChartDtoModelCopyWithImpl<
  $Res,
  $Val extends CategoryChartDtoModel
>
    implements $CategoryChartDtoModelCopyWith<$Res> {
  _$CategoryChartDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CategoryChartDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? categoryName = null,
    Object? totalOrders = null,
    Object? totalSalesAmount = null,
    Object? percentage = null,
  }) {
    return _then(
      _value.copyWith(
            categoryId: null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryName: null == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
                      as String,
            totalOrders: null == totalOrders
                ? _value.totalOrders
                : totalOrders // ignore: cast_nullable_to_non_nullable
                      as int,
            totalSalesAmount: null == totalSalesAmount
                ? _value.totalSalesAmount
                : totalSalesAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            percentage: null == percentage
                ? _value.percentage
                : percentage // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CategoryChartDtoModelImplCopyWith<$Res>
    implements $CategoryChartDtoModelCopyWith<$Res> {
  factory _$$CategoryChartDtoModelImplCopyWith(
    _$CategoryChartDtoModelImpl value,
    $Res Function(_$CategoryChartDtoModelImpl) then,
  ) = __$$CategoryChartDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'category_id') String categoryId,
    @JsonKey(name: 'category_name') String categoryName,
    @JsonKey(name: 'total_orders') int totalOrders,
    @JsonKey(name: 'total_sales_amount') double totalSalesAmount,
    double percentage,
  });
}

/// @nodoc
class __$$CategoryChartDtoModelImplCopyWithImpl<$Res>
    extends
        _$CategoryChartDtoModelCopyWithImpl<$Res, _$CategoryChartDtoModelImpl>
    implements _$$CategoryChartDtoModelImplCopyWith<$Res> {
  __$$CategoryChartDtoModelImplCopyWithImpl(
    _$CategoryChartDtoModelImpl _value,
    $Res Function(_$CategoryChartDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CategoryChartDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? categoryName = null,
    Object? totalOrders = null,
    Object? totalSalesAmount = null,
    Object? percentage = null,
  }) {
    return _then(
      _$CategoryChartDtoModelImpl(
        categoryId: null == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryName: null == categoryName
            ? _value.categoryName
            : categoryName // ignore: cast_nullable_to_non_nullable
                  as String,
        totalOrders: null == totalOrders
            ? _value.totalOrders
            : totalOrders // ignore: cast_nullable_to_non_nullable
                  as int,
        totalSalesAmount: null == totalSalesAmount
            ? _value.totalSalesAmount
            : totalSalesAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        percentage: null == percentage
            ? _value.percentage
            : percentage // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CategoryChartDtoModelImpl implements _CategoryChartDtoModel {
  const _$CategoryChartDtoModelImpl({
    @JsonKey(name: 'category_id') required this.categoryId,
    @JsonKey(name: 'category_name') required this.categoryName,
    @JsonKey(name: 'total_orders') required this.totalOrders,
    @JsonKey(name: 'total_sales_amount') required this.totalSalesAmount,
    required this.percentage,
  });

  factory _$CategoryChartDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CategoryChartDtoModelImplFromJson(json);

  @override
  @JsonKey(name: 'category_id')
  final String categoryId;
  @override
  @JsonKey(name: 'category_name')
  final String categoryName;
  @override
  @JsonKey(name: 'total_orders')
  final int totalOrders;
  @override
  @JsonKey(name: 'total_sales_amount')
  final double totalSalesAmount;
  @override
  final double percentage;

  @override
  String toString() {
    return 'CategoryChartDtoModel(categoryId: $categoryId, categoryName: $categoryName, totalOrders: $totalOrders, totalSalesAmount: $totalSalesAmount, percentage: $percentage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryChartDtoModelImpl &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.totalOrders, totalOrders) ||
                other.totalOrders == totalOrders) &&
            (identical(other.totalSalesAmount, totalSalesAmount) ||
                other.totalSalesAmount == totalSalesAmount) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    categoryId,
    categoryName,
    totalOrders,
    totalSalesAmount,
    percentage,
  );

  /// Create a copy of CategoryChartDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryChartDtoModelImplCopyWith<_$CategoryChartDtoModelImpl>
  get copyWith =>
      __$$CategoryChartDtoModelImplCopyWithImpl<_$CategoryChartDtoModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CategoryChartDtoModelImplToJson(this);
  }
}

abstract class _CategoryChartDtoModel implements CategoryChartDtoModel {
  const factory _CategoryChartDtoModel({
    @JsonKey(name: 'category_id') required final String categoryId,
    @JsonKey(name: 'category_name') required final String categoryName,
    @JsonKey(name: 'total_orders') required final int totalOrders,
    @JsonKey(name: 'total_sales_amount') required final double totalSalesAmount,
    required final double percentage,
  }) = _$CategoryChartDtoModelImpl;

  factory _CategoryChartDtoModel.fromJson(Map<String, dynamic> json) =
      _$CategoryChartDtoModelImpl.fromJson;

  @override
  @JsonKey(name: 'category_id')
  String get categoryId;
  @override
  @JsonKey(name: 'category_name')
  String get categoryName;
  @override
  @JsonKey(name: 'total_orders')
  int get totalOrders;
  @override
  @JsonKey(name: 'total_sales_amount')
  double get totalSalesAmount;
  @override
  double get percentage;

  /// Create a copy of CategoryChartDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategoryChartDtoModelImplCopyWith<_$CategoryChartDtoModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

OrderStatusDtoModel _$OrderStatusDtoModelFromJson(Map<String, dynamic> json) {
  return _OrderStatusDtoModel.fromJson(json);
}

/// @nodoc
mixin _$OrderStatusDtoModel {
  String get status => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;

  /// Serializes this OrderStatusDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderStatusDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderStatusDtoModelCopyWith<OrderStatusDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderStatusDtoModelCopyWith<$Res> {
  factory $OrderStatusDtoModelCopyWith(
    OrderStatusDtoModel value,
    $Res Function(OrderStatusDtoModel) then,
  ) = _$OrderStatusDtoModelCopyWithImpl<$Res, OrderStatusDtoModel>;
  @useResult
  $Res call({String status, int count});
}

/// @nodoc
class _$OrderStatusDtoModelCopyWithImpl<$Res, $Val extends OrderStatusDtoModel>
    implements $OrderStatusDtoModelCopyWith<$Res> {
  _$OrderStatusDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderStatusDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null, Object? count = null}) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            count: null == count
                ? _value.count
                : count // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderStatusDtoModelImplCopyWith<$Res>
    implements $OrderStatusDtoModelCopyWith<$Res> {
  factory _$$OrderStatusDtoModelImplCopyWith(
    _$OrderStatusDtoModelImpl value,
    $Res Function(_$OrderStatusDtoModelImpl) then,
  ) = __$$OrderStatusDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, int count});
}

/// @nodoc
class __$$OrderStatusDtoModelImplCopyWithImpl<$Res>
    extends _$OrderStatusDtoModelCopyWithImpl<$Res, _$OrderStatusDtoModelImpl>
    implements _$$OrderStatusDtoModelImplCopyWith<$Res> {
  __$$OrderStatusDtoModelImplCopyWithImpl(
    _$OrderStatusDtoModelImpl _value,
    $Res Function(_$OrderStatusDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderStatusDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null, Object? count = null}) {
    return _then(
      _$OrderStatusDtoModelImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        count: null == count
            ? _value.count
            : count // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderStatusDtoModelImpl extends _OrderStatusDtoModel {
  const _$OrderStatusDtoModelImpl({required this.status, required this.count})
    : super._();

  factory _$OrderStatusDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderStatusDtoModelImplFromJson(json);

  @override
  final String status;
  @override
  final int count;

  @override
  String toString() {
    return 'OrderStatusDtoModel(status: $status, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderStatusDtoModelImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, count);

  /// Create a copy of OrderStatusDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderStatusDtoModelImplCopyWith<_$OrderStatusDtoModelImpl> get copyWith =>
      __$$OrderStatusDtoModelImplCopyWithImpl<_$OrderStatusDtoModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderStatusDtoModelImplToJson(this);
  }
}

abstract class _OrderStatusDtoModel extends OrderStatusDtoModel {
  const factory _OrderStatusDtoModel({
    required final String status,
    required final int count,
  }) = _$OrderStatusDtoModelImpl;
  const _OrderStatusDtoModel._() : super._();

  factory _OrderStatusDtoModel.fromJson(Map<String, dynamic> json) =
      _$OrderStatusDtoModelImpl.fromJson;

  @override
  String get status;
  @override
  int get count;

  /// Create a copy of OrderStatusDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderStatusDtoModelImplCopyWith<_$OrderStatusDtoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SubPlanChartDtoModel _$SubPlanChartDtoModelFromJson(Map<String, dynamic> json) {
  return _SubPlanChartDtoModel.fromJson(json);
}

/// @nodoc
mixin _$SubPlanChartDtoModel {
  @JsonKey(name: 'sub_plan_id')
  String get subPlanId => throw _privateConstructorUsedError;
  @JsonKey(name: 'plan_name')
  String get planName => throw _privateConstructorUsedError;
  @JsonKey(name: 'sub_plan_name')
  String get subPlanName => throw _privateConstructorUsedError;
  @JsonKey(name: 'sub_plan_duration')
  int get subPlanDuration => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_count')
  int get orderCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_sales_amount')
  double get totalSalesAmount => throw _privateConstructorUsedError;

  /// Serializes this SubPlanChartDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubPlanChartDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubPlanChartDtoModelCopyWith<SubPlanChartDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubPlanChartDtoModelCopyWith<$Res> {
  factory $SubPlanChartDtoModelCopyWith(
    SubPlanChartDtoModel value,
    $Res Function(SubPlanChartDtoModel) then,
  ) = _$SubPlanChartDtoModelCopyWithImpl<$Res, SubPlanChartDtoModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'sub_plan_id') String subPlanId,
    @JsonKey(name: 'plan_name') String planName,
    @JsonKey(name: 'sub_plan_name') String subPlanName,
    @JsonKey(name: 'sub_plan_duration') int subPlanDuration,
    @JsonKey(name: 'order_count') int orderCount,
    @JsonKey(name: 'total_sales_amount') double totalSalesAmount,
  });
}

/// @nodoc
class _$SubPlanChartDtoModelCopyWithImpl<
  $Res,
  $Val extends SubPlanChartDtoModel
>
    implements $SubPlanChartDtoModelCopyWith<$Res> {
  _$SubPlanChartDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubPlanChartDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subPlanId = null,
    Object? planName = null,
    Object? subPlanName = null,
    Object? subPlanDuration = null,
    Object? orderCount = null,
    Object? totalSalesAmount = null,
  }) {
    return _then(
      _value.copyWith(
            subPlanId: null == subPlanId
                ? _value.subPlanId
                : subPlanId // ignore: cast_nullable_to_non_nullable
                      as String,
            planName: null == planName
                ? _value.planName
                : planName // ignore: cast_nullable_to_non_nullable
                      as String,
            subPlanName: null == subPlanName
                ? _value.subPlanName
                : subPlanName // ignore: cast_nullable_to_non_nullable
                      as String,
            subPlanDuration: null == subPlanDuration
                ? _value.subPlanDuration
                : subPlanDuration // ignore: cast_nullable_to_non_nullable
                      as int,
            orderCount: null == orderCount
                ? _value.orderCount
                : orderCount // ignore: cast_nullable_to_non_nullable
                      as int,
            totalSalesAmount: null == totalSalesAmount
                ? _value.totalSalesAmount
                : totalSalesAmount // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SubPlanChartDtoModelImplCopyWith<$Res>
    implements $SubPlanChartDtoModelCopyWith<$Res> {
  factory _$$SubPlanChartDtoModelImplCopyWith(
    _$SubPlanChartDtoModelImpl value,
    $Res Function(_$SubPlanChartDtoModelImpl) then,
  ) = __$$SubPlanChartDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'sub_plan_id') String subPlanId,
    @JsonKey(name: 'plan_name') String planName,
    @JsonKey(name: 'sub_plan_name') String subPlanName,
    @JsonKey(name: 'sub_plan_duration') int subPlanDuration,
    @JsonKey(name: 'order_count') int orderCount,
    @JsonKey(name: 'total_sales_amount') double totalSalesAmount,
  });
}

/// @nodoc
class __$$SubPlanChartDtoModelImplCopyWithImpl<$Res>
    extends _$SubPlanChartDtoModelCopyWithImpl<$Res, _$SubPlanChartDtoModelImpl>
    implements _$$SubPlanChartDtoModelImplCopyWith<$Res> {
  __$$SubPlanChartDtoModelImplCopyWithImpl(
    _$SubPlanChartDtoModelImpl _value,
    $Res Function(_$SubPlanChartDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubPlanChartDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subPlanId = null,
    Object? planName = null,
    Object? subPlanName = null,
    Object? subPlanDuration = null,
    Object? orderCount = null,
    Object? totalSalesAmount = null,
  }) {
    return _then(
      _$SubPlanChartDtoModelImpl(
        subPlanId: null == subPlanId
            ? _value.subPlanId
            : subPlanId // ignore: cast_nullable_to_non_nullable
                  as String,
        planName: null == planName
            ? _value.planName
            : planName // ignore: cast_nullable_to_non_nullable
                  as String,
        subPlanName: null == subPlanName
            ? _value.subPlanName
            : subPlanName // ignore: cast_nullable_to_non_nullable
                  as String,
        subPlanDuration: null == subPlanDuration
            ? _value.subPlanDuration
            : subPlanDuration // ignore: cast_nullable_to_non_nullable
                  as int,
        orderCount: null == orderCount
            ? _value.orderCount
            : orderCount // ignore: cast_nullable_to_non_nullable
                  as int,
        totalSalesAmount: null == totalSalesAmount
            ? _value.totalSalesAmount
            : totalSalesAmount // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SubPlanChartDtoModelImpl implements _SubPlanChartDtoModel {
  const _$SubPlanChartDtoModelImpl({
    @JsonKey(name: 'sub_plan_id') required this.subPlanId,
    @JsonKey(name: 'plan_name') required this.planName,
    @JsonKey(name: 'sub_plan_name') required this.subPlanName,
    @JsonKey(name: 'sub_plan_duration') required this.subPlanDuration,
    @JsonKey(name: 'order_count') required this.orderCount,
    @JsonKey(name: 'total_sales_amount') required this.totalSalesAmount,
  });

  factory _$SubPlanChartDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubPlanChartDtoModelImplFromJson(json);

  @override
  @JsonKey(name: 'sub_plan_id')
  final String subPlanId;
  @override
  @JsonKey(name: 'plan_name')
  final String planName;
  @override
  @JsonKey(name: 'sub_plan_name')
  final String subPlanName;
  @override
  @JsonKey(name: 'sub_plan_duration')
  final int subPlanDuration;
  @override
  @JsonKey(name: 'order_count')
  final int orderCount;
  @override
  @JsonKey(name: 'total_sales_amount')
  final double totalSalesAmount;

  @override
  String toString() {
    return 'SubPlanChartDtoModel(subPlanId: $subPlanId, planName: $planName, subPlanName: $subPlanName, subPlanDuration: $subPlanDuration, orderCount: $orderCount, totalSalesAmount: $totalSalesAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubPlanChartDtoModelImpl &&
            (identical(other.subPlanId, subPlanId) ||
                other.subPlanId == subPlanId) &&
            (identical(other.planName, planName) ||
                other.planName == planName) &&
            (identical(other.subPlanName, subPlanName) ||
                other.subPlanName == subPlanName) &&
            (identical(other.subPlanDuration, subPlanDuration) ||
                other.subPlanDuration == subPlanDuration) &&
            (identical(other.orderCount, orderCount) ||
                other.orderCount == orderCount) &&
            (identical(other.totalSalesAmount, totalSalesAmount) ||
                other.totalSalesAmount == totalSalesAmount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    subPlanId,
    planName,
    subPlanName,
    subPlanDuration,
    orderCount,
    totalSalesAmount,
  );

  /// Create a copy of SubPlanChartDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubPlanChartDtoModelImplCopyWith<_$SubPlanChartDtoModelImpl>
  get copyWith =>
      __$$SubPlanChartDtoModelImplCopyWithImpl<_$SubPlanChartDtoModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SubPlanChartDtoModelImplToJson(this);
  }
}

abstract class _SubPlanChartDtoModel implements SubPlanChartDtoModel {
  const factory _SubPlanChartDtoModel({
    @JsonKey(name: 'sub_plan_id') required final String subPlanId,
    @JsonKey(name: 'plan_name') required final String planName,
    @JsonKey(name: 'sub_plan_name') required final String subPlanName,
    @JsonKey(name: 'sub_plan_duration') required final int subPlanDuration,
    @JsonKey(name: 'order_count') required final int orderCount,
    @JsonKey(name: 'total_sales_amount') required final double totalSalesAmount,
  }) = _$SubPlanChartDtoModelImpl;

  factory _SubPlanChartDtoModel.fromJson(Map<String, dynamic> json) =
      _$SubPlanChartDtoModelImpl.fromJson;

  @override
  @JsonKey(name: 'sub_plan_id')
  String get subPlanId;
  @override
  @JsonKey(name: 'plan_name')
  String get planName;
  @override
  @JsonKey(name: 'sub_plan_name')
  String get subPlanName;
  @override
  @JsonKey(name: 'sub_plan_duration')
  int get subPlanDuration;
  @override
  @JsonKey(name: 'order_count')
  int get orderCount;
  @override
  @JsonKey(name: 'total_sales_amount')
  double get totalSalesAmount;

  /// Create a copy of SubPlanChartDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubPlanChartDtoModelImplCopyWith<_$SubPlanChartDtoModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

CommissionDtoModel _$CommissionDtoModelFromJson(Map<String, dynamic> json) {
  return _CommissionDtoModel.fromJson(json);
}

/// @nodoc
mixin _$CommissionDtoModel {
  @JsonKey(name: 'monthly_sales_total')
  double get monthlySalesTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'commission_rate_cash')
  int get commissionRateCash => throw _privateConstructorUsedError;
  @JsonKey(name: 'commission_rate_product')
  int get commissionRateProduct => throw _privateConstructorUsedError;
  @JsonKey(name: 'commission_amount_cash')
  double get commissionAmountCash => throw _privateConstructorUsedError;
  @JsonKey(name: 'commission_amount_product')
  double get commissionAmountProduct => throw _privateConstructorUsedError;
  @JsonKey(name: 'next_tier_rate_cash')
  int get nextTierRateCash => throw _privateConstructorUsedError;
  @JsonKey(name: 'next_tier_rate_product')
  int get nextTierRateProduct => throw _privateConstructorUsedError;
  @JsonKey(name: 'distance_to_next_tier')
  double get distanceToNextTier => throw _privateConstructorUsedError;

  /// Serializes this CommissionDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommissionDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommissionDtoModelCopyWith<CommissionDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommissionDtoModelCopyWith<$Res> {
  factory $CommissionDtoModelCopyWith(
    CommissionDtoModel value,
    $Res Function(CommissionDtoModel) then,
  ) = _$CommissionDtoModelCopyWithImpl<$Res, CommissionDtoModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'monthly_sales_total') double monthlySalesTotal,
    @JsonKey(name: 'commission_rate_cash') int commissionRateCash,
    @JsonKey(name: 'commission_rate_product') int commissionRateProduct,
    @JsonKey(name: 'commission_amount_cash') double commissionAmountCash,
    @JsonKey(name: 'commission_amount_product') double commissionAmountProduct,
    @JsonKey(name: 'next_tier_rate_cash') int nextTierRateCash,
    @JsonKey(name: 'next_tier_rate_product') int nextTierRateProduct,
    @JsonKey(name: 'distance_to_next_tier') double distanceToNextTier,
  });
}

/// @nodoc
class _$CommissionDtoModelCopyWithImpl<$Res, $Val extends CommissionDtoModel>
    implements $CommissionDtoModelCopyWith<$Res> {
  _$CommissionDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommissionDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
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
            monthlySalesTotal: null == monthlySalesTotal
                ? _value.monthlySalesTotal
                : monthlySalesTotal // ignore: cast_nullable_to_non_nullable
                      as double,
            commissionRateCash: null == commissionRateCash
                ? _value.commissionRateCash
                : commissionRateCash // ignore: cast_nullable_to_non_nullable
                      as int,
            commissionRateProduct: null == commissionRateProduct
                ? _value.commissionRateProduct
                : commissionRateProduct // ignore: cast_nullable_to_non_nullable
                      as int,
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
                      as int,
            nextTierRateProduct: null == nextTierRateProduct
                ? _value.nextTierRateProduct
                : nextTierRateProduct // ignore: cast_nullable_to_non_nullable
                      as int,
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
abstract class _$$CommissionDtoModelImplCopyWith<$Res>
    implements $CommissionDtoModelCopyWith<$Res> {
  factory _$$CommissionDtoModelImplCopyWith(
    _$CommissionDtoModelImpl value,
    $Res Function(_$CommissionDtoModelImpl) then,
  ) = __$$CommissionDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'monthly_sales_total') double monthlySalesTotal,
    @JsonKey(name: 'commission_rate_cash') int commissionRateCash,
    @JsonKey(name: 'commission_rate_product') int commissionRateProduct,
    @JsonKey(name: 'commission_amount_cash') double commissionAmountCash,
    @JsonKey(name: 'commission_amount_product') double commissionAmountProduct,
    @JsonKey(name: 'next_tier_rate_cash') int nextTierRateCash,
    @JsonKey(name: 'next_tier_rate_product') int nextTierRateProduct,
    @JsonKey(name: 'distance_to_next_tier') double distanceToNextTier,
  });
}

/// @nodoc
class __$$CommissionDtoModelImplCopyWithImpl<$Res>
    extends _$CommissionDtoModelCopyWithImpl<$Res, _$CommissionDtoModelImpl>
    implements _$$CommissionDtoModelImplCopyWith<$Res> {
  __$$CommissionDtoModelImplCopyWithImpl(
    _$CommissionDtoModelImpl _value,
    $Res Function(_$CommissionDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommissionDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
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
      _$CommissionDtoModelImpl(
        monthlySalesTotal: null == monthlySalesTotal
            ? _value.monthlySalesTotal
            : monthlySalesTotal // ignore: cast_nullable_to_non_nullable
                  as double,
        commissionRateCash: null == commissionRateCash
            ? _value.commissionRateCash
            : commissionRateCash // ignore: cast_nullable_to_non_nullable
                  as int,
        commissionRateProduct: null == commissionRateProduct
            ? _value.commissionRateProduct
            : commissionRateProduct // ignore: cast_nullable_to_non_nullable
                  as int,
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
                  as int,
        nextTierRateProduct: null == nextTierRateProduct
            ? _value.nextTierRateProduct
            : nextTierRateProduct // ignore: cast_nullable_to_non_nullable
                  as int,
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
class _$CommissionDtoModelImpl implements _CommissionDtoModel {
  const _$CommissionDtoModelImpl({
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

  factory _$CommissionDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommissionDtoModelImplFromJson(json);

  @override
  @JsonKey(name: 'monthly_sales_total')
  final double monthlySalesTotal;
  @override
  @JsonKey(name: 'commission_rate_cash')
  final int commissionRateCash;
  @override
  @JsonKey(name: 'commission_rate_product')
  final int commissionRateProduct;
  @override
  @JsonKey(name: 'commission_amount_cash')
  final double commissionAmountCash;
  @override
  @JsonKey(name: 'commission_amount_product')
  final double commissionAmountProduct;
  @override
  @JsonKey(name: 'next_tier_rate_cash')
  final int nextTierRateCash;
  @override
  @JsonKey(name: 'next_tier_rate_product')
  final int nextTierRateProduct;
  @override
  @JsonKey(name: 'distance_to_next_tier')
  final double distanceToNextTier;

  @override
  String toString() {
    return 'CommissionDtoModel(monthlySalesTotal: $monthlySalesTotal, commissionRateCash: $commissionRateCash, commissionRateProduct: $commissionRateProduct, commissionAmountCash: $commissionAmountCash, commissionAmountProduct: $commissionAmountProduct, nextTierRateCash: $nextTierRateCash, nextTierRateProduct: $nextTierRateProduct, distanceToNextTier: $distanceToNextTier)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommissionDtoModelImpl &&
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
    monthlySalesTotal,
    commissionRateCash,
    commissionRateProduct,
    commissionAmountCash,
    commissionAmountProduct,
    nextTierRateCash,
    nextTierRateProduct,
    distanceToNextTier,
  );

  /// Create a copy of CommissionDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommissionDtoModelImplCopyWith<_$CommissionDtoModelImpl> get copyWith =>
      __$$CommissionDtoModelImplCopyWithImpl<_$CommissionDtoModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CommissionDtoModelImplToJson(this);
  }
}

abstract class _CommissionDtoModel implements CommissionDtoModel {
  const factory _CommissionDtoModel({
    @JsonKey(name: 'monthly_sales_total')
    required final double monthlySalesTotal,
    @JsonKey(name: 'commission_rate_cash')
    required final int commissionRateCash,
    @JsonKey(name: 'commission_rate_product')
    required final int commissionRateProduct,
    @JsonKey(name: 'commission_amount_cash')
    required final double commissionAmountCash,
    @JsonKey(name: 'commission_amount_product')
    required final double commissionAmountProduct,
    @JsonKey(name: 'next_tier_rate_cash') required final int nextTierRateCash,
    @JsonKey(name: 'next_tier_rate_product')
    required final int nextTierRateProduct,
    @JsonKey(name: 'distance_to_next_tier')
    required final double distanceToNextTier,
  }) = _$CommissionDtoModelImpl;

  factory _CommissionDtoModel.fromJson(Map<String, dynamic> json) =
      _$CommissionDtoModelImpl.fromJson;

  @override
  @JsonKey(name: 'monthly_sales_total')
  double get monthlySalesTotal;
  @override
  @JsonKey(name: 'commission_rate_cash')
  int get commissionRateCash;
  @override
  @JsonKey(name: 'commission_rate_product')
  int get commissionRateProduct;
  @override
  @JsonKey(name: 'commission_amount_cash')
  double get commissionAmountCash;
  @override
  @JsonKey(name: 'commission_amount_product')
  double get commissionAmountProduct;
  @override
  @JsonKey(name: 'next_tier_rate_cash')
  int get nextTierRateCash;
  @override
  @JsonKey(name: 'next_tier_rate_product')
  int get nextTierRateProduct;
  @override
  @JsonKey(name: 'distance_to_next_tier')
  double get distanceToNextTier;

  /// Create a copy of CommissionDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommissionDtoModelImplCopyWith<_$CommissionDtoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
