import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/core/utils/currency_formatter.dart';
import '../../../../config/constants.dart';
import '../../../../core/models/order_model.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/utils/file_utils.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_button.dart';
import '../../../widget/rtc_divider.dart';
import '../../../widget/rtc_image.dart';
import '../../../widget/rtc_text_button.dart';
import '../../pre_invoice/widget/pre_invoice_document_item.dart';
import 'document_viewer_screen.dart';
import '../bloc/orders_cubit.dart';
import '../bloc/orders_state.dart';
import 'settlement_method_bottom_sheet.dart';
import 'order_upload_documents_sheet.dart';
import 'order_settlement_amount_row.dart';
import 'order_settlement_timer.dart';
import 'orders_ui_helpers.dart';
import '../../media_picker/media_picker.dart';

class OrderSettlementOperationsWidget extends StatefulWidget {
  final OrderOperationModel op;
  final bool showStep;

  const OrderSettlementOperationsWidget({
    super.key,
    required this.op,
    this.showStep = false,
  });

  @override
  State<OrderSettlementOperationsWidget> createState() =>
      _OrderSettlementOperationsWidgetState();
}

class _OrderSettlementOperationsWidgetState
    extends State<OrderSettlementOperationsWidget> {
  bool _isExpanded = true;

  void _showMethodSelector(
    BuildContext context,
    OrdersCubit cubit,
    String? currentMethod,
  ) {
    SettlementMethodBottomSheet.show(
      context,
      initialSelectedId: currentMethod,
      onSelect: (method) {
        cubit.selectSettlementMethod(method);
      },
    );
  }

  void _handleSettlement(
    BuildContext context,
    OrdersCubit cubit,
    String? method,
  ) async {
    if (method == null) return;

    if (method == 'card_to_card') {
      final state = cubit.state;
      if (state.settlementDocPaths.isEmpty) {
        cubit.pickSettlementDoc(context);
      } else {
        String trackingCode = '';
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: OrderUploadDocumentsSheet(
              filePath: state.settlementDocPaths.first,
              showTrackingField: true,
              hideDocumentItem: true,
              onTrackingCodeChanged: (val) => trackingCode = val,
              onConfirm: () {
                if (trackingCode.isNotEmpty) {
                  cubit.initiateSettlement(method, trackingCode: trackingCode);
                  Navigator.pop(context);
                }
              },
              onDelete: () => Navigator.pop(context),
            ),
          ),
        );
      }
    } else if (method == 'wallet_debit') {
      cubit.confirmSettlement();
    } else {
      cubit.initiateSettlement(method);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        final cubit = context.read<OrdersCubit>();
        final isPartial = state.isPartialClearance;

        // Derived calculations from state extension
        final differenceAmountStr = state.settlementDifferenceValue
            .toInt()
            .toString()
            .formatCurrency;
        final payableAmountStr = state.settlementPayableValue
            .toInt()
            .toString()
            .formatCurrency;

        // Cash discount placeholder
        final cashDiscountStr = '۰';

        // Get successful settlement amount if completed
        final settledAmountStr = state.isSettlementCompleted
            ? differenceAmountStr
            : '۰';

        final showBorder = !isPartial && !state.isSettlementCompleted;

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: showBorder
                ? Border(
                    right: BorderSide(
                      color: AppColors.brandPalette.shade600,
                      width: 4.0,
                    ),
                  )
                : null,
          ),
          child: Column(
            children: [
              InkWell(
                onTap: state.isSettlementCompleted
                    ? () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      }
                    : ((state.settlementMethod == 'ipg_sms') &&
                          state.settlementStep != SettlementStep.initial)
                    ? () => cubit.confirmSettlement()
                    : null,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      if (widget.showStep || state.isSettlementCompleted) ...[
                        Container(
                          width: 20.0,
                          height: 20.0,
                          decoration: BoxDecoration(
                            color: AppColors.grayPalette.shade900,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Center(
                            child: Text(
                              '${widget.op.step}',
                              style: theme.labelLarge!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                      ],
                      Text(
                        widget.op.title,
                        style: theme.labelLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.grayPalette.shade900,
                        ),
                      ),

                      Expanded(
                        child: OrdersUiHelpers.resolveSettlementHeaderTrailing(
                          context: context,
                          state: state,
                          isExpanded: _isExpanded,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (_isExpanded) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: RtcDivider(
                    height: 0.5,
                    color: AppColors.grayPalette.shade300,
                  ),
                ),
                if (state.isSettlementCompleted)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 16.0,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.grayPalette.shade50,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Row(
                            children: [
                              Text(
                                S.current.settlementAmountLabel,
                                style: theme.bodyMedium!.copyWith(
                                  color: AppColors.grayPalette.shade700,
                                ),
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  Text(
                                    settledAmountStr,
                                    style: theme.titleSmall!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.brandPalette.shade600,
                                    ),
                                  ),
                                  const SizedBox(width: 4.0),
                                  RtcImage(
                                    image: "$baseImage/rial.svg",
                                    width: 20,
                                    height: 20,
                                    boxFit: BoxFit.contain,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!isPartial) ...[
                          Text(
                            S.current.settlementMethod,
                            style: theme.bodyMedium!.copyWith(
                              color: AppColors.grayPalette.shade500,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          GestureDetector(
                            onTap: () => _showMethodSelector(
                              context,
                              cubit,
                              state.settlementMethod,
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 12.0,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.grayPalette.shade300,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    OrdersUiHelpers.resolveSettlementMethodTitle(
                                      state.settlementMethod,
                                    ),
                                    style: theme.bodyLarge!.copyWith(
                                      color: AppColors.grayPalette.shade900,
                                    ),
                                  ),
                                  const Spacer(),
                                  RtcImage(
                                    image: "$baseImage/angle-down_tab.svg",
                                    width: 24.0,
                                    height: 24.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12.0),
                        ],
                        Container(
                          padding: const EdgeInsets.all(14.0),
                          decoration: BoxDecoration(
                            color: AppColors.grayPalette.shade50,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Column(
                            children: [
                              OrderSettlementAmountRow(
                                label: S.current.differenceAmount,
                                amount: differenceAmountStr,
                                amountColor: isPartial
                                    ? AppColors.warningPalette.shade600
                                    : AppColors.grayPalette.shade900,
                                warningItem: isPartial,
                              ),
                              if (!isPartial) ...[
                                const SizedBox(height: 8.0),
                                RtcDivider(
                                  height: 1.0,
                                  color: AppColors.grayPalette.shade200,
                                ),
                                const SizedBox(height: 8.0),
                                OrderSettlementAmountRow(
                                  label: S.current.totalCashDiscount,
                                  amount: cashDiscountStr,
                                  amountColor: AppColors.grayPalette.shade900,
                                  warningItem: false,
                                ),
                                const SizedBox(height: 8.0),
                                RtcDivider(
                                  height: 1.0,
                                  color: AppColors.grayPalette.shade200,
                                ),
                                const SizedBox(height: 8.0),
                                OrderSettlementAmountRow(
                                  label: S.current.payableAmount,
                                  amount: payableAmountStr,
                                  amountColor:
                                      AppColors.warningPalette.shade600,
                                  warningItem: true,
                                  isBold: true,
                                ),
                              ],
                            ],
                          ),
                        ),
                        if (state.settlementMethod == 'card_to_card' &&
                            state.settlementDocPaths.isNotEmpty) ...[
                          const SizedBox(height: 12.0),
                          RtcDivider(
                            height: 0.5,
                            color: AppColors.grayPalette.shade300,
                            isDashed: true,
                          ),
                          const SizedBox(height: 12.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.current.transactionDoc,
                                style: theme.labelLarge!.copyWith(
                                  color: AppColors.grayPalette.shade900,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              RtcTextButton(
                                onPressed: () =>
                                    cubit.pickSettlementDoc(context),
                                title: S.current.add,
                                leftIcon: "$baseImage/plus.svg",
                                leftIconColor: AppColors.brandPalette.shade600,
                                styleBtn: theme.labelLarge!.copyWith(
                                  color: AppColors.brandPalette.shade600,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ...state.settlementDocPaths.asMap().entries.map((
                            entry,
                          ) {
                            int index = entry.key;
                            String path = entry.value;
                            return PreInvoiceDocumentItem(
                              title: S.current.otherDocumentsLabel(index + 1),
                              fileName: path.split('/').last,
                              fileSize: FileUtils.getFileSizeString(path),
                              onDelete: () => cubit.removeSettlementDoc(index),
                              onView: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DocumentViewerScreen(
                                      url: path,
                                      title: S.current.otherDocumentsLabel(
                                        index + 1,
                                      ),
                                      isLocalFile: true,
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                        ],
                        if (state.settlementMethod == 'ipg_sms' &&
                            !isPartial &&
                            state.settlementStep != SettlementStep.initial)
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Text(
                              S.current.paymentLinkSentTo(
                                state.settlementMobile ?? "",
                              ),
                              style: theme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColors.grayPalette.shade900,
                              ),
                            ),
                          ),
                        if (!isPartial) ...[
                          const SizedBox(height: 12.0),
                          if (state.settlementMethod == 'wallet_debit')
                            _buildWalletBalanceStatus(state, theme),
                          const SizedBox(height: 12.0),
                          if (state.settlementMethod == 'ipg_sms' &&
                              !isPartial &&
                              state.settlementStep != SettlementStep.initial)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Center(
                                child: state.isSettlementTimerActive
                                    ? OrderSettlementTimer(state: state)
                                    : GestureDetector(
                                        onTap: () =>
                                            cubit.resendSettlementLink(),
                                        child: Text(
                                          S.current.resendPaymentLink,
                                          style: theme.labelLarge!.copyWith(
                                            color:
                                                AppColors.brandPalette.shade600,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                              ),
                            )
                          else
                            Row(
                              children: [
                                const Spacer(),
                                RtcButton(
                                  title:
                                      OrdersUiHelpers.resolveSettlementButtonTitle(
                                        state.settlementMethod,
                                      ),
                                  isActive:
                                      !isPartial &&
                                      state.settlementMethod != null &&
                                      (state.settlementMethod !=
                                              'wallet_debit' ||
                                          state.isWalletBalanceSufficient),
                                  styleBtn: theme.labelLarge!.copyWith(
                                    color:
                                        (!isPartial &&
                                            state.settlementMethod != null &&
                                            (state.settlementMethod !=
                                                    'wallet_debit' ||
                                                state
                                                    .isWalletBalanceSufficient))
                                        ? Colors.white
                                        : AppColors.grayPalette.shade300,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  width: 160.0,
                                  isLoading:
                                      state.status ==
                                      OrdersRequestStatus.loading,
                                  onPressed: () => _handleSettlement(
                                    context,
                                    cubit,
                                    state.settlementMethod,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ],
                    ),
                  ),
                const SizedBox(height: 4.0),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildWalletBalanceStatus(OrdersState state, TextTheme theme) {
    final isSufficient = state.isWalletBalanceSufficient;
    final colorPalette = isSufficient
        ? AppColors.successPalette
        : AppColors.errorPalette;
    final message = isSufficient
        ? S.current.walletBalanceSufficient(state.walletName ?? "")
        : S.current.walletBalanceInsufficient(state.walletName ?? "");

    return Container(
      padding: const EdgeInsets.fromLTRB(14.0, 12.0, 14.0, 12.0),
      decoration: BoxDecoration(
        color: colorPalette.shade25,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: colorPalette.shade100, width: 1.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        spacing: 10.0,
        children: [
          if (isSufficient)
            RtcImage(
              image: "$baseImage/tick_circle.svg",
              width: 16.0,
              height: 16.0,
            )
          else
            Icon(Icons.error_outline, color: colorPalette.shade600, size: 16.0),
          Expanded(
            child: Text(
              message,
              textAlign: TextAlign.right,
              style: theme.bodyMedium!.copyWith(
                color: colorPalette.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
