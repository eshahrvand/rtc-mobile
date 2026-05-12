import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:pinput/pinput.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';
import '../../config/config.dart';
import '../theme/colors.dart';

class OTPIndicator extends StatelessWidget {
  final String otpCode;
  final bool isError;
  final int otpResendTimer;
  final void Function(String) onChange;
  final VoidCallback? onResendPressed;
  final int length;

  const OTPIndicator({
    Key? key,
    required this.otpCode,
    required this.isError,
    required this.otpResendTimer,
    required this.onChange,
    this.onResendPressed,
    required this.length,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Pinput(
              length: length,
              mainAxisAlignment: MainAxisAlignment.center,
              separatorBuilder: (_) {
                return SizedBox(width: 10);
              },
              // controller: otpController,
              autofocus: false,
              enabled: true,
              defaultPinTheme: PinTheme(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F7F9),
                  border: Border.all(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(16),
                ),
                textStyle: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: Colors.black),
              ),
              onChanged: onChange,

              // onCompleted: (pin) => print(pin),
              // onChanged: onCompleted,
            ),
          ),
        ),
        SizedBox(height: 16),
        TextButton(
          onPressed: otpResendTimer == 0 ? onResendPressed : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                otpResendTimer > 0
                    ? '00:${otpResendTimer.toString().padLeft(2, '0')}'
                    : 'درخواست مجدد رمز پویا',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: AppColors.brandPalette,
                ),
              ),
              if (otpResendTimer > 0)
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: RtcImage(image: '$baseImage/timer.svg'),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
