// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pre_invoice_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PreInvoiceState {
  PreInvoiceRequestStatus get status => throw _privateConstructorUsedError;
  String get errorMessage =>
      throw _privateConstructorUsedError; // Step tracking
  PreInvoiceStep get currentStep =>
      throw _privateConstructorUsedError; // Step 1 — Credit Plan
  List<CreditPlanItemModel> get creditPlans =>
      throw _privateConstructorUsedError;
  int get currentCreditPlanPage => throw _privateConstructorUsedError;
  bool get hasMoreCreditPlans => throw _privateConstructorUsedError;
  bool get isCreditPlanPaginationLoading => throw _privateConstructorUsedError;
  String? get selectedCreditPlanId =>
      throw _privateConstructorUsedError; // Step 2 — Products
  bool get isSearchActive => throw _privateConstructorUsedError;
  String get searchQuery => throw _privateConstructorUsedError;
  List<PreInvoiceChipModel> get filterChips =>
      throw _privateConstructorUsedError;
  int get selectedChipIndex => throw _privateConstructorUsedError;
  List<PreInvoiceProductModel> get allProducts =>
      throw _privateConstructorUsedError;
  List<PreInvoiceProductModel> get filteredProducts =>
      throw _privateConstructorUsedError;
  int get totalProductCount => throw _privateConstructorUsedError;
  int get currentProductPage => throw _privateConstructorUsedError;
  bool get hasMoreProducts => throw _privateConstructorUsedError;
  bool get isProductPaginationLoading => throw _privateConstructorUsedError;
  bool get showAvailableOnly => throw _privateConstructorUsedError;
  List<CartItemModel> get cartItems => throw _privateConstructorUsedError;
  bool get isCartVisible => throw _privateConstructorUsedError;
  String? get selectedCategoryId => throw _privateConstructorUsedError;
  List<CategoryDtoModel> get availableCategories =>
      throw _privateConstructorUsedError;
  int get currentCategoryPage => throw _privateConstructorUsedError;
  bool get hasMoreCategories => throw _privateConstructorUsedError;
  bool get isCategoryPaginationLoading => throw _privateConstructorUsedError;
  String? get selectedSortOrder => throw _privateConstructorUsedError;
  String? get selectedBrandId => throw _privateConstructorUsedError;
  List<BrandDtoModel> get availableBrands => throw _privateConstructorUsedError;
  int get currentBrandPage => throw _privateConstructorUsedError;
  bool get hasMoreBrands => throw _privateConstructorUsedError;
  bool get isBrandPaginationLoading =>
      throw _privateConstructorUsedError; // Summary
  String get totalAmount => throw _privateConstructorUsedError;
  String get totalDiscounts => throw _privateConstructorUsedError;
  String get payableAmount => throw _privateConstructorUsedError;
  int get totalQuantity =>
      throw _privateConstructorUsedError; // Step 3 — Customer Info
  String get customerIdQuery => throw _privateConstructorUsedError;
  bool get isNationalIdValid => throw _privateConstructorUsedError;
  bool get isPhoneNumberValid => throw _privateConstructorUsedError;
  bool get isPostalCodeValid => throw _privateConstructorUsedError;
  CustomerInfoModel? get customerInfo => throw _privateConstructorUsedError;
  CustomerInfoModel? get originalCustomerInfo =>
      throw _privateConstructorUsedError;
  bool get customerSearchLoading => throw _privateConstructorUsedError;
  bool get isExistingCustomer =>
      throw _privateConstructorUsedError; // Step 4 — Documents
  XFile? get mandatoryDoc => throw _privateConstructorUsedError;
  String? get mandatoryDocId => throw _privateConstructorUsedError;
  List<XFile> get optionalDocs => throw _privateConstructorUsedError;
  List<String> get optionalDocIds => throw _privateConstructorUsedError;
  String? get createdOrderId => throw _privateConstructorUsedError;
  bool get isEditMode => throw _privateConstructorUsedError;
  bool get isSubmittingPreInvoice => throw _privateConstructorUsedError;
  bool get isSubmittingAndClearing => throw _privateConstructorUsedError;
  bool get isUploadingDocuments => throw _privateConstructorUsedError;
  bool get isSubmittingCustomerInfo => throw _privateConstructorUsedError;

  /// Create a copy of PreInvoiceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PreInvoiceStateCopyWith<PreInvoiceState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PreInvoiceStateCopyWith<$Res> {
  factory $PreInvoiceStateCopyWith(
    PreInvoiceState value,
    $Res Function(PreInvoiceState) then,
  ) = _$PreInvoiceStateCopyWithImpl<$Res, PreInvoiceState>;
  @useResult
  $Res call({
    PreInvoiceRequestStatus status,
    String errorMessage,
    PreInvoiceStep currentStep,
    List<CreditPlanItemModel> creditPlans,
    int currentCreditPlanPage,
    bool hasMoreCreditPlans,
    bool isCreditPlanPaginationLoading,
    String? selectedCreditPlanId,
    bool isSearchActive,
    String searchQuery,
    List<PreInvoiceChipModel> filterChips,
    int selectedChipIndex,
    List<PreInvoiceProductModel> allProducts,
    List<PreInvoiceProductModel> filteredProducts,
    int totalProductCount,
    int currentProductPage,
    bool hasMoreProducts,
    bool isProductPaginationLoading,
    bool showAvailableOnly,
    List<CartItemModel> cartItems,
    bool isCartVisible,
    String? selectedCategoryId,
    List<CategoryDtoModel> availableCategories,
    int currentCategoryPage,
    bool hasMoreCategories,
    bool isCategoryPaginationLoading,
    String? selectedSortOrder,
    String? selectedBrandId,
    List<BrandDtoModel> availableBrands,
    int currentBrandPage,
    bool hasMoreBrands,
    bool isBrandPaginationLoading,
    String totalAmount,
    String totalDiscounts,
    String payableAmount,
    int totalQuantity,
    String customerIdQuery,
    bool isNationalIdValid,
    bool isPhoneNumberValid,
    bool isPostalCodeValid,
    CustomerInfoModel? customerInfo,
    CustomerInfoModel? originalCustomerInfo,
    bool customerSearchLoading,
    bool isExistingCustomer,
    XFile? mandatoryDoc,
    String? mandatoryDocId,
    List<XFile> optionalDocs,
    List<String> optionalDocIds,
    String? createdOrderId,
    bool isEditMode,
    bool isSubmittingPreInvoice,
    bool isSubmittingAndClearing,
    bool isUploadingDocuments,
    bool isSubmittingCustomerInfo,
  });
}

