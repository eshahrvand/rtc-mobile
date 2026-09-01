// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WalletState {
  WalletRequestStatus get status => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  WalletSummaryModel? get walletSummary => throw _privateConstructorUsedError;
  PocketModel? get selectedPocket => throw _privateConstructorUsedError;
  List<TransactionModel> get transactions => throw _privateConstructorUsedError;
  TransactionModel? get selectedTransaction =>
      throw _privateConstructorUsedError; // Filters
  String? get selectedDateFrom => throw _privateConstructorUsedError;
  String? get selectedDateTo => throw _privateConstructorUsedError;
  String? get selectedTransactionType => throw _privateConstructorUsedError;
  String? get selectedDateOptionId => throw _privateConstructorUsedError;

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletStateCopyWith<WalletState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletStateCopyWith<$Res> {
  factory $WalletStateCopyWith(
    WalletState value,
    $Res Function(WalletState) then,
  ) = _$WalletStateCopyWithImpl<$Res, WalletState>;
  @useResult
  $Res call({
    WalletRequestStatus status,
    String errorMessage,
    WalletSummaryModel? walletSummary,
    PocketModel? selectedPocket,
    List<TransactionModel> transactions,
    TransactionModel? selectedTransaction,
    String? selectedDateFrom,
    String? selectedDateTo,
    String? selectedTransactionType,
    String? selectedDateOptionId,
  });

  $WalletSummaryModelCopyWith<$Res>? get walletSummary;
  $PocketModelCopyWith<$Res>? get selectedPocket;
  $TransactionModelCopyWith<$Res>? get selectedTransaction;
}

