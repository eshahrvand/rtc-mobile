// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$DashboardState {
  DashboardRequestStatus get status => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  int get selectedNavIndex =>
      throw _privateConstructorUsedError; // Quick access data
  List<QuickAccessItemModel> get quickAccessItems =>
      throw _privateConstructorUsedError; // Message card
  String get messageText => throw _privateConstructorUsedError;
  String get messageIconPath =>
      throw _privateConstructorUsedError; // Line chart
  List<LineChartDataModel> get lineChartData =>
      throw _privateConstructorUsedError; // Pie charts
  List<PieChartItemModel> get pieChart1Data =>
      throw _privateConstructorUsedError;
  String get pieChart1Title => throw _privateConstructorUsedError;
  List<PieChartItemModel> get pieChart2Data =>
      throw _privateConstructorUsedError;
  String get pieChart2Title => throw _privateConstructorUsedError; // Bar chart
  List<BarChartItemModel> get barChartData =>
      throw _privateConstructorUsedError;
  String get barChartTitle =>
      throw _privateConstructorUsedError; // Recent orders
  List<OrderSummaryModel> get recentOrders =>
      throw _privateConstructorUsedError; // User Profile
  UserProfileDtoModel? get userProfile =>
      throw _privateConstructorUsedError; // Commission
  CommissionDtoModel? get commission =>
      throw _privateConstructorUsedError; // App Info
  String get appVersion => throw _privateConstructorUsedError;
  String get buildNumber => throw _privateConstructorUsedError;

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardStateCopyWith<DashboardState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardStateCopyWith<$Res> {
  factory $DashboardStateCopyWith(
    DashboardState value,
    $Res Function(DashboardState) then,
  ) = _$DashboardStateCopyWithImpl<$Res, DashboardState>;
  @useResult
  $Res call({
    DashboardRequestStatus status,
    String errorMessage,
    int selectedNavIndex,
    List<QuickAccessItemModel> quickAccessItems,
    String messageText,
    String messageIconPath,
    List<LineChartDataModel> lineChartData,
    List<PieChartItemModel> pieChart1Data,
    String pieChart1Title,
    List<PieChartItemModel> pieChart2Data,
    String pieChart2Title,
    List<BarChartItemModel> barChartData,
    String barChartTitle,
    List<OrderSummaryModel> recentOrders,
    UserProfileDtoModel? userProfile,
    CommissionDtoModel? commission,
    String appVersion,
    String buildNumber,
  });

  $UserProfileDtoModelCopyWith<$Res>? get userProfile;
  $CommissionDtoModelCopyWith<$Res>? get commission;
}

