import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../generated/l10n.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_image.dart';
import '../../../widget/rtc_text_field.dart';
import '../bloc/pre_invoice_cubit.dart';
import '../bloc/pre_invoice_state.dart';

class PreInvoiceDeliveryOptions extends StatelessWidget {
  const PreInvoiceDeliveryOptions({super.key});
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<PreInvoiceCubit, PreInvoiceState>(
        builder: (context, state) {
          final info = state.customerInfo;
          if (info == null) return const SizedBox.shrink();
          final cubit = context.read<PreInvoiceCubit>();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RecipientToggle(
                label: S.current.sendOrderToCustomerAddress,
                value: info.isOrderSentToCustomerAddress,
                onChanged: () => cubit.onCustomerFieldChanged(
                  'isOrderSentToCustomerAddress',
                  !info.isOrderSentToCustomerAddress,
                ),
              ),
              if (info.isOrderSentToCustomerAddress) ...[
                const SizedBox(height: 24),
                RecipientToggle(
                  label: S.current.receiveByAnotherPerson,
                  value: info.isOtherRecipient,
                  onChanged: () => cubit.onCustomerFieldChanged(
                    'isOtherRecipient',
                    !info.isOtherRecipient,
                  ),
                ),
                if (info.isOtherRecipient) ...[
                  const SizedBox(height: 24),
                  PreInvoiceRecipientFields(
                    key: ValueKey(state.customerIdQuery),
                  ),
                ],
              ],
            ],
          );
        },
      );
}

class RecipientToggle extends StatelessWidget {
  const RecipientToggle({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });
  final String label;
  final bool value;
  final VoidCallback onChanged;
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onChanged,
    child: Row(
      children: [
        Semantics(
          toggled: value,
          label: label,
          child: RtcImage(
            image: value
                ? 'assets/images/toggle_active.svg'
                : 'assets/images/toggle_base.svg',
            width: 36,
            height: 20,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.grayPalette.shade700,
            ),
          ),
        ),
      ],
    ),
  );
}

class PreInvoiceRecipientFields extends StatefulWidget {
  const PreInvoiceRecipientFields({super.key});
  @override
  State<PreInvoiceRecipientFields> createState() =>
      _PreInvoiceRecipientFieldsState();
}

class _PreInvoiceRecipientFieldsState extends State<PreInvoiceRecipientFields> {
  late final _name = TextEditingController(
    text: context.read<PreInvoiceCubit>().state.customerInfo?.recipientName,
  );
  late final _nationalId = TextEditingController(
    text: context
        .read<PreInvoiceCubit>()
        .state
        .customerInfo
        ?.recipientNationalId,
  );
  @override
  void dispose() {
    _name.dispose();
    _nationalId.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PreInvoiceCubit>();
    final label = Theme.of(context).textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.w500,
      color: AppColors.grayPalette.shade700,
    );
    return Column(
      children: [
        RtcTextField(
          controller: _name,
          labelText: S.current.recipientNameRequired,
          labelStyle: label,
          textStyle: Theme.of(context).textTheme.bodyLarge,
          hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.grayPalette.shade400,
          ),
          hintText: S.current.recipientNameHint,
          onChanged: (String value) =>
              cubit.onCustomerFieldChanged('recipientName', value),
        ),
        const SizedBox(height: 24),
        RtcTextField(
          controller: _nationalId,
          labelText: S.current.recipientNationalIdRequired,
          labelStyle: label,
          textStyle: Theme.of(context).textTheme.bodyLarge,
          hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.grayPalette.shade400,
          ),
          hintText: S.current.recipientNationalIdHint,
          keyboardType: TextInputType.number,
          maxLength: 10,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9۰-۹]')),
          ],
          onChanged: (String value) =>
              cubit.onCustomerFieldChanged('recipientNationalId', value),
        ),
      ],
    );
  }
}
