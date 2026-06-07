import 'package:rtc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_button.dart';
import 'package:rtc_mobile/ui/widget/rtc_divider.dart';
import '../../../../data/models/pre_invoice_model.dart';
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
                      RtcTextField(
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
                        isError:
                            !state.isNationalIdValid &&
                            state.customerIdQuery.isNotEmpty,
                        suffix: _nationalIdController.text.isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  _nationalIdController.clear();
                                  cubit.onCustomerIdChanged('');
                                  setState(() {});
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: RtcImage(
                                    image: '$baseImage/close.svg',
                                    width: 20,
                                    height: 20,
                                    color: AppColors.grayPalette.shade600,
                                    boxFit: BoxFit.fill,
                                  ),
                                ),
                              )
                            : null,
                        helper:
                            !state.isNationalIdValid &&
                                state.customerIdQuery.isNotEmpty
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
                                      color: AppColors.errorPalette.shade600,
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                        onChanged: (value) {
                          cubit.onCustomerIdChanged(value);
                          setState(() {});
                        },
                      ),
                      if (state.customerInfo == null) ...[
                        const SizedBox(height: 12),
                        RtcButton(
                          title: S.current.checkButton,
                          isActive:
                              state.isNationalIdValid &&
                              state.customerIdQuery.isNotEmpty,
                          isLoading: state.customerSearchLoading,
                          styleBtn: theme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w600,
                            color:
                                state.isNationalIdValid &&
                                    state.customerIdQuery.isNotEmpty
                                ? Colors.white
                                : AppColors.grayPalette.shade300,
                          ),
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            cubit.searchCustomer();
                          },
                        ),
                      ],
                      if (state.customerInfo != null) ...[
                        const SizedBox(height: 12),
                        RtcDivider(
                          color: AppColors.grayPalette.shade300,
                          height: 1,
                        ),
                        const SizedBox(height: 12),
                        RtcTextField(
                          labelText:
                              state.isExistingCustomer &&
                                  (state
                                          .originalCustomerInfo
                                          ?.lastName
                                          .isNotEmpty ??
                                      false)
                              ? S.current.nameLabel
                              : S.current.nameLabelWithStar,
                          labelStyle: theme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.grayPalette.shade700,
                          ),
                          controller: _firstNameController,
                          readOnly:
                              state.isExistingCustomer &&
                              (state
                                      .originalCustomerInfo
                                      ?.firstName
                                      .isNotEmpty ??
                                  false),
                          isSetReadOnlyColor: true,
                          onChanged: (value) =>
                              cubit.onCustomerFieldChanged('firstName', value),
                        ),
                        SizedBox(height: 12),
                        RtcTextField(
                          labelText:
                              state.isExistingCustomer &&
                                  (state
                                          .originalCustomerInfo
                                          ?.lastName
                                          .isNotEmpty ??
                                      false)
                              ? S.current.lastNameLabel
                              : S.current.lastNameLabelWithStar,
                          labelStyle: theme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.grayPalette.shade700,
                          ),
                          controller: _lastNameController,
                          readOnly:
                              state.isExistingCustomer &&
                              (state
                                      .originalCustomerInfo
                                      ?.lastName
                                      .isNotEmpty ??
                                  false),
                          isSetReadOnlyColor: true,
                          onChanged: (value) =>
                              cubit.onCustomerFieldChanged('lastName', value),
                        ),
                        SizedBox(height: 12),
                        RtcTextField(
                          labelText: S.current.phoneNumberLabelWithStar,
                          labelStyle: theme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.grayPalette.shade700,
                          ),
                          controller: _phoneNumberController,
                          onChanged: (value) => cubit.onCustomerFieldChanged(
                            'phoneNumber',
                            value,
                          ),
                        ),
                        SizedBox(height: 12),
                        RtcTextField(
                          labelText: S.current.postalCodeLabelWithStar,
                          labelStyle: theme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.grayPalette.shade700,
                          ),
                          controller: _postalCodeController,
                          onChanged: (value) =>
                              cubit.onCustomerFieldChanged('postalCode', value),
                        ),
                        SizedBox(height: 12),
                        RtcTextField(
                          labelText: S.current.fullAddressLabelWithStar,
                          labelStyle: theme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.grayPalette.shade700,
                          ),
                          minLines: 1,
                          maxLines: 3,
                          controller: _addressController,
                          onChanged: (value) =>
                              cubit.onCustomerFieldChanged('address', value),
                        ),
                        SizedBox(height: 24),
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
                                    ? "$baseImage/toggle_active.svg"
                                    : "$baseImage/toggle_base.svg",
                                width: 36,
                                height: 20,
                              ),
                            ),
                            SizedBox(
                              width: 48,
                              child: Text(
                                textAlign: TextAlign.right,
                                state.customerInfo!.isOrderSentToCustomerAddress
                                    ? S.current.active
                                    : S.current.inactive,
                                style: theme.bodyMedium!.copyWith(
                                  color: AppColors.grayPalette.shade700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                      ],
                    ],
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
