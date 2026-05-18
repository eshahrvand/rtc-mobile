import 'package:rtc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import '../../../../config/config.dart';
import '../../../widget/rtc_image.dart';
import '../bloc/pre_invoice_cubit.dart';
import '../bloc/pre_invoice_state.dart';
import 'pre_invoice_section_widget.dart';

class PreInvoiceStep5View extends StatelessWidget {
  const PreInvoiceStep5View({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreInvoiceCubit, PreInvoiceState>(
      builder: (context, state) {
        final cubit = context.read<PreInvoiceCubit>();

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    PreInvoiceSectionWidget(
                      title: S.current.creditPlanTitle,
                      icon: RtcImage(
                        image: '$baseImage/package-check.svg',
                        width: 20,
                        height: 20,
                      ),
                      child: _buildCreditPlanInfo(state),
                    ),
                    PreInvoiceSectionWidget(
                      title: S.current.productsTitle,
                      icon: RtcImage(
                        image: '$baseImage/package-check.svg',
                        width: 20,
                        height: 20,
                      ),
                      trailing: _buildEditButton(
                        () => cubit.goToStep(PreInvoiceStep.products),
                      ),
                      child: Column(
                        children:
                            state.cartItems
                                .map((item) => _buildProductItem(item))
                                .toList(),
                      ),
                    ),
                    PreInvoiceSectionWidget(
                      title: S.current.customerInfoTitle,
                      icon: RtcImage(
                        image: '$baseImage/family.svg',
                        width: 20,
                        height: 20,
                      ),
                      trailing: _buildEditButton(
                        () => cubit.goToStep(PreInvoiceStep.customerInfo),
                      ),
                      child: _buildCustomerInfo(state),
                    ),
                    PreInvoiceSectionWidget(
                      title: S.current.uploadedDocumentsTitle,
                      icon: RtcImage(
                        image: '$baseImage/document-list-check.svg',
                        width: 20,
                        height: 20,
                      ),
                      trailing: _buildEditButton(
                        () => cubit.goToStep(PreInvoiceStep.documents),
                      ),
                      child: _buildDocuments(state),
                    ),
                    PreInvoiceSectionWidget(
                      title: S.current.financialSummaryTitle,
                      icon: RtcImage(
                        image: '$baseImage/dollar.svg',
                        width: 20,
                        height: 20,
                      ),
                      child: _buildFinancialSummary(state),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEditButton(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.brandPalette.shade600),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(
          Icons.edit_outlined,
          size: 16,
          color: AppColors.brandPalette.shade600,
        ),
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
}