/// @nodoc
class _$PreInvoiceStateCopyWithImpl<$Res, $Val extends PreInvoiceState>
    implements $PreInvoiceStateCopyWith<$Res> {
  _$PreInvoiceStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PreInvoiceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? errorMessage = null,
    Object? currentStep = null,
    Object? creditPlans = null,
    Object? currentCreditPlanPage = null,
    Object? hasMoreCreditPlans = null,
    Object? isCreditPlanPaginationLoading = null,
    Object? selectedCreditPlanId = freezed,
    Object? isSearchActive = null,
    Object? searchQuery = null,
    Object? filterChips = null,
    Object? selectedChipIndex = null,
    Object? allProducts = null,
    Object? filteredProducts = null,
    Object? totalProductCount = null,
    Object? currentProductPage = null,
    Object? hasMoreProducts = null,
    Object? isProductPaginationLoading = null,
    Object? showAvailableOnly = null,
    Object? cartItems = null,
    Object? isCartVisible = null,
    Object? selectedCategoryId = freezed,
    Object? availableCategories = null,
    Object? currentCategoryPage = null,
    Object? hasMoreCategories = null,
    Object? isCategoryPaginationLoading = null,
    Object? selectedSortOrder = freezed,
    Object? selectedBrandId = freezed,
    Object? availableBrands = null,
    Object? currentBrandPage = null,
    Object? hasMoreBrands = null,
    Object? isBrandPaginationLoading = null,
    Object? totalAmount = null,
    Object? totalDiscounts = null,
    Object? payableAmount = null,
    Object? totalQuantity = null,
    Object? customerIdQuery = null,
    Object? isNationalIdValid = null,
    Object? isPhoneNumberValid = null,
    Object? isPostalCodeValid = null,
    Object? customerInfo = freezed,
    Object? originalCustomerInfo = freezed,
    Object? customerSearchLoading = null,
    Object? isExistingCustomer = null,
    Object? mandatoryDoc = freezed,
    Object? mandatoryDocId = freezed,
    Object? optionalDocs = null,
    Object? optionalDocIds = null,
    Object? createdOrderId = freezed,
    Object? isEditMode = null,
    Object? isSubmittingPreInvoice = null,
    Object? isSubmittingAndClearing = null,
    Object? isUploadingDocuments = null,
    Object? isSubmittingCustomerInfo = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as PreInvoiceRequestStatus,
            errorMessage: null == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String,
            currentStep: null == currentStep
                ? _value.currentStep
                : currentStep // ignore: cast_nullable_to_non_nullable
                      as PreInvoiceStep,
            creditPlans: null == creditPlans
                ? _value.creditPlans
                : creditPlans // ignore: cast_nullable_to_non_nullable
                      as List<CreditPlanItemModel>,
            currentCreditPlanPage: null == currentCreditPlanPage
                ? _value.currentCreditPlanPage
                : currentCreditPlanPage // ignore: cast_nullable_to_non_nullable
                      as int,
            hasMoreCreditPlans: null == hasMoreCreditPlans
                ? _value.hasMoreCreditPlans
                : hasMoreCreditPlans // ignore: cast_nullable_to_non_nullable
                      as bool,
            isCreditPlanPaginationLoading: null == isCreditPlanPaginationLoading
                ? _value.isCreditPlanPaginationLoading
                : isCreditPlanPaginationLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            selectedCreditPlanId: freezed == selectedCreditPlanId
                ? _value.selectedCreditPlanId
                : selectedCreditPlanId // ignore: cast_nullable_to_non_nullable
                      as String?,
            isSearchActive: null == isSearchActive
                ? _value.isSearchActive
                : isSearchActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            searchQuery: null == searchQuery
                ? _value.searchQuery
                : searchQuery // ignore: cast_nullable_to_non_nullable
                      as String,
            filterChips: null == filterChips
                ? _value.filterChips
                : filterChips // ignore: cast_nullable_to_non_nullable
                      as List<PreInvoiceChipModel>,
            selectedChipIndex: null == selectedChipIndex
                ? _value.selectedChipIndex
                : selectedChipIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            allProducts: null == allProducts
                ? _value.allProducts
                : allProducts // ignore: cast_nullable_to_non_nullable
                      as List<PreInvoiceProductModel>,
            filteredProducts: null == filteredProducts
                ? _value.filteredProducts
                : filteredProducts // ignore: cast_nullable_to_non_nullable
                      as List<PreInvoiceProductModel>,
            totalProductCount: null == totalProductCount
                ? _value.totalProductCount
                : totalProductCount // ignore: cast_nullable_to_non_nullable
                      as int,
            currentProductPage: null == currentProductPage
                ? _value.currentProductPage
                : currentProductPage // ignore: cast_nullable_to_non_nullable
                      as int,
            hasMoreProducts: null == hasMoreProducts
                ? _value.hasMoreProducts
                : hasMoreProducts // ignore: cast_nullable_to_non_nullable
                      as bool,
            isProductPaginationLoading: null == isProductPaginationLoading
                ? _value.isProductPaginationLoading
                : isProductPaginationLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            showAvailableOnly: null == showAvailableOnly
                ? _value.showAvailableOnly
                : showAvailableOnly // ignore: cast_nullable_to_non_nullable
                      as bool,
            cartItems: null == cartItems
                ? _value.cartItems
                : cartItems // ignore: cast_nullable_to_non_nullable
                      as List<CartItemModel>,
            isCartVisible: null == isCartVisible
                ? _value.isCartVisible
                : isCartVisible // ignore: cast_nullable_to_non_nullable
                      as bool,
            selectedCategoryId: freezed == selectedCategoryId
                ? _value.selectedCategoryId
                : selectedCategoryId // ignore: cast_nullable_to_non_nullable
                      as String?,
            availableCategories: null == availableCategories
                ? _value.availableCategories
                : availableCategories // ignore: cast_nullable_to_non_nullable
                      as List<CategoryDtoModel>,
            currentCategoryPage: null == currentCategoryPage
                ? _value.currentCategoryPage
                : currentCategoryPage // ignore: cast_nullable_to_non_nullable
                      as int,
            hasMoreCategories: null == hasMoreCategories
                ? _value.hasMoreCategories
                : hasMoreCategories // ignore: cast_nullable_to_non_nullable
                      as bool,
            isCategoryPaginationLoading: null == isCategoryPaginationLoading
                ? _value.isCategoryPaginationLoading
                : isCategoryPaginationLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            selectedSortOrder: freezed == selectedSortOrder
                ? _value.selectedSortOrder
                : selectedSortOrder // ignore: cast_nullable_to_non_nullable
                      as String?,
            selectedBrandId: freezed == selectedBrandId
                ? _value.selectedBrandId
                : selectedBrandId // ignore: cast_nullable_to_non_nullable
                      as String?,
            availableBrands: null == availableBrands
                ? _value.availableBrands
                : availableBrands // ignore: cast_nullable_to_non_nullable
                      as List<BrandDtoModel>,
            currentBrandPage: null == currentBrandPage
                ? _value.currentBrandPage
                : currentBrandPage // ignore: cast_nullable_to_non_nullable
                      as int,
            hasMoreBrands: null == hasMoreBrands
                ? _value.hasMoreBrands
                : hasMoreBrands // ignore: cast_nullable_to_non_nullable
                      as bool,
            isBrandPaginationLoading: null == isBrandPaginationLoading
                ? _value.isBrandPaginationLoading
                : isBrandPaginationLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            totalAmount: null == totalAmount
                ? _value.totalAmount
                : totalAmount // ignore: cast_nullable_to_non_nullable
                      as String,
            totalDiscounts: null == totalDiscounts
                ? _value.totalDiscounts
                : totalDiscounts // ignore: cast_nullable_to_non_nullable
                      as String,
            payableAmount: null == payableAmount
                ? _value.payableAmount
                : payableAmount // ignore: cast_nullable_to_non_nullable
                      as String,
            totalQuantity: null == totalQuantity
                ? _value.totalQuantity
                : totalQuantity // ignore: cast_nullable_to_non_nullable
                      as int,
            customerIdQuery: null == customerIdQuery
                ? _value.customerIdQuery
                : customerIdQuery // ignore: cast_nullable_to_non_nullable
                      as String,
            isNationalIdValid: null == isNationalIdValid
                ? _value.isNationalIdValid
                : isNationalIdValid // ignore: cast_nullable_to_non_nullable
                      as bool,
            isPhoneNumberValid: null == isPhoneNumberValid
                ? _value.isPhoneNumberValid
                : isPhoneNumberValid // ignore: cast_nullable_to_non_nullable
                      as bool,
            isPostalCodeValid: null == isPostalCodeValid
                ? _value.isPostalCodeValid
                : isPostalCodeValid // ignore: cast_nullable_to_non_nullable
                      as bool,
            customerInfo: freezed == customerInfo
                ? _value.customerInfo
                : customerInfo // ignore: cast_nullable_to_non_nullable
                      as CustomerInfoModel?,
            originalCustomerInfo: freezed == originalCustomerInfo
                ? _value.originalCustomerInfo
                : originalCustomerInfo // ignore: cast_nullable_to_non_nullable
                      as CustomerInfoModel?,
            customerSearchLoading: null == customerSearchLoading
                ? _value.customerSearchLoading
                : customerSearchLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isExistingCustomer: null == isExistingCustomer
                ? _value.isExistingCustomer
                : isExistingCustomer // ignore: cast_nullable_to_non_nullable
                      as bool,
            mandatoryDoc: freezed == mandatoryDoc
                ? _value.mandatoryDoc
                : mandatoryDoc // ignore: cast_nullable_to_non_nullable
                      as XFile?,
            mandatoryDocId: freezed == mandatoryDocId
                ? _value.mandatoryDocId
                : mandatoryDocId // ignore: cast_nullable_to_non_nullable
                      as String?,
            optionalDocs: null == optionalDocs
                ? _value.optionalDocs
                : optionalDocs // ignore: cast_nullable_to_non_nullable
                      as List<XFile>,
            optionalDocIds: null == optionalDocIds
                ? _value.optionalDocIds
                : optionalDocIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            createdOrderId: freezed == createdOrderId
                ? _value.createdOrderId
                : createdOrderId // ignore: cast_nullable_to_non_nullable
                      as String?,
            isEditMode: null == isEditMode
                ? _value.isEditMode
                : isEditMode // ignore: cast_nullable_to_non_nullable
                      as bool,
            isSubmittingPreInvoice: null == isSubmittingPreInvoice
                ? _value.isSubmittingPreInvoice
                : isSubmittingPreInvoice // ignore: cast_nullable_to_non_nullable
                      as bool,
            isSubmittingAndClearing: null == isSubmittingAndClearing
                ? _value.isSubmittingAndClearing
                : isSubmittingAndClearing // ignore: cast_nullable_to_non_nullable
                      as bool,
            isUploadingDocuments: null == isUploadingDocuments
                ? _value.isUploadingDocuments
                : isUploadingDocuments // ignore: cast_nullable_to_non_nullable
                      as bool,
            isSubmittingCustomerInfo: null == isSubmittingCustomerInfo
                ? _value.isSubmittingCustomerInfo
                : isSubmittingCustomerInfo // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PreInvoiceStateImplCopyWith<$Res>
    implements $PreInvoiceStateCopyWith<$Res> {
  factory _$$PreInvoiceStateImplCopyWith(
    _$PreInvoiceStateImpl value,
    $Res Function(_$PreInvoiceStateImpl) then,
  ) = __$$PreInvoiceStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    PreInvoiceRequestStatus status,
    String errorMessage,
    PreInvoiceStep currentStep,
    List<CreditPlanItemModel> creditPlans,
    int currentCreditPlanPage,
    bool hasMoreCreditPlans,
    bool isCreditPlanPaginationLoading,
    String? selectedCreditPlanId,
    bool isSearchActive,
    String searchQuery,
    List<PreInvoiceChipModel> filterChips,
    int selectedChipIndex,
    List<PreInvoiceProductModel> allProducts,
    List<PreInvoiceProductModel> filteredProducts,
    int totalProductCount,
    int currentProductPage,
    bool hasMoreProducts,
    bool isProductPaginationLoading,
    bool showAvailableOnly,
    List<CartItemModel> cartItems,
    bool isCartVisible,
    String? selectedCategoryId,
    List<CategoryDtoModel> availableCategories,
    int currentCategoryPage,
    bool hasMoreCategories,
    bool isCategoryPaginationLoading,
    String? selectedSortOrder,
    String? selectedBrandId,
    List<BrandDtoModel> availableBrands,
    int currentBrandPage,
    bool hasMoreBrands,
    bool isBrandPaginationLoading,
    String totalAmount,
    String totalDiscounts,
    String payableAmount,
    int totalQuantity,
    String customerIdQuery,
    bool isNationalIdValid,
    bool isPhoneNumberValid,
    bool isPostalCodeValid,
    CustomerInfoModel? customerInfo,
    CustomerInfoModel? originalCustomerInfo,
    bool customerSearchLoading,
    bool isExistingCustomer,
    XFile? mandatoryDoc,
    String? mandatoryDocId,
    List<XFile> optionalDocs,
    List<String> optionalDocIds,
    String? createdOrderId,
    bool isEditMode,
    bool isSubmittingPreInvoice,
    bool isSubmittingAndClearing,
    bool isUploadingDocuments,
    bool isSubmittingCustomerInfo,
  });
}

