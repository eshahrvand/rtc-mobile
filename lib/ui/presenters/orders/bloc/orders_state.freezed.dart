// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'orders_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$OrdersState {
  OrdersRequestStatus get status => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  List<OrderSummaryModel> get allOrders => throw _privateConstructorUsedError;
  List<OrderSummaryModel> get filteredOrders =>
      throw _privateConstructorUsedError;
  String get searchQuery => throw _privateConstructorUsedError;
  bool get isSearchActive => throw _privateConstructorUsedError;
  List<String> get selectedBadges => throw _privateConstructorUsedError;
  OrderDetailModel? get selectedOrder => throw _privateConstructorUsedError;
  int get selectedTabIndex => throw _privateConstructorUsedError;
  bool get isCreditPlanExpanded => throw _privateConstructorUsedError;
  bool get isFinancialSectionExpanded => throw _privateConstructorUsedError;
  bool get isProductsExpanded => throw _privateConstructorUsedError;
  bool get isCustomerInfoExpanded => throw _privateConstructorUsedError;
  bool get isDocumentsExpanded => throw _privateConstructorUsedError;
  bool get isFinancialSummaryExpanded => throw _privateConstructorUsedError;
  bool get isClearanceSectionExpanded => throw _privateConstructorUsedError;
  String? get selectedStatusId => throw _privateConstructorUsedError;
  String? get selectedSubPlanId => throw _privateConstructorUsedError;
  List<SubPlanDtoModel> get subPlans => throw _privateConstructorUsedError;
  Jalali? get startDate => throw _privateConstructorUsedError;
  Jalali? get endDate => throw _privateConstructorUsedError;
  String? get selectedDateOptionId =>
      throw _privateConstructorUsedError; // Deep Link Flow
  PaymentOutcome get deepLinkPaymentOutcome =>
      throw _privateConstructorUsedError;
  Map<String, dynamic>? get pendingNavigation =>
      throw _privateConstructorUsedError; // Clearance Flow
  ClearanceStep get clearanceStep => throw _privateConstructorUsedError;
  String get clearanceAmount => throw _privateConstructorUsedError;
  OrderOperationModel? get disburseOperation =>
      throw _privateConstructorUsedError;
  String? get excessAmount => throw _privateConstructorUsedError;
  GatewayType? get gatewayType => throw _privateConstructorUsedError;
  String? get walletName => throw _privateConstructorUsedError;
  XFile? get uploadedClearanceDoc => throw _privateConstructorUsedError;
  String? get uploadedClearanceDocId => throw _privateConstructorUsedError;
  String? get orderAmount => throw _privateConstructorUsedError;
  bool get isOutOfTolerance => throw _privateConstructorUsedError;
  double? get tolerance => throw _privateConstructorUsedError;
  bool get toleranceCheckEnabled =>
      throw _privateConstructorUsedError; // Settlement Flow
  SettlementStep get settlementStep => throw _privateConstructorUsedError;
  OrderOperationModel? get settlementOperation =>
      throw _privateConstructorUsedError;
  String? get settlementMethod => throw _privateConstructorUsedError;
  String? get settlementRedirectUrl => throw _privateConstructorUsedError;
  double? get settlementReservedAmount => throw _privateConstructorUsedError;
  String? get settlementBankAccount => throw _privateConstructorUsedError;
  String? get settlementBankName => throw _privateConstructorUsedError;
  String? get settlementAccountHolder => throw _privateConstructorUsedError;
  String? get settlementTrackingCode => throw _privateConstructorUsedError;
  List<XFile> get settlementDocs => throw _privateConstructorUsedError;
  bool get isWalletBalanceSufficient => throw _privateConstructorUsedError;
  bool get isSettlementCompleted =>
      throw _privateConstructorUsedError; // Settlement Timer (for "Send Link" mode)
  int get settlementCountdown => throw _privateConstructorUsedError;
  bool get isSettlementTimerActive =>
      throw _privateConstructorUsedError; // Clearance OTP Timer
  int get clearanceOtpCountdown => throw _privateConstructorUsedError;
  bool get isClearanceOtpTimerActive =>
      throw _privateConstructorUsedError; // Settlement Extras
  String? get settlementMobile =>
      throw _privateConstructorUsedError; // Disbursement Extras
  String? get disbursementMobile => throw _privateConstructorUsedError;
  String? get disbursementRedirectUrl => throw _privateConstructorUsedError;
  String? get disbursementGatewayType =>
      throw _privateConstructorUsedError; // Printing
  bool get isPrinting => throw _privateConstructorUsedError;
  PrintStatus get printStatus => throw _privateConstructorUsedError;
  String? get lastPrintedFilePath =>
      throw _privateConstructorUsedError; // Pagination
  int get currentPage => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  bool get isPaginationLoading => throw _privateConstructorUsedError;
  bool get hasMoreData => throw _privateConstructorUsedError;

  /// Create a copy of OrdersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrdersStateCopyWith<OrdersState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrdersStateCopyWith<$Res> {
  factory $OrdersStateCopyWith(
    OrdersState value,
    $Res Function(OrdersState) then,
  ) = _$OrdersStateCopyWithImpl<$Res, OrdersState>;
  @useResult
  $Res call({
    OrdersRequestStatus status,
    String errorMessage,
    List<OrderSummaryModel> allOrders,
    List<OrderSummaryModel> filteredOrders,
    String searchQuery,
    bool isSearchActive,
    List<String> selectedBadges,
    OrderDetailModel? selectedOrder,
    int selectedTabIndex,
    bool isCreditPlanExpanded,
    bool isFinancialSectionExpanded,
    bool isProductsExpanded,
    bool isCustomerInfoExpanded,
    bool isDocumentsExpanded,
    bool isFinancialSummaryExpanded,
    bool isClearanceSectionExpanded,
    String? selectedStatusId,
    String? selectedSubPlanId,
    List<SubPlanDtoModel> subPlans,
    Jalali? startDate,
    Jalali? endDate,
    String? selectedDateOptionId,
    PaymentOutcome deepLinkPaymentOutcome,
    Map<String, dynamic>? pendingNavigation,
    ClearanceStep clearanceStep,
    String clearanceAmount,
    OrderOperationModel? disburseOperation,
    String? excessAmount,
    GatewayType? gatewayType,
    String? walletName,
    XFile? uploadedClearanceDoc,
    String? uploadedClearanceDocId,
    String? orderAmount,
    bool isOutOfTolerance,
    double? tolerance,
    bool toleranceCheckEnabled,
    SettlementStep settlementStep,
    OrderOperationModel? settlementOperation,
    String? settlementMethod,
    String? settlementRedirectUrl,
    double? settlementReservedAmount,
    String? settlementBankAccount,
    String? settlementBankName,
    String? settlementAccountHolder,
    String? settlementTrackingCode,
    List<XFile> settlementDocs,
    bool isWalletBalanceSufficient,
    bool isSettlementCompleted,
    int settlementCountdown,
    bool isSettlementTimerActive,
    int clearanceOtpCountdown,
    bool isClearanceOtpTimerActive,
    String? settlementMobile,
    String? disbursementMobile,
    String? disbursementRedirectUrl,
    String? disbursementGatewayType,
    bool isPrinting,
    PrintStatus printStatus,
    String? lastPrintedFilePath,
    int currentPage,
    int totalCount,
    bool isPaginationLoading,
    bool hasMoreData,
  });
}

