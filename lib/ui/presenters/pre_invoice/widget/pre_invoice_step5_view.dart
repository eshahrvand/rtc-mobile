import 'package:rtc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/config.dart';
import '../../../widget/rtc_button.dart';
import '../../../widget/rtc_image.dart';
import '../../../widget/rtc_step_indicator.dart';
import '../bloc/pre_invoice_cubit.dart';
import '../bloc/pre_invoice_state.dart';

class PreInvoiceStep5View extends StatelessWidget {
  const PreInvoiceStep5View({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreInvoiceCubit, PreInvoiceState>(
      builder: (context, state) {
        final cubit = context.read<PreInvoiceCubit>();

        return Column(
          children: [
            RtcStepIndicator(
              totalSteps: 5,
              currentStepIndex: 4,
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
                child: Column(
                  children: [
                    _buildSectionHeader(S.current.creditPlanTitle, '$baseImage/package-check.svg'),
                    _buildCreditPlanInfo(state),
                    const Divider(),
                    _buildSectionHeader(S.current.productsTitle, '$baseImage/package-check.svg', onEdit: () => cubit.goToStep(PreInvoiceStep.products)),
                    ...state.cartItems.map((item) => _buildProductItem(item)).toList(),
                    const Divider(),
                    _buildSectionHeader(S.current.customerInfoTitle, '$baseImage/family.svg', onEdit: () => cubit.goToStep(PreInvoiceStep.customerInfo)),
                    _buildCustomerInfo(state),
                    const Divider(),
                    _buildSectionHeader(S.current.uploadedDocumentsTitle, '$baseImage/document-list-check.svg', onEdit: () => cubit.goToStep(PreInvoiceStep.documents)),
                    _buildDocuments(state),
                    const Divider(),
                    _buildSectionHeader(S.current.financialSummaryTitle, '$baseImage/dollar.svg'),
                    _buildFinancialSummary(state),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            _buildBottomButtons(context, cubit),
          ],
        );
      },
    );
  }

  Widget _buildSectionHeader(String title, String iconPath, {VoidCallback? onEdit}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          if (onEdit != null)
            GestureDetector(
              onTap: onEdit,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(Icons.edit_outlined, size: 16, color: Colors.blue),
              ),
            ),
          const Spacer(),
          Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          RtcImage(image: iconPath, width: 20, height: 20),
        ],
      ),
    );
  }

  Widget _buildCreditPlanInfo(PreInvoiceState state) {
    final plan = state.creditPlans.firstWhere((p) => p.id == state.selectedCreditPlanId, orElse: () => state.creditPlans.first);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildInfoRow(S.current.providerLabel, plan.providerName),
          _buildInfoRow(S.current.planNameLabel, plan.planName),
          _buildInfoRow(S.current.priceIncreaseLabel, '۱۵٪', valueColor: Colors.blue),
          _buildInfoRow(S.current.validityPeriodLabel, plan.validityDuration),
        ],
      ),
    );
  }

  Widget _buildProductItem(dynamic item) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade100),
              borderRadius: BorderRadius.circular(8),
            ),
            child: RtcImage(image: item.imageUrl, boxFit: BoxFit.contain),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(item.name, textAlign: TextAlign.right, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (item.discount != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(4)),
                        child: Text(item.discount!, style: const TextStyle(color: Colors.red, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    const SizedBox(width: 8),
                    Text(S.current.toman, style: const TextStyle(fontSize: 10)),
                    const SizedBox(width: 4),
                    Text(item.price, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.blue)),
                  child: Text('${item.quantity}', style: const TextStyle(fontSize: 10, color: Colors.blue, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerInfo(PreInvoiceState state) {
    final info = state.customerInfo!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildInfoRow(S.current.nameLabel, info.firstName),
          _buildInfoRow(S.current.phoneNumberLabel, info.phoneNumber),
          _buildInfoRow(S.current.nationalCodeLabel, info.nationalId),
          _buildInfoRow(S.current.postalCodeLabel, info.postalCode),
          _buildInfoRow(S.current.addressLabel, ''),
          Text(info.address, textAlign: TextAlign.right, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildDocuments(PreInvoiceState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildDocItem(S.current.nationalCardFront, '۶ MB', true),
          if (state.optionalDocPath != null) _buildDocItem(S.current.optionalDocuments, '۶ MB', false),
        ],
      ),
    );
  }

  Widget _buildDocItem(String title, String size, bool isMandatory) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade100), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(size, style: const TextStyle(fontSize: 10, color: Colors.grey)),
            const SizedBox(height: 4),
            const Icon(Icons.image_outlined, size: 16, color: Colors.blue),
          ]),
          const Spacer(),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            const Text('national_card_front', style: TextStyle(fontSize: 10, color: Colors.grey)),
          ]),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.image_outlined, color: Colors.blue),
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialSummary(PreInvoiceState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildInfoRow('${S.current.totalBasePrice} (۳ ${S.current.products})', '۱۴,۴۹۰,۰۰۰'),
          _buildInfoRow(S.current.totalDiscounts, '۴۹۰,۰۰۰'),
          _buildInfoRow(S.current.payableAmount, '۱۴,۰۰۰,۰۰۰', isBold: true, valueColor: Colors.blue),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? valueColor, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(value, style: TextStyle(fontSize: 14, fontWeight: isBold ? FontWeight.bold : FontWeight.normal, color: valueColor ?? Colors.black)),
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildBottomButtons(BuildContext context, PreInvoiceCubit cubit) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -4))],
      ),
      child: Row(
        children: [
          Expanded(
            child: RtcButton(
              title: S.current.submitAndClearCart,
              onPressed: () => cubit.submitAndClear(),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: RtcButton(
              title: S.current.submitPreInvoice,
              backgroundColor: Colors.blue.shade50,
              styleBtn: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              onPressed: () => cubit.submitPreInvoice(),
            ),
          ),
        ],
      ),
    );
  }
}
