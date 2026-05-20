import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:rtc_mobile/ui/widget/rtc_divider.dart';
import '../../../../config/config.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_button.dart';
import '../../../widget/rtc_image.dart';

class OrderClearanceOtpSheet extends StatefulWidget {
  final String phoneNumber;
  final VoidCallback onConfirm;

  const OrderClearanceOtpSheet({
    super.key,
    required this.phoneNumber,
    required this.onConfirm,
  });

  @override
  State<OrderClearanceOtpSheet> createState() => _OrderClearanceOtpSheetState();
}

class _OrderClearanceOtpSheetState extends State<OrderClearanceOtpSheet> {
  final TextEditingController _otpController = TextEditingController();
  bool _isComplete = false;

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 24),
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
                width: 31,
                height: 2,
                decoration: BoxDecoration(
                  color: AppColors.brandPalette.shade600,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Header Row
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  Text(
                    'تخلیه کارت اعتباری',
                    style: theme.labelLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.grayPalette.shade900,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: RtcImage(
                      image: "$baseImage/close.svg",
                      width: 20,
                      height: 20,
                      color: AppColors.grayPalette.shade800,
                      boxFit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            RtcDivider(color: AppColors.grayPalette.shade200, height: 0.5),

            // Prompt Text
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: 24,
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'کد تایید ارسال شده به شماره ${widget.phoneNumber} را وارد کنید.',
                  textAlign: TextAlign.right,
                  style: theme.bodyLarge!.copyWith(
                    color: AppColors.grayPalette.shade900,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            // OTP Input
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Pinput(
                  length: 5,
                  controller: _otpController,
                  onChanged: (value) {
                    setState(() {
                      _isComplete = value.length == 5;
                    });
                  },
                  defaultPinTheme: PinTheme(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grayPalette.shade200),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: theme.titleLarge!.copyWith(
                      color: AppColors.grayPalette.shade900,
                    ),
                  ),
                  focusedPinTheme: PinTheme(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.brandPalette.shade600,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: theme.titleLarge!.copyWith(
                      color: AppColors.grayPalette.shade900,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Timer Row
            Row(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${(60).toString().padLeft(2, '0')}:${(60).toString().padLeft(2, '0')}',

                  style: theme.labelLarge!.copyWith(
                    color: AppColors.grayPalette.shade600,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                RtcImage(image: "$baseImage/clock.svg", height: 20, width: 20),
              ],
            ),
            const SizedBox(height: 32),

            // Buttons Row
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  Expanded(
                    child: RtcButton(
                      title: 'انصراف',
                      backgroundColor: Colors.white,
                      borderColor: AppColors.grayPalette.shade300,
                      styleBtn: theme.labelLarge!.copyWith(
                        color: AppColors.grayPalette.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: RtcButton(
                      title: 'تایید وتخلیه کارت',
                      styleBtn: theme.labelLarge!.copyWith(
                        color: AppColors.grayPalette.shade300,
                        fontWeight: FontWeight.w600,
                      ),
                      isActive: _isComplete,
                      onPressed: widget.onConfirm,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