/// @nodoc
class _$OrdersStateCopyWithImpl<$Res, $Val extends OrdersState>
    implements $OrdersStateCopyWith<$Res> {
  _$OrdersStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrdersState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? errorMessage = null,
    Object? allOrders = null,
    Object? filteredOrders = null,
    Object? searchQuery = null,
    Object? isSearchActive = null,
    Object? selectedBadges = null,
    Object? selectedOrder = freezed,
    Object? selectedTabIndex = null,
    Object? isCreditPlanExpanded = null,
    Object? isFinancialSectionExpanded = null,
    Object? isProductsExpanded = null,
    Object? isCustomerInfoExpanded = null,
    Object? isDocumentsExpanded = null,
    Object? isFinancialSummaryExpanded = null,
    Object? isClearanceSectionExpanded = null,
    Object? selectedStatusId = freezed,
    Object? selectedSubPlanId = freezed,
    Object? subPlans = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? selectedDateOptionId = freezed,
    Object? deepLinkPaymentOutcome = null,
    Object? pendingNavigation = freezed,
    Object? clearanceStep = null,
    Object? clearanceAmount = null,
    Object? disburseOperation = freezed,
    Object? excessAmount = freezed,
    Object? gatewayType = freezed,
    Object? walletName = freezed,
    Object? uploadedClearanceDoc = freezed,
    Object? uploadedClearanceDocId = freezed,
    Object? orderAmount = freezed,
    Object? isOutOfTolerance = null,
    Object? tolerance = freezed,
    Object? toleranceCheckEnabled = null,
    Object? settlementStep = null,
    Object? settlementOperation = freezed,
    Object? settlementMethod = freezed,
    Object? settlementRedirectUrl = freezed,
    Object? settlementReservedAmount = freezed,
    Object? settlementBankAccount = freezed,
    Object? settlementBankName = freezed,
    Object? settlementAccountHolder = freezed,
    Object? settlementTrackingCode = freezed,
    Object? settlementDocs = null,
    Object? isWalletBalanceSufficient = null,
    Object? isSettlementCompleted = null,
    Object? settlementCountdown = null,
    Object? isSettlementTimerActive = null,
    Object? clearanceOtpCountdown = null,
    Object? isClearanceOtpTimerActive = null,
    Object? settlementMobile = freezed,
    Object? disbursementMobile = freezed,
    Object? disbursementRedirectUrl = freezed,
    Object? disbursementGatewayType = freezed,
    Object? isPrinting = null,
    Object? printStatus = null,
    Object? lastPrintedFilePath = freezed,
    Object? currentPage = null,
    Object? totalCount = null,
    Object? isPaginationLoading = null,
    Object? hasMoreData = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as OrdersRequestStatus,
            errorMessage: null == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String,
            allOrders: null == allOrders
                ? _value.allOrders
                : allOrders // ignore: cast_nullable_to_non_nullable
                      as List<OrderSummaryModel>,
            filteredOrders: null == filteredOrders
                ? _value.filteredOrders
                : filteredOrders // ignore: cast_nullable_to_non_nullable
                      as List<OrderSummaryModel>,
            searchQuery: null == searchQuery
                ? _value.searchQuery
                : searchQuery // ignore: cast_nullable_to_non_nullable
                      as String,
            isSearchActive: null == isSearchActive
                ? _value.isSearchActive
                : isSearchActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            selectedBadges: null == selectedBadges
                ? _value.selectedBadges
                : selectedBadges // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            selectedOrder: freezed == selectedOrder
                ? _value.selectedOrder
                : selectedOrder // ignore: cast_nullable_to_non_nullable
                      as OrderDetailModel?,
            selectedTabIndex: null == selectedTabIndex
                ? _value.selectedTabIndex
                : selectedTabIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            isCreditPlanExpanded: null == isCreditPlanExpanded
                ? _value.isCreditPlanExpanded
                : isCreditPlanExpanded // ignore: cast_nullable_to_non_nullable
                      as bool,
            isFinancialSectionExpanded: null == isFinancialSectionExpanded
                ? _value.isFinancialSectionExpanded
                : isFinancialSectionExpanded // ignore: cast_nullable_to_non_nullable
                      as bool,
            isProductsExpanded: null == isProductsExpanded
                ? _value.isProductsExpanded
                : isProductsExpanded // ignore: cast_nullable_to_non_nullable
                      as bool,
            isCustomerInfoExpanded: null == isCustomerInfoExpanded
                ? _value.isCustomerInfoExpanded
                : isCustomerInfoExpanded // ignore: cast_nullable_to_non_nullable
                      as bool,
            isDocumentsExpanded: null == isDocumentsExpanded
                ? _value.isDocumentsExpanded
                : isDocumentsExpanded // ignore: cast_nullable_to_non_nullable
                      as bool,
            isFinancialSummaryExpanded: null == isFinancialSummaryExpanded
                ? _value.isFinancialSummaryExpanded
                : isFinancialSummaryExpanded // ignore: cast_nullable_to_non_nullable
                      as bool,
            isClearanceSectionExpanded: null == isClearanceSectionExpanded
                ? _value.isClearanceSectionExpanded
                : isClearanceSectionExpanded // ignore: cast_nullable_to_non_nullable
                      as bool,
            selectedStatusId: freezed == selectedStatusId
                ? _value.selectedStatusId
                : selectedStatusId // ignore: cast_nullable_to_non_nullable
                      as String?,
            selectedSubPlanId: freezed == selectedSubPlanId
                ? _value.selectedSubPlanId
                : selectedSubPlanId // ignore: cast_nullable_to_non_nullable
                      as String?,
            subPlans: null == subPlans
                ? _value.subPlans
                : subPlans // ignore: cast_nullable_to_non_nullable
                      as List<SubPlanDtoModel>,
            startDate: freezed == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as Jalali?,
            endDate: freezed == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as Jalali?,
            selectedDateOptionId: freezed == selectedDateOptionId
                ? _value.selectedDateOptionId
                : selectedDateOptionId // ignore: cast_nullable_to_non_nullable
                      as String?,
            deepLinkPaymentOutcome: null == deepLinkPaymentOutcome
                ? _value.deepLinkPaymentOutcome
                : deepLinkPaymentOutcome // ignore: cast_nullable_to_non_nullable
                      as PaymentOutcome,
            pendingNavigation: freezed == pendingNavigation
                ? _value.pendingNavigation
                : pendingNavigation // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            clearanceStep: null == clearanceStep
                ? _value.clearanceStep
                : clearanceStep // ignore: cast_nullable_to_non_nullable
                      as ClearanceStep,
            clearanceAmount: null == clearanceAmount
                ? _value.clearanceAmount
                : clearanceAmount // ignore: cast_nullable_to_non_nullable
                      as String,
            disburseOperation: freezed == disburseOperation
                ? _value.disburseOperation
                : disburseOperation // ignore: cast_nullable_to_non_nullable
                      as OrderOperationModel?,
            excessAmount: freezed == excessAmount
                ? _value.excessAmount
                : excessAmount // ignore: cast_nullable_to_non_nullable
                      as String?,
            gatewayType: freezed == gatewayType
                ? _value.gatewayType
                : gatewayType // ignore: cast_nullable_to_non_nullable
                      as GatewayType?,
            walletName: freezed == walletName
                ? _value.walletName
                : walletName // ignore: cast_nullable_to_non_nullable
                      as String?,
            uploadedClearanceDoc: freezed == uploadedClearanceDoc
                ? _value.uploadedClearanceDoc
                : uploadedClearanceDoc // ignore: cast_nullable_to_non_nullable
                      as XFile?,
            uploadedClearanceDocId: freezed == uploadedClearanceDocId
                ? _value.uploadedClearanceDocId
                : uploadedClearanceDocId // ignore: cast_nullable_to_non_nullable
                      as String?,
            orderAmount: freezed == orderAmount
                ? _value.orderAmount
                : orderAmount // ignore: cast_nullable_to_non_nullable
                      as String?,
            isOutOfTolerance: null == isOutOfTolerance
                ? _value.isOutOfTolerance
                : isOutOfTolerance // ignore: cast_nullable_to_non_nullable
                      as bool,
            tolerance: freezed == tolerance
                ? _value.tolerance
                : tolerance // ignore: cast_nullable_to_non_nullable
                      as double?,
            toleranceCheckEnabled: null == toleranceCheckEnabled
                ? _value.toleranceCheckEnabled
                : toleranceCheckEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            settlementStep: null == settlementStep
                ? _value.settlementStep
                : settlementStep // ignore: cast_nullable_to_non_nullable
                      as SettlementStep,
            settlementOperation: freezed == settlementOperation
                ? _value.settlementOperation
                : settlementOperation // ignore: cast_nullable_to_non_nullable
                      as OrderOperationModel?,
            settlementMethod: freezed == settlementMethod
                ? _value.settlementMethod
                : settlementMethod // ignore: cast_nullable_to_non_nullable
                      as String?,
            settlementRedirectUrl: freezed == settlementRedirectUrl
                ? _value.settlementRedirectUrl
                : settlementRedirectUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            settlementReservedAmount: freezed == settlementReservedAmount
                ? _value.settlementReservedAmount
                : settlementReservedAmount // ignore: cast_nullable_to_non_nullable
                      as double?,
            settlementBankAccount: freezed == settlementBankAccount
                ? _value.settlementBankAccount
                : settlementBankAccount // ignore: cast_nullable_to_non_nullable
                      as String?,
            settlementBankName: freezed == settlementBankName
                ? _value.settlementBankName
                : settlementBankName // ignore: cast_nullable_to_non_nullable
                      as String?,
            settlementAccountHolder: freezed == settlementAccountHolder
                ? _value.settlementAccountHolder
                : settlementAccountHolder // ignore: cast_nullable_to_non_nullable
                      as String?,
            settlementTrackingCode: freezed == settlementTrackingCode
                ? _value.settlementTrackingCode
                : settlementTrackingCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            settlementDocs: null == settlementDocs
                ? _value.settlementDocs
                : settlementDocs // ignore: cast_nullable_to_non_nullable
                      as List<XFile>,
            isWalletBalanceSufficient: null == isWalletBalanceSufficient
                ? _value.isWalletBalanceSufficient
                : isWalletBalanceSufficient // ignore: cast_nullable_to_non_nullable
                      as bool,
            isSettlementCompleted: null == isSettlementCompleted
                ? _value.isSettlementCompleted
                : isSettlementCompleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            settlementCountdown: null == settlementCountdown
                ? _value.settlementCountdown
                : settlementCountdown // ignore: cast_nullable_to_non_nullable
                      as int,
            isSettlementTimerActive: null == isSettlementTimerActive
                ? _value.isSettlementTimerActive
                : isSettlementTimerActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            clearanceOtpCountdown: null == clearanceOtpCountdown
                ? _value.clearanceOtpCountdown
                : clearanceOtpCountdown // ignore: cast_nullable_to_non_nullable
                      as int,
            isClearanceOtpTimerActive: null == isClearanceOtpTimerActive
                ? _value.isClearanceOtpTimerActive
                : isClearanceOtpTimerActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            settlementMobile: freezed == settlementMobile
                ? _value.settlementMobile
                : settlementMobile // ignore: cast_nullable_to_non_nullable
                      as String?,
            disbursementMobile: freezed == disbursementMobile
                ? _value.disbursementMobile
                : disbursementMobile // ignore: cast_nullable_to_non_nullable
                      as String?,
            disbursementRedirectUrl: freezed == disbursementRedirectUrl
                ? _value.disbursementRedirectUrl
                : disbursementRedirectUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            disbursementGatewayType: freezed == disbursementGatewayType
                ? _value.disbursementGatewayType
                : disbursementGatewayType // ignore: cast_nullable_to_non_nullable
                      as String?,
            isPrinting: null == isPrinting
                ? _value.isPrinting
                : isPrinting // ignore: cast_nullable_to_non_nullable
                      as bool,
            printStatus: null == printStatus
                ? _value.printStatus
                : printStatus // ignore: cast_nullable_to_non_nullable
                      as PrintStatus,
            lastPrintedFilePath: freezed == lastPrintedFilePath
                ? _value.lastPrintedFilePath
                : lastPrintedFilePath // ignore: cast_nullable_to_non_nullable
                      as String?,
            currentPage: null == currentPage
                ? _value.currentPage
                : currentPage // ignore: cast_nullable_to_non_nullable
                      as int,
            totalCount: null == totalCount
                ? _value.totalCount
                : totalCount // ignore: cast_nullable_to_non_nullable
                      as int,
            isPaginationLoading: null == isPaginationLoading
                ? _value.isPaginationLoading
                : isPaginationLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasMoreData: null == hasMoreData
                ? _value.hasMoreData
                : hasMoreData // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrdersStateImplCopyWith<$Res>
    implements $OrdersStateCopyWith<$Res> {
  factory _$$OrdersStateImplCopyWith(
    _$OrdersStateImpl value,
    $Res Function(_$OrdersStateImpl) then,
  ) = __$$OrdersStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    OrdersRequestStatus status,
    String errorMessage,
    List<OrderSummaryModel> allOrders,
    List<OrderSummaryModel> filteredOrders,
    String searchQuery,
    bool isSearchActive,
    List<String> selectedBadges,
    OrderDetailModel? selectedOrder,
    int selectedTabIndex,
    bool isCreditPlanExpanded,
    bool isFinancialSectionExpanded,
    bool isProductsExpanded,
    bool isCustomerInfoExpanded,
    bool isDocumentsExpanded,
    bool isFinancialSummaryExpanded,
    bool isClearanceSectionExpanded,
    String? selectedStatusId,
    String? selectedSubPlanId,
    List<SubPlanDtoModel> subPlans,
    Jalali? startDate,
    Jalali? endDate,
    String? selectedDateOptionId,
    PaymentOutcome deepLinkPaymentOutcome,
    Map<String, dynamic>? pendingNavigation,
    ClearanceStep clearanceStep,
    String clearanceAmount,
    OrderOperationModel? disburseOperation,
    String? excessAmount,
    GatewayType? gatewayType,
    String? walletName,
    XFile? uploadedClearanceDoc,
    String? uploadedClearanceDocId,
    String? orderAmount,
    bool isOutOfTolerance,
    double? tolerance,
    bool toleranceCheckEnabled,
    SettlementStep settlementStep,
    OrderOperationModel? settlementOperation,
    String? settlementMethod,
    String? settlementRedirectUrl,
    double? settlementReservedAmount,
    String? settlementBankAccount,
    String? settlementBankName,
    String? settlementAccountHolder,
    String? settlementTrackingCode,
    List<XFile> settlementDocs,
    bool isWalletBalanceSufficient,
    bool isSettlementCompleted,
    int settlementCountdown,
    bool isSettlementTimerActive,
    int clearanceOtpCountdown,
    bool isClearanceOtpTimerActive,
    String? settlementMobile,
    String? disbursementMobile,
    String? disbursementRedirectUrl,
    String? disbursementGatewayType,
    bool isPrinting,
    PrintStatus printStatus,
    String? lastPrintedFilePath,
    int currentPage,
    int totalCount,
    bool isPaginationLoading,
    bool hasMoreData,
  });
}

