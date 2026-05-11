import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

import '../../../../generated/l10n.dart';
import '../../../../config/config.dart';
import '../../../../widget/rtc_button.dart';
import '../../../../widget/rtc_image.dart';
import '../../../../widget/rtc_text_button.dart';
import '../bloc/auth_cubit.dart';
import '../bloc/auth_state.dart';

class OtpWidget extends StatelessWidget {
  const OtpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 60),
              Center(
                child: RtcImage(image: '$baseImage/rtc_logo.png', height: 60),
              ),
              const SizedBox(height: 20),
              Text(
                S.current.companyName,
                textAlign: TextAlign.center,
                // TODO: replace with AppTextStyle
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                S.current.appSubtitle,
                textAlign: TextAlign.center,
                // TODO: replace with AppTextStyle
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 60),
              Text(
                S.current.enterOtpCode,
                textAlign: TextAlign.right,
                // TODO: replace with AppTextStyle
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    S.current.otpSentTo(state.phoneNumber),
                    textAlign: TextAlign.right,
                    // TODO: replace with AppTextStyle
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => context.read<AuthCubit>().editPhoneNumber(),
                    child: const Icon(Icons.edit_outlined, size: 20),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Pinput(
                  length: 5,
                  onChanged: (value) =>
                      context.read<AuthCubit>().onOtpChanged(value),
                  defaultPinTheme: PinTheme(
                    width: 56,
                    height: 56,
                    // TODO: replace with theme colors/styles
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              if (!state.isTimerExpired)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${(state.remainingSeconds ~/ 60).toString().padLeft(2, '0')}:${(state.remainingSeconds % 60).toString().padLeft(2, '0')}',
                      // TODO: replace with AppTextStyle
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.access_time, size: 20),
                  ],
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RtcTextButton(
                      title: S.current.sendViaRubika,
                      onPressed: () =>
                          context.read<AuthCubit>().sendViaRubika(),
                    ),
                    const SizedBox(
                      height: 20,
                      child: VerticalDivider(thickness: 1, width: 20),
                    ),
                    RtcTextButton(
                      title: S.current.resendSms,
                      onPressed: () => context.read<AuthCubit>().resendOtp(),
                    ),
                  ],
                ),
              const SizedBox(height: 60),
              RtcButton(
                title: S.current.confirm,
                isActive: state.isOtpComplete,
                isLoading: state.isLoading,
                onPressed: () => context.read<AuthCubit>().submitOtp(),
                width: double.infinity,
                // TODO: replace with theme color
                backgroundColor: state.isOtpComplete
                    ? Colors.blue
                    : Colors.grey.shade200,
              ),
            ],
          ),
        );
      },
    );
  }
}
