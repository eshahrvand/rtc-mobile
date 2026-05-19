import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_collapsible_section.dart';
import '../../../../config/config.dart';
import '../../../../data/models/order_model.dart';
import '../../../../generated/l10n.dart';
import '../../../widget/rtc_image.dart';
import '../bloc/orders_cubit.dart';
import '../bloc/orders_state.dart';
import 'order_details_credit_plan_widget.dart';
import 'order_details_customer_info.dart';
import 'order_details_document_item.dart';
import 'order_details_products_widget.dart';

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
              OrderDetailsCreditPlanWidget(order: order),
              OrderDetailsProductsWidget(order: order),
              RtcCollapsibleSection(
                title: S.current.customerInfo,
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
                child: OrderDetailsCustomerInfo(customer: order.customer),
              ),

              RtcCollapsibleSection(
                title: S.current.uploadedDocumentsTitle,
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
                      .map((d) => OrderDetailsDocumentItem(doc: d))
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