/// @nodoc
class __$$OrdersStateImplCopyWithImpl<$Res>
    extends _$OrdersStateCopyWithImpl<$Res, _$OrdersStateImpl>
    implements _$$OrdersStateImplCopyWith<$Res> {
  __$$OrdersStateImplCopyWithImpl(
    _$OrdersStateImpl _value,
    $Res Function(_$OrdersStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrdersState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? errorMessage = null,
    Object? allOrders = null,
    Object? filteredOrders = null,
    Object? searchQuery = null,
    Object? isSearchActive = null,
    Object? selectedBadges = null,
    Object? selectedOrder = freezed,
    Object? selectedTabIndex = null,
    Object? isCreditPlanExpanded = null,
    Object? isFinancialSectionExpanded = null,
    Object? isProductsExpanded = null,
    Object? isCustomerInfoExpanded = null,
    Object? isDocumentsExpanded = null,
    Object? isFinancialSummaryExpanded = null,
    Object? isClearanceSectionExpanded = null,
    Object? selectedStatusId = freezed,
    Object? selectedSubPlanId = freezed,
    Object? subPlans = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? selectedDateOptionId = freezed,
    Object? deepLinkPaymentOutcome = null,
    Object? pendingNavigation = freezed,
    Object? clearanceStep = null,
    Object? clearanceAmount = null,
    Object? disburseOperation = freezed,
    Object? excessAmount = freezed,
    Object? gatewayType = freezed,
    Object? walletName = freezed,
    Object? uploadedClearanceDoc = freezed,
    Object? uploadedClearanceDocId = freezed,
    Object? orderAmount = freezed,
    Object? isOutOfTolerance = null,
    Object? tolerance = freezed,
    Object? toleranceCheckEnabled = null,
    Object? settlementStep = null,
    Object? settlementOperation = freezed,
    Object? settlementMethod = freezed,
    Object? settlementRedirectUrl = freezed,
    Object? settlementReservedAmount = freezed,
    Object? settlementBankAccount = freezed,
    Object? settlementBankName = freezed,
    Object? settlementAccountHolder = freezed,
    Object? settlementTrackingCode = freezed,
    Object? settlementDocs = null,
    Object? isWalletBalanceSufficient = null,
    Object? isSettlementCompleted = null,
    Object? settlementCountdown = null,
    Object? isSettlementTimerActive = null,
    Object? clearanceOtpCountdown = null,
    Object? isClearanceOtpTimerActive = null,
    Object? settlementMobile = freezed,
    Object? disbursementMobile = freezed,
    Object? disbursementRedirectUrl = freezed,
    Object? disbursementGatewayType = freezed,
    Object? isPrinting = null,
    Object? printStatus = null,
    Object? lastPrintedFilePath = freezed,
    Object? currentPage = null,
    Object? totalCount = null,
    Object? isPaginationLoading = null,
    Object? hasMoreData = null,
  }) {
    return _then(
      _$OrdersStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as OrdersRequestStatus,
        errorMessage: null == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String,
        allOrders: null == allOrders
            ? _value._allOrders
            : allOrders // ignore: cast_nullable_to_non_nullable
                  as List<OrderSummaryModel>,
        filteredOrders: null == filteredOrders
            ? _value._filteredOrders
            : filteredOrders // ignore: cast_nullable_to_non_nullable
                  as List<OrderSummaryModel>,
        searchQuery: null == searchQuery
            ? _value.searchQuery
            : searchQuery // ignore: cast_nullable_to_non_nullable
                  as String,
        isSearchActive: null == isSearchActive
            ? _value.isSearchActive
            : isSearchActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        selectedBadges: null == selectedBadges
            ? _value._selectedBadges
            : selectedBadges // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        selectedOrder: freezed == selectedOrder
            ? _value.selectedOrder
            : selectedOrder // ignore: cast_nullable_to_non_nullable
                  as OrderDetailModel?,
        selectedTabIndex: null == selectedTabIndex
            ? _value.selectedTabIndex
            : selectedTabIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        isCreditPlanExpanded: null == isCreditPlanExpanded
            ? _value.isCreditPlanExpanded
            : isCreditPlanExpanded // ignore: cast_nullable_to_non_nullable
                  as bool,
        isFinancialSectionExpanded: null == isFinancialSectionExpanded
            ? _value.isFinancialSectionExpanded
            : isFinancialSectionExpanded // ignore: cast_nullable_to_non_nullable
                  as bool,
        isProductsExpanded: null == isProductsExpanded
            ? _value.isProductsExpanded
            : isProductsExpanded // ignore: cast_nullable_to_non_nullable
                  as bool,
        isCustomerInfoExpanded: null == isCustomerInfoExpanded
            ? _value.isCustomerInfoExpanded
            : isCustomerInfoExpanded // ignore: cast_nullable_to_non_nullable
                  as bool,
        isDocumentsExpanded: null == isDocumentsExpanded
            ? _value.isDocumentsExpanded
            : isDocumentsExpanded // ignore: cast_nullable_to_non_nullable
                  as bool,
        isFinancialSummaryExpanded: null == isFinancialSummaryExpanded
            ? _value.isFinancialSummaryExpanded
            : isFinancialSummaryExpanded // ignore: cast_nullable_to_non_nullable
                  as bool,
        isClearanceSectionExpanded: null == isClearanceSectionExpanded
            ? _value.isClearanceSectionExpanded
            : isClearanceSectionExpanded // ignore: cast_nullable_to_non_nullable
                  as bool,
        selectedStatusId: freezed == selectedStatusId
            ? _value.selectedStatusId
            : selectedStatusId // ignore: cast_nullable_to_non_nullable
                  as String?,
        selectedSubPlanId: freezed == selectedSubPlanId
            ? _value.selectedSubPlanId
            : selectedSubPlanId // ignore: cast_nullable_to_non_nullable
                  as String?,
        subPlans: null == subPlans
            ? _value._subPlans
            : subPlans // ignore: cast_nullable_to_non_nullable
                  as List<SubPlanDtoModel>,
        startDate: freezed == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as Jalali?,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as Jalali?,
        selectedDateOptionId: freezed == selectedDateOptionId
            ? _value.selectedDateOptionId
            : selectedDateOptionId // ignore: cast_nullable_to_non_nullable
                  as String?,
        deepLinkPaymentOutcome: null == deepLinkPaymentOutcome
            ? _value.deepLinkPaymentOutcome
            : deepLinkPaymentOutcome // ignore: cast_nullable_to_non_nullable
                  as PaymentOutcome,
        pendingNavigation: freezed == pendingNavigation
            ? _value._pendingNavigation
            : pendingNavigation // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        clearanceStep: null == clearanceStep
            ? _value.clearanceStep
            : clearanceStep // ignore: cast_nullable_to_non_nullable
                  as ClearanceStep,
        clearanceAmount: null == clearanceAmount
            ? _value.clearanceAmount
            : clearanceAmount // ignore: cast_nullable_to_non_nullable
                  as String,
        disburseOperation: freezed == disburseOperation
            ? _value.disburseOperation
            : disburseOperation // ignore: cast_nullable_to_non_nullable
                  as OrderOperationModel?,
        excessAmount: freezed == excessAmount
            ? _value.excessAmount
            : excessAmount // ignore: cast_nullable_to_non_nullable
                  as String?,
        gatewayType: freezed == gatewayType
            ? _value.gatewayType
            : gatewayType // ignore: cast_nullable_to_non_nullable
                  as GatewayType?,
        walletName: freezed == walletName
            ? _value.walletName
            : walletName // ignore: cast_nullable_to_non_nullable
                  as String?,
        uploadedClearanceDoc: freezed == uploadedClearanceDoc
            ? _value.uploadedClearanceDoc
            : uploadedClearanceDoc // ignore: cast_nullable_to_non_nullable
                  as XFile?,
        uploadedClearanceDocId: freezed == uploadedClearanceDocId
            ? _value.uploadedClearanceDocId
            : uploadedClearanceDocId // ignore: cast_nullable_to_non_nullable
                  as String?,
        orderAmount: freezed == orderAmount
            ? _value.orderAmount
            : orderAmount // ignore: cast_nullable_to_non_nullable
                  as String?,
        isOutOfTolerance: null == isOutOfTolerance
            ? _value.isOutOfTolerance
            : isOutOfTolerance // ignore: cast_nullable_to_non_nullable
                  as bool,
        tolerance: freezed == tolerance
            ? _value.tolerance
            : tolerance // ignore: cast_nullable_to_non_nullable
                  as double?,
        toleranceCheckEnabled: null == toleranceCheckEnabled
            ? _value.toleranceCheckEnabled
            : toleranceCheckEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        settlementStep: null == settlementStep
            ? _value.settlementStep
            : settlementStep // ignore: cast_nullable_to_non_nullable
                  as SettlementStep,
        settlementOperation: freezed == settlementOperation
            ? _value.settlementOperation
            : settlementOperation // ignore: cast_nullable_to_non_nullable
                  as OrderOperationModel?,
        settlementMethod: freezed == settlementMethod
            ? _value.settlementMethod
            : settlementMethod // ignore: cast_nullable_to_non_nullable
                  as String?,
        settlementRedirectUrl: freezed == settlementRedirectUrl
            ? _value.settlementRedirectUrl
            : settlementRedirectUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        settlementReservedAmount: freezed == settlementReservedAmount
            ? _value.settlementReservedAmount
            : settlementReservedAmount // ignore: cast_nullable_to_non_nullable
                  as double?,
        settlementBankAccount: freezed == settlementBankAccount
            ? _value.settlementBankAccount
            : settlementBankAccount // ignore: cast_nullable_to_non_nullable
                  as String?,
        settlementBankName: freezed == settlementBankName
            ? _value.settlementBankName
            : settlementBankName // ignore: cast_nullable_to_non_nullable
                  as String?,
        settlementAccountHolder: freezed == settlementAccountHolder
            ? _value.settlementAccountHolder
            : settlementAccountHolder // ignore: cast_nullable_to_non_nullable
                  as String?,
        settlementTrackingCode: freezed == settlementTrackingCode
            ? _value.settlementTrackingCode
            : settlementTrackingCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        settlementDocs: null == settlementDocs
            ? _value._settlementDocs
            : settlementDocs // ignore: cast_nullable_to_non_nullable
                  as List<XFile>,
        isWalletBalanceSufficient: null == isWalletBalanceSufficient
            ? _value.isWalletBalanceSufficient
            : isWalletBalanceSufficient // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSettlementCompleted: null == isSettlementCompleted
            ? _value.isSettlementCompleted
            : isSettlementCompleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        settlementCountdown: null == settlementCountdown
            ? _value.settlementCountdown
            : settlementCountdown // ignore: cast_nullable_to_non_nullable
                  as int,
        isSettlementTimerActive: null == isSettlementTimerActive
            ? _value.isSettlementTimerActive
            : isSettlementTimerActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        clearanceOtpCountdown: null == clearanceOtpCountdown
            ? _value.clearanceOtpCountdown
            : clearanceOtpCountdown // ignore: cast_nullable_to_non_nullable
                  as int,
        isClearanceOtpTimerActive: null == isClearanceOtpTimerActive
            ? _value.isClearanceOtpTimerActive
            : isClearanceOtpTimerActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        settlementMobile: freezed == settlementMobile
            ? _value.settlementMobile
            : settlementMobile // ignore: cast_nullable_to_non_nullable
                  as String?,
        disbursementMobile: freezed == disbursementMobile
            ? _value.disbursementMobile
            : disbursementMobile // ignore: cast_nullable_to_non_nullable
                  as String?,
        disbursementRedirectUrl: freezed == disbursementRedirectUrl
            ? _value.disbursementRedirectUrl
            : disbursementRedirectUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        disbursementGatewayType: freezed == disbursementGatewayType
            ? _value.disbursementGatewayType
            : disbursementGatewayType // ignore: cast_nullable_to_non_nullable
                  as String?,
        isPrinting: null == isPrinting
            ? _value.isPrinting
            : isPrinting // ignore: cast_nullable_to_non_nullable
                  as bool,
        printStatus: null == printStatus
            ? _value.printStatus
            : printStatus // ignore: cast_nullable_to_non_nullable
                  as PrintStatus,
        lastPrintedFilePath: freezed == lastPrintedFilePath
            ? _value.lastPrintedFilePath
            : lastPrintedFilePath // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentPage: null == currentPage
            ? _value.currentPage
            : currentPage // ignore: cast_nullable_to_non_nullable
                  as int,
        totalCount: null == totalCount
            ? _value.totalCount
            : totalCount // ignore: cast_nullable_to_non_nullable
                  as int,
        isPaginationLoading: null == isPaginationLoading
            ? _value.isPaginationLoading
            : isPaginationLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasMoreData: null == hasMoreData
            ? _value.hasMoreData
            : hasMoreData // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$OrdersStateImpl implements _OrdersState {
  const _$OrdersStateImpl({
    this.status = OrdersRequestStatus.initial,
    this.errorMessage = '',
    final List<OrderSummaryModel> allOrders = const [],
    final List<OrderSummaryModel> filteredOrders = const [],
    this.searchQuery = '',
    this.isSearchActive = false,
    final List<String> selectedBadges = const [],
    this.selectedOrder,
    this.selectedTabIndex = 0,
    this.isCreditPlanExpanded = true,
    this.isFinancialSectionExpanded = true,
    this.isProductsExpanded = true,
    this.isCustomerInfoExpanded = true,
    this.isDocumentsExpanded = true,
    this.isFinancialSummaryExpanded = true,
    this.isClearanceSectionExpanded = true,
    this.selectedStatusId,
    this.selectedSubPlanId,
    final List<SubPlanDtoModel> subPlans = const [],
    this.startDate,
    this.endDate,
    this.selectedDateOptionId,
    this.deepLinkPaymentOutcome = PaymentOutcome.initial,
    final Map<String, dynamic>? pendingNavigation,
    this.clearanceStep = ClearanceStep.initial,
    this.clearanceAmount = '',
    this.disburseOperation,
    this.excessAmount,
    this.gatewayType,
    this.walletName,
    this.uploadedClearanceDoc,
    this.uploadedClearanceDocId,
    this.orderAmount,
    this.isOutOfTolerance = false,
    this.tolerance,
    this.toleranceCheckEnabled = true,
    this.settlementStep = SettlementStep.initial,
    this.settlementOperation,
    this.settlementMethod = 'ipg_sms',
    this.settlementRedirectUrl,
    this.settlementReservedAmount,
    this.settlementBankAccount,
    this.settlementBankName,
    this.settlementAccountHolder,
    this.settlementTrackingCode,
    final List<XFile> settlementDocs = const [],
    this.isWalletBalanceSufficient = true,
    this.isSettlementCompleted = false,
    this.settlementCountdown = 60,
    this.isSettlementTimerActive = false,
    this.clearanceOtpCountdown = 120,
    this.isClearanceOtpTimerActive = false,
    this.settlementMobile,
    this.disbursementMobile,
    this.disbursementRedirectUrl,
    this.disbursementGatewayType,
    this.isPrinting = false,
    this.printStatus = PrintStatus.initial,
    this.lastPrintedFilePath,
    this.currentPage = 1,
    this.totalCount = 0,
    this.isPaginationLoading = false,
    this.hasMoreData = true,
  }) : _allOrders = allOrders,
       _filteredOrders = filteredOrders,
       _selectedBadges = selectedBadges,
       _subPlans = subPlans,
       _pendingNavigation = pendingNavigation,
       _settlementDocs = settlementDocs;

  @override
  @JsonKey()
  final OrdersRequestStatus status;
  @override
  @JsonKey()
  final String errorMessage;
  final List<OrderSummaryModel> _allOrders;
  @override
  @JsonKey()
  List<OrderSummaryModel> get allOrders {
    if (_allOrders is EqualUnmodifiableListView) return _allOrders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allOrders);
  }

  final List<OrderSummaryModel> _filteredOrders;
  @override
  @JsonKey()
  List<OrderSummaryModel> get filteredOrders {
    if (_filteredOrders is EqualUnmodifiableListView) return _filteredOrders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredOrders);
  }

  @override
  @JsonKey()
  final String searchQuery;
  @override
  @JsonKey()
  final bool isSearchActive;
  final List<String> _selectedBadges;
  @override
  @JsonKey()
  List<String> get selectedBadges {
    if (_selectedBadges is EqualUnmodifiableListView) return _selectedBadges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedBadges);
  }

  @override
  final OrderDetailModel? selectedOrder;
  @override
  @JsonKey()
  final int selectedTabIndex;
  @override
  @JsonKey()
  final bool isCreditPlanExpanded;
  @override
  @JsonKey()
  final bool isFinancialSectionExpanded;
  @override
  @JsonKey()
  final bool isProductsExpanded;
  @override
  @JsonKey()
  final bool isCustomerInfoExpanded;
  @override
  @JsonKey()
  final bool isDocumentsExpanded;
  @override
  @JsonKey()
  final bool isFinancialSummaryExpanded;
  @override
  @JsonKey()
  final bool isClearanceSectionExpanded;
  @override
  final String? selectedStatusId;
  @override
  final String? selectedSubPlanId;
  final List<SubPlanDtoModel> _subPlans;
  @override
  @JsonKey()
  List<SubPlanDtoModel> get subPlans {
    if (_subPlans is EqualUnmodifiableListView) return _subPlans;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subPlans);
  }

  @override
  final Jalali? startDate;
  @override
  final Jalali? endDate;
  @override
  final String? selectedDateOptionId;
  // Deep Link Flow
  @override
  @JsonKey()
  final PaymentOutcome deepLinkPaymentOutcome;
  final Map<String, dynamic>? _pendingNavigation;
  @override
  Map<String, dynamic>? get pendingNavigation {
    final value = _pendingNavigation;
    if (value == null) return null;
    if (_pendingNavigation is EqualUnmodifiableMapView)
      return _pendingNavigation;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  // Clearance Flow
  @override
  @JsonKey()
  final ClearanceStep clearanceStep;
  @override
  @JsonKey()
  final String clearanceAmount;
  @override
  final OrderOperationModel? disburseOperation;
  @override
  final String? excessAmount;
  @override
  final GatewayType? gatewayType;
  @override
  final String? walletName;
  @override
  final XFile? uploadedClearanceDoc;
  @override
  final String? uploadedClearanceDocId;
  @override
  final String? orderAmount;
  @override
  @JsonKey()
  final bool isOutOfTolerance;
  @override
  final double? tolerance;
  @override
  @JsonKey()
  final bool toleranceCheckEnabled;
  // Settlement Flow
  @override
  @JsonKey()
  final SettlementStep settlementStep;
  @override
  final OrderOperationModel? settlementOperation;
  @override
  @JsonKey()
  final String? settlementMethod;
  @override
  final String? settlementRedirectUrl;
  @override
  final double? settlementReservedAmount;
  @override
  final String? settlementBankAccount;
  @override
  final String? settlementBankName;
  @override
  final String? settlementAccountHolder;
  @override
  final String? settlementTrackingCode;
  final List<XFile> _settlementDocs;
  @override
  @JsonKey()
  List<XFile> get settlementDocs {
    if (_settlementDocs is EqualUnmodifiableListView) return _settlementDocs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_settlementDocs);
  }

  @override
  @JsonKey()
  final bool isWalletBalanceSufficient;
  @override
  @JsonKey()
  final bool isSettlementCompleted;
  // Settlement Timer (for "Send Link" mode)
  @override
  @JsonKey()
  final int settlementCountdown;
  @override
  @JsonKey()
  final bool isSettlementTimerActive;
  // Clearance OTP Timer
  @override
  @JsonKey()
  final int clearanceOtpCountdown;
  @override
  @JsonKey()
  final bool isClearanceOtpTimerActive;
  // Settlement Extras
  @override
  final String? settlementMobile;
  // Disbursement Extras
  @override
  final String? disbursementMobile;
  @override
  final String? disbursementRedirectUrl;
  @override
  final String? disbursementGatewayType;
  // Printing
  @override
  @JsonKey()
  final bool isPrinting;
  @override
  @JsonKey()
  final PrintStatus printStatus;
  @override
  final String? lastPrintedFilePath;
  // Pagination
  @override
  @JsonKey()
  final int currentPage;
  @override
  @JsonKey()
  final int totalCount;
  @override
  @JsonKey()
  final bool isPaginationLoading;
  @override
  @JsonKey()
  final bool hasMoreData;

  @override
  String toString() {
    return 'OrdersState(status: $status, errorMessage: $errorMessage, allOrders: $allOrders, filteredOrders: $filteredOrders, searchQuery: $searchQuery, isSearchActive: $isSearchActive, selectedBadges: $selectedBadges, selectedOrder: $selectedOrder, selectedTabIndex: $selectedTabIndex, isCreditPlanExpanded: $isCreditPlanExpanded, isFinancialSectionExpanded: $isFinancialSectionExpanded, isProductsExpanded: $isProductsExpanded, isCustomerInfoExpanded: $isCustomerInfoExpanded, isDocumentsExpanded: $isDocumentsExpanded, isFinancialSummaryExpanded: $isFinancialSummaryExpanded, isClearanceSectionExpanded: $isClearanceSectionExpanded, selectedStatusId: $selectedStatusId, selectedSubPlanId: $selectedSubPlanId, subPlans: $subPlans, startDate: $startDate, endDate: $endDate, selectedDateOptionId: $selectedDateOptionId, deepLinkPaymentOutcome: $deepLinkPaymentOutcome, pendingNavigation: $pendingNavigation, clearanceStep: $clearanceStep, clearanceAmount: $clearanceAmount, disburseOperation: $disburseOperation, excessAmount: $excessAmount, gatewayType: $gatewayType, walletName: $walletName, uploadedClearanceDoc: $uploadedClearanceDoc, uploadedClearanceDocId: $uploadedClearanceDocId, orderAmount: $orderAmount, isOutOfTolerance: $isOutOfTolerance, tolerance: $tolerance, toleranceCheckEnabled: $toleranceCheckEnabled, settlementStep: $settlementStep, settlementOperation: $settlementOperation, settlementMethod: $settlementMethod, settlementRedirectUrl: $settlementRedirectUrl, settlementReservedAmount: $settlementReservedAmount, settlementBankAccount: $settlementBankAccount, settlementBankName: $settlementBankName, settlementAccountHolder: $settlementAccountHolder, settlementTrackingCode: $settlementTrackingCode, settlementDocs: $settlementDocs, isWalletBalanceSufficient: $isWalletBalanceSufficient, isSettlementCompleted: $isSettlementCompleted, settlementCountdown: $settlementCountdown, isSettlementTimerActive: $isSettlementTimerActive, clearanceOtpCountdown: $clearanceOtpCountdown, isClearanceOtpTimerActive: $isClearanceOtpTimerActive, settlementMobile: $settlementMobile, disbursementMobile: $disbursementMobile, disbursementRedirectUrl: $disbursementRedirectUrl, disbursementGatewayType: $disbursementGatewayType, isPrinting: $isPrinting, printStatus: $printStatus, lastPrintedFilePath: $lastPrintedFilePath, currentPage: $currentPage, totalCount: $totalCount, isPaginationLoading: $isPaginationLoading, hasMoreData: $hasMoreData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrdersStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality().equals(
              other._allOrders,
              _allOrders,
            ) &&
            const DeepCollectionEquality().equals(
              other._filteredOrders,
              _filteredOrders,
            ) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.isSearchActive, isSearchActive) ||
                other.isSearchActive == isSearchActive) &&
            const DeepCollectionEquality().equals(
              other._selectedBadges,
              _selectedBadges,
            ) &&
            (identical(other.selectedOrder, selectedOrder) ||
                other.selectedOrder == selectedOrder) &&
            (identical(other.selectedTabIndex, selectedTabIndex) ||
                other.selectedTabIndex == selectedTabIndex) &&
            (identical(other.isCreditPlanExpanded, isCreditPlanExpanded) ||
                other.isCreditPlanExpanded == isCreditPlanExpanded) &&
            (identical(
                  other.isFinancialSectionExpanded,
                  isFinancialSectionExpanded,
                ) ||
                other.isFinancialSectionExpanded ==
                    isFinancialSectionExpanded) &&
            (identical(other.isProductsExpanded, isProductsExpanded) ||
                other.isProductsExpanded == isProductsExpanded) &&
            (identical(other.isCustomerInfoExpanded, isCustomerInfoExpanded) ||
                other.isCustomerInfoExpanded == isCustomerInfoExpanded) &&
            (identical(other.isDocumentsExpanded, isDocumentsExpanded) ||
                other.isDocumentsExpanded == isDocumentsExpanded) &&
            (identical(
                  other.isFinancialSummaryExpanded,
                  isFinancialSummaryExpanded,
                ) ||
                other.isFinancialSummaryExpanded ==
                    isFinancialSummaryExpanded) &&
            (identical(
                  other.isClearanceSectionExpanded,
                  isClearanceSectionExpanded,
                ) ||
                other.isClearanceSectionExpanded ==
                    isClearanceSectionExpanded) &&
            (identical(other.selectedStatusId, selectedStatusId) ||
                other.selectedStatusId == selectedStatusId) &&
            (identical(other.selectedSubPlanId, selectedSubPlanId) ||
                other.selectedSubPlanId == selectedSubPlanId) &&
            const DeepCollectionEquality().equals(other._subPlans, _subPlans) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.selectedDateOptionId, selectedDateOptionId) ||
                other.selectedDateOptionId == selectedDateOptionId) &&
            (identical(other.deepLinkPaymentOutcome, deepLinkPaymentOutcome) ||
                other.deepLinkPaymentOutcome == deepLinkPaymentOutcome) &&
            const DeepCollectionEquality().equals(
              other._pendingNavigation,
              _pendingNavigation,
            ) &&
            (identical(other.clearanceStep, clearanceStep) ||
                other.clearanceStep == clearanceStep) &&
            (identical(other.clearanceAmount, clearanceAmount) ||
                other.clearanceAmount == clearanceAmount) &&
            (identical(other.disburseOperation, disburseOperation) ||
                other.disburseOperation == disburseOperation) &&
            (identical(other.excessAmount, excessAmount) ||
                other.excessAmount == excessAmount) &&
            (identical(other.gatewayType, gatewayType) ||
                other.gatewayType == gatewayType) &&
            (identical(other.walletName, walletName) ||
                other.walletName == walletName) &&
            (identical(other.uploadedClearanceDoc, uploadedClearanceDoc) ||
                other.uploadedClearanceDoc == uploadedClearanceDoc) &&
            (identical(other.uploadedClearanceDocId, uploadedClearanceDocId) ||
                other.uploadedClearanceDocId == uploadedClearanceDocId) &&
            (identical(other.orderAmount, orderAmount) ||
                other.orderAmount == orderAmount) &&
            (identical(other.isOutOfTolerance, isOutOfTolerance) ||
                other.isOutOfTolerance == isOutOfTolerance) &&
            (identical(other.tolerance, tolerance) ||
                other.tolerance == tolerance) &&
            (identical(other.toleranceCheckEnabled, toleranceCheckEnabled) ||
                other.toleranceCheckEnabled == toleranceCheckEnabled) &&
            (identical(other.settlementStep, settlementStep) ||
                other.settlementStep == settlementStep) &&
            (identical(other.settlementOperation, settlementOperation) ||
                other.settlementOperation == settlementOperation) &&
            (identical(other.settlementMethod, settlementMethod) ||
                other.settlementMethod == settlementMethod) &&
            (identical(other.settlementRedirectUrl, settlementRedirectUrl) ||
                other.settlementRedirectUrl == settlementRedirectUrl) &&
            (identical(
                  other.settlementReservedAmount,
                  settlementReservedAmount,
                ) ||
                other.settlementReservedAmount == settlementReservedAmount) &&
            (identical(other.settlementBankAccount, settlementBankAccount) ||
                other.settlementBankAccount == settlementBankAccount) &&
            (identical(other.settlementBankName, settlementBankName) ||
                other.settlementBankName == settlementBankName) &&
            (identical(
                  other.settlementAccountHolder,
                  settlementAccountHolder,
                ) ||
                other.settlementAccountHolder == settlementAccountHolder) &&
            (identical(other.settlementTrackingCode, settlementTrackingCode) ||
                other.settlementTrackingCode == settlementTrackingCode) &&
            const DeepCollectionEquality().equals(
              other._settlementDocs,
              _settlementDocs,
            ) &&
            (identical(
                  other.isWalletBalanceSufficient,
                  isWalletBalanceSufficient,
                ) ||
                other.isWalletBalanceSufficient == isWalletBalanceSufficient) &&
            (identical(other.isSettlementCompleted, isSettlementCompleted) ||
                other.isSettlementCompleted == isSettlementCompleted) &&
            (identical(other.settlementCountdown, settlementCountdown) ||
                other.settlementCountdown == settlementCountdown) &&
            (identical(
                  other.isSettlementTimerActive,
                  isSettlementTimerActive,
                ) ||
                other.isSettlementTimerActive == isSettlementTimerActive) &&
            (identical(other.clearanceOtpCountdown, clearanceOtpCountdown) ||
                other.clearanceOtpCountdown == clearanceOtpCountdown) &&
            (identical(
                  other.isClearanceOtpTimerActive,
                  isClearanceOtpTimerActive,
                ) ||
                other.isClearanceOtpTimerActive == isClearanceOtpTimerActive) &&
            (identical(other.settlementMobile, settlementMobile) ||
                other.settlementMobile == settlementMobile) &&
            (identical(other.disbursementMobile, disbursementMobile) ||
                other.disbursementMobile == disbursementMobile) &&
            (identical(
                  other.disbursementRedirectUrl,
                  disbursementRedirectUrl,
                ) ||
                other.disbursementRedirectUrl == disbursementRedirectUrl) &&
            (identical(
                  other.disbursementGatewayType,
                  disbursementGatewayType,
                ) ||
                other.disbursementGatewayType == disbursementGatewayType) &&
            (identical(other.isPrinting, isPrinting) ||
                other.isPrinting == isPrinting) &&
            (identical(other.printStatus, printStatus) ||
                other.printStatus == printStatus) &&
            (identical(other.lastPrintedFilePath, lastPrintedFilePath) ||
                other.lastPrintedFilePath == lastPrintedFilePath) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.isPaginationLoading, isPaginationLoading) ||
                other.isPaginationLoading == isPaginationLoading) &&
            (identical(other.hasMoreData, hasMoreData) ||
                other.hasMoreData == hasMoreData));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    status,
    errorMessage,
    const DeepCollectionEquality().hash(_allOrders),
    const DeepCollectionEquality().hash(_filteredOrders),
    searchQuery,
    isSearchActive,
    const DeepCollectionEquality().hash(_selectedBadges),
    selectedOrder,
    selectedTabIndex,
    isCreditPlanExpanded,
    isFinancialSectionExpanded,
    isProductsExpanded,
    isCustomerInfoExpanded,
    isDocumentsExpanded,
    isFinancialSummaryExpanded,
    isClearanceSectionExpanded,
    selectedStatusId,
    selectedSubPlanId,
    const DeepCollectionEquality().hash(_subPlans),
    startDate,
    endDate,
    selectedDateOptionId,
    deepLinkPaymentOutcome,
    const DeepCollectionEquality().hash(_pendingNavigation),
    clearanceStep,
    clearanceAmount,
    disburseOperation,
    excessAmount,
    gatewayType,
    walletName,
    uploadedClearanceDoc,
    uploadedClearanceDocId,
    orderAmount,
    isOutOfTolerance,
    tolerance,
    toleranceCheckEnabled,
    settlementStep,
    settlementOperation,
    settlementMethod,
    settlementRedirectUrl,
    settlementReservedAmount,
    settlementBankAccount,
    settlementBankName,
    settlementAccountHolder,
    settlementTrackingCode,
    const DeepCollectionEquality().hash(_settlementDocs),
    isWalletBalanceSufficient,
    isSettlementCompleted,
    settlementCountdown,
    isSettlementTimerActive,
    clearanceOtpCountdown,
    isClearanceOtpTimerActive,
    settlementMobile,
    disbursementMobile,
    disbursementRedirectUrl,
    disbursementGatewayType,
    isPrinting,
    printStatus,
    lastPrintedFilePath,
    currentPage,
    totalCount,
    isPaginationLoading,
    hasMoreData,
  ]);

  /// Create a copy of OrdersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrdersStateImplCopyWith<_$OrdersStateImpl> get copyWith =>
      __$$OrdersStateImplCopyWithImpl<_$OrdersStateImpl>(this, _$identity);
}