/// @nodoc
class _$DashboardStateCopyWithImpl<$Res, $Val extends DashboardState>
    implements $DashboardStateCopyWith<$Res> {
  _$DashboardStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? errorMessage = null,
    Object? selectedNavIndex = null,
    Object? quickAccessItems = null,
    Object? messageText = null,
    Object? messageIconPath = null,
    Object? lineChartData = null,
    Object? pieChart1Data = null,
    Object? pieChart1Title = null,
    Object? pieChart2Data = null,
    Object? pieChart2Title = null,
    Object? barChartData = null,
    Object? barChartTitle = null,
    Object? recentOrders = null,
    Object? userProfile = freezed,
    Object? commission = freezed,
    Object? appVersion = null,
    Object? buildNumber = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as DashboardRequestStatus,
            errorMessage: null == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String,
            selectedNavIndex: null == selectedNavIndex
                ? _value.selectedNavIndex
                : selectedNavIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            quickAccessItems: null == quickAccessItems
                ? _value.quickAccessItems
                : quickAccessItems // ignore: cast_nullable_to_non_nullable
                      as List<QuickAccessItemModel>,
            messageText: null == messageText
                ? _value.messageText
                : messageText // ignore: cast_nullable_to_non_nullable
                      as String,
            messageIconPath: null == messageIconPath
                ? _value.messageIconPath
                : messageIconPath // ignore: cast_nullable_to_non_nullable
                      as String,
            lineChartData: null == lineChartData
                ? _value.lineChartData
                : lineChartData // ignore: cast_nullable_to_non_nullable
                      as List<LineChartDataModel>,
            pieChart1Data: null == pieChart1Data
                ? _value.pieChart1Data
                : pieChart1Data // ignore: cast_nullable_to_non_nullable
                      as List<PieChartItemModel>,
            pieChart1Title: null == pieChart1Title
                ? _value.pieChart1Title
                : pieChart1Title // ignore: cast_nullable_to_non_nullable
                      as String,
            pieChart2Data: null == pieChart2Data
                ? _value.pieChart2Data
                : pieChart2Data // ignore: cast_nullable_to_non_nullable
                      as List<PieChartItemModel>,
            pieChart2Title: null == pieChart2Title
                ? _value.pieChart2Title
                : pieChart2Title // ignore: cast_nullable_to_non_nullable
                      as String,
            barChartData: null == barChartData
                ? _value.barChartData
                : barChartData // ignore: cast_nullable_to_non_nullable
                      as List<BarChartItemModel>,
            barChartTitle: null == barChartTitle
                ? _value.barChartTitle
                : barChartTitle // ignore: cast_nullable_to_non_nullable
                      as String,
            recentOrders: null == recentOrders
                ? _value.recentOrders
                : recentOrders // ignore: cast_nullable_to_non_nullable
                      as List<OrderSummaryModel>,
            userProfile: freezed == userProfile
                ? _value.userProfile
                : userProfile // ignore: cast_nullable_to_non_nullable
                      as UserProfileDtoModel?,
            commission: freezed == commission
                ? _value.commission
                : commission // ignore: cast_nullable_to_non_nullable
                      as CommissionDtoModel?,
            appVersion: null == appVersion
                ? _value.appVersion
                : appVersion // ignore: cast_nullable_to_non_nullable
                      as String,
            buildNumber: null == buildNumber
                ? _value.buildNumber
                : buildNumber // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserProfileDtoModelCopyWith<$Res>? get userProfile {
    if (_value.userProfile == null) {
      return null;
    }

    return $UserProfileDtoModelCopyWith<$Res>(_value.userProfile!, (value) {
      return _then(_value.copyWith(userProfile: value) as $Val);
    });
  }

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CommissionDtoModelCopyWith<$Res>? get commission {
    if (_value.commission == null) {
      return null;
    }

    return $CommissionDtoModelCopyWith<$Res>(_value.commission!, (value) {
      return _then(_value.copyWith(commission: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DashboardStateImplCopyWith<$Res>
    implements $DashboardStateCopyWith<$Res> {
  factory _$$DashboardStateImplCopyWith(
    _$DashboardStateImpl value,
    $Res Function(_$DashboardStateImpl) then,
  ) = __$$DashboardStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DashboardRequestStatus status,
    String errorMessage,
    int selectedNavIndex,
    List<QuickAccessItemModel> quickAccessItems,
    String messageText,
    String messageIconPath,
    List<LineChartDataModel> lineChartData,
    List<PieChartItemModel> pieChart1Data,
    String pieChart1Title,
    List<PieChartItemModel> pieChart2Data,
    String pieChart2Title,
    List<BarChartItemModel> barChartData,
    String barChartTitle,
    List<OrderSummaryModel> recentOrders,
    UserProfileDtoModel? userProfile,
    CommissionDtoModel? commission,
    String appVersion,
    String buildNumber,
  });

  @override
  $UserProfileDtoModelCopyWith<$Res>? get userProfile;
  @override
  $CommissionDtoModelCopyWith<$Res>? get commission;
}

/// @nodoc
class __$$DashboardStateImplCopyWithImpl<$Res>
    extends _$DashboardStateCopyWithImpl<$Res, _$DashboardStateImpl>
    implements _$$DashboardStateImplCopyWith<$Res> {
  __$$DashboardStateImplCopyWithImpl(
    _$DashboardStateImpl _value,
    $Res Function(_$DashboardStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? errorMessage = null,
    Object? selectedNavIndex = null,
    Object? quickAccessItems = null,
    Object? messageText = null,
    Object? messageIconPath = null,
    Object? lineChartData = null,
    Object? pieChart1Data = null,
    Object? pieChart1Title = null,
    Object? pieChart2Data = null,
    Object? pieChart2Title = null,
    Object? barChartData = null,
    Object? barChartTitle = null,
    Object? recentOrders = null,
    Object? userProfile = freezed,
    Object? commission = freezed,
    Object? appVersion = null,
    Object? buildNumber = null,
  }) {
    return _then(
      _$DashboardStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as DashboardRequestStatus,
        errorMessage: null == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String,
        selectedNavIndex: null == selectedNavIndex
            ? _value.selectedNavIndex
            : selectedNavIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        quickAccessItems: null == quickAccessItems
            ? _value._quickAccessItems
            : quickAccessItems // ignore: cast_nullable_to_non_nullable
                  as List<QuickAccessItemModel>,
        messageText: null == messageText
            ? _value.messageText
            : messageText // ignore: cast_nullable_to_non_nullable
                  as String,
        messageIconPath: null == messageIconPath
            ? _value.messageIconPath
            : messageIconPath // ignore: cast_nullable_to_non_nullable
                  as String,
        lineChartData: null == lineChartData
            ? _value._lineChartData
            : lineChartData // ignore: cast_nullable_to_non_nullable
                  as List<LineChartDataModel>,
        pieChart1Data: null == pieChart1Data
            ? _value._pieChart1Data
            : pieChart1Data // ignore: cast_nullable_to_non_nullable
                  as List<PieChartItemModel>,
        pieChart1Title: null == pieChart1Title
            ? _value.pieChart1Title
            : pieChart1Title // ignore: cast_nullable_to_non_nullable
                  as String,
        pieChart2Data: null == pieChart2Data
            ? _value._pieChart2Data
            : pieChart2Data // ignore: cast_nullable_to_non_nullable
                  as List<PieChartItemModel>,
        pieChart2Title: null == pieChart2Title
            ? _value.pieChart2Title
            : pieChart2Title // ignore: cast_nullable_to_non_nullable
                  as String,
        barChartData: null == barChartData
            ? _value._barChartData
            : barChartData // ignore: cast_nullable_to_non_nullable
                  as List<BarChartItemModel>,
        barChartTitle: null == barChartTitle
            ? _value.barChartTitle
            : barChartTitle // ignore: cast_nullable_to_non_nullable
                  as String,
        recentOrders: null == recentOrders
            ? _value._recentOrders
            : recentOrders // ignore: cast_nullable_to_non_nullable
                  as List<OrderSummaryModel>,
        userProfile: freezed == userProfile
            ? _value.userProfile
            : userProfile // ignore: cast_nullable_to_non_nullable
                  as UserProfileDtoModel?,
        commission: freezed == commission
            ? _value.commission
            : commission // ignore: cast_nullable_to_non_nullable
                  as CommissionDtoModel?,
        appVersion: null == appVersion
            ? _value.appVersion
            : appVersion // ignore: cast_nullable_to_non_nullable
                  as String,
        buildNumber: null == buildNumber
            ? _value.buildNumber
            : buildNumber // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$DashboardStateImpl implements _DashboardState {
  const _$DashboardStateImpl({
    this.status = DashboardRequestStatus.initial,
    this.errorMessage = '',
    this.selectedNavIndex = 0,
    final List<QuickAccessItemModel> quickAccessItems = const [],
    this.messageText = '',
    this.messageIconPath = '',
    final List<LineChartDataModel> lineChartData = const [],
    final List<PieChartItemModel> pieChart1Data = const [],
    this.pieChart1Title = '',
    final List<PieChartItemModel> pieChart2Data = const [],
    this.pieChart2Title = '',
    final List<BarChartItemModel> barChartData = const [],
    this.barChartTitle = '',
    final List<OrderSummaryModel> recentOrders = const [],
    this.userProfile,
    this.commission,
    this.appVersion = '',
    this.buildNumber = '',
  }) : _quickAccessItems = quickAccessItems,
       _lineChartData = lineChartData,
       _pieChart1Data = pieChart1Data,
       _pieChart2Data = pieChart2Data,
       _barChartData = barChartData,
       _recentOrders = recentOrders;

  @override
  @JsonKey()
  final DashboardRequestStatus status;
  @override
  @JsonKey()
  final String errorMessage;
  @override
  @JsonKey()
  final int selectedNavIndex;
  // Quick access data
  final List<QuickAccessItemModel> _quickAccessItems;
  // Quick access data
  @override
  @JsonKey()
  List<QuickAccessItemModel> get quickAccessItems {
    if (_quickAccessItems is EqualUnmodifiableListView)
      return _quickAccessItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_quickAccessItems);
  }

  // Message card
  @override
  @JsonKey()
  final String messageText;
  @override
  @JsonKey()
  final String messageIconPath;
  // Line chart
  final List<LineChartDataModel> _lineChartData;
  // Line chart
  @override
  @JsonKey()
  List<LineChartDataModel> get lineChartData {
    if (_lineChartData is EqualUnmodifiableListView) return _lineChartData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lineChartData);
  }

  // Pie charts
  final List<PieChartItemModel> _pieChart1Data;
  // Pie charts
  @override
  @JsonKey()
  List<PieChartItemModel> get pieChart1Data {
    if (_pieChart1Data is EqualUnmodifiableListView) return _pieChart1Data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pieChart1Data);
  }

  @override
  @JsonKey()
  final String pieChart1Title;
  final List<PieChartItemModel> _pieChart2Data;
  @override
  @JsonKey()
  List<PieChartItemModel> get pieChart2Data {
    if (_pieChart2Data is EqualUnmodifiableListView) return _pieChart2Data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pieChart2Data);
  }

  @override
  @JsonKey()
  final String pieChart2Title;
  // Bar chart
  final List<BarChartItemModel> _barChartData;
  // Bar chart
  @override
  @JsonKey()
  List<BarChartItemModel> get barChartData {
    if (_barChartData is EqualUnmodifiableListView) return _barChartData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_barChartData);
  }

  @override
  @JsonKey()
  final String barChartTitle;
  // Recent orders
  final List<OrderSummaryModel> _recentOrders;
  // Recent orders
  @override
  @JsonKey()
  List<OrderSummaryModel> get recentOrders {
    if (_recentOrders is EqualUnmodifiableListView) return _recentOrders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentOrders);
  }

  // User Profile
  @override
  final UserProfileDtoModel? userProfile;
  // Commission
  @override
  final CommissionDtoModel? commission;
  // App Info
  @override
  @JsonKey()
  final String appVersion;
  @override
  @JsonKey()
  final String buildNumber;

  @override
  String toString() {
    return 'DashboardState(status: $status, errorMessage: $errorMessage, selectedNavIndex: $selectedNavIndex, quickAccessItems: $quickAccessItems, messageText: $messageText, messageIconPath: $messageIconPath, lineChartData: $lineChartData, pieChart1Data: $pieChart1Data, pieChart1Title: $pieChart1Title, pieChart2Data: $pieChart2Data, pieChart2Title: $pieChart2Title, barChartData: $barChartData, barChartTitle: $barChartTitle, recentOrders: $recentOrders, userProfile: $userProfile, commission: $commission, appVersion: $appVersion, buildNumber: $buildNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.selectedNavIndex, selectedNavIndex) ||
                other.selectedNavIndex == selectedNavIndex) &&
            const DeepCollectionEquality().equals(
              other._quickAccessItems,
              _quickAccessItems,
            ) &&
            (identical(other.messageText, messageText) ||
                other.messageText == messageText) &&
            (identical(other.messageIconPath, messageIconPath) ||
                other.messageIconPath == messageIconPath) &&
            const DeepCollectionEquality().equals(
              other._lineChartData,
              _lineChartData,
            ) &&
            const DeepCollectionEquality().equals(
              other._pieChart1Data,
              _pieChart1Data,
            ) &&
            (identical(other.pieChart1Title, pieChart1Title) ||
                other.pieChart1Title == pieChart1Title) &&
            const DeepCollectionEquality().equals(
              other._pieChart2Data,
              _pieChart2Data,
            ) &&
            (identical(other.pieChart2Title, pieChart2Title) ||
                other.pieChart2Title == pieChart2Title) &&
            const DeepCollectionEquality().equals(
              other._barChartData,
              _barChartData,
            ) &&
            (identical(other.barChartTitle, barChartTitle) ||
                other.barChartTitle == barChartTitle) &&
            const DeepCollectionEquality().equals(
              other._recentOrders,
              _recentOrders,
            ) &&
            (identical(other.userProfile, userProfile) ||
                other.userProfile == userProfile) &&
            (identical(other.commission, commission) ||
                other.commission == commission) &&
            (identical(other.appVersion, appVersion) ||
                other.appVersion == appVersion) &&
            (identical(other.buildNumber, buildNumber) ||
                other.buildNumber == buildNumber));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    errorMessage,
    selectedNavIndex,
    const DeepCollectionEquality().hash(_quickAccessItems),
    messageText,
    messageIconPath,
    const DeepCollectionEquality().hash(_lineChartData),
    const DeepCollectionEquality().hash(_pieChart1Data),
    pieChart1Title,
    const DeepCollectionEquality().hash(_pieChart2Data),
    pieChart2Title,
    const DeepCollectionEquality().hash(_barChartData),
    barChartTitle,
    const DeepCollectionEquality().hash(_recentOrders),
    userProfile,
    commission,
    appVersion,
    buildNumber,
  );

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardStateImplCopyWith<_$DashboardStateImpl> get copyWith =>
      __$$DashboardStateImplCopyWithImpl<_$DashboardStateImpl>(
        this,
        _$identity,
      );
}