/// @nodoc
class __$$PreInvoiceStateImplCopyWithImpl<$Res>
    extends _$PreInvoiceStateCopyWithImpl<$Res, _$PreInvoiceStateImpl>
    implements _$$PreInvoiceStateImplCopyWith<$Res> {
  __$$PreInvoiceStateImplCopyWithImpl(
    _$PreInvoiceStateImpl _value,
    $Res Function(_$PreInvoiceStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PreInvoiceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? errorMessage = null,
    Object? currentStep = null,
    Object? creditPlans = null,
    Object? currentCreditPlanPage = null,
    Object? hasMoreCreditPlans = null,
    Object? isCreditPlanPaginationLoading = null,
    Object? selectedCreditPlanId = freezed,
    Object? isSearchActive = null,
    Object? searchQuery = null,
    Object? filterChips = null,
    Object? selectedChipIndex = null,
    Object? allProducts = null,
    Object? filteredProducts = null,
    Object? totalProductCount = null,
    Object? currentProductPage = null,
    Object? hasMoreProducts = null,
    Object? isProductPaginationLoading = null,
    Object? showAvailableOnly = null,
    Object? cartItems = null,
    Object? isCartVisible = null,
    Object? selectedCategoryId = freezed,
    Object? availableCategories = null,
    Object? currentCategoryPage = null,
    Object? hasMoreCategories = null,
    Object? isCategoryPaginationLoading = null,
    Object? selectedSortOrder = freezed,
    Object? selectedBrandId = freezed,
    Object? availableBrands = null,
    Object? currentBrandPage = null,
    Object? hasMoreBrands = null,
    Object? isBrandPaginationLoading = null,
    Object? totalAmount = null,
    Object? totalDiscounts = null,
    Object? payableAmount = null,
    Object? totalQuantity = null,
    Object? customerIdQuery = null,
    Object? isNationalIdValid = null,
    Object? isPhoneNumberValid = null,
    Object? isPostalCodeValid = null,
    Object? customerInfo = freezed,
    Object? originalCustomerInfo = freezed,
    Object? customerSearchLoading = null,
    Object? isExistingCustomer = null,
    Object? mandatoryDoc = freezed,
    Object? mandatoryDocId = freezed,
    Object? optionalDocs = null,
    Object? optionalDocIds = null,
    Object? createdOrderId = freezed,
    Object? isEditMode = null,
    Object? isSubmittingPreInvoice = null,
    Object? isSubmittingAndClearing = null,
    Object? isUploadingDocuments = null,
    Object? isSubmittingCustomerInfo = null,
  }) {
    return _then(
      _$PreInvoiceStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as PreInvoiceRequestStatus,
        errorMessage: null == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String,
        currentStep: null == currentStep
            ? _value.currentStep
            : currentStep // ignore: cast_nullable_to_non_nullable
                  as PreInvoiceStep,
        creditPlans: null == creditPlans
            ? _value._creditPlans
            : creditPlans // ignore: cast_nullable_to_non_nullable
                  as List<CreditPlanItemModel>,
        currentCreditPlanPage: null == currentCreditPlanPage
            ? _value.currentCreditPlanPage
            : currentCreditPlanPage // ignore: cast_nullable_to_non_nullable
                  as int,
        hasMoreCreditPlans: null == hasMoreCreditPlans
            ? _value.hasMoreCreditPlans
            : hasMoreCreditPlans // ignore: cast_nullable_to_non_nullable
                  as bool,
        isCreditPlanPaginationLoading: null == isCreditPlanPaginationLoading
            ? _value.isCreditPlanPaginationLoading
            : isCreditPlanPaginationLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        selectedCreditPlanId: freezed == selectedCreditPlanId
            ? _value.selectedCreditPlanId
            : selectedCreditPlanId // ignore: cast_nullable_to_non_nullable
                  as String?,
        isSearchActive: null == isSearchActive
            ? _value.isSearchActive
            : isSearchActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        searchQuery: null == searchQuery
            ? _value.searchQuery
            : searchQuery // ignore: cast_nullable_to_non_nullable
                  as String,
        filterChips: null == filterChips
            ? _value._filterChips
            : filterChips // ignore: cast_nullable_to_non_nullable
                  as List<PreInvoiceChipModel>,
        selectedChipIndex: null == selectedChipIndex
            ? _value.selectedChipIndex
            : selectedChipIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        allProducts: null == allProducts
            ? _value._allProducts
            : allProducts // ignore: cast_nullable_to_non_nullable
                  as List<PreInvoiceProductModel>,
        filteredProducts: null == filteredProducts
            ? _value._filteredProducts
            : filteredProducts // ignore: cast_nullable_to_non_nullable
                  as List<PreInvoiceProductModel>,
        totalProductCount: null == totalProductCount
            ? _value.totalProductCount
            : totalProductCount // ignore: cast_nullable_to_non_nullable
                  as int,
        currentProductPage: null == currentProductPage
            ? _value.currentProductPage
            : currentProductPage // ignore: cast_nullable_to_non_nullable
                  as int,
        hasMoreProducts: null == hasMoreProducts
            ? _value.hasMoreProducts
            : hasMoreProducts // ignore: cast_nullable_to_non_nullable
                  as bool,
        isProductPaginationLoading: null == isProductPaginationLoading
            ? _value.isProductPaginationLoading
            : isProductPaginationLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        showAvailableOnly: null == showAvailableOnly
            ? _value.showAvailableOnly
            : showAvailableOnly // ignore: cast_nullable_to_non_nullable
                  as bool,
        cartItems: null == cartItems
            ? _value._cartItems
            : cartItems // ignore: cast_nullable_to_non_nullable
                  as List<CartItemModel>,
        isCartVisible: null == isCartVisible
            ? _value.isCartVisible
            : isCartVisible // ignore: cast_nullable_to_non_nullable
                  as bool,
        selectedCategoryId: freezed == selectedCategoryId
            ? _value.selectedCategoryId
            : selectedCategoryId // ignore: cast_nullable_to_non_nullable
                  as String?,
        availableCategories: null == availableCategories
            ? _value._availableCategories
            : availableCategories // ignore: cast_nullable_to_non_nullable
                  as List<CategoryDtoModel>,
        currentCategoryPage: null == currentCategoryPage
            ? _value.currentCategoryPage
            : currentCategoryPage // ignore: cast_nullable_to_non_nullable
                  as int,
        hasMoreCategories: null == hasMoreCategories
            ? _value.hasMoreCategories
            : hasMoreCategories // ignore: cast_nullable_to_non_nullable
                  as bool,
        isCategoryPaginationLoading: null == isCategoryPaginationLoading
            ? _value.isCategoryPaginationLoading
            : isCategoryPaginationLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        selectedSortOrder: freezed == selectedSortOrder
            ? _value.selectedSortOrder
            : selectedSortOrder // ignore: cast_nullable_to_non_nullable
                  as String?,
        selectedBrandId: freezed == selectedBrandId
            ? _value.selectedBrandId
            : selectedBrandId // ignore: cast_nullable_to_non_nullable
                  as String?,
        availableBrands: null == availableBrands
            ? _value._availableBrands
            : availableBrands // ignore: cast_nullable_to_non_nullable
                  as List<BrandDtoModel>,
        currentBrandPage: null == currentBrandPage
            ? _value.currentBrandPage
            : currentBrandPage // ignore: cast_nullable_to_non_nullable
                  as int,
        hasMoreBrands: null == hasMoreBrands
            ? _value.hasMoreBrands
            : hasMoreBrands // ignore: cast_nullable_to_non_nullable
                  as bool,
        isBrandPaginationLoading: null == isBrandPaginationLoading
            ? _value.isBrandPaginationLoading
            : isBrandPaginationLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        totalAmount: null == totalAmount
            ? _value.totalAmount
            : totalAmount // ignore: cast_nullable_to_non_nullable
                  as String,
        totalDiscounts: null == totalDiscounts
            ? _value.totalDiscounts
            : totalDiscounts // ignore: cast_nullable_to_non_nullable
                  as String,
        payableAmount: null == payableAmount
            ? _value.payableAmount
            : payableAmount // ignore: cast_nullable_to_non_nullable
                  as String,
        totalQuantity: null == totalQuantity
            ? _value.totalQuantity
            : totalQuantity // ignore: cast_nullable_to_non_nullable
                  as int,
        customerIdQuery: null == customerIdQuery
            ? _value.customerIdQuery
            : customerIdQuery // ignore: cast_nullable_to_non_nullable
                  as String,
        isNationalIdValid: null == isNationalIdValid
            ? _value.isNationalIdValid
            : isNationalIdValid // ignore: cast_nullable_to_non_nullable
                  as bool,
        isPhoneNumberValid: null == isPhoneNumberValid
            ? _value.isPhoneNumberValid
            : isPhoneNumberValid // ignore: cast_nullable_to_non_nullable
                  as bool,
        isPostalCodeValid: null == isPostalCodeValid
            ? _value.isPostalCodeValid
            : isPostalCodeValid // ignore: cast_nullable_to_non_nullable
                  as bool,
        customerInfo: freezed == customerInfo
            ? _value.customerInfo
            : customerInfo // ignore: cast_nullable_to_non_nullable
                  as CustomerInfoModel?,
        originalCustomerInfo: freezed == originalCustomerInfo
            ? _value.originalCustomerInfo
            : originalCustomerInfo // ignore: cast_nullable_to_non_nullable
                  as CustomerInfoModel?,
        customerSearchLoading: null == customerSearchLoading
            ? _value.customerSearchLoading
            : customerSearchLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isExistingCustomer: null == isExistingCustomer
            ? _value.isExistingCustomer
            : isExistingCustomer // ignore: cast_nullable_to_non_nullable
                  as bool,
        mandatoryDoc: freezed == mandatoryDoc
            ? _value.mandatoryDoc
            : mandatoryDoc // ignore: cast_nullable_to_non_nullable
                  as XFile?,
        mandatoryDocId: freezed == mandatoryDocId
            ? _value.mandatoryDocId
            : mandatoryDocId // ignore: cast_nullable_to_non_nullable
                  as String?,
        optionalDocs: null == optionalDocs
            ? _value._optionalDocs
            : optionalDocs // ignore: cast_nullable_to_non_nullable
                  as List<XFile>,
        optionalDocIds: null == optionalDocIds
            ? _value._optionalDocIds
            : optionalDocIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        createdOrderId: freezed == createdOrderId
            ? _value.createdOrderId
            : createdOrderId // ignore: cast_nullable_to_non_nullable
                  as String?,
        isEditMode: null == isEditMode
            ? _value.isEditMode
            : isEditMode // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSubmittingPreInvoice: null == isSubmittingPreInvoice
            ? _value.isSubmittingPreInvoice
            : isSubmittingPreInvoice // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSubmittingAndClearing: null == isSubmittingAndClearing
            ? _value.isSubmittingAndClearing
            : isSubmittingAndClearing // ignore: cast_nullable_to_non_nullable
                  as bool,
        isUploadingDocuments: null == isUploadingDocuments
            ? _value.isUploadingDocuments
            : isUploadingDocuments // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSubmittingCustomerInfo: null == isSubmittingCustomerInfo
            ? _value.isSubmittingCustomerInfo
            : isSubmittingCustomerInfo // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$PreInvoiceStateImpl implements _PreInvoiceState {
  const _$PreInvoiceStateImpl({
    this.status = PreInvoiceRequestStatus.initial,
    this.errorMessage = '',
    this.currentStep = PreInvoiceStep.creditPlan,
    final List<CreditPlanItemModel> creditPlans = const [],
    this.currentCreditPlanPage = 1,
    this.hasMoreCreditPlans = false,
    this.isCreditPlanPaginationLoading = false,
    this.selectedCreditPlanId,
    this.isSearchActive = false,
    this.searchQuery = '',
    final List<PreInvoiceChipModel> filterChips = const [],
    this.selectedChipIndex = 0,
    final List<PreInvoiceProductModel> allProducts = const [],
    final List<PreInvoiceProductModel> filteredProducts = const [],
    this.totalProductCount = 0,
    this.currentProductPage = 1,
    this.hasMoreProducts = false,
    this.isProductPaginationLoading = false,
    this.showAvailableOnly = false,
    final List<CartItemModel> cartItems = const [],
    this.isCartVisible = false,
    this.selectedCategoryId,
    final List<CategoryDtoModel> availableCategories = const [],
    this.currentCategoryPage = 1,
    this.hasMoreCategories = false,
    this.isCategoryPaginationLoading = false,
    this.selectedSortOrder,
    this.selectedBrandId,
    final List<BrandDtoModel> availableBrands = const [],
    this.currentBrandPage = 1,
    this.hasMoreBrands = false,
    this.isBrandPaginationLoading = false,
    this.totalAmount = '0',
    this.totalDiscounts = '0',
    this.payableAmount = '0',
    this.totalQuantity = 0,
    this.customerIdQuery = '',
    this.isNationalIdValid = false,
    this.isPhoneNumberValid = true,
    this.isPostalCodeValid = true,
    this.customerInfo,
    this.originalCustomerInfo,
    this.customerSearchLoading = false,
    this.isExistingCustomer = false,
    this.mandatoryDoc,
    this.mandatoryDocId,
    final List<XFile> optionalDocs = const [],
    final List<String> optionalDocIds = const [],
    this.createdOrderId,
    this.isEditMode = false,
    this.isSubmittingPreInvoice = false,
    this.isSubmittingAndClearing = false,
    this.isUploadingDocuments = false,
    this.isSubmittingCustomerInfo = false,
  }) : _creditPlans = creditPlans,
       _filterChips = filterChips,
       _allProducts = allProducts,
       _filteredProducts = filteredProducts,
       _cartItems = cartItems,
       _availableCategories = availableCategories,
       _availableBrands = availableBrands,
       _optionalDocs = optionalDocs,
       _optionalDocIds = optionalDocIds;

  @override
  @JsonKey()
  final PreInvoiceRequestStatus status;
  @override
  @JsonKey()
  final String errorMessage;
  // Step tracking
  @override
  @JsonKey()
  final PreInvoiceStep currentStep;
  // Step 1 — Credit Plan
  final List<CreditPlanItemModel> _creditPlans;
  // Step 1 — Credit Plan
  @override
  @JsonKey()
  List<CreditPlanItemModel> get creditPlans {
    if (_creditPlans is EqualUnmodifiableListView) return _creditPlans;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_creditPlans);
  }

  @override
  @JsonKey()
  final int currentCreditPlanPage;
  @override
  @JsonKey()
  final bool hasMoreCreditPlans;
  @override
  @JsonKey()
  final bool isCreditPlanPaginationLoading;
  @override
  final String? selectedCreditPlanId;
  // Step 2 — Products
  @override
  @JsonKey()
  final bool isSearchActive;
  @override
  @JsonKey()
  final String searchQuery;
  final List<PreInvoiceChipModel> _filterChips;
  @override
  @JsonKey()
  List<PreInvoiceChipModel> get filterChips {
    if (_filterChips is EqualUnmodifiableListView) return _filterChips;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filterChips);
  }

  @override
  @JsonKey()
  final int selectedChipIndex;
  final List<PreInvoiceProductModel> _allProducts;
  @override
  @JsonKey()
  List<PreInvoiceProductModel> get allProducts {
    if (_allProducts is EqualUnmodifiableListView) return _allProducts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allProducts);
  }

  final List<PreInvoiceProductModel> _filteredProducts;
  @override
  @JsonKey()
  List<PreInvoiceProductModel> get filteredProducts {
    if (_filteredProducts is EqualUnmodifiableListView)
      return _filteredProducts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredProducts);
  }

  @override
  @JsonKey()
  final int totalProductCount;
  @override
  @JsonKey()
  final int currentProductPage;
  @override
  @JsonKey()
  final bool hasMoreProducts;
  @override
  @JsonKey()
  final bool isProductPaginationLoading;
  @override
  @JsonKey()
  final bool showAvailableOnly;
  final List<CartItemModel> _cartItems;
  @override
  @JsonKey()
  List<CartItemModel> get cartItems {
    if (_cartItems is EqualUnmodifiableListView) return _cartItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cartItems);
  }

  @override
  @JsonKey()
  final bool isCartVisible;
  @override
  final String? selectedCategoryId;
  final List<CategoryDtoModel> _availableCategories;
  @override
  @JsonKey()
  List<CategoryDtoModel> get availableCategories {
    if (_availableCategories is EqualUnmodifiableListView)
      return _availableCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableCategories);
  }

  @override
  @JsonKey()
  final int currentCategoryPage;
  @override
  @JsonKey()
  final bool hasMoreCategories;
  @override
  @JsonKey()
  final bool isCategoryPaginationLoading;
  @override
  final String? selectedSortOrder;
  @override
  final String? selectedBrandId;
  final List<BrandDtoModel> _availableBrands;
  @override
  @JsonKey()
  List<BrandDtoModel> get availableBrands {
    if (_availableBrands is EqualUnmodifiableListView) return _availableBrands;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableBrands);
  }

  @override
  @JsonKey()
  final int currentBrandPage;
  @override
  @JsonKey()
  final bool hasMoreBrands;
  @override
  @JsonKey()
  final bool isBrandPaginationLoading;
  // Summary
  @override
  @JsonKey()
  final String totalAmount;
  @override
  @JsonKey()
  final String totalDiscounts;
  @override
  @JsonKey()
  final String payableAmount;
  @override
  @JsonKey()
  final int totalQuantity;
  // Step 3 — Customer Info
  @override
  @JsonKey()
  final String customerIdQuery;
  @override
  @JsonKey()
  final bool isNationalIdValid;
  @override
  @JsonKey()
  final bool isPhoneNumberValid;
  @override
  @JsonKey()
  final bool isPostalCodeValid;
  @override
  final CustomerInfoModel? customerInfo;
  @override
  final CustomerInfoModel? originalCustomerInfo;
  @override
  @JsonKey()
  final bool customerSearchLoading;
  @override
  @JsonKey()
  final bool isExistingCustomer;
  // Step 4 — Documents
  @override
  final XFile? mandatoryDoc;
  @override
  final String? mandatoryDocId;
  final List<XFile> _optionalDocs;
  @override
  @JsonKey()
  List<XFile> get optionalDocs {
    if (_optionalDocs is EqualUnmodifiableListView) return _optionalDocs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_optionalDocs);
  }

  final List<String> _optionalDocIds;
  @override
  @JsonKey()
  List<String> get optionalDocIds {
    if (_optionalDocIds is EqualUnmodifiableListView) return _optionalDocIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_optionalDocIds);
  }

  @override
  final String? createdOrderId;
  @override
  @JsonKey()
  final bool isEditMode;
  @override
  @JsonKey()
  final bool isSubmittingPreInvoice;
  @override
  @JsonKey()
  final bool isSubmittingAndClearing;
  @override
  @JsonKey()
  final bool isUploadingDocuments;
  @override
  @JsonKey()
  final bool isSubmittingCustomerInfo;

  @override
  String toString() {
    return 'PreInvoiceState(status: $status, errorMessage: $errorMessage, currentStep: $currentStep, creditPlans: $creditPlans, currentCreditPlanPage: $currentCreditPlanPage, hasMoreCreditPlans: $hasMoreCreditPlans, isCreditPlanPaginationLoading: $isCreditPlanPaginationLoading, selectedCreditPlanId: $selectedCreditPlanId, isSearchActive: $isSearchActive, searchQuery: $searchQuery, filterChips: $filterChips, selectedChipIndex: $selectedChipIndex, allProducts: $allProducts, filteredProducts: $filteredProducts, totalProductCount: $totalProductCount, currentProductPage: $currentProductPage, hasMoreProducts: $hasMoreProducts, isProductPaginationLoading: $isProductPaginationLoading, showAvailableOnly: $showAvailableOnly, cartItems: $cartItems, isCartVisible: $isCartVisible, selectedCategoryId: $selectedCategoryId, availableCategories: $availableCategories, currentCategoryPage: $currentCategoryPage, hasMoreCategories: $hasMoreCategories, isCategoryPaginationLoading: $isCategoryPaginationLoading, selectedSortOrder: $selectedSortOrder, selectedBrandId: $selectedBrandId, availableBrands: $availableBrands, currentBrandPage: $currentBrandPage, hasMoreBrands: $hasMoreBrands, isBrandPaginationLoading: $isBrandPaginationLoading, totalAmount: $totalAmount, totalDiscounts: $totalDiscounts, payableAmount: $payableAmount, totalQuantity: $totalQuantity, customerIdQuery: $customerIdQuery, isNationalIdValid: $isNationalIdValid, isPhoneNumberValid: $isPhoneNumberValid, isPostalCodeValid: $isPostalCodeValid, customerInfo: $customerInfo, originalCustomerInfo: $originalCustomerInfo, customerSearchLoading: $customerSearchLoading, isExistingCustomer: $isExistingCustomer, mandatoryDoc: $mandatoryDoc, mandatoryDocId: $mandatoryDocId, optionalDocs: $optionalDocs, optionalDocIds: $optionalDocIds, createdOrderId: $createdOrderId, isEditMode: $isEditMode, isSubmittingPreInvoice: $isSubmittingPreInvoice, isSubmittingAndClearing: $isSubmittingAndClearing, isUploadingDocuments: $isUploadingDocuments, isSubmittingCustomerInfo: $isSubmittingCustomerInfo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PreInvoiceStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            const DeepCollectionEquality().equals(
              other._creditPlans,
              _creditPlans,
            ) &&
            (identical(other.currentCreditPlanPage, currentCreditPlanPage) ||
                other.currentCreditPlanPage == currentCreditPlanPage) &&
            (identical(other.hasMoreCreditPlans, hasMoreCreditPlans) ||
                other.hasMoreCreditPlans == hasMoreCreditPlans) &&
            (identical(
                  other.isCreditPlanPaginationLoading,
                  isCreditPlanPaginationLoading,
                ) ||
                other.isCreditPlanPaginationLoading ==
                    isCreditPlanPaginationLoading) &&
            (identical(other.selectedCreditPlanId, selectedCreditPlanId) ||
                other.selectedCreditPlanId == selectedCreditPlanId) &&
            (identical(other.isSearchActive, isSearchActive) ||
                other.isSearchActive == isSearchActive) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            const DeepCollectionEquality().equals(
              other._filterChips,
              _filterChips,
            ) &&
            (identical(other.selectedChipIndex, selectedChipIndex) ||
                other.selectedChipIndex == selectedChipIndex) &&
            const DeepCollectionEquality().equals(
              other._allProducts,
              _allProducts,
            ) &&
            const DeepCollectionEquality().equals(
              other._filteredProducts,
              _filteredProducts,
            ) &&
            (identical(other.totalProductCount, totalProductCount) ||
                other.totalProductCount == totalProductCount) &&
            (identical(other.currentProductPage, currentProductPage) ||
                other.currentProductPage == currentProductPage) &&
            (identical(other.hasMoreProducts, hasMoreProducts) ||
                other.hasMoreProducts == hasMoreProducts) &&
            (identical(
                  other.isProductPaginationLoading,
                  isProductPaginationLoading,
                ) ||
                other.isProductPaginationLoading ==
                    isProductPaginationLoading) &&
            (identical(other.showAvailableOnly, showAvailableOnly) ||
                other.showAvailableOnly == showAvailableOnly) &&
            const DeepCollectionEquality().equals(
              other._cartItems,
              _cartItems,
            ) &&
            (identical(other.isCartVisible, isCartVisible) ||
                other.isCartVisible == isCartVisible) &&
            (identical(other.selectedCategoryId, selectedCategoryId) ||
                other.selectedCategoryId == selectedCategoryId) &&
            const DeepCollectionEquality().equals(
              other._availableCategories,
              _availableCategories,
            ) &&
            (identical(other.currentCategoryPage, currentCategoryPage) ||
                other.currentCategoryPage == currentCategoryPage) &&
            (identical(other.hasMoreCategories, hasMoreCategories) ||
                other.hasMoreCategories == hasMoreCategories) &&
            (identical(
                  other.isCategoryPaginationLoading,
                  isCategoryPaginationLoading,
                ) ||
                other.isCategoryPaginationLoading ==
                    isCategoryPaginationLoading) &&
            (identical(other.selectedSortOrder, selectedSortOrder) ||
                other.selectedSortOrder == selectedSortOrder) &&
            (identical(other.selectedBrandId, selectedBrandId) ||
                other.selectedBrandId == selectedBrandId) &&
            const DeepCollectionEquality().equals(
              other._availableBrands,
              _availableBrands,
            ) &&
            (identical(other.currentBrandPage, currentBrandPage) ||
                other.currentBrandPage == currentBrandPage) &&
            (identical(other.hasMoreBrands, hasMoreBrands) ||
                other.hasMoreBrands == hasMoreBrands) &&
            (identical(
                  other.isBrandPaginationLoading,
                  isBrandPaginationLoading,
                ) ||
                other.isBrandPaginationLoading == isBrandPaginationLoading) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.totalDiscounts, totalDiscounts) ||
                other.totalDiscounts == totalDiscounts) &&
            (identical(other.payableAmount, payableAmount) ||
                other.payableAmount == payableAmount) &&
            (identical(other.totalQuantity, totalQuantity) ||
                other.totalQuantity == totalQuantity) &&
            (identical(other.customerIdQuery, customerIdQuery) ||
                other.customerIdQuery == customerIdQuery) &&
            (identical(other.isNationalIdValid, isNationalIdValid) ||
                other.isNationalIdValid == isNationalIdValid) &&
            (identical(other.isPhoneNumberValid, isPhoneNumberValid) ||
                other.isPhoneNumberValid == isPhoneNumberValid) &&
            (identical(other.isPostalCodeValid, isPostalCodeValid) ||
                other.isPostalCodeValid == isPostalCodeValid) &&
            (identical(other.customerInfo, customerInfo) ||
                other.customerInfo == customerInfo) &&
            (identical(other.originalCustomerInfo, originalCustomerInfo) ||
                other.originalCustomerInfo == originalCustomerInfo) &&
            (identical(other.customerSearchLoading, customerSearchLoading) ||
                other.customerSearchLoading == customerSearchLoading) &&
            (identical(other.isExistingCustomer, isExistingCustomer) ||
                other.isExistingCustomer == isExistingCustomer) &&
            (identical(other.mandatoryDoc, mandatoryDoc) ||
                other.mandatoryDoc == mandatoryDoc) &&
            (identical(other.mandatoryDocId, mandatoryDocId) ||
                other.mandatoryDocId == mandatoryDocId) &&
            const DeepCollectionEquality().equals(
              other._optionalDocs,
              _optionalDocs,
            ) &&
            const DeepCollectionEquality().equals(
              other._optionalDocIds,
              _optionalDocIds,
            ) &&
            (identical(other.createdOrderId, createdOrderId) ||
                other.createdOrderId == createdOrderId) &&
            (identical(other.isEditMode, isEditMode) ||
                other.isEditMode == isEditMode) &&
            (identical(other.isSubmittingPreInvoice, isSubmittingPreInvoice) ||
                other.isSubmittingPreInvoice == isSubmittingPreInvoice) &&
            (identical(
                  other.isSubmittingAndClearing,
                  isSubmittingAndClearing,
                ) ||
                other.isSubmittingAndClearing == isSubmittingAndClearing) &&
            (identical(other.isUploadingDocuments, isUploadingDocuments) ||
                other.isUploadingDocuments == isUploadingDocuments) &&
            (identical(
                  other.isSubmittingCustomerInfo,
                  isSubmittingCustomerInfo,
                ) ||
                other.isSubmittingCustomerInfo == isSubmittingCustomerInfo));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    status,
    errorMessage,
    currentStep,
    const DeepCollectionEquality().hash(_creditPlans),
    currentCreditPlanPage,
    hasMoreCreditPlans,
    isCreditPlanPaginationLoading,
    selectedCreditPlanId,
    isSearchActive,
    searchQuery,
    const DeepCollectionEquality().hash(_filterChips),
    selectedChipIndex,
    const DeepCollectionEquality().hash(_allProducts),
    const DeepCollectionEquality().hash(_filteredProducts),
    totalProductCount,
    currentProductPage,
    hasMoreProducts,
    isProductPaginationLoading,
    showAvailableOnly,
    const DeepCollectionEquality().hash(_cartItems),
    isCartVisible,
    selectedCategoryId,
    const DeepCollectionEquality().hash(_availableCategories),
    currentCategoryPage,
    hasMoreCategories,
    isCategoryPaginationLoading,
    selectedSortOrder,
    selectedBrandId,
    const DeepCollectionEquality().hash(_availableBrands),
    currentBrandPage,
    hasMoreBrands,
    isBrandPaginationLoading,
    totalAmount,
    totalDiscounts,
    payableAmount,
    totalQuantity,
    customerIdQuery,
    isNationalIdValid,
    isPhoneNumberValid,
    isPostalCodeValid,
    customerInfo,
    originalCustomerInfo,
    customerSearchLoading,
    isExistingCustomer,
    mandatoryDoc,
    mandatoryDocId,
    const DeepCollectionEquality().hash(_optionalDocs),
    const DeepCollectionEquality().hash(_optionalDocIds),
    createdOrderId,
    isEditMode,
    isSubmittingPreInvoice,
    isSubmittingAndClearing,
    isUploadingDocuments,
    isSubmittingCustomerInfo,
  ]);

  /// Create a copy of PreInvoiceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PreInvoiceStateImplCopyWith<_$PreInvoiceStateImpl> get copyWith =>
      __$$PreInvoiceStateImplCopyWithImpl<_$PreInvoiceStateImpl>(
        this,
        _$identity,
      );
}

