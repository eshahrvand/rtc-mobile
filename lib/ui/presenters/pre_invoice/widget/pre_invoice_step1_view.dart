import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../widget/rtc_credit_plan_item.dart';
import '../bloc/pre_invoice_cubit.dart';
import '../bloc/pre_invoice_state.dart';

class PreInvoiceStep1View extends StatelessWidget {
  const PreInvoiceStep1View({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreInvoiceCubit, PreInvoiceState>(
      builder: (context, state) {
        final cubit = context.read<PreInvoiceCubit>();

        return state.status == PreInvoiceRequestStatus.loading
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
              );
      },
    );
  }
}
