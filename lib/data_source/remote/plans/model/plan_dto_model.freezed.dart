// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan_dto_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SubPlanListResponse _$SubPlanListResponseFromJson(Map<String, dynamic> json) {
  return _SubPlanListResponse.fromJson(json);
}

/// @nodoc
mixin _$SubPlanListResponse {
  int get count => throw _privateConstructorUsedError;
  String? get next => throw _privateConstructorUsedError;
  String? get previous => throw _privateConstructorUsedError;
  List<SubPlanDtoModel> get results => throw _privateConstructorUsedError;

  /// Serializes this SubPlanListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubPlanListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubPlanListResponseCopyWith<SubPlanListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubPlanListResponseCopyWith<$Res> {
  factory $SubPlanListResponseCopyWith(
    SubPlanListResponse value,
    $Res Function(SubPlanListResponse) then,
  ) = _$SubPlanListResponseCopyWithImpl<$Res, SubPlanListResponse>;
  @useResult
  $Res call({
    int count,
    String? next,
    String? previous,
    List<SubPlanDtoModel> results,
  });
}

/// @nodoc
class _$SubPlanListResponseCopyWithImpl<$Res, $Val extends SubPlanListResponse>
    implements $SubPlanListResponseCopyWith<$Res> {
  _$SubPlanListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubPlanListResponse
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
                      as List<SubPlanDtoModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SubPlanListResponseImplCopyWith<$Res>
    implements $SubPlanListResponseCopyWith<$Res> {
  factory _$$SubPlanListResponseImplCopyWith(
    _$SubPlanListResponseImpl value,
    $Res Function(_$SubPlanListResponseImpl) then,
  ) = __$$SubPlanListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int count,
    String? next,
    String? previous,
    List<SubPlanDtoModel> results,
  });
}

/// @nodoc
class __$$SubPlanListResponseImplCopyWithImpl<$Res>
    extends _$SubPlanListResponseCopyWithImpl<$Res, _$SubPlanListResponseImpl>
    implements _$$SubPlanListResponseImplCopyWith<$Res> {
  __$$SubPlanListResponseImplCopyWithImpl(
    _$SubPlanListResponseImpl _value,
    $Res Function(_$SubPlanListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubPlanListResponse
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
      _$SubPlanListResponseImpl(
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
                  as List<SubPlanDtoModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SubPlanListResponseImpl implements _SubPlanListResponse {
  const _$SubPlanListResponseImpl({
    required this.count,
    this.next,
    this.previous,
    required final List<SubPlanDtoModel> results,
  }) : _results = results;

  factory _$SubPlanListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubPlanListResponseImplFromJson(json);

  @override
  final int count;
  @override
  final String? next;
  @override
  final String? previous;
  final List<SubPlanDtoModel> _results;
  @override
  List<SubPlanDtoModel> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  String toString() {
    return 'SubPlanListResponse(count: $count, next: $next, previous: $previous, results: $results)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubPlanListResponseImpl &&
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

  /// Create a copy of SubPlanListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubPlanListResponseImplCopyWith<_$SubPlanListResponseImpl> get copyWith =>
      __$$SubPlanListResponseImplCopyWithImpl<_$SubPlanListResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SubPlanListResponseImplToJson(this);
  }
}

abstract class _SubPlanListResponse implements SubPlanListResponse {
  const factory _SubPlanListResponse({
    required final int count,
    final String? next,
    final String? previous,
    required final List<SubPlanDtoModel> results,
  }) = _$SubPlanListResponseImpl;

  factory _SubPlanListResponse.fromJson(Map<String, dynamic> json) =
      _$SubPlanListResponseImpl.fromJson;

  @override
  int get count;
  @override
  String? get next;
  @override
  String? get previous;
  @override
  List<SubPlanDtoModel> get results;

  /// Create a copy of SubPlanListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubPlanListResponseImplCopyWith<_$SubPlanListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SubPlanDtoModel _$SubPlanDtoModelFromJson(Map<String, dynamic> json) {
  return _SubPlanDtoModel.fromJson(json);
}

/// @nodoc
mixin _$SubPlanDtoModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'credit_plan')
  CreditPlanSummaryDtoModel get creditPlan =>
      throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'repayment_duration_months')
  int get repaymentDurationMonths => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this SubPlanDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubPlanDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubPlanDtoModelCopyWith<SubPlanDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubPlanDtoModelCopyWith<$Res> {
  factory $SubPlanDtoModelCopyWith(
    SubPlanDtoModel value,
    $Res Function(SubPlanDtoModel) then,
  ) = _$SubPlanDtoModelCopyWithImpl<$Res, SubPlanDtoModel>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'credit_plan') CreditPlanSummaryDtoModel creditPlan,
    String name,
    @JsonKey(name: 'repayment_duration_months') int repaymentDurationMonths,
    @JsonKey(name: 'is_active') bool isActive,
  });

  $CreditPlanSummaryDtoModelCopyWith<$Res> get creditPlan;
}

