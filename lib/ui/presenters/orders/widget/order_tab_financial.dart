import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import '../../../../config/config.dart';
import '../../../../data/models/order_model.dart';
import '../../../widget/rtc_button.dart';
import '../../../widget/rtc_collapsible_section.dart';
import '../../../widget/rtc_image.dart';
import '../bloc/orders_cubit.dart';
import '../bloc/orders_state.dart';
import 'order_operation_item_widget.dart';
import 'order_settlement_operations_widget.dart';

class OrderTabFinancial extends StatelessWidget {
  final OrderDetailModel order;

  const OrderTabFinancial({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        final cubit = context.read<OrdersCubit>();
        final isWaitingSettlement = order.status == 'در انتظار تسویه';

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    RtcCollapsibleSection(
                      title: S.current.financialSummaryTitle,
                      icon: RtcImage(
                        image: '$baseImage/dollar.svg',
                        width: 20,
                        height: 20,
                        color: AppColors.grayPalette.shade700,
                      ),
                      isExpanded: state.isFinancialSummaryExpanded,
                      onToggle: () => cubit.toggleFinancialSummary(),
                      showDivider: true,
                      headerSpacing: 8,
                      trailing: RtcImage(
                        image: state.isFinancialSummaryExpanded
                            ? "$baseImage/arrow_up_tab.svg"
                            : "$baseImage/angle-down_tab.svg",
                        color: AppColors.grayPalette.shade600,
                      ),
                      child: _buildFinancialSummary(
                        order.financialSummary,
                        order.isSettled,
                        isWaitingSettlement,
                        context,
                      ),
                    ),
                    ...order.operations.map((op) {
                      if (op.step == 2 && isWaitingSettlement) {
                        return OrderSettlementOperationsWidget(op: op);
                      }
                      return OrderOperationItemWidget(op: op);
                    }).toList(),
                  ],
                ),
              ),
            ),
            if (order.status == 'پیش فاکتور')
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
                child: RtcButton(
                  styleBtn: theme.labelLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  title: S.current.dischargeAndSettlement,
                  onPressed: () {},
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildFinancialSummary(
    FinancialSummaryModel summary,
    bool isSettled,
    bool isWaitingSettlement,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          if (isWaitingSettlement) ...[
            _buildInfoRow(
              context,
              S.current.finalFactorAmount,
              summary.finalAmount,
              isBold: true,
            ),
          ] else if (isSettled) ...[
            _buildInfoRow(
              context,
              S.current.finalFactorAmount,
              summary.finalAmount,
              isBold: true,
            ),
          ] else ...[
            _buildInfoRow(context, S.current.totalBasePrice, summary.basePrice),
            _buildInfoRow(
              context,
              S.current.totalDiscounts,
              summary.totalDiscount,
            ),
            _buildInfoRow(
              context,
              S.current.finalFactorAmount,
              summary.finalAmount,
              isBold: true,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value, {
    bool isBold = false,
  }) {
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
          Row(
            spacing: 4,
            children: [
              Text(
                value,
                style: theme.bodyMedium!.copyWith(
                  color: AppColors.grayPalette.shade900,
                ),
              ),
              Text(
                S.current.toman,
                style: theme.bodyMedium!.copyWith(
                  color: AppColors.grayPalette.shade900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

