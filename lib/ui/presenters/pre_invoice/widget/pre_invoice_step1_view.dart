import 'package:rtc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../widget/rtc_button.dart';
import '../../../widget/rtc_credit_plan_item.dart';
import '../../../widget/rtc_step_indicator.dart';
import '../bloc/pre_invoice_cubit.dart';
import '../bloc/pre_invoice_state.dart';

class PreInvoiceStep1View extends StatelessWidget {
  const PreInvoiceStep1View({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreInvoiceCubit, PreInvoiceState>(
      builder: (context, state) {
        final cubit = context.read<PreInvoiceCubit>();

        return Column(
          children: [
            RtcStepIndicator(
              totalSteps: 5,
              currentStepIndex: 0,
              stepLabels: [
                S.current.selectCreditPlan,
                S.current.selectProducts,
                S.current.customerInfo,
                S.current.uploadDocuments,
                S.current.reviewAndSubmit,
              ],
            ),
            Expanded(
              child: state.status == PreInvoiceRequestStatus.loading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: state.creditPlans.length,
                      itemBuilder: (context, index) {
                        final plan = state.creditPlans[index];
                        return RtcCreditPlanItem(
                          plan: plan,
                          isSelected: state.selectedCreditPlanId == plan.id,
                          onTap: () => cubit.onCreditPlanSelected(plan.id),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RtcButton(
                title: S.current.nextStep,
                isActive: state.selectedCreditPlanId != null,
                onPressed: () => cubit.goToStep(PreInvoiceStep.products),
              ),
            ),
          ],
        );
      },
    );
  }
}