/// @nodoc
class _$SubPlanDtoModelCopyWithImpl<$Res, $Val extends SubPlanDtoModel>
    implements $SubPlanDtoModelCopyWith<$Res> {
  _$SubPlanDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubPlanDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? creditPlan = null,
    Object? name = null,
    Object? repaymentDurationMonths = null,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            creditPlan: null == creditPlan
                ? _value.creditPlan
                : creditPlan // ignore: cast_nullable_to_non_nullable
                      as CreditPlanSummaryDtoModel,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            repaymentDurationMonths: null == repaymentDurationMonths
                ? _value.repaymentDurationMonths
                : repaymentDurationMonths // ignore: cast_nullable_to_non_nullable
                      as int,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of SubPlanDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CreditPlanSummaryDtoModelCopyWith<$Res> get creditPlan {
    return $CreditPlanSummaryDtoModelCopyWith<$Res>(_value.creditPlan, (value) {
      return _then(_value.copyWith(creditPlan: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SubPlanDtoModelImplCopyWith<$Res>
    implements $SubPlanDtoModelCopyWith<$Res> {
  factory _$$SubPlanDtoModelImplCopyWith(
    _$SubPlanDtoModelImpl value,
    $Res Function(_$SubPlanDtoModelImpl) then,
  ) = __$$SubPlanDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'credit_plan') CreditPlanSummaryDtoModel creditPlan,
    String name,
    @JsonKey(name: 'repayment_duration_months') int repaymentDurationMonths,
    @JsonKey(name: 'is_active') bool isActive,
  });

  @override
  $CreditPlanSummaryDtoModelCopyWith<$Res> get creditPlan;
}

/// @nodoc
class __$$SubPlanDtoModelImplCopyWithImpl<$Res>
    extends _$SubPlanDtoModelCopyWithImpl<$Res, _$SubPlanDtoModelImpl>
    implements _$$SubPlanDtoModelImplCopyWith<$Res> {
  __$$SubPlanDtoModelImplCopyWithImpl(
    _$SubPlanDtoModelImpl _value,
    $Res Function(_$SubPlanDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubPlanDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? creditPlan = null,
    Object? name = null,
    Object? repaymentDurationMonths = null,
    Object? isActive = null,
  }) {
    return _then(
      _$SubPlanDtoModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        creditPlan: null == creditPlan
            ? _value.creditPlan
            : creditPlan // ignore: cast_nullable_to_non_nullable
                  as CreditPlanSummaryDtoModel,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        repaymentDurationMonths: null == repaymentDurationMonths
            ? _value.repaymentDurationMonths
            : repaymentDurationMonths // ignore: cast_nullable_to_non_nullable
                  as int,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SubPlanDtoModelImpl implements _SubPlanDtoModel {
  const _$SubPlanDtoModelImpl({
    required this.id,
    @JsonKey(name: 'credit_plan') required this.creditPlan,
    required this.name,
    @JsonKey(name: 'repayment_duration_months')
    required this.repaymentDurationMonths,
    @JsonKey(name: 'is_active') required this.isActive,
  });

  factory _$SubPlanDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubPlanDtoModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'credit_plan')
  final CreditPlanSummaryDtoModel creditPlan;
  @override
  final String name;
  @override
  @JsonKey(name: 'repayment_duration_months')
  final int repaymentDurationMonths;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;

  @override
  String toString() {
    return 'SubPlanDtoModel(id: $id, creditPlan: $creditPlan, name: $name, repaymentDurationMonths: $repaymentDurationMonths, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubPlanDtoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.creditPlan, creditPlan) ||
                other.creditPlan == creditPlan) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(
                  other.repaymentDurationMonths,
                  repaymentDurationMonths,
                ) ||
                other.repaymentDurationMonths == repaymentDurationMonths) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    creditPlan,
    name,
    repaymentDurationMonths,
    isActive,
  );

  /// Create a copy of SubPlanDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubPlanDtoModelImplCopyWith<_$SubPlanDtoModelImpl> get copyWith =>
      __$$SubPlanDtoModelImplCopyWithImpl<_$SubPlanDtoModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SubPlanDtoModelImplToJson(this);
  }
}

abstract class _SubPlanDtoModel implements SubPlanDtoModel {
  const factory _SubPlanDtoModel({
    required final String id,
    @JsonKey(name: 'credit_plan')
    required final CreditPlanSummaryDtoModel creditPlan,
    required final String name,
    @JsonKey(name: 'repayment_duration_months')
    required final int repaymentDurationMonths,
    @JsonKey(name: 'is_active') required final bool isActive,
  }) = _$SubPlanDtoModelImpl;

  factory _SubPlanDtoModel.fromJson(Map<String, dynamic> json) =
      _$SubPlanDtoModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'credit_plan')
  CreditPlanSummaryDtoModel get creditPlan;
  @override
  String get name;
  @override
  @JsonKey(name: 'repayment_duration_months')
  int get repaymentDurationMonths;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;

  /// Create a copy of SubPlanDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubPlanDtoModelImplCopyWith<_$SubPlanDtoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreditPlanSummaryDtoModel _$CreditPlanSummaryDtoModelFromJson(
  Map<String, dynamic> json,
) {
  return _CreditPlanSummaryDtoModel.fromJson(json);
}

/// @nodoc
mixin _$CreditPlanSummaryDtoModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int? get validity_window_days => throw _privateConstructorUsedError;
  ImageDtoModel? get image => throw _privateConstructorUsedError;

  /// Serializes this CreditPlanSummaryDtoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreditPlanSummaryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreditPlanSummaryDtoModelCopyWith<CreditPlanSummaryDtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreditPlanSummaryDtoModelCopyWith<$Res> {
  factory $CreditPlanSummaryDtoModelCopyWith(
    CreditPlanSummaryDtoModel value,
    $Res Function(CreditPlanSummaryDtoModel) then,
  ) = _$CreditPlanSummaryDtoModelCopyWithImpl<$Res, CreditPlanSummaryDtoModel>;
  @useResult
  $Res call({
    String id,
    String name,
    int? validity_window_days,
    ImageDtoModel? image,
  });

  $ImageDtoModelCopyWith<$Res>? get image;
}

