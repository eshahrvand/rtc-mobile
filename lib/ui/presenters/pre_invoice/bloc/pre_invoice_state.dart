import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../data/models/pre_invoice_model.dart';

part 'pre_invoice_state.freezed.dart';

enum PreInvoiceStep {
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
    String? selectedCreditPlanId,

    // Step 2 — Products
    @Default(false) bool isSearchActive,
    @Default('') String searchQuery,
    @Default([]) List<PreInvoiceChipModel> filterChips,
    @Default(0) int selectedChipIndex,
    @Default([]) List<PreInvoiceProductModel> allProducts,
    @Default([]) List<PreInvoiceProductModel> filteredProducts,
    @Default(false) bool showAvailableOnly,
    @Default([]) List<CartItemModel> cartItems,
    @Default(false) bool isCartVisible,
    String? selectedCategoryId,
    String? selectedSortOrder,

    // Summary
    @Default('0') String totalAmount,
    @Default('0') String totalDiscounts,
    @Default('0') String payableAmount,
    @Default(0) int totalQuantity,

    // Step 3 — Customer Info
    @Default('') String customerIdQuery,
    @Default(false) bool isNationalIdValid,
    @Default(true) bool isPhoneNumberValid,
    CustomerInfoModel? customerInfo,
    CustomerInfoModel? originalCustomerInfo,
    @Default(false) bool customerSearchLoading,
    @Default(false) bool isExistingCustomer,

    // Step 4 — Documents
    String? mandatoryDocPath,
    String? mandatoryDocId,
    @Default([]) List<String> optionalDocPaths,
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
  int get totalCartItemsCount =>
      cartItems.fold(0, (sum, item) => sum + item.quantity);

  bool get isCurrentStepValid => switch (currentStep) {
    PreInvoiceStep.creditPlan => selectedCreditPlanId != null,
    PreInvoiceStep.products => totalCartItemsCount > 0,
    PreInvoiceStep.customerInfo => customerInfo != null,
    PreInvoiceStep.documents => mandatoryDocPath != null,
    PreInvoiceStep.review => true,
  };

  bool get isNextStepLoading => switch (currentStep) {
    PreInvoiceStep.creditPlan => status == PreInvoiceRequestStatus.loading,
    PreInvoiceStep.customerInfo => isSubmittingCustomerInfo,
    PreInvoiceStep.documents => isUploadingDocuments,
    _ => false,
  };
}
