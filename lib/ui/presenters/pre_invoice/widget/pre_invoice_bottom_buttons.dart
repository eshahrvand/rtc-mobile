import 'package:flutter/material.dart';
import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_button.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';
import '../bloc/pre_invoice_cubit.dart';
import '../bloc/pre_invoice_state.dart';
import 'pre_invoice_ui_helpers.dart';

class PreInvoiceBottomButtons extends StatelessWidget {
  final PreInvoiceState state;
  final PreInvoiceCubit cubit;

  const PreInvoiceBottomButtons({
    super.key,
    required this.state,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    if (state.isEditMode) {
      return _buildEditModeButtons(context);
    }

    if (state.currentStep == PreInvoiceStep.review) {
      return _buildReviewModeButtons(context);
    }

    if (state.currentStep == PreInvoiceStep.customerInfo &&
        state.customerInfo == null) {
      return const SizedBox.shrink();
    }

    return _buildStandardStepButtons(context);
  }

  Widget _buildEditModeButtons(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: AppColors.secondaryShadow,
        ),
        child: Row(
          spacing: 12,
          children: [
            Expanded(
              child: RtcButton(
                title: S.current.back,
                backgroundColor: AppColors.grayPalette.shade50,
                styleBtn: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.grayPalette.shade700,
                    ),
                onPressed: () => cubit.exitEditMode(),
                borderColor: AppColors.grayPalette.shade300,
              ),
            ),
            Expanded(
              child: RtcButton(
                title: S.current.save,
                styleBtn: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                onPressed: () => cubit.exitEditMode(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewModeButtons(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: AppColors.secondaryShadow,
        ),
        child: Row(
          spacing: 12,
          children: [
            Expanded(
              child: RtcButton(
                title: S.current.submitPreInvoice,
                backgroundColor: AppColors.brandPalette.shade50,
                styleBtn: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.brandPalette.shade700,
                    ),
                isLoading: state.isSubmittingAndClearing,
                onPressed: () => cubit.submitAndClear(),
                borderColor: AppColors.brandPalette.shade50,
              ),
            ),
            Expanded(
              child: RtcButton(
                title: S.current.submitAndClearCart,
                styleBtn: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                isLoading: state.isSubmittingPreInvoice,
                onPressed: () => cubit.submitPreInvoice(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStandardStepButtons(BuildContext context) {
    final isActive = state.isCurrentStepValid;
    final isLoading = state.isNextStepLoading;
    final title = PreInvoiceUiHelpers.resolveNextStepTitle(state);

    return SafeArea(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: AppColors.secondaryShadow,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Row(
            spacing: 10,
            children: [
              Expanded(
                child: RtcButton(
                  title: title,
                  styleBtn: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: isActive
                            ? Colors.white
                            : AppColors.grayPalette.shade300,
                        fontWeight: FontWeight.w600,
                      ),
                  isActive: isActive,
                  isLoading: isLoading,
                  onPressed: () => _handleNextStep(),
                ),
              ),
              if (state.currentStep == PreInvoiceStep.products &&
                  state.cartItems.isNotEmpty)
                GestureDetector(
                  onTap: () => cubit.showCart(),
                  child: Container(
                    height: 44,
                    width: 44,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.brandPalette.shade50,
                      border: Border.all(
                        color: AppColors.grayPalette.shade200,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: RtcImage(
                      image: "$baseImage/basket-bottom-sheet.svg",
                      width: 24,
                      height: 24,
                      color: AppColors.brandPalette.shade600,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleNextStep() {
    final nextStep = switch (state.currentStep) {
      PreInvoiceStep.creditPlan => PreInvoiceStep.products,
      PreInvoiceStep.products => PreInvoiceStep.customerInfo,
      PreInvoiceStep.customerInfo => PreInvoiceStep.documents,
      PreInvoiceStep.documents => PreInvoiceStep.review,
      _ => null,
    };
    if (nextStep != null) {
      cubit.goToStep(nextStep);
    }
  }
}
