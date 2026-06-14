import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_button.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';
import 'package:rtc_mobile/ui/widget/rtc_text_field.dart';
import '../bloc/pre_invoice_cubit.dart';
import '../bloc/pre_invoice_state.dart';

class PreInvoiceStep3NationalIdField extends StatelessWidget {
  final TextEditingController controller;
  final PreInvoiceState state;
  final PreInvoiceCubit cubit;
  final VoidCallback onClear;

  const PreInvoiceStep3NationalIdField({
    super.key,
    required this.controller,
    required this.state,
    required this.cubit,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Column(
      children: [
        RtcTextField(
          controller: controller,
          keyboardType: TextInputType.number,
          labelText: S.current.nationalCodeLabelWithStar,
          labelStyle: theme.bodyMedium!.copyWith(
            color: AppColors.grayPalette.shade700,
            fontWeight: FontWeight.w500,
          ),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp("[0-9۰-۹\b]"))
          ],
          maxLength: 10,
          hintText: S.current.nationalCodeHint,
          hintStyle: theme.bodyLarge!.copyWith(
            color: AppColors.grayPalette.shade400,
          ),
          isError: !state.isNationalIdValid && state.customerIdQuery.isNotEmpty,
          suffix: controller.text.isNotEmpty
              ? GestureDetector(
                  onTap: onClear,
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
          helper: !state.isNationalIdValid && state.customerIdQuery.isNotEmpty
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
          onChanged: (value) => cubit.onCustomerIdChanged(value),
        ),
        if (state.customerInfo == null) ...[
          const SizedBox(height: 12),
          RtcButton(
            title: S.current.checkButton,
            isActive: state.isNationalIdValid && state.customerIdQuery.isNotEmpty,
            isLoading: state.customerSearchLoading,
            styleBtn: theme.titleSmall!.copyWith(
              fontWeight: FontWeight.w600,
              color: state.isNationalIdValid && state.customerIdQuery.isNotEmpty
                  ? Colors.white
                  : AppColors.grayPalette.shade300,
            ),
            onPressed: () {
              FocusScope.of(context).unfocus();
              cubit.searchCustomer();
            },
          ),
        ],
      ],
    );
  }
}

class PreInvoiceStep3CustomerFields extends StatelessWidget {
  final PreInvoiceState state;
  final PreInvoiceCubit cubit;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneNumberController;
  final TextEditingController postalCodeController;
  final TextEditingController addressController;

  const PreInvoiceStep3CustomerFields({
    super.key,
    required this.state,
    required this.cubit,
    required this.firstNameController,
    required this.lastNameController,
    required this.phoneNumberController,
    required this.postalCodeController,
    required this.addressController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Column(
      children: [
        RtcTextField(
          labelText: state.isExistingCustomer &&
                  (state.originalCustomerInfo?.lastName.isNotEmpty ?? false)
              ? S.current.nameLabel
              : S.current.nameLabelWithStar,
          labelStyle: theme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.grayPalette.shade700,
          ),
          controller: firstNameController,
          readOnly: state.isExistingCustomer &&
              (state.originalCustomerInfo?.firstName.isNotEmpty ?? false),
          isSetReadOnlyColor: true,
          onChanged: (value) =>
              cubit.onCustomerFieldChanged('firstName', value),
        ),
        const SizedBox(height: 12),
        RtcTextField(
          labelText: state.isExistingCustomer &&
                  (state.originalCustomerInfo?.lastName.isNotEmpty ?? false)
              ? S.current.lastNameLabel
              : S.current.lastNameLabelWithStar,
          labelStyle: theme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.grayPalette.shade700,
          ),
          controller: lastNameController,
          readOnly: state.isExistingCustomer &&
              (state.originalCustomerInfo?.lastName.isNotEmpty ?? false),
          isSetReadOnlyColor: true,
          onChanged: (value) => cubit.onCustomerFieldChanged('lastName', value),
        ),
        const SizedBox(height: 12),
        RtcTextField(
          labelText: S.current.phoneNumberLabelWithStar,
          labelStyle: theme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.grayPalette.shade700,
          ),
          controller: phoneNumberController,
          keyboardType: TextInputType.phone,
          maxLength: 11,
          isError: !state.isPhoneNumberValid,
          helper: !state.isPhoneNumberValid
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
                      S.current.phoneNumberWrong,
                      style: theme.bodySmall!.copyWith(
                        color: AppColors.errorPalette.shade600,
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
          onChanged: (value) => cubit.onCustomerFieldChanged(
            'phoneNumber',
            value,
          ),
        ),
        const SizedBox(height: 12),
        RtcTextField(
          labelText: S.current.postalCodeLabelWithStar,
          labelStyle: theme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.grayPalette.shade700,
          ),
          keyboardType: TextInputType.number,
          controller: postalCodeController,
          onChanged: (value) =>
              cubit.onCustomerFieldChanged('postalCode', value),
          maxLength: 10,
          isError: !state.isPostalCodeValid,
          helper: !state.isPostalCodeValid
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
                      S.current.postalCodeWrong,
                      style: theme.bodySmall!.copyWith(
                        color: AppColors.errorPalette.shade600,
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        ),
        const SizedBox(height: 12),
        RtcTextField(
          labelText: S.current.fullAddressLabelWithStar,
          labelStyle: theme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.grayPalette.shade700,
          ),
          minLines: 1,
          maxLines: 3,
          controller: addressController,
          onChanged: (value) => cubit.onCustomerFieldChanged('address', value),
        ),
      ],
    );
  }
}

class PreInvoiceStep3AddressToggle extends StatelessWidget {
  final bool isOrderSentToCustomerAddress;
  final VoidCallback onToggle;

  const PreInvoiceStep3AddressToggle({
    super.key,
    required this.isOrderSentToCustomerAddress,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Row(
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
        const Spacer(),
        GestureDetector(
          onTap: onToggle,
          child: RtcImage(
            image: isOrderSentToCustomerAddress
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
            isOrderSentToCustomerAddress ? S.current.active : S.current.inactive,
            style: theme.bodyMedium!.copyWith(
              color: AppColors.grayPalette.shade700,
            ),
          ),
        ),
      ],
    );
  }
}
