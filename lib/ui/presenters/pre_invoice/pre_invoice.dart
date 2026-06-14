import 'package:rtc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/config/snackbar.dart';
import 'package:rtc_mobile/ui/presenters/pre_invoice/widget/pre_invoice_cart_bottom_sheet.dart';
import 'package:rtc_mobile/ui/router/app_route.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
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
import 'widget/pre_invoice_bottom_buttons.dart';
import 'widget/pre_invoice_ui_helpers.dart';

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
            if (state.status == PreInvoiceRequestStatus.error
                ) {
              rtcSnackBar(
                context: context,
                type: SnackBarType.error,
                message: state.errorMessage,
              );
            }
            if(state.status == PreInvoiceRequestStatus.stockLimitReached){
              rtcSnackBar(
                context: context,
                type: SnackBarType.warning,
                message: state.errorMessage,
              );

            }

            if (state.status == PreInvoiceRequestStatus.submitted ||
                state.status == PreInvoiceRequestStatus.submittedAndCleared) {
              rtcSnackBar(
                context: context,
                type: SnackBarType.success,
                message: S.current.successSubmitPreInvoice,
              );
            }
            if (state.status == PreInvoiceRequestStatus.submitted) {
              context.go(AppRoutes.orderDetail, extra: state.createdOrderId);
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

          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              if (didPop) return;

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
            child: Scaffold(
              appBar: RtcAppBar(
                title: state.isEditMode
                    ? PreInvoiceUiHelpers.resolveEditTitle(state.currentStep)
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
                hideBackIcon: (state.currentStep == PreInvoiceStep.creditPlan ||
                    state.isEditMode),
                backIconPath: (state.currentStep == PreInvoiceStep.creditPlan ||
                        state.isEditMode)
                    ? ""
                    : '$baseImage/angle-right.svg',
                actions: [
                  if (!state.isEditMode)
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: GestureDetector(
                        onTap: () => context.pop(),
                        child: RtcImage(
                          image: '$baseImage/close_appbar.svg',
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                ],
                showShadow: false,
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    if (!state.isEditMode)
                      RtcStepIndicator(
                        totalSteps: 5,
                        currentStepIndex: state.currentStep.index,
                        stepLabels: PreInvoiceUiHelpers.stepLabels,
                      ),
                    Expanded(
                      child: PreInvoiceStepContent(step: state.currentStep),
                    ),
                    PreInvoiceBottomButtons(state: state, cubit: cubit),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
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

class PreInvoiceStepContent extends StatelessWidget {
  final PreInvoiceStep step;

  const PreInvoiceStepContent({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return switch (step) {
      PreInvoiceStep.creditPlan => const PreInvoiceStep1View(),
      PreInvoiceStep.products => const PreInvoiceStep2View(),
      PreInvoiceStep.customerInfo =>  PreInvoiceStep3View(),
      PreInvoiceStep.documents => const PreInvoiceStep4View(),
      PreInvoiceStep.review => const PreInvoiceStep5View(),
    };
  }
}
