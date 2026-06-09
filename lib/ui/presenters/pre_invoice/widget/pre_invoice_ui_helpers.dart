import 'package:rtc_mobile/generated/l10n.dart';
import '../bloc/pre_invoice_state.dart';

class PreInvoiceUiHelpers {
  /// Resolves the AppBar title when in edit mode.
  static String resolveEditTitle(PreInvoiceStep step) => switch (step) {
        PreInvoiceStep.products => S.current.editProductsTitle,
        PreInvoiceStep.customerInfo => S.current.editCustomerInfoTitle,
        PreInvoiceStep.documents => S.current.editDocumentsTitle,
        _ => '',
      };

  /// Labels for the step indicator.
  static List<String> get stepLabels => [
        S.current.selectCreditPlan,
        S.current.selectProducts,
        S.current.customerInfo,
        S.current.uploadDocuments,
        S.current.reviewAndSubmit,
      ];

  /// Resolves the primary button title for the bottom navigation.
  static String resolveNextStepTitle(PreInvoiceState state) {
    if (state.currentStep == PreInvoiceStep.products) {
      final totalItems = state.totalCartItemsCount;
      return totalItems > 0
          ? '${S.current.nextStep} ($totalItems ${S.current.product})'
          : S.current.nextStep;
    }
    return S.current.nextStep;
  }
}
