import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_collapsible_section.dart';
import 'package:rtc_mobile/ui/widget/rtc_divider.dart';
import '../../../../config/config.dart';
import '../../../../data/models/order_model.dart';
import '../../../../generated/l10n.dart';
import '../../../widget/rtc_image.dart';
import '../bloc/orders_cubit.dart';
import '../bloc/orders_state.dart';

class OrderTabDetails extends StatelessWidget {
  final OrderDetailModel order;

  const OrderTabDetails({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        final cubit = context.read<OrdersCubit>();

        return SingleChildScrollView(
          child: Column(
            children: [
              RtcCollapsibleSection(
                title: 'طرح اعتباری',
                icon: RtcImage(
                  image: '$baseImage/referee-card.svg',
                  width: 18,
                  height: 18,
                  color: AppColors.grayPalette.shade700,
                ),
                isExpanded: state.isCreditPlanExpanded,
                onToggle: () => cubit.toggleCreditPlan(),
                trailing: RtcImage(
                  image: state.isCreditPlanExpanded
                      ? "$baseImage/arrow_up_tab.svg"
                      : "$baseImage/angle-down_tab.svg",
                  width: 24,
                  height: 24,
                  color: AppColors.grayPalette.shade600,
                ),
                child: order.creditPlan == null
                    ? const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('طرحی انتخاب نشده است'),
                      )
                    : _CreditPlanInfo(plan: order.creditPlan!),
              ),

              RtcCollapsibleSection(
                title: 'کالاها',
                icon: RtcImage(
                  image: '$baseImage/package-check-tab.svg',
                  width: 18,
                  height: 18,
                  color: AppColors.grayPalette.shade700,
                ),
                isExpanded: state.isProductsExpanded,
                onToggle: () => cubit.toggleProducts(),
                trailing: RtcImage(
                  image: state.isProductsExpanded
                      ? "$baseImage/arrow_up_tab.svg"
                      : "$baseImage/angle-down_tab.svg",
                  width: 24,
                  height: 24,
                  color: AppColors.grayPalette.shade600,
                ),
                child: Column(
                  children: order.products
                      .map((p) => _ProductItem(product: p))
                      .toList(),
                ),
              ),

              RtcCollapsibleSection(
                title: 'اطلاعات مشتری',
                icon: RtcImage(
                  image: '$baseImage/user-tab.svg',
                  width: 18,
                  height: 18,
                  color: AppColors.grayPalette.shade700,
                ),
                isExpanded: state.isCustomerInfoExpanded,
                onToggle: () => cubit.toggleCustomerInfo(),
                trailing: RtcImage(
                  image: state.isCustomerInfoExpanded
                      ? "$baseImage/arrow_up_tab.svg"
                      : "$baseImage/angle-down_tab.svg",
                  width: 24,
                  height: 24,
                  color: AppColors.grayPalette.shade600,
                ),
                child: _CustomerInfo(customer: order.customer),
              ),

              RtcCollapsibleSection(
                title: 'مدارک بارگذاری شده',
                icon: RtcImage(
                  image: '$baseImage/papers-text-tab.svg',
                  width: 18,
                  height: 18,
                  color: AppColors.grayPalette.shade700,
                ),
                isExpanded: state.isDocumentsExpanded,
                onToggle: () => cubit.toggleDocuments(),
                trailing: RtcImage(
                  image: state.isDocumentsExpanded
                      ? "$baseImage/arrow_up_tab.svg"
                      : "$baseImage/angle-down_tab.svg",
                  width: 24,
                  height: 24,
                  color: AppColors.grayPalette.shade600,
                ),
                child: Column(
                  children: order.documents
                      .map((d) => _DocumentItem(doc: d))
                      .toList(),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }
}

class _CreditPlanInfo extends StatelessWidget {
  final CreditPlanModel plan;

  const _CreditPlanInfo({required this.plan});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          _InfoRow(label: 'ارائه دهنده', value: plan.provider),
          _InfoRow(label: 'نام طرح', value: plan.planName),
          _InfoRow(
            label: 'افزایش قیمت',
            value: plan.priceIncrease,
            valueColor: Colors.blue,
          ),
          _InfoRow(label: 'مدت اعتبار', value: plan.validityPeriod),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool isBold;

  const _InfoRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.isBold = true,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
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
              fontWeight: FontWeight.w600,
              color: AppColors.grayPalette.shade900,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductItem extends StatelessWidget {
  final OrderProductModel product;

  const _ProductItem({required this.product});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(8),

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
                  style: theme.bodyMedium!.copyWith(
                    color: AppColors.grayPalette.shade900,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  spacing: 4,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (product.oldPrice != null)
                      Text(
                        product.oldPrice!,
                        style: theme.bodyMedium!.copyWith(
                          color: AppColors.grayPalette.shade500,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    if (product.discount != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: AppColors.errorPalette.shade50,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          product.discount!,
                          style: theme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.errorPalette.shade700,
                          ),
                        ),
                      ),
                  ],
                ),
                Row(
                  spacing: 4,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      product.price,
                      style: theme.labelMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.grayPalette.shade900,
                      ),
                    ),

                    Text(
                      S.current.toman,
                      style: theme.labelMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.grayPalette.shade900,
                      ),
                    ),

                    Spacer(),
                    Container(
                      width: 24,
                      height: 24,
                      padding: const EdgeInsets.only(right: 2, left: 2),

                      decoration: BoxDecoration(
                        color: AppColors.brandPalette.shade25,
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),

                      child: Center(
                        child: Text(
                          product.quantity,
                          style: theme.labelLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.brandPalette.shade600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomerInfo extends StatelessWidget {
  final OrderCustomerModel customer;

  const _CustomerInfo({required this.customer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoRow(label: 'نام', value: customer.name),
          _InfoRow(label: 'شماره موبایل', value: customer.phone),
          _InfoRow(label: 'کد ملی', value: customer.nationalCode),
          _InfoRow(label: 'کد پستی', value: customer.postalCode),
          const _InfoRow(label: 'آدرس:', value: ''),
          Text(
            customer.address,

            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.grayPalette.shade900,
            ),
          ),
        ],
      ),
    );
  }
}

class _DocumentItem extends StatelessWidget {
  final OrderDocumentModel doc;

  const _DocumentItem({required this.doc});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grayPalette.shade200, width: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        spacing: 14,
        children: [
          RtcImage(
            image: '$baseImage/featured-icon.svg',
            width: 32,
            height: 32,
          ),

          Column(
            spacing: 3,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doc.title,
                style: theme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.grayPalette.shade900,
                ),
              ),
              Text(
                doc.fileName,
                style: theme.bodyMedium!.copyWith(
                  color: AppColors.grayPalette.shade600,
                ),
              ),
            ],
          ),

          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                doc.fileSize,
                style: theme.bodyMedium!.copyWith(
                  color: AppColors.grayPalette.shade600,
                ),
              ),
              const SizedBox(height: 4),
              RtcImage(
                image: '$baseImage/eye-document.svg',
                width: 20,
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
