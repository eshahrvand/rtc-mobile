import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../data/models/pre_invoice_model.dart';

part 'pre_invoice_state.freezed.dart';

enum PreInvoiceStep {
  creditPlan,      // Step 1
  products,        // Step 2
  customerInfo,    // Step 3
  documents,       // Step 4
  review,          // Step 5
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

    // Step 3 — Customer Info
    @Default('') String customerIdQuery,
    CustomerInfoModel? customerInfo,
    @Default(false) bool customerSearchLoading,

    // Step 4 — Documents
    String? mandatoryDocPath,
    String? optionalDocPath,
  }) = _PreInvoiceState;
}