abstract class _PreInvoiceState implements PreInvoiceState {
  const factory _PreInvoiceState({
    final PreInvoiceRequestStatus status,
    final String errorMessage,
    final PreInvoiceStep currentStep,
    final List<CreditPlanItemModel> creditPlans,
    final int currentCreditPlanPage,
    final bool hasMoreCreditPlans,
    final bool isCreditPlanPaginationLoading,
    final String? selectedCreditPlanId,
    final bool isSearchActive,
    final String searchQuery,
    final List<PreInvoiceChipModel> filterChips,
    final int selectedChipIndex,
    final List<PreInvoiceProductModel> allProducts,
    final List<PreInvoiceProductModel> filteredProducts,
    final int totalProductCount,
    final int currentProductPage,
    final bool hasMoreProducts,
    final bool isProductPaginationLoading,
    final bool showAvailableOnly,
    final List<CartItemModel> cartItems,
    final bool isCartVisible,
    final String? selectedCategoryId,
    final List<CategoryDtoModel> availableCategories,
    final int currentCategoryPage,
    final bool hasMoreCategories,
    final bool isCategoryPaginationLoading,
    final String? selectedSortOrder,
    final String? selectedBrandId,
    final List<BrandDtoModel> availableBrands,
    final int currentBrandPage,
    final bool hasMoreBrands,
    final bool isBrandPaginationLoading,
    final String totalAmount,
    final String totalDiscounts,
    final String payableAmount,
    final int totalQuantity,
    final String customerIdQuery,
    final bool isNationalIdValid,
    final bool isPhoneNumberValid,
    final bool isPostalCodeValid,
    final CustomerInfoModel? customerInfo,
    final CustomerInfoModel? originalCustomerInfo,
    final bool customerSearchLoading,
    final bool isExistingCustomer,
    final XFile? mandatoryDoc,
    final String? mandatoryDocId,
    final List<XFile> optionalDocs,
    final List<String> optionalDocIds,
    final String? createdOrderId,
    final bool isEditMode,
    final bool isSubmittingPreInvoice,
    final bool isSubmittingAndClearing,
    final bool isUploadingDocuments,
    final bool isSubmittingCustomerInfo,
  }) = _$PreInvoiceStateImpl;

