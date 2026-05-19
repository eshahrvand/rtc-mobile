import 'package:rtc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_divider.dart';
import '../../../../config/config.dart';
import '../../../widget/rtc_counter.dart';
import '../../../widget/rtc_image.dart';
import '../bloc/pre_invoice_cubit.dart';
import '../bloc/pre_invoice_state.dart';
import '../../../../data/models/pre_invoice_model.dart';
import 'package:rtc_mobile/ui/widget/rtc_discount_badge.dart';
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
                        children: state.cartItems.map((item) {
                          final product = state.allProducts.firstWhere(
                            (p) => p.id == item.productId,
                            orElse: () => PreInvoiceProductModel(
                              id: '',
                              name: '',
                              imageUrl: '',
                              price: '',
                              inventory: '0',
                            ),
                          );
                          return _buildProductItem(item, product, theme, cubit);
                        }).toList(),
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

  Widget _buildProductItem(
    CartItemModel item,
    PreInvoiceProductModel product,
    TextTheme theme,
    PreInvoiceCubit cubit,
  ) {
    return Container(
      height: 90,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(4),

            child: RtcImage(image: product.imageUrl, boxFit: BoxFit.contain),
          ),
          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  textAlign: TextAlign.right,
                  style: theme.labelMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.grayPalette.shade800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product.isAvailable
                      ? 'موجودی (${product.inventory})'
                      : 'ناموجود',
                  style: theme.labelSmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: product.isAvailable
                        ? AppColors.successPalette.shade600
                        : AppColors.errorPalette.shade600,
                  ),
                ),

                const SizedBox(height: 8),

                SizedBox(
                  height: 45,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (product.oldPrice != null) ...[
                                const SizedBox(width: 8),
                                Text(
                                  product.oldPrice!,
                                  style: theme.bodySmall!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.lineThrough,
                                    color: AppColors.grayPalette.shade400,
                                  ),
                                ),
                                SizedBox(width: 2),
                              ],
                              if (product.discount != null)
                                RtcDiscountBadge(
                                  discount: product.discount!,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            spacing: 4,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                product.price,
                                style: theme.labelLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.grayPalette.shade900,
                                ),
                              ),
                              Text(
                                S.current.toman,
                                style: theme.bodySmall!.copyWith(
                                  color: AppColors.grayPalette.shade600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      _buildCounter(
                        item.quantity,
                        () => cubit.increaseQuantity(item.productId),
                        () => cubit.removeFromCart(item.productId),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCounter(
    int quantity,
    VoidCallback onAdd,
    VoidCallback onRemove,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.grayPalette.shade200),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onAdd,
            child: RtcImage(
              image: "$baseImage/add-basket.svg",
              width: 16,
              height: 16,
            ),
          ),
          const SizedBox(width: 14),
          Text(
            '$quantity',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 14),
          GestureDetector(
            onTap: onRemove,
            child: RtcImage(
              image: quantity == 1
                  ? "$baseImage/delete.svg"
                  : "$baseImage/remove.svg",
              width: 16,
              height: 16,
              color: quantity == 1 ? AppColors.errorPalette.shade600 : null,
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
            isPrice: true,
          ),
          _buildInfoRow(
            S.current.totalDiscounts,
            '۴۹۰,۰۰۰',
            theme,
            isPrice: true,
          ),

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
            isPrice: true,
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
    bool isPrice = false,
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

          Row(
            mainAxisSize: MainAxisSize.min,

            children: [
              Text(
                value,
                style: theme.labelMedium!.copyWith(
                  color: valueColor ?? AppColors.grayPalette.shade900,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (isPrice) ...[
                SizedBox(width: 4),
                Text(
                  S.current.toman,
                  style: theme.bodySmall!.copyWith(
                    color: valueColor ?? AppColors.grayPalette.shade700,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
