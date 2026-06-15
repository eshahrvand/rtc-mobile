import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../config/config.dart';
import '../../../../data/models/order_model.dart';
import '../../../widget/rtc_button.dart';
import '../../../widget/rtc_collapsible_section.dart';
import '../../../widget/rtc_image.dart';
import '../bloc/orders_cubit.dart';
import '../bloc/orders_state.dart';
import 'order_clearance_amount_sheet.dart';
import 'order_clearance_operation_widget.dart';
import 'order_clearance_otp_sheet.dart';
import 'order_financial_summary_widget.dart';
import 'order_operation_item_widget.dart';
import 'order_payment_history_widget.dart';
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
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: BlocBuilder<OrdersCubit, OrdersState>(
          builder: (context, state) {
            return OrderClearanceAmountSheet(
              totalAmount: widget.order.financialSummary.finalAmount,
              amountController: _amountController,
              isLoading: state.status == OrdersRequestStatus.loading,
              onCheckPressed: () {
                cubit
                    .initiateClearance(_amountController.text)
                    .then((_) {
                      if (context.mounted) Navigator.pop(context);
                    })
                    .catchError((_) {});
              },
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        final cubit = context.read<OrdersCubit>();
        final clearanceAmount = state.resolvedClearanceAmount;
        final excessAmount = state.resolvedExcessAmount;
        final walletName =
            state.walletName ?? widget.order.creditPlan?.planName;
        final showSettlement = state.shouldShowSettlement;

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: RtcCollapsibleSection(
                        title: S.current.financialSummaryTitle,
                        icon: RtcImage(
                          image: '$baseImage/dollar.svg',
                          width: 20.0,
                          height: 20.0,
                          color: AppColors.grayPalette.shade700,
                        ),
                        isExpanded: state.isFinancialSummaryExpanded,
                        alwaysShowChild: true,
                        onToggle: () => cubit.toggleFinancialSummary(),
                        showDivider: true,
                        headerSpacing: 8.0,
                        trailing: RtcImage(
                          image: state.isFinancialSummaryExpanded
                              ? "$baseImage/arrow_up_tab.svg"
                              : "$baseImage/angle-down_tab.svg",
                          color: AppColors.grayPalette.shade600,
                        ),
                        child: OrderFinancialSummaryWidget(
                          summary: widget.order.financialSummary,
                          isExpanded: state.isFinancialSummaryExpanded,
                        ),
                      ),
                    ),
                    if (state.shouldShowDisbursement)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: OrderClearanceOperationWidget(
                          amount: clearanceAmount,
                          statusDisplay: state.lastDisbursementStatusDisplay,
                          orderAmount:
                              state.orderAmount ??
                              widget.order.financialSummary.finalAmount,
                          excessAmount: excessAmount,
                          walletName: walletName,
                          isOutOfTolerance: state.isOutOfTolerance,
                          isOnline: state.gatewayType == GatewayType.online,
                          showStep: showSettlement,
                          isLoading:
                              state.status == OrdersRequestStatus.loading,
                          onAction: () {
                            if (state.disbursementGatewayType == 'otp') {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (_) => BlocProvider.value(
                                  value: cubit,
                                  child: BlocBuilder<OrdersCubit, OrdersState>(
                                    builder: (context, state) {
                                      return OrderClearanceOtpSheet(
                                        phoneNumber:
                                            state.disbursementMobile ??
                                            widget.order.customer.phone,
                                        isLoading:
                                            state.status ==
                                            OrdersRequestStatus.loading,
                                        onConfirm: (otp) {
                                          cubit
                                              .confirmClearanceOtp(otp)
                                              .then((_) {
                                                if (context.mounted) {
                                                  Navigator.pop(context);
                                                }
                                              })
                                              .catchError((_) {});
                                        },
                                      );
                                    },
                                  ),
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
                                  (state.isPreInvoice ||
                                      state.isWaitingSettlement)
                              ? () {
                                  cubit.resetClearance();
                                  _showAmountSheet(context, cubit);
                                }
                              : null,
                        ),
                      ),
                    if (showSettlement)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 32.0),
                        child: OrderSettlementOperationsWidget(
                          showStep: showSettlement,
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
                      OrderPaymentHistoryWidget(
                        payments: widget.order.payments,
                      ),
                  ],
                ),
              ),
            ),
            if (state.isPreInvoice &&
                state.clearanceStep == ClearanceStep.initial)
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 30.0),
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
}