abstract class _OrdersState implements OrdersState {
  const factory _OrdersState({
    final OrdersRequestStatus status,
    final String errorMessage,
    final List<OrderSummaryModel> allOrders,
    final List<OrderSummaryModel> filteredOrders,
    final String searchQuery,
    final bool isSearchActive,
    final List<String> selectedBadges,
    final OrderDetailModel? selectedOrder,
    final int selectedTabIndex,
    final bool isCreditPlanExpanded,
    final bool isFinancialSectionExpanded,
    final bool isProductsExpanded,
    final bool isCustomerInfoExpanded,
    final bool isDocumentsExpanded,
    final bool isFinancialSummaryExpanded,
    final bool isClearanceSectionExpanded,
    final String? selectedStatusId,
    final String? selectedSubPlanId,
    final List<SubPlanDtoModel> subPlans,
    final Jalali? startDate,
    final Jalali? endDate,
    final String? selectedDateOptionId,
    final PaymentOutcome deepLinkPaymentOutcome,
    final Map<String, dynamic>? pendingNavigation,
    final ClearanceStep clearanceStep,
    final String clearanceAmount,
    final OrderOperationModel? disburseOperation,
    final String? excessAmount,
    final GatewayType? gatewayType,
    final String? walletName,
    final XFile? uploadedClearanceDoc,
    final String? uploadedClearanceDocId,
    final String? orderAmount,
    final bool isOutOfTolerance,
    final double? tolerance,
    final bool toleranceCheckEnabled,
    final SettlementStep settlementStep,
    final OrderOperationModel? settlementOperation,
    final String? settlementMethod,
    final String? settlementRedirectUrl,
    final double? settlementReservedAmount,
    final String? settlementBankAccount,
    final String? settlementBankName,
    final String? settlementAccountHolder,
    final String? settlementTrackingCode,
    final List<XFile> settlementDocs,
    final bool isWalletBalanceSufficient,
    final bool isSettlementCompleted,
    final int settlementCountdown,
    final bool isSettlementTimerActive,
    final int clearanceOtpCountdown,
    final bool isClearanceOtpTimerActive,
    final String? settlementMobile,
    final String? disbursementMobile,
    final String? disbursementRedirectUrl,
    final String? disbursementGatewayType,
    final bool isPrinting,
    final PrintStatus printStatus,
    final String? lastPrintedFilePath,
    final int currentPage,
    final int totalCount,
    final bool isPaginationLoading,
    final bool hasMoreData,
  }) = _$OrdersStateImpl;

