import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../widget/rtc_credit_plan_item.dart';
import '../bloc/pre_invoice_cubit.dart';
import '../bloc/pre_invoice_state.dart';

class PreInvoiceStep1View extends StatefulWidget {
  const PreInvoiceStep1View({super.key});

  @override
  State<PreInvoiceStep1View> createState() => _PreInvoiceStep1ViewState();
}

class _PreInvoiceStep1ViewState extends State<PreInvoiceStep1View> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      context.read<PreInvoiceCubit>().fetchSubPlansNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreInvoiceCubit, PreInvoiceState>(
      builder: (context, state) {
        final cubit = context.read<PreInvoiceCubit>();

        return state.status == PreInvoiceRequestStatus.loading &&
                state.creditPlans.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : SizedBox(
              child: ListView.builder(
                controller: _scrollController,
                itemCount:
                    state.creditPlans.length +
                    (state.isCreditPlanPaginationLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == state.creditPlans.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final plan = state.creditPlans[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index == state.creditPlans.length - 1 ? 20 : 0,
                    ),
                    child: RtcCreditPlanItem(
                      plan: plan,
                      isSelected: state.selectedCreditPlanId == plan.id,
                      onTap: () => cubit.onCreditPlanSelected(plan.id),
                    ),
                  );
                },
              ),
            );
      },
    );
  }
}
