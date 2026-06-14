import 'package:flutter/material.dart';
import 'package:rtc_mobile/core/utils/currency_formatter.dart';
import '../../../../config/config.dart';
import '../../../../generated/l10n.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_button.dart';
import '../../../widget/rtc_divider.dart';
import '../../../widget/rtc_image.dart';
import '../../../widget/rtc_status_badge.dart';

class OrderClearanceOperationWidget extends StatefulWidget {
  final String amount;
  final String? orderAmount;
  final String? excessAmount;
  final String? walletName;
  final VoidCallback onAction;
  final VoidCallback? onEdit;
  final bool isOnline;
  final bool isOutOfTolerance;
  final bool showStep;
  final bool isLoading;

  const OrderClearanceOperationWidget({
    super.key,
    required this.amount,
    this.orderAmount,
    this.excessAmount,
    this.walletName,
    required this.onAction,
    this.onEdit,
    this.isOnline = false,
    this.isOutOfTolerance = false,
    this.showStep = false,
    this.isLoading = false,
  });

  @override
  State<OrderClearanceOperationWidget> createState() =>
      _OrderClearanceOperationWidgetState();
}

class _OrderClearanceOperationWidgetState
    extends State<OrderClearanceOperationWidget> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final bool isCompleted = widget.onEdit == null && !widget.isOutOfTolerance;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: !isCompleted
            ? Border(
                right: BorderSide(
                  color: AppColors.brandPalette.shade600,
                  width: 4.0,
                ),
              )
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: isCompleted
                ? () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  }
                : null,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
              child: Row(
                children: [
                  if (widget.showStep || isCompleted) ...[
                    Container(
                      width: 20.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                        color: AppColors.grayPalette.shade900,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Center(
                        child: Text(
                          '1',
                          style: theme.labelLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                  ],
                  Text(
                    S.current.clearanceOperation,
                    style: theme.labelLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.grayPalette.shade900,
                    ),
                  ),
                  if (isCompleted)
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: RtcStatusBadge(status: S.current.uploaded),
                    ),
                  const Spacer(),
                  if (widget.onEdit != null)
                    GestureDetector(
                      onTap: () {
                        debugPrint(
                          '>> OrderClearanceOperationWidget: Edit clicked',
                        );
                        widget.onEdit!();
                      },
                      child: RtcImage(
                        image: "$baseImage/edit.svg",
                        width: 24.0,
                        height: 24.0,
                        color: AppColors.brandPalette.shade600,
                      ),
                    )
                  else if (isCompleted)
                    RtcImage(
                      image: _isExpanded
                          ? "$baseImage/arrow_up_tab.svg"
                          : "$baseImage/angle-down_tab.svg",
                      width: 24.0,
                      height: 24.0,
                      color: AppColors.grayPalette.shade600,
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    child: Column(
                      children: [
                        if (widget.isOutOfTolerance &&
                            widget.orderAmount != null) ...[
                          Row(
                            children: [
                              Text(
                                S.current.orderAmountLabel,
                                style: theme.bodyMedium!.copyWith(
                                  color: AppColors.grayPalette.shade700,
                                ),
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  Text(
                                    widget.orderAmount!.formatCurrency,
                                    style: theme.titleSmall!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.grayPalette.shade900,
                                    ),
                                  ),
                                  const SizedBox(width: 2.0),
                                  RtcImage(
                                    image: "$baseImage/toman.svg",
                                    width: 24.0,
                                    height: 24.0,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                        ],
                        Row(
                          children: [
                            Text(
                              S.current.clearanceAmountLabel,
                              style: theme.bodyMedium!.copyWith(
                                color: AppColors.grayPalette.shade700,
                              ),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                Text(
                                  widget.amount.formatCurrency,
                                  style: theme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.brandPalette.shade600,
                                  ),
                                ),
                                const SizedBox(width: 4.0),
                                RtcImage(
                                  image: "$baseImage/toman.svg",
                                  width: 24.0,
                                  height: 24.0,
                                ),
                              ],
                            ),
                          ],
                        ),
                        if (widget.excessAmount != null) ...[
                          const SizedBox(height: 16.0),
                          Row(
                            children: [
                              Text(
                                S.current.differenceAmount,
                                style: theme.bodyMedium!.copyWith(
                                  color: AppColors.grayPalette.shade700,
                                ),
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  Text(
                                    widget.excessAmount!.formatCurrency,
                                    style: theme.titleSmall!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: widget.isOutOfTolerance
                                          ? AppColors.errorPalette.shade600
                                          : AppColors.successPalette.shade600,
                                    ),
                                  ),
                                  const SizedBox(width: 4.0),
                                  RtcImage(
                                    image: "$baseImage/toman.svg",
                                    width: 24.0,
                                    height: 24.0,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  if (widget.isOutOfTolerance)
                    _buildStatusMessage(
                      theme: theme,
                      message: S.current.excessAmountOutOfTolerance,
                      icon: "$baseImage/warning.svg",
                      colorPalette: AppColors.errorPalette,
                    )
                  else if (widget.excessAmount != null)
                    _buildStatusMessage(
                      theme: theme,
                      message: S.current.excessAmountAddedToWallet(
                        widget.walletName ?? "",
                      ),
                      icon: "$baseImage/wallet.svg",
                      colorPalette: AppColors.successPalette,
                    ),
                  if (!widget.isOutOfTolerance && widget.onEdit != null) ...[
                    const SizedBox(height: 16.0),
                    RtcDivider(
                      color: AppColors.grayPalette.shade300,
                      height: 1.0,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      widget.isOnline
                          ? S.current.clearanceRequestInstruction
                          : S.current.uploadClearanceInstruction,
                      textAlign: TextAlign.right,
                      style: theme.labelMedium!.copyWith(
                        color: AppColors.grayPalette.shade900,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: RtcButton(
                        title: widget.isOnline
                            ? S.current.requestCodeButton
                            : S.current.uploadClearanceDocuments,
                        styleBtn: theme.labelLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        width: widget.isOnline ? 147.0 : 172.0,
                        isLoading: widget.isLoading,
                        onPressed: widget.onAction,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusMessage({
    required TextTheme theme,
    required String message,
    required String icon,
    required MaterialColor colorPalette,
  }) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: colorPalette.shade50,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: colorPalette.shade100),
      ),
      child: Row(
        children: [
          RtcImage(
            image: icon,
            width: 20.0,
            height: 20.0,
            color: colorPalette.shade600,
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              message,
              style: theme.labelMedium!.copyWith(
                color: colorPalette.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
