import 'package:cross_file/cross_file.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../config/constants.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_divider.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';
import 'package:rtc_mobile/ui/widget/rtc_counter_widget.dart';
import 'package:rtc_mobile/ui/widget/rtc_discount_badge.dart';
import 'package:rtc_mobile/core/utils/file_utils.dart';
import 'package:rtc_mobile/ui/presenters/orders/widget/document_viewer_screen.dart';
import '../../../../core/models/pre_invoice_model.dart';
import '../bloc/pre_invoice_cubit.dart';
import '../bloc/pre_invoice_state.dart';
import 'pre_invoice_document_item.dart';

class PreInvoiceEditButton extends StatelessWidget {
  final VoidCallback onTap;

  const PreInvoiceEditButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
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
}

class PreInvoiceStep5InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool isFinalPrice;
  final bool isPrice;

  const PreInvoiceStep5InfoRow({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
    this.isFinalPrice = false,
    this.isPrice = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
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
                const SizedBox(width: 4),
                RtcImage(
                  image: isFinalPrice
                      ? "$baseImage/rial_blue.svg"
                      : "$baseImage/rial.svg",
                  width: 16,
                  height: 16,
                  boxFit: BoxFit.contain,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class PreInvoiceStep5CreditPlan extends StatelessWidget {
  final PreInvoiceState state;

  const PreInvoiceStep5CreditPlan({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final plan = state.creditPlans.firstWhere(
      (p) => p.id == state.selectedCreditPlanId,
      orElse: () => state.creditPlans.first,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        spacing: 7,
        children: [
          PreInvoiceStep5InfoRow(
            label: S.current.providerLabel,
            value: plan.providerName,
          ),
          PreInvoiceStep5InfoRow(
            label: S.current.planNameLabel,
            value: plan.planName,
          ),
          PreInvoiceStep5InfoRow(
            label: '${S.current.validityPeriodLabel}',
            value: '${plan.validityDuration} ${S.current.day}',
          ),
        ],
      ),
    );
  }
}

class PreInvoiceStep5ProductItem extends StatelessWidget {
  final CartItemModel item;
  final PreInvoiceProductModel product;
  final PreInvoiceCubit cubit;

  const PreInvoiceStep5ProductItem({
    super.key,
    required this.item,
    required this.product,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      constraints: const BoxConstraints(minHeight: 95),
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
                  height: 49,
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
                                  style: theme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.lineThrough,
                                    color: AppColors.grayPalette.shade400,
                                  ),
                                ),
                                const SizedBox(width: 4),
                              ],
                              if (product.discount != null &&
                                  product.discount != "0%")
                                RtcDiscountBadge(
                                  backgroundColor:
                                      AppColors.errorPalette.shade50,
                                  textStyle: theme.bodyMedium!.copyWith(
                                    color: AppColors.errorPalette.shade700,
                                  ),
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
                            spacing: 2,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                product.price,
                                style: theme.labelLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.grayPalette.shade900,
                                ),
                              ),
                              RtcImage(
                                image: "$baseImage/rial.svg",
                                width: 18,
                                height: 18,
                                boxFit: BoxFit.contain,
                              ),
                            ],
                          ),
                        ],
                      ),
                      RtcCounterWidget(
                        quantity: item.quantity,
                        onAdd: () => cubit.increaseQuantity(item.productId),
                        onRemove: () => cubit.removeFromCart(item.productId),
                        isAvailable: true,
                        isCardStyle: false,
                        colorDeleteIcon: true,
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
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
}

class PreInvoiceStep5CustomerInfo extends StatelessWidget {
  final PreInvoiceState state;

  const PreInvoiceStep5CustomerInfo({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final info = state.customerInfo!;
    final fullName = '${info.firstName} ${info.lastName}'.trim();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        spacing: 7,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PreInvoiceStep5InfoRow(label: S.current.nameLabel, value: fullName),
          RtcDivider(color: AppColors.grayPalette.shade200, height: 0.5),
          PreInvoiceStep5InfoRow(
            label: S.current.phoneNumberLabel,
            value: info.phoneNumber,
          ),
          RtcDivider(color: AppColors.grayPalette.shade200, height: 0.5),
          PreInvoiceStep5InfoRow(
            label: S.current.nationalCodeLabel,
            value: info.nationalId,
          ),
          RtcDivider(color: AppColors.grayPalette.shade200, height: 0.5),
          PreInvoiceStep5InfoRow(
            label: S.current.postalCodeLabel,
            value: info.postalCode,
          ),
          RtcDivider(color: AppColors.grayPalette.shade200, height: 0.5),
          PreInvoiceStep5InfoRow(label: S.current.addressLabel, value: ''),
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
}

class PreInvoiceStep5Documents extends StatelessWidget {
  final PreInvoiceState state;

  const PreInvoiceStep5Documents({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          if (state.mandatoryDoc != null)
            PreInvoiceStep5DocItem(
              title: S.current.nationalCardFront,
              xFile: state.mandatoryDoc!,
            ),
          ...state.optionalDocs.asMap().entries.map((entry) {
            return PreInvoiceStep5DocItem(
              title: S.current.otherDocumentsLabel(entry.key + 1),
              xFile: entry.value,
            );
          }),
        ],
      ),
    );
  }
}

class PreInvoiceStep5DocItem extends StatefulWidget {
  final String title;
  final XFile xFile;

  const PreInvoiceStep5DocItem({
    super.key,
    required this.title,
    required this.xFile,
  });

  @override
  State<PreInvoiceStep5DocItem> createState() => _PreInvoiceStep5DocItemState();
}

class _PreInvoiceStep5DocItemState extends State<PreInvoiceStep5DocItem> {
  String _size = '...';

  @override
  void initState() {
    super.initState();
    _calculateSize();
  }

  Future<void> _calculateSize() async {
    final s = await FileUtils.getXFileSizeString(widget.xFile);
    if (mounted) {
      setState(() {
        _size = s;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PreInvoiceDocumentItem(
      title: widget.title,
      fileName: widget.xFile.name,
      fileSize: _size,
      onDelete: () {},
      onView: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DocumentViewerScreen(
              url: widget.xFile.path,
              title: widget.title,
              isLocalFile: true,
            ),
          ),
        );
      },
      showDeleteButton: false,
    );
  }
}

class PreInvoiceStep5FinancialSummary extends StatelessWidget {
  final PreInvoiceState state;

  const PreInvoiceStep5FinancialSummary({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final totalItems = state.totalCartItemsCount;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        spacing: 7,
        children: [
          PreInvoiceStep5InfoRow(
            label:
                '${S.current.totalBasePrice} ($totalItems ${S.current.product})',
            value: state.totalAmount,
            isPrice: true,
          ),
          PreInvoiceStep5InfoRow(
            label: S.current.totalDiscounts,
            value: state.totalDiscounts,
            isPrice: true,
          ),
          RtcDivider(
            height: 0.5,
            color: AppColors.grayPalette.shade200,
            isDashed: true,
          ),
          PreInvoiceStep5InfoRow(
            label: S.current.payableAmount,
            value: state.payableAmount,
            isFinalPrice: true,
            isPrice: true,
            valueColor: AppColors.brandPalette.shade600,
          ),
        ],
      ),
    );
  }
}
