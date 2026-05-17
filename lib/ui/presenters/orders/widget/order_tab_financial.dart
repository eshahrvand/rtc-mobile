import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_status_badge.dart';
import '../../../../config/config.dart';
import '../../../../data/models/order_model.dart';
import '../../../widget/rtc_button.dart';
import '../../../widget/rtc_collapsible_section.dart';
import '../../../widget/rtc_image.dart';
import '../bloc/orders_cubit.dart';
import '../bloc/orders_state.dart';

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
                        return _buildSettlementOperations(op, context);
                      }
                      return _buildOperationItem(op, context);
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

  Widget _buildSettlementOperations(
    OrderOperationModel op,
    BuildContext context,
  ) {
    var theme = Theme.of(context).textTheme;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: AppColors.grayPalette.shade900,

                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    '${op.step}',
                    style: theme.labelLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                op.title,
                style: theme.labelLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.grayPalette.shade900,
                ),
              ),
              const Spacer(),
              RtcImage(
                image: "$baseImage/arrow_up_tab.svg",
                width: 24,
                height: 24,
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.current.settlementMethod,
                style: theme.bodyMedium!.copyWith(
                  color: AppColors.grayPalette.shade500,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.grayPalette.shade300,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Text(
                      S.current.walletSettlement,
                      style: theme.bodyLarge!.copyWith(
                        color: AppColors.grayPalette.shade900,
                      ),
                    ),
                    const Spacer(),
                    RtcImage(
                      image: "$baseImage/angle-down_tab.svg",
                      width: 24,
                      height: 24,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.current.differenceAmount,
                    style: theme.bodySmall!.copyWith(
                      color: AppColors.grayPalette.shade600,
                    ),
                  ),
                  Row(
                    spacing: 4,
                    children: [
                      Text(
                        '۲۴,۰۰۰,۰۰۰',
                        style: theme.labelLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.warningPalette.shade600,
                        ),
                      ),

                      Text(
                        S.current.toman,
                        style: theme.labelLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.warningPalette.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                decoration: BoxDecoration(
                  color: AppColors.successPalette.shade25,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.successPalette.shade100,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  spacing: 10,
                  children: [
                    RtcImage(
                      image: "$baseImage/tick_circle.svg",
                      width: 16,
                      height: 16,
                    ),

                    Expanded(
                      child: Text(
                        S.current.walletBalanceSufficient,
                        textAlign: TextAlign.right,
                        style: theme.bodyMedium!.copyWith(
                          color: AppColors.successPalette.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  SizedBox(width: 120),

                  Spacer(),
                  RtcButton(
                    title: S.current.payWithWallet,
                    styleBtn: theme.labelLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    width: 160,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOperationItem(OrderOperationModel op, BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: AppColors.grayPalette.shade900,

                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    '${op.step}',
                    style: theme.labelLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                op.title,
                style: theme.labelLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.grayPalette.shade900,
                ),
              ),
              const SizedBox(width: 8),
              if (op.isCompleted) RtcStatusBadge(status: op.status),
              const Spacer(),
              RtcImage(
                image: "$baseImage/angle-down_tab.svg",
                width: 24,
                height: 24,
              ),
            ],
          ),
        ),
      ],
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
