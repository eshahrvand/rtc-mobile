import 'package:rtc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_text_button.dart';

import '../../../widget/rtc_button.dart';
import '../../../widget/rtc_text_field.dart';
import '../../../widget/rtc_image.dart';
import '../bloc/pre_invoice_cubit.dart';
import '../bloc/pre_invoice_state.dart';

class PreInvoiceStep3View extends StatelessWidget {
  const PreInvoiceStep3View({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return BlocBuilder<PreInvoiceCubit, PreInvoiceState>(
      builder: (context, state) {
        final cubit = context.read<PreInvoiceCubit>();
        //TODO: have has size error here
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: 14,
                      children: [
                        Expanded(
                          child: RtcTextField(
                            labelText: S.current.nationalCodeLabelWithStar,
                            labelStyle: theme.bodyMedium!.copyWith(
                              color: AppColors.grayPalette.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                            hintText: S.current.nationalCodeHint,
                            hintStyle: theme.bodyLarge!.copyWith(
                              color: AppColors.grayPalette.shade400,
                            ),
                            isError: !state.isNationalIdValid,
                            helper: !state.isNationalIdValid
                                ? Row(
                                    spacing: 8,
                                    children: [
                                      RtcImage(
                                        image: 'assets/images/alert.svg',
                                        width: 14,
                                        height: 14,
                                        color: AppColors.errorPalette.shade600,
                                      ),
                                      Text(
                                        S.current.nationalIdWrong,
                                        style: theme.bodySmall!.copyWith(
                                          color:
                                              AppColors.errorPalette.shade600,
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink(),
                            onChanged: (value) =>
                                cubit.onCustomerIdChanged(value),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(2, 10, 2, 10),
                          child: RtcTextButton(
                            title: S.current.checkButton,
                            styleBtn: theme.labelLarge!.copyWith(
                              color: AppColors.brandPalette.shade600,
                              fontWeight: FontWeight.w600,
                            ),
                            onPressed: () => cubit.searchCustomer(),
                          ),
                        ),
                      ],
                    ),
                    if (state.customerSearchLoading)
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    if (state.customerInfo != null) ...[
                      const SizedBox(height: 24),
                      Text(
                        S.current.nameLabel,
                        style: theme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.grayPalette.shade700
                        ),
                      ),
                      const SizedBox(height: 8),
                      RtcTextField(
                        controller: TextEditingController(
                          text: state.customerInfo!.firstName,
                        ),
                        onChanged: (value) =>
                            cubit.onCustomerFieldChanged('firstName', value),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        S.current.lastNameLabel,
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                      RtcTextField(
                        controller: TextEditingController(
                          text: state.customerInfo!.lastName,
                        ),
                        onChanged: (value) =>
                            cubit.onCustomerFieldChanged('lastName', value),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        S.current.phoneNumberLabel,
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                      RtcTextField(
                        controller: TextEditingController(
                          text: state.customerInfo!.phoneNumber,
                        ),
                        onChanged: (value) =>
                            cubit.onCustomerFieldChanged('phoneNumber', value),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        S.current.postalCodeLabel,
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                      RtcTextField(
                        controller: TextEditingController(
                          text: state.customerInfo!.postalCode,
                        ),
                        onChanged: (value) =>
                            cubit.onCustomerFieldChanged('postalCode', value),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        S.current.fullAddressLabel,
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                      RtcTextField(
                        maxLines: 3,
                        controller: TextEditingController(
                          text: state.customerInfo!.address,
                        ),
                        onChanged: (value) =>
                            cubit.onCustomerFieldChanged('address', value),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            S.current.sendOrderToCustomerAddress,
                            style: const TextStyle(fontSize: 14),
                          ),
                          Switch(
                            value: state
                                .customerInfo!
                                .isOrderSentToCustomerAddress,
                            onChanged: (value) => cubit.onCustomerFieldChanged(
                              'isOrderSentToCustomerAddress',
                              value,
                            ),
                            activeColor: Colors.blue,
                          ),
                          Text(
                            S.current.inactive,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),

            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: AppColors.secondaryShadow,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: RtcButton(
                  title: S.current.nextStep,
                  isActive: state.customerInfo != null,
                  onPressed: () => cubit.goToStep(PreInvoiceStep.documents),

                  styleBtn: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),),
              ),
            ),
          ],
        );
      },
    );
  }
}
