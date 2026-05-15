import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/config.dart';
import '../../../../data/models/order_model.dart';
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
              _CollapsibleSection(
                title: 'طرح اعتباری',
                iconPath: '$baseImage/package-check.svg',
                isExpanded: state.isCreditPlanExpanded,
                onToggle: () => cubit.toggleCreditPlan(),
                child: order.creditPlan == null
                    ? const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('طرحی انتخاب نشده است'),
                      )
                    : _CreditPlanInfo(plan: order.creditPlan!),
              ),
              const Divider(),
              _CollapsibleSection(
                title: 'کالاها',
                iconPath: '$baseImage/package-check.svg',
                isExpanded: state.isProductsExpanded,
                onToggle: () => cubit.toggleProducts(),
                child: Column(
                  children: order.products.map((p) => _ProductItem(product: p)).toList(),
                ),
              ),
              const Divider(),
              _CollapsibleSection(
                title: 'اطلاعات مشتری',
                iconPath: '$baseImage/family.svg',
                isExpanded: state.isCustomerInfoExpanded,
                onToggle: () => cubit.toggleCustomerInfo(),
                child: _CustomerInfo(customer: order.customer),
              ),
              const Divider(),
              _CollapsibleSection(
                title: 'مدارک بارگذاری شده',
                iconPath: '$baseImage/document-list-check.svg',
                isExpanded: state.isDocumentsExpanded,
                onToggle: () => cubit.toggleDocuments(),
                child: Column(
                  children: order.documents.map((d) => _DocumentItem(doc: d)).toList(),
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

class _CollapsibleSection extends StatelessWidget {
  final String title;
  final String iconPath;
  final bool isExpanded;
  final VoidCallback onToggle;
  final Widget child;

  const _CollapsibleSection({
    required this.title,
    required this.iconPath,
    required this.isExpanded,
    required this.onToggle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onToggle,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(
                  isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: Colors.grey,
                ),
                const Spacer(),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                RtcImage(image: iconPath, width: 20, height: 20, color: Colors.black),
              ],
            ),
          ),
        ),
        if (isExpanded) child,
      ],
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
          _InfoRow(label: 'نام طرح', plan.planName),
          _InfoRow(label: 'افزایش قیمت', value: plan.priceIncrease, valueColor: Colors.blue),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: valueColor ?? Colors.black,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: RtcImage(image: product.imageUrl, boxFit: BoxFit.contain),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  product.name,
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (product.discount != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          product.discount!,
                          style: const TextStyle(fontSize: 10, color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ),
                    const SizedBox(width: 8),
                    if (product.oldPrice != null)
                      Text(
                        product.oldPrice!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text('تومان', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    const SizedBox(width: 4),
                    Text(
                      product.price,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blue),
                  ),
                  child: Text(
                    product.quantity,
                    style: const TextStyle(fontSize: 12, color: Colors.blue, fontWeight: FontWeight.bold),
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

class _CustomerInfo extends StatelessWidget {
  final OrderCustomerModel customer;

  const _CustomerInfo({required this.customer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _InfoRow(label: 'نام', value: customer.name),
          _InfoRow(label: 'شماره موبایل', value: customer.phone),
          _InfoRow(label: 'کد ملی', value: customer.nationalCode),
          _InfoRow(label: 'کد پستی', value: customer.postalCode),
          const _InfoRow(label: 'آدرس:', value: ''),
          Text(
            customer.address,
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 13, color: Colors.black),
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(doc.fileSize, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(height: 4),
              RtcImage(image: '$baseImage/waiting.svg', width: 16, height: 16, color: Colors.blue),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(doc.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              Text(doc.fileName, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: RtcImage(image: '$baseImage/waiting.svg', width: 20, height: 20, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
