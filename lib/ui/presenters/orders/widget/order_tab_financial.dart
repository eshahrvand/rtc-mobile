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
import 'order_clearance_amount_sheet.dart';
import 'order_operation_item_widget.dart';

class OrderTabFinancial extends StatefulWidget {
  final OrderDetailModel order;

  const OrderTabFinancial({super.key, required this.order});

  @override
  State<OrderTabFinancial> createState() => _OrderTabFinancialState();
}

class _OrderTabFinancialState extends State<OrderTabFinancial> {
  late TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(
      text: widget.order.financialSummary.finalAmount,
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        final cubit = context.read<OrdersCubit>();
        final isPreInvoice = widget.order.status == 'پیش فاکتور';
        final isWaitingSettlement = widget.order.status == 'در انتظار تسویه';
        final isInitialClearance = state.clearanceStep == ClearanceStep.initial;
        final isClearanceInProgress =
            state.clearanceStep == ClearanceStep.amountEntered ||
            state.clearanceStep == ClearanceStep.documentsPending;

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
                        widget.order.financialSummary,
                        widget.order.isSettled,
                        isWaitingSettlement,
                        context,
                      ),
                    ),

                    if (state.disburseOperation != null)
                      OrderOperationItemWidget(op: state.disburseOperation!),

                    if (widget.order.operations.isNotEmpty)
                      ...widget.order.operations.map(
                        (op) => OrderOperationItemWidget(op: op),
                      ),

                    if (widget.order.payments.isNotEmpty)
                      _buildPaymentHistory(widget.order.payments, context),
                  ],
                ),
              ),
            ),
            if (isPreInvoice && isInitialClearance)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
                child: RtcButton(
                  styleBtn: theme.labelLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  title: S.current.dischargeAndSettlement,
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => OrderClearanceAmountSheet(
                        totalAmount: widget.order.financialSummary.finalAmount,
                        amountController: _amountController,
                        onCheckPressed: () {
                          cubit.initiateClearance(_amountController.text);
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
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
      ),
    );
  }

  Widget _buildPaymentHistory(List<OrderPaymentModel> payments, BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
          child: Text(
            'تاریخچه پرداخت‌ها',
            style: theme.labelLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.grayPalette.shade900,
            ),
          ),
        ),
        ...payments.map((p) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.grayPalette.shade200),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(p.type, style: theme.bodyMedium),
                      Text(p.date,
                          style: theme.bodySmall!.copyWith(
                              color: AppColors.grayPalette.shade600)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(p.amount,
                              style: theme.titleSmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.brandPalette.shade600)),
                          const SizedBox(width: 4),
                          Text(S.current.toman,
                              style: theme.bodySmall!.copyWith(
                                  color: AppColors.brandPalette.shade600)),
                        ],
                      ),
                      if (p.status != null)
                        Text(p.status!,
                            style: theme.labelSmall!.copyWith(
                                color: p.status == 'موفق'
                                    ? AppColors.successPalette.shade600
                                    : AppColors.errorPalette.shade600)),
                    ],
                  ),
                ],
              ),
            )),
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
