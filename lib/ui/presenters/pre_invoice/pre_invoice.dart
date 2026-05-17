import 'package:rtc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/ui/presenters/pre_invoice/widget/pre_invoice_cart_bottom_sheet.dart';
import 'package:rtc_mobile/ui/router/app_route.dart';
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
              // Behavior defined by developer - assuming pop for now
              context.pop();
            }
          },
        ),
        BlocListener<PreInvoiceCubit, PreInvoiceState>(
          listenWhen: (prev, curr) => prev.isCartVisible != curr.isCartVisible,
          listener: (context, state) {
            if (state.isCartVisible) {
              _showCartBottomSheet(context);
            } else {
              // Bottom sheet usually handles its own closing,
              // but if triggered by state we might need Navigator.pop(context)
              // if it's currently open.
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
              title: S.current.releaseFactor,
              onBack: () {
                if (state.currentStep == PreInvoiceStep.creditPlan) {
                  context.pop();
                } else {
                  final prevStep =
                      PreInvoiceStep.values[state.currentStep.index - 1];
                  cubit.goToStep(prevStep);
                }
              },
              backIconPath: state.currentStep == PreInvoiceStep.creditPlan
                  ? '$baseImage/close.svg'
                  : '$baseImage/angle-right.svg',
            ),
            body: Column(
              children: [
                BlocBuilder<PreInvoiceCubit, PreInvoiceState>(
                  buildWhen: (prev, curr) =>
                      prev.currentStep != curr.currentStep,
                  builder: (context, state) => RtcStepIndicator(
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
                ),
                Expanded(
                  child: BlocBuilder<PreInvoiceCubit, PreInvoiceState>(
                    buildWhen: (prev, curr) =>
                        prev.currentStep != curr.currentStep,
                    builder: (context, state) {
                      switch (state.currentStep) {
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
                    },
                  ),
                ),
              ],
            ),
          );
        },
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
