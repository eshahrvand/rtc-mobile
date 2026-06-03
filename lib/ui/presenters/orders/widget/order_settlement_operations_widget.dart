import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/config.dart';
import '../../../../data/models/order_model.dart';
import '../../../../generated/l10n.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_button.dart';
import '../../../widget/rtc_divider.dart';
import '../../../widget/rtc_image.dart';
import '../../../widget/rtc_status_badge.dart';
import '../bloc/orders_cubit.dart';
import '../bloc/orders_state.dart';
import 'settlement_method_bottom_sheet.dart';
import 'order_upload_documents_sheet.dart';
import '../../media_picker/media_picker.dart';

class OrderSettlementOperationsWidget extends StatefulWidget {
  final OrderOperationModel op;

  const OrderSettlementOperationsWidget({super.key, required this.op});

  @override
  State<OrderSettlementOperationsWidget> createState() =>
      _OrderSettlementOperationsWidgetState();
}

class _OrderSettlementOperationsWidgetState
    extends State<OrderSettlementOperationsWidget> {
  bool _isExpanded = true;

  void _showMethodSelector(BuildContext context, OrdersCubit cubit) {
    SettlementMethodBottomSheet.show(
      context,
      onSelect: (method) {
        cubit.initiateSettlement(method);
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
      final result = await MediaPickerBottomSheet.show(
        context,
        isMultiSelection: false,
      );
      if (result != null && result.isNotEmpty) {
        final imagePath = result.first.file.path;
        String trackingCode = '';
        if (context.mounted) {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: OrderUploadDocumentsSheet(
                filePath: imagePath,
                showTrackingField: true,
                onTrackingCodeChanged: (val) => trackingCode = val,
                onConfirm: () {
                  if (trackingCode.isNotEmpty) {
                    cubit.initiateSettlement(method);
                    cubit.confirmSettlement(
                      trackingCode: trackingCode,
                      imagePath: imagePath,
                    );
                    Navigator.pop(context);
                  }
                },
                onDelete: () {},
              ),
            ),
          );
        }
      }
    } else if (method == 'ipg' ||
        method == 'link' ||
        method == 'wallet_debit') {
      cubit.confirmSettlement();
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        final cubit = context.read<OrdersCubit>();
        final isPartial =
            state.clearanceStep != ClearanceStep.success &&
            state.clearanceAmount.isNotEmpty;

        // Calculate actual difference amount dynamically
        double diffValue = 0;
        String differenceAmount = '۰';
        if (state.selectedOrder != null) {
          final orderTotal =
              double.tryParse(
                state.selectedOrder!.financialSummary.finalAmount.replaceAll(
                  ',',
                  '',
                ),
              ) ??
              0;

          double totalCleared = 0;
          for (var record in state.selectedOrder!.disbursementRecords) {
            if (record.status == 'موفق' || record.status == 'success') {
              totalCleared +=
                  double.tryParse(record.amount.replaceAll(',', '')) ?? 0;
            }
          }

          diffValue = (orderTotal - totalCleared);
          if (diffValue < 0) diffValue = 0;

          differenceAmount = _formatAmount(diffValue);
        }

        // Placeholder for cash discount - can be updated if data exists in state/order
        double cashDiscountValue = 0;
        String cashDiscount = _formatAmount(cashDiscountValue);

        // Calculate payable amount
        double payableValue = diffValue - cashDiscountValue;
        if (payableValue < 0) payableValue = 0;
        String payableAmount = _formatAmount(payableValue);

        // Get total and cleared strings for display
        final orderTotalValue =
            double.tryParse(
              state.selectedOrder!.financialSummary.finalAmount.replaceAll(
                ',',
                '',
              ),
            ) ??
            0;
        final totalClearedValue = orderTotalValue - diffValue;

        String orderTotalStr = _formatAmount(orderTotalValue);
        String totalClearedStr = _formatAmount(totalClearedValue);

        // Get successful settlement amount if completed
        String settledAmountStr = '۰';
        if (state.isSettlementCompleted && state.selectedOrder != null) {
          final successRecords = state.selectedOrder!.settlementRecords.where(
            (r) => r.status == 'موفق' || r.status == 'success',
          );

          if (successRecords.isNotEmpty) {
            settledAmountStr = successRecords.first.amount;
          } else {
            // Fallback to diffValue if no success record found but marked completed
            settledAmountStr = differenceAmount;
          }
        }

        return Container(
          color: Colors.white,
          child: Column(
            children: [
              InkWell(
                onTap: state.isSettlementCompleted
                    ? () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      }
                    : null,
                child: Padding(
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
                            '${widget.op.step}',
                            style: theme.labelLarge!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.op.title,
                        style: theme.labelLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.grayPalette.shade900,
                        ),
                      ),

                      if (state.isSettlementCompleted)
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: RtcStatusBadge(status: "انجام شده"),
                        ),

                      const Spacer(),

                      isPartial
                          ? Container(
                              height: 22,
                              padding: const EdgeInsets.symmetric(
                                vertical: 2,
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.warningPalette.shade100,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                spacing: 4,
                                children: [
                                  RtcImage(
                                    image: "$baseImage/waiting.svg",
                                    width: 12,
                                    height: 12,
                                    color: AppColors.grayPalette.shade900,
                                  ),
                                  Text(
                                    'در انتظار تکمیل تخلیه',
                                    style: theme.bodyMedium!.copyWith(
                                      color: AppColors.grayPalette.shade900,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : RtcImage(
                              image:
                                  (state.isSettlementCompleted && !_isExpanded)
                                  ? "$baseImage/angle-down_tab.svg"
                                  : "$baseImage/arrow_up_tab.svg",
                              width: 24,
                              height: 24,
                            ),
                    ],
                  ),
                ),
              ),

              if (_isExpanded) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
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
                            horizontal: 12,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.grayPalette.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Text(
                                S.current.payableAmount,
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
                                  const SizedBox(width: 4),
                                  RtcImage(
                                    image: "$baseImage/toman.svg",
                                    width: 24,
                                    height: 24,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                else if (!isPartial)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 12, 16.0, 16.0),
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
                        GestureDetector(
                          onTap: () => _showMethodSelector(context, cubit),
                          child: Container(
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
                                  _getMethodTitle(state.settlementMethod),
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
                        ),
                        const SizedBox(height: 12),
                        _buildAmountRow(
                          theme,
                          S.current.differenceAmount,
                          differenceAmount,
                          AppColors.grayPalette.shade900,
                          false,
                        ),
                        const SizedBox(height: 8),
                        _buildAmountRow(
                          theme,
                          'جمع تخفیف نقدی',
                          cashDiscount,
                          AppColors.grayPalette.shade900,
                          false,
                        ),
                        const SizedBox(height: 8),
                        _buildAmountRow(
                          theme,
                          S.current.payableAmount,
                          payableAmount,
                          AppColors.warningPalette.shade600,
                          true,
                          isBold: true,
                        ),
                        const SizedBox(height: 12),
                        if (state.settlementMethod == 'wallet_debit' &&
                            state.isWalletBalanceSufficient)
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
                                    state.walletName != null
                                        ? 'موجودی کیف پول ${state.walletName} شما برای پرداخت ما به تفاوت مبلغ کافیست'
                                        : S.current.walletBalanceSufficient,
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
                        if (state.settlementMethod == 'wallet_debit' &&
                            !state.isWalletBalanceSufficient)
                          Container(
                            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                            decoration: BoxDecoration(
                              color: AppColors.errorPalette.shade25,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppColors.errorPalette.shade100,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              spacing: 10,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: AppColors.errorPalette.shade600,
                                  size: 16,
                                ),
                                Expanded(
                                  child: Text(
                                    state.walletName != null
                                        ? 'موجودی کیف پول ${state.walletName} شما برای پرداخت این مبلغ کافی نمی‌باشد'
                                        : 'موجودی کیف پول شما کافی نمی‌باشد',
                                    textAlign: TextAlign.right,
                                    style: theme.bodyMedium!.copyWith(
                                      color: AppColors.errorPalette.shade600,
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
                            const Spacer(),
                            RtcButton(
                              title: _getButtonTitle(state.settlementMethod),
                              isActive:
                                  !isPartial &&
                                  state.settlementMethod != null &&
                                  (state.settlementMethod != 'wallet_debit' ||
                                      state.isWalletBalanceSufficient),
                              styleBtn: theme.labelLarge!.copyWith(
                                color:
                                    (!isPartial &&
                                        state.settlementMethod != null &&
                                        (state.settlementMethod !=
                                                'wallet_debit' ||
                                            state.isWalletBalanceSufficient))
                                    ? Colors.white
                                    : AppColors.grayPalette.shade300,
                                fontWeight: FontWeight.w600,
                              ),
                              width:
                                  state.settlementMethod == 'ipg' ||
                                      state.settlementMethod == 'link'
                                  ? 240
                                  : 160,
                              onPressed: () => _handleSettlement(
                                context,
                                cubit,
                                state.settlementMethod,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 32),
              ],
            ],
          ),
        );
      },
    );
  }

  String _formatAmount(double amount) {
    if (amount <= 0) return '۰';
    return amount
        .toStringAsFixed(0)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }

  Widget _buildAmountRow(
    TextTheme theme,
    String label,
    String amount,
    Color amountColor,
    bool warningItem, {
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.bodyMedium!.copyWith(
            color: AppColors.grayPalette.shade700,
          ),
        ),
        Row(
          spacing: 2,
          children: [
            Text(
              amount,
              style: theme.labelLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: amountColor,
              ),
            ),
            RtcImage(
              image: warningItem
                  ? "$baseImage/toman_warning.svg"
                  : "$baseImage/toman.svg",
              width: 24,
              height: 24,
            ),
          ],
        ),
      ],
    );
  }

  String _getMethodTitle(String? method) {
    switch (method) {
      case 'wallet_debit':
        return S.current.walletSettlement;
      case 'ipg':
        return 'پرداخت از طریق درگاه آنلاین';
      case 'link':
        return 'ارسال لیتک پرداخت به مشتری';
      case 'card_to_card':
        return 'ثبت فیش واریزی';
      default:
        return 'انتخاب روش تسویه';
    }
  }

  String _getButtonTitle(String? method) {
    switch (method) {
      case 'wallet_debit':
        return 'پرداخت با کیف پول';
      case 'ipg':
        return ' رفتن به درگاه شاپرک ';
      case 'link':
        return 'ارسال لینک پرداخت';
      case 'card_to_card':
        return 'آپلود فیش واریزی';
      default:
        return 'تایید و پرداخت';
    }
  }
}