  @override
  OrdersRequestStatus get status;
  @override
  String get errorMessage;
  @override
  List<OrderSummaryModel> get allOrders;
  @override
  List<OrderSummaryModel> get filteredOrders;
  @override
  String get searchQuery;
  @override
  bool get isSearchActive;
  @override
  List<String> get selectedBadges;
  @override
  OrderDetailModel? get selectedOrder;
  @override
  int get selectedTabIndex;
  @override
  bool get isCreditPlanExpanded;
  @override
  bool get isFinancialSectionExpanded;
  @override
  bool get isProductsExpanded;
  @override
  bool get isCustomerInfoExpanded;
  @override
  bool get isDocumentsExpanded;
  @override
  bool get isFinancialSummaryExpanded;
  @override
  bool get isClearanceSectionExpanded;
  @override
  String? get selectedStatusId;
  @override
  String? get selectedSubPlanId;
  @override
  List<SubPlanDtoModel> get subPlans;
  @override
  Jalali? get startDate;
  @override
  Jalali? get endDate;
  @override
  String? get selectedDateOptionId; // Deep Link Flow
  @override
  PaymentOutcome get deepLinkPaymentOutcome;
  @override
  Map<String, dynamic>? get pendingNavigation; // Clearance Flow
  @override
  ClearanceStep get clearanceStep;
  @override
  String get clearanceAmount;
  @override
  OrderOperationModel? get disburseOperation;
  @override
  String? get excessAmount;
  @override
  GatewayType? get gatewayType;
  @override
  String? get walletName;
  @override
  XFile? get uploadedClearanceDoc;
  @override
  String? get uploadedClearanceDocId;
  @override
  String? get orderAmount;
  @override
  bool get isOutOfTolerance;
  @override
  double? get tolerance;
  @override
  bool get toleranceCheckEnabled; // Settlement Flow
  @override
  SettlementStep get settlementStep;
  @override
  OrderOperationModel? get settlementOperation;
  @override
  String? get settlementMethod;
  @override
  String? get settlementRedirectUrl;
  @override
  double? get settlementReservedAmount;
  @override
  String? get settlementBankAccount;
  @override
  String? get settlementBankName;
  @override
  String? get settlementAccountHolder;
  @override
  String? get settlementTrackingCode;
  @override
  List<XFile> get settlementDocs;
  @override
  bool get isWalletBalanceSufficient;
  @override
  bool get isSettlementCompleted; // Settlement Timer (for "Send Link" mode)
  @override
  int get settlementCountdown;
  @override
  bool get isSettlementTimerActive; // Clearance OTP Timer
  @override
  int get clearanceOtpCountdown;
  @override
  bool get isClearanceOtpTimerActive; // Settlement Extras
  @override
  String? get settlementMobile; // Disbursement Extras
  @override
  String? get disbursementMobile;
  @override
  String? get disbursementRedirectUrl;
  @override
  String? get disbursementGatewayType; // Printing
  @override
  bool get isPrinting;
  @override
  PrintStatus get printStatus;
  @override
  String? get lastPrintedFilePath; // Pagination
  @override
  int get currentPage;
  @override
  int get totalCount;
  @override
  bool get isPaginationLoading;
  @override
  bool get hasMoreData;

  /// Create a copy of OrdersState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrdersStateImplCopyWith<_$OrdersStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