/// @nodoc
class _$WalletStateCopyWithImpl<$Res, $Val extends WalletState>
    implements $WalletStateCopyWith<$Res> {
  _$WalletStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? errorMessage = null,
    Object? walletSummary = freezed,
    Object? selectedPocket = freezed,
    Object? transactions = null,
    Object? selectedTransaction = freezed,
    Object? selectedDateFrom = freezed,
    Object? selectedDateTo = freezed,
    Object? selectedTransactionType = freezed,
    Object? selectedDateOptionId = freezed,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as WalletRequestStatus,
            errorMessage: null == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String,
            walletSummary: freezed == walletSummary
                ? _value.walletSummary
                : walletSummary // ignore: cast_nullable_to_non_nullable
                      as WalletSummaryModel?,
            selectedPocket: freezed == selectedPocket
                ? _value.selectedPocket
                : selectedPocket // ignore: cast_nullable_to_non_nullable
                      as PocketModel?,
            transactions: null == transactions
                ? _value.transactions
                : transactions // ignore: cast_nullable_to_non_nullable
                      as List<TransactionModel>,
            selectedTransaction: freezed == selectedTransaction
                ? _value.selectedTransaction
                : selectedTransaction // ignore: cast_nullable_to_non_nullable
                      as TransactionModel?,
            selectedDateFrom: freezed == selectedDateFrom
                ? _value.selectedDateFrom
                : selectedDateFrom // ignore: cast_nullable_to_non_nullable
                      as String?,
            selectedDateTo: freezed == selectedDateTo
                ? _value.selectedDateTo
                : selectedDateTo // ignore: cast_nullable_to_non_nullable
                      as String?,
            selectedTransactionType: freezed == selectedTransactionType
                ? _value.selectedTransactionType
                : selectedTransactionType // ignore: cast_nullable_to_non_nullable
                      as String?,
            selectedDateOptionId: freezed == selectedDateOptionId
                ? _value.selectedDateOptionId
                : selectedDateOptionId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WalletSummaryModelCopyWith<$Res>? get walletSummary {
    if (_value.walletSummary == null) {
      return null;
    }

    return $WalletSummaryModelCopyWith<$Res>(_value.walletSummary!, (value) {
      return _then(_value.copyWith(walletSummary: value) as $Val);
    });
  }

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PocketModelCopyWith<$Res>? get selectedPocket {
    if (_value.selectedPocket == null) {
      return null;
    }

    return $PocketModelCopyWith<$Res>(_value.selectedPocket!, (value) {
      return _then(_value.copyWith(selectedPocket: value) as $Val);
    });
  }

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransactionModelCopyWith<$Res>? get selectedTransaction {
    if (_value.selectedTransaction == null) {
      return null;
    }

    return $TransactionModelCopyWith<$Res>(_value.selectedTransaction!, (
      value,
    ) {
      return _then(_value.copyWith(selectedTransaction: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WalletStateImplCopyWith<$Res>
    implements $WalletStateCopyWith<$Res> {
  factory _$$WalletStateImplCopyWith(
    _$WalletStateImpl value,
    $Res Function(_$WalletStateImpl) then,
  ) = __$$WalletStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    WalletRequestStatus status,
    String errorMessage,
    WalletSummaryModel? walletSummary,
    PocketModel? selectedPocket,
    List<TransactionModel> transactions,
    TransactionModel? selectedTransaction,
    String? selectedDateFrom,
    String? selectedDateTo,
    String? selectedTransactionType,
    String? selectedDateOptionId,
  });

  @override
  $WalletSummaryModelCopyWith<$Res>? get walletSummary;
  @override
  $PocketModelCopyWith<$Res>? get selectedPocket;
  @override
  $TransactionModelCopyWith<$Res>? get selectedTransaction;
}

/// @nodoc
class __$$WalletStateImplCopyWithImpl<$Res>
    extends _$WalletStateCopyWithImpl<$Res, _$WalletStateImpl>
    implements _$$WalletStateImplCopyWith<$Res> {
  __$$WalletStateImplCopyWithImpl(
    _$WalletStateImpl _value,
    $Res Function(_$WalletStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? errorMessage = null,
    Object? walletSummary = freezed,
    Object? selectedPocket = freezed,
    Object? transactions = null,
    Object? selectedTransaction = freezed,
    Object? selectedDateFrom = freezed,
    Object? selectedDateTo = freezed,
    Object? selectedTransactionType = freezed,
    Object? selectedDateOptionId = freezed,
  }) {
    return _then(
      _$WalletStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as WalletRequestStatus,
        errorMessage: null == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String,
        walletSummary: freezed == walletSummary
            ? _value.walletSummary
            : walletSummary // ignore: cast_nullable_to_non_nullable
                  as WalletSummaryModel?,
        selectedPocket: freezed == selectedPocket
            ? _value.selectedPocket
            : selectedPocket // ignore: cast_nullable_to_non_nullable
                  as PocketModel?,
        transactions: null == transactions
            ? _value._transactions
            : transactions // ignore: cast_nullable_to_non_nullable
                  as List<TransactionModel>,
        selectedTransaction: freezed == selectedTransaction
            ? _value.selectedTransaction
            : selectedTransaction // ignore: cast_nullable_to_non_nullable
                  as TransactionModel?,
        selectedDateFrom: freezed == selectedDateFrom
            ? _value.selectedDateFrom
            : selectedDateFrom // ignore: cast_nullable_to_non_nullable
                  as String?,
        selectedDateTo: freezed == selectedDateTo
            ? _value.selectedDateTo
            : selectedDateTo // ignore: cast_nullable_to_non_nullable
                  as String?,
        selectedTransactionType: freezed == selectedTransactionType
            ? _value.selectedTransactionType
            : selectedTransactionType // ignore: cast_nullable_to_non_nullable
                  as String?,
        selectedDateOptionId: freezed == selectedDateOptionId
            ? _value.selectedDateOptionId
            : selectedDateOptionId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$WalletStateImpl implements _WalletState {
  const _$WalletStateImpl({
    this.status = WalletRequestStatus.initial,
    this.errorMessage = '',
    this.walletSummary,
    this.selectedPocket,
    final List<TransactionModel> transactions = const [],
    this.selectedTransaction,
    this.selectedDateFrom,
    this.selectedDateTo,
    this.selectedTransactionType,
    this.selectedDateOptionId,
  }) : _transactions = transactions;

  @override
  @JsonKey()
  final WalletRequestStatus status;
  @override
  @JsonKey()
  final String errorMessage;
  @override
  final WalletSummaryModel? walletSummary;
  @override
  final PocketModel? selectedPocket;
  final List<TransactionModel> _transactions;
  @override
  @JsonKey()
  List<TransactionModel> get transactions {
    if (_transactions is EqualUnmodifiableListView) return _transactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transactions);
  }

  @override
  final TransactionModel? selectedTransaction;
  // Filters
  @override
  final String? selectedDateFrom;
  @override
  final String? selectedDateTo;
  @override
  final String? selectedTransactionType;
  @override
  final String? selectedDateOptionId;

  @override
  String toString() {
    return 'WalletState(status: $status, errorMessage: $errorMessage, walletSummary: $walletSummary, selectedPocket: $selectedPocket, transactions: $transactions, selectedTransaction: $selectedTransaction, selectedDateFrom: $selectedDateFrom, selectedDateTo: $selectedDateTo, selectedTransactionType: $selectedTransactionType, selectedDateOptionId: $selectedDateOptionId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.walletSummary, walletSummary) ||
                other.walletSummary == walletSummary) &&
            (identical(other.selectedPocket, selectedPocket) ||
                other.selectedPocket == selectedPocket) &&
            const DeepCollectionEquality().equals(
              other._transactions,
              _transactions,
            ) &&
            (identical(other.selectedTransaction, selectedTransaction) ||
                other.selectedTransaction == selectedTransaction) &&
            (identical(other.selectedDateFrom, selectedDateFrom) ||
                other.selectedDateFrom == selectedDateFrom) &&
            (identical(other.selectedDateTo, selectedDateTo) ||
                other.selectedDateTo == selectedDateTo) &&
            (identical(
                  other.selectedTransactionType,
                  selectedTransactionType,
                ) ||
                other.selectedTransactionType == selectedTransactionType) &&
            (identical(other.selectedDateOptionId, selectedDateOptionId) ||
                other.selectedDateOptionId == selectedDateOptionId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    errorMessage,
    walletSummary,
    selectedPocket,
    const DeepCollectionEquality().hash(_transactions),
    selectedTransaction,
    selectedDateFrom,
    selectedDateTo,
    selectedTransactionType,
    selectedDateOptionId,
  );

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletStateImplCopyWith<_$WalletStateImpl> get copyWith =>
      __$$WalletStateImplCopyWithImpl<_$WalletStateImpl>(this, _$identity);
}

abstract class _WalletState implements WalletState {
  const factory _WalletState({
    final WalletRequestStatus status,
    final String errorMessage,
    final WalletSummaryModel? walletSummary,
    final PocketModel? selectedPocket,
    final List<TransactionModel> transactions,
    final TransactionModel? selectedTransaction,
    final String? selectedDateFrom,
    final String? selectedDateTo,
    final String? selectedTransactionType,
    final String? selectedDateOptionId,
  }) = _$WalletStateImpl;

  @override
  WalletRequestStatus get status;
  @override
  String get errorMessage;
  @override
  WalletSummaryModel? get walletSummary;
  @override
  PocketModel? get selectedPocket;
  @override
  List<TransactionModel> get transactions;
  @override
  TransactionModel? get selectedTransaction; // Filters
  @override
  String? get selectedDateFrom;
  @override
  String? get selectedDateTo;
  @override
  String? get selectedTransactionType;
  @override
  String? get selectedDateOptionId;

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletStateImplCopyWith<_$WalletStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
