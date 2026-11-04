import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cross_file/cross_file.dart';
import 'package:intl/intl.dart';
import '../../../../data_source/remote/catalog/model/brand_dto_model.dart';
import '../../../../core/models/pre_invoice_model.dart';
import '../../../../data_source/remote/catalog/model/category_dto_model.dart';
import '../../../../config/regex_national_number_validator.dart';

part 'pre_invoice_state.freezed.dart';

enum PreInvoiceStep {
  branch, // Optional initial step for multi-branch agents
  creditPlan, // Step 1
  products, // Step 2
  customerInfo, // Step 3
  documents, // Step 4
  review, // Step 5
}

enum PreInvoiceRequestStatus {
  initial,
  loading,
  success,
  error,
  submitted,
  submittedAndCleared,
  stockLimitReached,
}

@freezed
class PreInvoiceState with _$PreInvoiceState {
  const factory PreInvoiceState({
    @Default(PreInvoiceRequestStatus.initial) PreInvoiceRequestStatus status,
    @Default('') String errorMessage,

    // Step tracking
    @Default(PreInvoiceStep.creditPlan) PreInvoiceStep currentStep,

    // Step 1 — Credit Plan
    @Default([]) List<CreditPlanItemModel> creditPlans,
    @Default(1) int currentCreditPlanPage,
    @Default(false) bool hasMoreCreditPlans,
    @Default(false) bool isCreditPlanPaginationLoading,
    String? selectedCreditPlanId,

    // Step 2 — Products
    @Default(false) bool isSearchActive,
    @Default('') String searchQuery,
    @Default([]) List<PreInvoiceChipModel> filterChips,
    @Default(0) int selectedChipIndex,
    @Default([]) List<PreInvoiceProductModel> allProducts,
    @Default([]) List<PreInvoiceProductModel> filteredProducts,
    @Default(0) int totalProductCount,
    @Default(1) int currentProductPage,
    @Default(false) bool hasMoreProducts,
    @Default(false) bool isProductPaginationLoading,
    @Default(false) bool showAvailableOnly,
    @Default([]) List<CartItemModel> cartItems,
    @Default(false) bool isCartVisible,
    @Default([]) List<String> selectedCategoryIds,
    @Default([]) List<CategoryDtoModel> availableCategories,
    @Default(1) int currentCategoryPage,
    @Default(false) bool hasMoreCategories,
    @Default(false) bool isCategoryPaginationLoading,

    String? selectedSortOrder,
    String? selectedBrandId,
    @Default([]) List<BrandDtoModel> availableBrands,
    @Default(1) int currentBrandPage,
    @Default(false) bool hasMoreBrands,
    @Default(false) bool isBrandPaginationLoading,

    // Summary
    @Default('0') String totalAmount,
    @Default('0') String totalDiscounts,
    @Default('0') String payableAmount,
    @Default(0) int totalQuantity,

    // Step 3 — Customer Info
    @Default('') String customerIdQuery,
    @Default(false) bool isNationalIdValid,
    @Default(true) bool isPhoneNumberValid,
    @Default(true) bool isPostalCodeValid,
    CustomerInfoModel? customerInfo,
    CustomerInfoModel? originalCustomerInfo,
    @Default(false) bool customerSearchLoading,
    @Default(false) bool isExistingCustomer,

    // Step 4 — Documents
    XFile? mandatoryDoc,
    String? mandatoryDocId,
    @Default([]) List<XFile> optionalDocs,
    @Default([]) List<String> optionalDocIds,

    String? createdOrderId,

    @Default(false) bool isEditMode,

    @Default(false) bool isSubmittingPreInvoice,
    @Default(false) bool isSubmittingAndClearing,
    @Default(false) bool isUploadingDocuments,
    @Default(false) bool isSubmittingCustomerInfo,
  }) = _PreInvoiceState;
}

extension PreInvoiceStateX on PreInvoiceState {
  /// Consumer prices are supplied independently of plan/discount prices.
  /// Missing data is not interpreted as a zero or a plan price.
  String? get consumerFinalAmount {
    if (cartItems.isEmpty ||
        cartItems.any((item) => item.consumerUnitPrice == null)) {
      return null;
    }
    final amount = cartItems.fold<num>(
      0,
      (sum, item) => sum + item.consumerUnitPrice! * item.quantity,
    );
    return NumberFormat('#,###', 'en_US').format(amount);
  }

  int get totalCartItemsCount =>
      cartItems.fold(0, (sum, item) => sum + item.quantity);

  bool get isCurrentStepValid => switch (currentStep) {
    PreInvoiceStep.branch =>
      false, // Validated by the invoice-local branch state.
    PreInvoiceStep.creditPlan => selectedCreditPlanId != null,
    PreInvoiceStep.products => totalCartItemsCount > 0,
    PreInvoiceStep.customerInfo =>
      customerInfo != null &&
          customerInfo!.firstName.isNotEmpty &&
          customerInfo!.lastName.isNotEmpty &&
          customerInfo!.phoneNumber.isNotEmpty &&
          isPhoneNumberValid &&
          customerInfo!.postalCode.isNotEmpty &&
          isPostalCodeValid &&
          customerInfo!.address.isNotEmpty &&
          isDeliveryRecipientValid,
    PreInvoiceStep.documents => mandatoryDoc != null,
    PreInvoiceStep.review => true,
  };

  bool get isDeliveryRecipientValid {
    final info = customerInfo;
    if (info == null ||
        !info.isOrderSentToCustomerAddress ||
        !info.isOtherRecipient)
      return true;
    return info.recipientName.trim().isNotEmpty &&
        RegExp(r'^\d{10}$').hasMatch(info.recipientNationalId) &&
        isNationalIDValid(info.recipientNationalId);
  }

  bool get isNextStepLoading => switch (currentStep) {
    PreInvoiceStep.branch => status == PreInvoiceRequestStatus.loading,
    PreInvoiceStep.creditPlan => status == PreInvoiceRequestStatus.loading,
    PreInvoiceStep.customerInfo => isSubmittingCustomerInfo,
    PreInvoiceStep.documents => isUploadingDocuments,
    _ => false,
  };
}