abstract class _DashboardState implements DashboardState {
  const factory _DashboardState({
    final DashboardRequestStatus status,
    final String errorMessage,
    final int selectedNavIndex,
    final List<QuickAccessItemModel> quickAccessItems,
    final String messageText,
    final String messageIconPath,
    final List<LineChartDataModel> lineChartData,
    final List<PieChartItemModel> pieChart1Data,
    final String pieChart1Title,
    final List<PieChartItemModel> pieChart2Data,
    final String pieChart2Title,
    final List<BarChartItemModel> barChartData,
    final String barChartTitle,
    final List<OrderSummaryModel> recentOrders,
    final UserProfileDtoModel? userProfile,
    final CommissionDtoModel? commission,
    final String appVersion,
    final String buildNumber,
  }) = _$DashboardStateImpl;

  @override
  DashboardRequestStatus get status;
  @override
  String get errorMessage;
  @override
  int get selectedNavIndex; // Quick access data
  @override
  List<QuickAccessItemModel> get quickAccessItems; // Message card
  @override
  String get messageText;
  @override
  String get messageIconPath; // Line chart
  @override
  List<LineChartDataModel> get lineChartData; // Pie charts
  @override
  List<PieChartItemModel> get pieChart1Data;
  @override
  String get pieChart1Title;
  @override
  List<PieChartItemModel> get pieChart2Data;
  @override
  String get pieChart2Title; // Bar chart
  @override
  List<BarChartItemModel> get barChartData;
  @override
  String get barChartTitle; // Recent orders
  @override
  List<OrderSummaryModel> get recentOrders; // User Profile
  @override
  UserProfileDtoModel? get userProfile; // Commission
  @override
  CommissionDtoModel? get commission; // App Info
  @override
  String get appVersion;
  @override
  String get buildNumber;

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardStateImplCopyWith<_$DashboardStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
