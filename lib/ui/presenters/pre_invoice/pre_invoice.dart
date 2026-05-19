import 'package:rtc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/ui/presenters/pre_invoice/widget/pre_invoice_cart_bottom_sheet.dart';
import 'package:rtc_mobile/ui/router/app_route.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_button.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';
import '../../widget/rtc_appbar.dart';
import '../../widget/rtc_step_indicator.dart';
import 'bloc/pre_invoice_cubit.dart';
import 'bloc/pre_invoice_state.dart';
import 'widget/pre_invoice_step1_view.dart';
import 'widget/pre_invoice_step2_view.dart';
import 'widget/pre_invoice_step3_view.dart';
import 'widget/pre_invoice_step4_view.dart';
import 'widget/pre_invoice_step5_view.dart';

class PreInvoiceScreen extends StatelessWidget {
  const PreInvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PreInvoiceCubit()..init(),
      child: const PreInvoiceView(),
    );
  }
}

class PreInvoiceView extends StatelessWidget {
  const PreInvoiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PreInvoiceCubit, PreInvoiceState>(
          listenWhen: (prev, curr) => prev.status != curr.status,
          listener: (context, state) {
            if (state.status == PreInvoiceRequestStatus.error) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
            }
            if (state.status == PreInvoiceRequestStatus.submitted) {
              context.go(AppRoutes.orderDetail);
            }
            if (state.status == PreInvoiceRequestStatus.submittedAndCleared) {
              context.pop();
            }
          },
        ),
        BlocListener<PreInvoiceCubit, PreInvoiceState>(
          listenWhen: (prev, curr) => prev.isCartVisible != curr.isCartVisible,
          listener: (context, state) {
            if (state.isCartVisible) {
              _showCartBottomSheet(context);
            }
          },
        ),
      ],
      child: BlocBuilder<PreInvoiceCubit, PreInvoiceState>(
        builder: (context, state) {
          final cubit = context.read<PreInvoiceCubit>();

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: RtcAppBar(
              title: state.isEditMode
                  ? _getEditTitle(state.currentStep)
                  : S.current.releaseFactor,
              onBack: () {
                if (state.isEditMode) {
                  cubit.exitEditMode();
                } else if (state.currentStep == PreInvoiceStep.creditPlan) {
                  context.pop();
                } else {
                  final prevStep =
                      PreInvoiceStep.values[state.currentStep.index - 1];
                  cubit.goToStep(prevStep);
                }
              },
              backIconPath: (state.currentStep == PreInvoiceStep.creditPlan &&
                      !state.isEditMode)
                  ? '$baseImage/close.svg'
                  : '$baseImage/angle-right.svg',
            ),
            body: Column(
              children: [
                if (!state.isEditMode)
                  RtcStepIndicator(
                    totalSteps: 5,
                    currentStepIndex: state.currentStep.index,
                    stepLabels: [
                      S.current.selectCreditPlan,
                      S.current.selectProducts,
                      S.current.customerInfo,
                      S.current.uploadDocuments,
                      S.current.reviewAndSubmit,
                    ],
                  ),
                Expanded(
                  child: _buildStepView(state.currentStep),
                ),
                _buildBottomButtons(context, state, cubit),
              ],
            ),
          );
        },
      ),
    );
  }

  String _getEditTitle(PreInvoiceStep step) {
    switch (step) {
      case PreInvoiceStep.products:
        return S.current.editProductsTitle;
      case PreInvoiceStep.customerInfo:
        return S.current.editCustomerInfoTitle;
      case PreInvoiceStep.documents:
        return S.current.editDocumentsTitle;
      default:
        return '';
    }
  }

  Widget _buildBottomButtons(
    BuildContext context,
    PreInvoiceState state,
    PreInvoiceCubit cubit,
  ) {
    if (state.isEditMode) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: AppColors.secondaryShadow,
        ),
        child: Row(
          children: [
            Expanded(
              child: RtcButton(
                title: S.current.save,
                onPressed: () => cubit.exitEditMode(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: RtcButton(
                title: S.current.back,
                backgroundColor: AppColors.grayPalette.shade50,
                styleBtn: TextStyle(
                  color: AppColors.grayPalette.shade600,
                  fontWeight: FontWeight.bold,
                ),
                onPressed: () => cubit.exitEditMode(),
              ),
            ),
          ],
        ),
      );
    }

    if (state.currentStep == PreInvoiceStep.review) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: AppColors.secondaryShadow,
        ),
        child: Row(
          children: [
            Expanded(
              child: RtcButton(
                title: S.current.submitAndClearCart,
                onPressed: () => cubit.submitAndClear(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: RtcButton(
                title: S.current.submitPreInvoice,
                backgroundColor: AppColors.brandPalette.shade50,
                styleBtn: TextStyle(
                  color: AppColors.brandPalette.shade600,
                  fontWeight: FontWeight.bold,
                ),
                onPressed: () => cubit.submitPreInvoice(),
              ),
            ),
          ],
        ),
      );
    }

    String title = S.current.nextStep;
    bool isActive = false;
    VoidCallback onPressed = () {};

    if (state.currentStep == PreInvoiceStep.creditPlan) {
      isActive = state.selectedCreditPlanId != null;
      onPressed = () => cubit.goToStep(PreInvoiceStep.products);
    } else if (state.currentStep == PreInvoiceStep.products) {
      int totalItems = state.cartItems.fold(
        0,
        (sum, item) => sum + item.quantity,
      );
      isActive = totalItems > 0;
      title = isActive
          ? '${S.current.nextStep} ($totalItems ${S.current.products})'
          : S.current.nextStep;
      onPressed = () => cubit.goToStep(PreInvoiceStep.customerInfo);
    } else if (state.currentStep == PreInvoiceStep.customerInfo) {
      isActive = state.customerInfo != null;
      onPressed = () => cubit.goToStep(PreInvoiceStep.documents);
    } else if (state.currentStep == PreInvoiceStep.documents) {
      isActive = state.mandatoryDocPath != null;
      onPressed = () => cubit.goToStep(PreInvoiceStep.review);
    }

    return Container(
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
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                isActive: isActive,
                onPressed: onPressed,
              ),
            ),
            if (state.currentStep == PreInvoiceStep.products)
              GestureDetector(
                onTap: () => cubit.showCart(),
                child: Container(
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
                    boxFit: BoxFit.fill,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepView(PreInvoiceStep step) {
    switch (step) {
      case PreInvoiceStep.creditPlan:
        return const PreInvoiceStep1View();
      case PreInvoiceStep.products:
        return const PreInvoiceStep2View();
      case PreInvoiceStep.customerInfo:
        return const PreInvoiceStep3View();
      case PreInvoiceStep.documents:
        return const PreInvoiceStep4View();
      case PreInvoiceStep.review:
        return const PreInvoiceStep5View();
    }
  }

  void _showCartBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<PreInvoiceCubit>(),
        child: const PreInvoiceCartBottomSheet(),
      ),
    ).then((_) {
      if (context.mounted) {
        context.read<PreInvoiceCubit>().hideCart();
      }
    });
  }
}
