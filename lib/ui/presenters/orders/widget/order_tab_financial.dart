import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../config/config.dart';
import '../../../../core/enums/order_status.dart';
import '../../../../data/models/order_model.dart';
import '../../../widget/rtc_button.dart';
import '../../../widget/rtc_collapsible_section.dart';
import '../../../widget/rtc_image.dart';
import '../bloc/orders_cubit.dart';
import '../bloc/orders_state.dart';
import 'order_clearance_amount_sheet.dart';
import 'order_clearance_operation_widget.dart';
import 'order_clearance_otp_sheet.dart';
import 'order_operation_item_widget.dart';
import 'order_settlement_operations_widget.dart';

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

  void _showAmountSheet(BuildContext context, OrdersCubit cubit) {
    _amountController.text = widget.order.financialSummary.finalAmount;
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
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        final cubit = context.read<OrdersCubit>();
        final isPreInvoice = widget.order.orderStatus == OrderStatus.preInvoice;
        final isWaitingSettlement =
            widget.order.orderStatus == OrderStatus.awaitingSettlement;
        final isInitialClearance = state.clearanceStep == ClearanceStep.initial;

        final clearanceAmountVal =
            double.tryParse(state.clearanceAmount.replaceAll(',', '')) ?? 0;
        final orderAmountVal =
            double.tryParse(
              (state.orderAmount ?? widget.order.financialSummary.finalAmount)
                  .replaceAll(',', ''),
            ) ??
            0;

        // 1. Try to find a successful record from server
        final successRecords = widget.order.disbursementRecords.where(
          (r) => r.status == 'موفق' || r.status == 'success',
        );

        final String clearanceAmount = () {
          if (successRecords.isNotEmpty) {
            return successRecords.first.amount;
          }
          if (state.clearanceAmount.isNotEmpty) {
            return state.clearanceAmount;
          }
          return widget.order.financialSummary.finalAmount;
        }();

        final String? excessAmount = () {
          if (successRecords.isNotEmpty) {
            final disbursedVal =
                double.tryParse(
                  successRecords.first.amount.replaceAll(',', ''),
                ) ??
                0;
            final orderVal =
                double.tryParse(
                  widget.order.financialSummary.finalAmount.replaceAll(',', ''),
                ) ??
                0;
            if (disbursedVal > orderVal) {
              return (disbursedVal - orderVal).toStringAsFixed(0);
            }
            return null;
          }
          return state.excessAmount;
        }();

        final String? walletName =
            state.walletName ?? widget.order.creditPlan?.planName;

        // Hide settlement if the entered clearance amount already covers the total
        final isOverDischarge =
            state.clearanceAmount.isNotEmpty &&
            clearanceAmountVal >= orderAmountVal;

        final showSettlement =
            !isOverDischarge &&
            !state.isOutOfTolerance && // Hide if out of tolerance
            (isWaitingSettlement ||
                widget.order.settlementRecords.isNotEmpty ||
                state.clearanceStep == ClearanceStep.success ||
                state.clearanceAmount.isNotEmpty);

        final showSteps = showSettlement;

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: RtcCollapsibleSection(
                        title: S.current.financialSummaryTitle,
                        icon: RtcImage(
                          image: '$baseImage/dollar.svg',
                          width: 20,
                          height: 20,
                          color: AppColors.grayPalette.shade700,
                        ),
                        isExpanded: state.isFinancialSummaryExpanded,
                        alwaysShowChild: true,
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
                          state.isFinancialSummaryExpanded,
                          context,
                        ),
                      ),
                    ),

                    if (state.disburseOperation != null &&
                        (state.clearanceAmount.isNotEmpty ||
                            widget.order.orderStatus ==
                                OrderStatus.underReview ||
                            widget.order.orderStatus == OrderStatus.approved ||
                            widget.order.orderStatus ==
                                OrderStatus.awaitingSettlement ||
                            widget.order.orderStatus == OrderStatus.rejected))
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: OrderClearanceOperationWidget(
                          amount: clearanceAmount,
                          orderAmount:
                              state.orderAmount ??
                              widget.order.financialSummary.finalAmount,
                          excessAmount: excessAmount,
                          walletName: walletName,
                          isOutOfTolerance: state.isOutOfTolerance,
                          isOnline: state.gatewayType == GatewayType.online,
                          showStep: showSteps,
                          onAction: () {
                            if (state.disbursementGatewayType == 'otp') {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (_) => OrderClearanceOtpSheet(
                                  phoneNumber:
                                      state.disbursementMobile ??
                                      widget.order.customer.phone,
                                  onConfirm: (otp) {
                                    Navigator.pop(context);
                                    cubit.confirmClearanceOtp(otp);
                                  },
                                ),
                              );
                            } else if (state.disbursementGatewayType ==
                                'redirect') {
                              if (state.disbursementRedirectUrl != null) {
                                launchUrl(
                                  Uri.parse(state.disbursementRedirectUrl!),
                                  mode: LaunchMode.externalApplication,
                                );
                              }
                            } else {
                              cubit.pickClearanceDocument(context);
                            }
                          },
                          onEdit:
                              state.clearanceAmount.isNotEmpty &&
                                  (widget.order.orderStatus ==
                                          OrderStatus.preInvoice ||
                                      widget.order.orderStatus ==
                                          OrderStatus.awaitingSettlement)
                              ? () {
                                  cubit.resetClearance();
                                  _showAmountSheet(context, cubit);
                                }
                              : null,
                        ),
                      ),

                    if (showSettlement)
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 32),
                        child: OrderSettlementOperationsWidget(
                          showStep: showSteps,
                          op:
                              state.settlementOperation ??
                              const OrderOperationModel(
                                step: 2,
                                title: 'عملیات تسویه',
                                status: '',
                                isCompleted: false,
                              ),
                        ),
                      ),

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
                  onPressed: () => _showAmountSheet(context, cubit),
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
    bool isExpanded,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          if (isExpanded) ...[
            _buildInfoRow(context, S.current.totalBasePrice, summary.basePrice),
            _buildInfoRow(
              context,
              S.current.totalDiscounts,
              summary.totalDiscount,
            ),
          ],
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

  Widget _buildPaymentHistory(
    List<OrderPaymentModel> payments,
    BuildContext context,
  ) {
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
        ...payments.map(
          (p) => Container(
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
                    Text(
                      p.date,
                      style: theme.bodySmall!.copyWith(
                        color: AppColors.grayPalette.shade600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          p.amount,
                          style: theme.titleSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.brandPalette.shade600,
                          ),
                        ),
                        const SizedBox(width: 2),
                        RtcImage(
                          image: "$baseImage/toman.svg",
                          width: 24,
                          height: 24,
                        ),
                      ],
                    ),
                    if (p.status != null)
                      Text(
                        p.status!,
                        style: theme.labelSmall!.copyWith(
                          color: p.status == 'موفق'
                              ? AppColors.successPalette.shade600
                              : AppColors.errorPalette.shade600,
                        ),
                      ),
                  ],
                ),
              ],
            ),
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
                  fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
                  fontSize: isBold ? 14 : 12,
                ),
              ),
              RtcImage(
                image: "$baseImage/toman.svg",
                width: 18,
                height: 18,
                boxFit: BoxFit.fill,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
