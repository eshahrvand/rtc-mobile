import 'package:flutter/material.dart';
import '../../../../config/constants.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/core/utils/thousands_separator_input_formatter.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_button.dart';
import '../../../widget/rtc_divider.dart';
import '../../../widget/rtc_image.dart';
import '../../../widget/rtc_text_field.dart';

class OrderClearanceAmountSheet extends StatefulWidget {
  final String totalAmount;
  final TextEditingController amountController;
  final VoidCallback onCheckPressed;
  final bool isLoading;

  const OrderClearanceAmountSheet({
    super.key,
    required this.totalAmount,
    required this.amountController,
    required this.onCheckPressed,
    this.isLoading = false,
  });

  @override
  State<OrderClearanceAmountSheet> createState() =>
      _OrderClearanceAmountSheetState();
}

class _OrderClearanceAmountSheetState extends State<OrderClearanceAmountSheet> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    // Request focus after the frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 32),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Center(
                child: Container(
                  width: 33,
                  height: 2,
                  decoration: BoxDecoration(
                    color: AppColors.brandPalette.shade600,
                  ),
                ),
              ),
              const SizedBox(height: 40),
      
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.current.finalFactorAmountLabel,
                    style: theme.bodyMedium!.copyWith(
                      color: AppColors.grayPalette.shade700,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        widget.totalAmount,
                        style: theme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.grayPalette.shade900,
                        ),
                      ),
                      const SizedBox(width: 4),
                      RtcImage(
                        image: "$baseImage/rial.svg",
                        width: 24,
                        height: 24,
                        boxFit: BoxFit.contain,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
      
              const RtcDivider(isDashed: true),
              const SizedBox(height: 12),
      
              // Input label
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  S.current.enterClearanceAmountHint,
                  style: theme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.grayPalette.shade900,
                  ),
                ),
              ),
              const SizedBox(height: 12),
      
              Row(
                spacing: 16,
                children: [
                  Expanded(
                    child: RtcTextField(
                      controller: widget.amountController,
                      focusNode: _focusNode,
                      autoFocus: true,
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.number,
                      inputFormatters: [ThousandsSeparatorInputFormatter()],
                      suffix: Padding(
                        padding: const EdgeInsets.fromLTRB(14, 12, 0, 12),
                        child: RtcImage(
                          image: "$baseImage/rial.svg",
                          width: 24,
                          height: 24,
                          boxFit: BoxFit.contain,
                        ),
                      ),
                      textStyle: theme.bodyLarge!.copyWith(
                        color: AppColors.grayPalette.shade900,
                      ),
                    ),
                  ),
      
                  RtcButton(
                    title: S.current.checkButton,
                    onPressed: widget.onCheckPressed,
                    isLoading: widget.isLoading,
                    height: 44,
                    width: 88,
                    styleBtn: theme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
