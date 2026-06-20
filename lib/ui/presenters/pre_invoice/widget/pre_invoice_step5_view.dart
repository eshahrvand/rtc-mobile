import 'dart:io';

import 'package:rtc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_divider.dart';
import '../../../../config/config.dart';
import '../../../../core/models/pre_invoice_model.dart';
import '../../../widget/rtc_image.dart';
import '../bloc/pre_invoice_cubit.dart';
import '../bloc/pre_invoice_state.dart';
import 'pre_invoice_section_widget.dart';

import 'pre_invoice_step5_widgets.dart';

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
                  spacing: 8,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: PreInvoiceSectionWidget(
                        title: S.current.creditPlanTitle,
                        icon: RtcImage(
                          image: '$baseImage/referee-card.svg',
                          width: 20,
                          height: 20,
                        ),
                        child: PreInvoiceStep5CreditPlan(state: state),
                      ),
                    ),
                    PreInvoiceSectionWidget(
                      title: S.current.productsTitle,
                      icon: RtcImage(
                        image: '$baseImage/package-check-tab.svg',
                        width: 20,
                        height: 20,
                      ),
                      trailing: PreInvoiceEditButton(
                        onTap: () => cubit.enterEditMode(PreInvoiceStep.products),
                      ),
                      child: Column(
                        children: state.cartItems.asMap().entries.map((entry) {
                          final item = entry.value;
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
                          return Column(
                            children: [
                              PreInvoiceStep5ProductItem(
                                item: item,
                                product: product,
                                cubit: cubit,
                              ),
                              if (entry.key != state.cartItems.length - 1) ...[
                                const SizedBox(height: 7),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: RtcDivider(
                                    color: AppColors.grayPalette.shade200,
                                    height: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 7),
                              ],
                            ],
                          );
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
                      trailing: PreInvoiceEditButton(
                        onTap: () => cubit.enterEditMode(PreInvoiceStep.customerInfo),
                      ),
                      child: PreInvoiceStep5CustomerInfo(state: state),
                    ),
                    PreInvoiceSectionWidget(
                      title: S.current.uploadedDocumentsTitle,
                      icon: RtcImage(
                        image: '$baseImage/papers-text-tab.svg',
                        width: 20,
                        height: 20,
                      ),
                      trailing: PreInvoiceEditButton(
                        onTap: () => cubit.enterEditMode(PreInvoiceStep.documents),
                      ),
                      child: PreInvoiceStep5Documents(state: state),
                    ),
                    PreInvoiceSectionWidget(
                      title: S.current.financialSummaryTitle,
                      icon: RtcImage(
                        image: '$baseImage/dollar.svg',
                        width: 16,
                        height: 16,
                        color: AppColors.grayPalette.shade700,
                      ),
                      child: PreInvoiceStep5FinancialSummary(state: state),
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
}
