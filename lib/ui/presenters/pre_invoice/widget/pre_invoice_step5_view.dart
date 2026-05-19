import 'package:rtc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_divider.dart';
import '../../../../config/config.dart';
import '../../../widget/rtc_image.dart';
import '../bloc/pre_invoice_cubit.dart';
import '../bloc/pre_invoice_state.dart';
import 'pre_invoice_document_item.dart';
import 'pre_invoice_section_widget.dart';

class PreInvoiceStep5View extends StatelessWidget {
  const PreInvoiceStep5View({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
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
                        image: '$baseImage/referee-card.svg',
                        width: 20,
                        height: 20,
                      ),
                      child: _buildCreditPlanInfo(state, theme),
                    ),
                    PreInvoiceSectionWidget(
                      title: S.current.productsTitle,
                      icon: RtcImage(
                        image: '$baseImage/package-check-tab.svg',
                        width: 20,
                        height: 20,
                      ),
                      trailing: _buildEditButton(
                        () => cubit.enterEditMode(PreInvoiceStep.products),
                      ),
                      child: Column(
                        children: state.cartItems
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
                        () => cubit.enterEditMode(PreInvoiceStep.customerInfo),
                      ),
                      child: _buildCustomerInfo(state, theme),
                    ),
                    PreInvoiceSectionWidget(
                      title: S.current.uploadedDocumentsTitle,
                      icon: RtcImage(
                        image: '$baseImage/papers-text-tab.svg',
                        width: 20,
                        height: 20,
                      ),
                      trailing: _buildEditButton(
                        () => cubit.enterEditMode(PreInvoiceStep.documents),
                      ),
                      child: _buildDocuments(state),
                    ),
                    PreInvoiceSectionWidget(
                      title: S.current.financialSummaryTitle,
                      icon: RtcImage(
                        image: '$baseImage/dollar.svg',
                        width: 16,
                        height: 16,
                        color: AppColors.grayPalette.shade700,
                      ),
                      child: _buildFinancialSummary(state, theme),
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
      child: RtcImage(
        image: "$baseImage/edit.svg",
        width: 20,
        height: 20,
        color: AppColors.brandPalette.shade600,
      ),
    );
  }

  Widget _buildCreditPlanInfo(PreInvoiceState state, TextTheme theme) {
    final plan = state.creditPlans.firstWhere(
      (p) => p.id == state.selectedCreditPlanId,
      orElse: () => state.creditPlans.first,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        spacing: 7,
        children: [
          _buildInfoRow(S.current.providerLabel, plan.providerName, theme),
          _buildInfoRow(S.current.planNameLabel, plan.planName, theme),
          _buildInfoRow(
            S.current.priceIncreaseLabel,
            '۱۵٪',
            theme,
            valueColor: AppColors.brandPalette.shade700,
          ),
          _buildInfoRow(
            S.current.validityPeriodLabel,
            plan.validityDuration,
            theme,
          ),
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
                Text(
                  item.name,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (item.discount != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          item.discount!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    const SizedBox(width: 8),
                    Text(S.current.toman, style: const TextStyle(fontSize: 10)),
                    const SizedBox(width: 4),
                    Text(
                      item.price,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blue),
                  ),
                  child: Text(
                    '${item.quantity}',
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerInfo(PreInvoiceState state, TextTheme theme) {
    final info = state.customerInfo!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        spacing: 7,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(S.current.nameLabel, info.firstName, theme),
          RtcDivider(color: AppColors.grayPalette.shade200, height: 0.5),
          _buildInfoRow(S.current.phoneNumberLabel, info.phoneNumber, theme),
          RtcDivider(color: AppColors.grayPalette.shade200, height: 0.5),
          _buildInfoRow(S.current.nationalCodeLabel, info.nationalId, theme),
          RtcDivider(color: AppColors.grayPalette.shade200, height: 0.5),
          _buildInfoRow(S.current.postalCodeLabel, info.postalCode, theme),
          RtcDivider(color: AppColors.grayPalette.shade200, height: 0.5),
          _buildInfoRow(S.current.addressLabel, '', theme),
          RtcDivider(color: AppColors.grayPalette.shade200, height: 0.5),
          Text(
            info.address,

            style: theme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.grayPalette.shade900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocuments(PreInvoiceState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildDocItem(
            S.current.nationalCardFront,
            '۶ MB',
            'national_card_front',
          ),
          ...state.optionalDocPaths.asMap().entries.map((entry) {
            return _buildDocItem(
              S.current.otherDocumentsLabel(entry.key + 1),
              '۶ MB',
              'optional_doc_${entry.key + 1}',
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDocItem(String title, String size, String fileName) {
    return PreInvoiceDocumentItem(
      title: title,
      fileName: fileName,
      fileSize: size,
      onDelete: () {},
      onView: () {},
      showDeleteButton: false,
    );
  }

  Widget _buildFinancialSummary(PreInvoiceState state, TextTheme theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        spacing: 7,
        children: [
          _buildInfoRow(
            '${S.current.totalBasePrice} (۳ ${S.current.products})',
            '۱۴,۴۹۰,۰۰۰',
            theme,
          ),
          _buildInfoRow(S.current.totalDiscounts, '۴۹۰,۰۰۰', theme),

          RtcDivider(
            height: 0.5,
            color: AppColors.grayPalette.shade200,
            isDashed: true,
          ),
          _buildInfoRow(
            S.current.payableAmount,
            '۱۴,۰۰۰,۰۰۰',
            theme,
            isBold: true,
            valueColor: Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    String label,
    String value,
    TextTheme theme, {
    Color? valueColor,
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.bodyMedium!.copyWith(
              color: AppColors.grayPalette.shade600,
            ),
          ),
          Text(
            value,
            style: theme.labelMedium!.copyWith(
              color: valueColor ?? AppColors.grayPalette.shade900,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
