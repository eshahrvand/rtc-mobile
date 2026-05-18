import 'package:rtc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_text_button.dart';
import '../../../../data/models/pre_invoice_model.dart';
import '../../../widget/rtc_button.dart';
import '../../../widget/rtc_text_field.dart';
import '../../../widget/rtc_image.dart';
import '../../../../config/config.dart';
import '../bloc/pre_invoice_cubit.dart';
import '../bloc/pre_invoice_state.dart';

class PreInvoiceStep3View extends StatefulWidget {
  const PreInvoiceStep3View({super.key});

  @override
  State<PreInvoiceStep3View> createState() => _PreInvoiceStep3ViewState();
}

class _PreInvoiceStep3ViewState extends State<PreInvoiceStep3View> {
  final TextEditingController _nationalIdController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<PreInvoiceCubit>();
    _nationalIdController.text = cubit.state.customerIdQuery;
    _updateOtherControllers(cubit.state.customerInfo);
  }

  void _updateOtherControllers(CustomerInfoModel? customerInfo) {
    if (customerInfo != null) {
      if (_firstNameController.text != customerInfo.firstName) {
        _firstNameController.text = customerInfo.firstName;
      }
      if (_lastNameController.text != customerInfo.lastName) {
        _lastNameController.text = customerInfo.lastName;
      }
      if (_phoneNumberController.text != customerInfo.phoneNumber) {
        _phoneNumberController.text = customerInfo.phoneNumber;
      }
      if (_postalCodeController.text != customerInfo.postalCode) {
        _postalCodeController.text = customerInfo.postalCode;
      }
      if (_addressController.text != customerInfo.address) {
        _addressController.text = customerInfo.address;
      }
    }
  }

  @override
  void dispose() {
    _nationalIdController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _postalCodeController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return BlocListener<PreInvoiceCubit, PreInvoiceState>(
      listenWhen: (prev, curr) => prev.customerInfo != curr.customerInfo,
      listener: (context, state) {
        _updateOtherControllers(state.customerInfo);
      },
      child: BlocBuilder<PreInvoiceCubit, PreInvoiceState>(
        builder: (context, state) {
          final cubit = context.read<PreInvoiceCubit>();

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
                              controller: _nationalIdController,
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
                                          color:
                                              AppColors.errorPalette.shade600,
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
                              isActive: state.isNationalIdValid,
                              styleBtn: theme.labelLarge!.copyWith(
                                color: state.isNationalIdValid
                                    ? AppColors.brandPalette.shade600
                                    : AppColors.grayPalette.shade400,
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
                          S.current.nameLabelWithStar,
                          style: theme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.grayPalette.shade700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        RtcTextField(
                          controller: _firstNameController,
                          onChanged: (value) =>
                              cubit.onCustomerFieldChanged('firstName', value),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          S.current.lastNameLabelWithStar,
                          style: theme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.grayPalette.shade700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        RtcTextField(
                          controller: _lastNameController,
                          onChanged: (value) =>
                              cubit.onCustomerFieldChanged('lastName', value),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          S.current.phoneNumberLabelWithStar,
                          style: theme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.grayPalette.shade700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        RtcTextField(
                          controller: _phoneNumberController,
                          onChanged: (value) => cubit.onCustomerFieldChanged(
                            'phoneNumber',
                            value,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          S.current.postalCodeLabelWithStar,
                          style: theme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.grayPalette.shade700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        RtcTextField(
                          controller: _postalCodeController,
                          onChanged: (value) =>
                              cubit.onCustomerFieldChanged('postalCode', value),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          S.current.fullAddressLabelWithStar,
                          style: theme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.grayPalette.shade700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        RtcTextField(
                          minLines: 1,
                          maxLines: 3,
                          controller: _addressController,
                          onChanged: (value) =>
                              cubit.onCustomerFieldChanged('address', value),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          spacing: 8,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              S.current.sendOrderToCustomerAddress,
                              style: theme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColors.grayPalette.shade700,
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                            GestureDetector(
                              onTap: () => cubit.onCustomerFieldChanged(
                                'isOrderSentToCustomerAddress',
                                !state
                                    .customerInfo!
                                    .isOrderSentToCustomerAddress,
                              ),
                              child: RtcImage(
                                image:
                                    state
                                        .customerInfo!
                                        .isOrderSentToCustomerAddress
                                    ? "$baseImage/toggle_base.svg"
                                    : "$baseImage/toggle_base.svg",
                                width: 36,
                                height: 20,
                              ),
                            ),
                            Text(
                              state.customerInfo!.isOrderSentToCustomerAddress
                                  ? S.current.active
                                  : S.current.inactive,
                              style: theme.bodyMedium!.copyWith(
                                color:
                                    state
                                        .customerInfo!
                                        .isOrderSentToCustomerAddress
                                    ? AppColors.brandPalette.shade600
                                    : AppColors.grayPalette.shade400,
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
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
