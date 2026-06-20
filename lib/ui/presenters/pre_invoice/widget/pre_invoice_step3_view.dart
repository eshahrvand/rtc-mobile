import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_divider.dart';
import '../../../../core/models/pre_invoice_model.dart';
import '../bloc/pre_invoice_cubit.dart';
import '../bloc/pre_invoice_state.dart';
import 'pre_invoice_step3_widgets.dart';

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
                      PreInvoiceStep3NationalIdField(
                        controller: _nationalIdController,
                        state: state,
                        cubit: cubit,
                        onClear: () {
                          _nationalIdController.clear();
                          cubit.onCustomerIdChanged('');
                          setState(() {});
                        },
                      ),
                      if (state.customerInfo != null) ...[
                        const SizedBox(height: 12),
                        RtcDivider(
                          color: AppColors.grayPalette.shade300,
                          height: 1,
                        ),
                        const SizedBox(height: 12),
                        PreInvoiceStep3CustomerFields(
                          state: state,
                          cubit: cubit,
                          firstNameController: _firstNameController,
                          lastNameController: _lastNameController,
                          phoneNumberController: _phoneNumberController,
                          postalCodeController: _postalCodeController,
                          addressController: _addressController,
                        ),
                        const SizedBox(height: 24),
                        PreInvoiceStep3AddressToggle(
                          isOrderSentToCustomerAddress:
                              state.customerInfo!.isOrderSentToCustomerAddress,
                          onToggle: () => cubit.onCustomerFieldChanged(
                            'isOrderSentToCustomerAddress',
                            !state
                                .customerInfo!
                                .isOrderSentToCustomerAddress,
                          ),
                        ),
                        const SizedBox(height: 12),
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
