import 'package:rtc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widget/rtc_button.dart';
import '../../../widget/rtc_step_indicator.dart';
import '../../../widget/rtc_text_field.dart';
import '../bloc/pre_invoice_cubit.dart';
import '../bloc/pre_invoice_state.dart';

class PreInvoiceStep3View extends StatelessWidget {
  const PreInvoiceStep3View({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreInvoiceCubit, PreInvoiceState>(
      builder: (context, state) {
        final cubit = context.read<PreInvoiceCubit>();

        return Column(
          children: [
            RtcStepIndicator(
              totalSteps: 5,
              currentStepIndex: 2,
              stepLabels: [
                S.current.selectCreditPlan,
                S.current.selectProducts,
                S.current.customerInfo,
                S.current.uploadDocuments,
                S.current.reviewAndSubmit,
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(S.current.nationalCodeLabel, style: const TextStyle(fontSize: 12)),
                    const SizedBox(height: 8),
                    RtcTextField(
                      hintText: S.current.nationalCodeHint,
                      onChanged: (value) => cubit.onCustomerIdChanged(value),
                      suffix: TextButton(
                        onPressed: () => cubit.searchCustomer(),
                        child: Text(S.current.checkButton, style: const TextStyle(color: Colors.blue)),
                      ),
                    ),
                    if (state.customerSearchLoading)
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    if (state.customerInfo != null) ...[
                      const SizedBox(height: 24),
                      Text(S.current.nameLabel, style: const TextStyle(fontSize: 12)),
                      const SizedBox(height: 8),
                      RtcTextField(
                        controller: TextEditingController(text: state.customerInfo!.firstName),
                        onChanged: (value) => cubit.onCustomerFieldChanged('firstName', value),
                      ),
                      const SizedBox(height: 16),
                      Text(S.current.lastNameLabel, style: const TextStyle(fontSize: 12)),
                      const SizedBox(height: 8),
                      RtcTextField(
                        controller: TextEditingController(text: state.customerInfo!.lastName),
                        onChanged: (value) => cubit.onCustomerFieldChanged('lastName', value),
                      ),
                      const SizedBox(height: 16),
                      Text(S.current.phoneNumberLabel, style: const TextStyle(fontSize: 12)),
                      const SizedBox(height: 8),
                      RtcTextField(
                        controller: TextEditingController(text: state.customerInfo!.phoneNumber),
                        onChanged: (value) => cubit.onCustomerFieldChanged('phoneNumber', value),
                      ),
                      const SizedBox(height: 16),
                      Text(S.current.postalCodeLabel, style: const TextStyle(fontSize: 12)),
                      const SizedBox(height: 8),
                      RtcTextField(
                        controller: TextEditingController(text: state.customerInfo!.postalCode),
                        onChanged: (value) => cubit.onCustomerFieldChanged('postalCode', value),
                      ),
                      const SizedBox(height: 16),
                      Text(S.current.fullAddressLabel, style: const TextStyle(fontSize: 12)),
                      const SizedBox(height: 8),
                      RtcTextField(
                        maxLines: 3,
                        controller: TextEditingController(text: state.customerInfo!.address),
                        onChanged: (value) => cubit.onCustomerFieldChanged('address', value),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(S.current.sendOrderToCustomerAddress, style: const TextStyle(fontSize: 14)),
                          Switch(
                            value: state.customerInfo!.isOrderSentToCustomerAddress,
                            onChanged: (value) => cubit.onCustomerFieldChanged('isOrderSentToCustomerAddress', value),
                            activeColor: Colors.blue,
                          ),
                          Text(S.current.inactive, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RtcButton(
                title: S.current.nextStep,
                isActive: state.customerInfo != null,
                onPressed: () => cubit.goToStep(PreInvoiceStep.documents),
              ),
            ),
          ],
        );
      },
    );
  }
}