/// @nodoc
class _$CreditPlanSummaryDtoModelCopyWithImpl<
  $Res,
  $Val extends CreditPlanSummaryDtoModel
>
    implements $CreditPlanSummaryDtoModelCopyWith<$Res> {
  _$CreditPlanSummaryDtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreditPlanSummaryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? validity_window_days = freezed,
    Object? image = freezed,
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
            validity_window_days: freezed == validity_window_days
                ? _value.validity_window_days
                : validity_window_days // ignore: cast_nullable_to_non_nullable
                      as int?,
            image: freezed == image
                ? _value.image
                : image // ignore: cast_nullable_to_non_nullable
                      as ImageDtoModel?,
          )
          as $Val,
    );
  }

  /// Create a copy of CreditPlanSummaryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ImageDtoModelCopyWith<$Res>? get image {
    if (_value.image == null) {
      return null;
    }

    return $ImageDtoModelCopyWith<$Res>(_value.image!, (value) {
      return _then(_value.copyWith(image: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CreditPlanSummaryDtoModelImplCopyWith<$Res>
    implements $CreditPlanSummaryDtoModelCopyWith<$Res> {
  factory _$$CreditPlanSummaryDtoModelImplCopyWith(
    _$CreditPlanSummaryDtoModelImpl value,
    $Res Function(_$CreditPlanSummaryDtoModelImpl) then,
  ) = __$$CreditPlanSummaryDtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    int? validity_window_days,
    ImageDtoModel? image,
  });

  @override
  $ImageDtoModelCopyWith<$Res>? get image;
}

/// @nodoc
class __$$CreditPlanSummaryDtoModelImplCopyWithImpl<$Res>
    extends
        _$CreditPlanSummaryDtoModelCopyWithImpl<
          $Res,
          _$CreditPlanSummaryDtoModelImpl
        >
    implements _$$CreditPlanSummaryDtoModelImplCopyWith<$Res> {
  __$$CreditPlanSummaryDtoModelImplCopyWithImpl(
    _$CreditPlanSummaryDtoModelImpl _value,
    $Res Function(_$CreditPlanSummaryDtoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreditPlanSummaryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? validity_window_days = freezed,
    Object? image = freezed,
  }) {
    return _then(
      _$CreditPlanSummaryDtoModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        validity_window_days: freezed == validity_window_days
            ? _value.validity_window_days
            : validity_window_days // ignore: cast_nullable_to_non_nullable
                  as int?,
        image: freezed == image
            ? _value.image
            : image // ignore: cast_nullable_to_non_nullable
                  as ImageDtoModel?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreditPlanSummaryDtoModelImpl implements _CreditPlanSummaryDtoModel {
  const _$CreditPlanSummaryDtoModelImpl({
    required this.id,
    required this.name,
    this.validity_window_days,
    this.image,
  });

  factory _$CreditPlanSummaryDtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreditPlanSummaryDtoModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final int? validity_window_days;
  @override
  final ImageDtoModel? image;

  @override
  String toString() {
    return 'CreditPlanSummaryDtoModel(id: $id, name: $name, validity_window_days: $validity_window_days, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreditPlanSummaryDtoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.validity_window_days, validity_window_days) ||
                other.validity_window_days == validity_window_days) &&
            (identical(other.image, image) || other.image == image));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, validity_window_days, image);

  /// Create a copy of CreditPlanSummaryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreditPlanSummaryDtoModelImplCopyWith<_$CreditPlanSummaryDtoModelImpl>
  get copyWith =>
      __$$CreditPlanSummaryDtoModelImplCopyWithImpl<
        _$CreditPlanSummaryDtoModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreditPlanSummaryDtoModelImplToJson(this);
  }
}

abstract class _CreditPlanSummaryDtoModel implements CreditPlanSummaryDtoModel {
  const factory _CreditPlanSummaryDtoModel({
    required final String id,
    required final String name,
    final int? validity_window_days,
    final ImageDtoModel? image,
  }) = _$CreditPlanSummaryDtoModelImpl;

  factory _CreditPlanSummaryDtoModel.fromJson(Map<String, dynamic> json) =
      _$CreditPlanSummaryDtoModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  int? get validity_window_days;
  @override
  ImageDtoModel? get image;

  /// Create a copy of CreditPlanSummaryDtoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreditPlanSummaryDtoModelImplCopyWith<_$CreditPlanSummaryDtoModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