  @override
  PreInvoiceRequestStatus get status;
  @override
  String get errorMessage; // Step tracking
  @override
  PreInvoiceStep get currentStep; // Step 1 — Credit Plan
  @override
  List<CreditPlanItemModel> get creditPlans;
  @override
  int get currentCreditPlanPage;
  @override
  bool get hasMoreCreditPlans;
  @override
  bool get isCreditPlanPaginationLoading;
  @override
  String? get selectedCreditPlanId; // Step 2 — Products
  @override
  bool get isSearchActive;
  @override
  String get searchQuery;
  @override
  List<PreInvoiceChipModel> get filterChips;
  @override
  int get selectedChipIndex;
  @override
  List<PreInvoiceProductModel> get allProducts;
  @override
  List<PreInvoiceProductModel> get filteredProducts;
  @override
  int get totalProductCount;
  @override
  int get currentProductPage;
  @override
  bool get hasMoreProducts;
  @override
  bool get isProductPaginationLoading;
  @override
  bool get showAvailableOnly;
  @override
  List<CartItemModel> get cartItems;
  @override
  bool get isCartVisible;
  @override
  String? get selectedCategoryId;
  @override
  List<CategoryDtoModel> get availableCategories;
  @override
  int get currentCategoryPage;
  @override
  bool get hasMoreCategories;
  @override
  bool get isCategoryPaginationLoading;
  @override
  String? get selectedSortOrder;
  @override
  String? get selectedBrandId;
  @override
  List<BrandDtoModel> get availableBrands;
  @override
  int get currentBrandPage;
  @override
  bool get hasMoreBrands;
  @override
  bool get isBrandPaginationLoading; // Summary
  @override
  String get totalAmount;
  @override
  String get totalDiscounts;
  @override
  String get payableAmount;
  @override
  int get totalQuantity; // Step 3 — Customer Info
  @override
  String get customerIdQuery;
  @override
  bool get isNationalIdValid;
  @override
  bool get isPhoneNumberValid;
  @override
  bool get isPostalCodeValid;
  @override
  CustomerInfoModel? get customerInfo;
  @override
  CustomerInfoModel? get originalCustomerInfo;
  @override
  bool get customerSearchLoading;
  @override
  bool get isExistingCustomer; // Step 4 — Documents
  @override
  XFile? get mandatoryDoc;
  @override
  String? get mandatoryDocId;
  @override
  List<XFile> get optionalDocs;
  @override
  List<String> get optionalDocIds;
  @override
  String? get createdOrderId;
  @override
  bool get isEditMode;
  @override
  bool get isSubmittingPreInvoice;
  @override
  bool get isSubmittingAndClearing;
  @override
  bool get isUploadingDocuments;
  @override
  bool get isSubmittingCustomerInfo;

  /// Create a copy of PreInvoiceState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PreInvoiceStateImplCopyWith<_$PreInvoiceStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
