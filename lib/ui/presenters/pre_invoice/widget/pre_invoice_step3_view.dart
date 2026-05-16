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
            const RtcStepIndicator(
              totalSteps: 5,
              currentStepIndex: 2,
              stepLabels: [
                'انتخاب طرح اعتباری',
                'انتخاب کالاها',
                'اطلاعات مشتری',
                'بارگذاری مدارک',
                'بررسی نهایی و ثبت',
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('کد ملی*', style: TextStyle(fontSize: 12)),
                    const SizedBox(height: 8),
                    RtcTextField(
                      hintText: 'کد ملی مشتری را وارد کنید',
                      onChanged: (value) => cubit.onCustomerIdChanged(value),
                      suffix: TextButton(
                        onPressed: () => cubit.searchCustomer(),
                        child: const Text('بررسی', style: TextStyle(color: Colors.blue)),
                      ),
                    ),
                    if (state.customerSearchLoading)
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    if (state.customerInfo != null) ...[
                      const SizedBox(height: 24),
                      const Text('نام*', style: TextStyle(fontSize: 12)),
                      const SizedBox(height: 8),
                      RtcTextField(
                        controller: TextEditingController(text: state.customerInfo!.firstName),
                        onChanged: (value) => cubit.onCustomerFieldChanged('firstName', value),
                      ),
                      const SizedBox(height: 16),
                      const Text('نام خانوادگی*', style: TextStyle(fontSize: 12)),
                      const SizedBox(height: 8),
                      RtcTextField(
                        controller: TextEditingController(text: state.customerInfo!.lastName),
                        onChanged: (value) => cubit.onCustomerFieldChanged('lastName', value),
                      ),
                      const SizedBox(height: 16),
                      const Text('شماره موبایل*', style: TextStyle(fontSize: 12)),
                      const SizedBox(height: 8),
                      RtcTextField(
                        controller: TextEditingController(text: state.customerInfo!.phoneNumber),
                        onChanged: (value) => cubit.onCustomerFieldChanged('phoneNumber', value),
                      ),
                      const SizedBox(height: 16),
                      const Text('کد پستی*', style: TextStyle(fontSize: 12)),
                      const SizedBox(height: 8),
                      RtcTextField(
                        controller: TextEditingController(text: state.customerInfo!.postalCode),
                        onChanged: (value) => cubit.onCustomerFieldChanged('postalCode', value),
                      ),
                      const SizedBox(height: 16),
                      const Text('آدرس کامل*', style: TextStyle(fontSize: 12)),
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
                          const Text('ارسال سفارش به آدرس مشتری', style: TextStyle(fontSize: 14)),
                          Switch(
                            value: state.customerInfo!.isOrderSentToCustomerAddress,
                            onChanged: (value) => cubit.onCustomerFieldChanged('isOrderSentToCustomerAddress', value),
                            activeColor: Colors.blue,
                          ),
                          const Text('غیر فعال', style: TextStyle(fontSize: 12, color: Colors.grey)),
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
                title: 'مرحله بعد',
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
