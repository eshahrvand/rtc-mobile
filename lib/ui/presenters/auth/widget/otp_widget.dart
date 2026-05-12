import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';

import '../../../../config/config.dart';
import '../../../../generated/l10n.dart';

import '../../../widget/rtc_button.dart';
import '../../../widget/rtc_image.dart';
import '../../../widget/rtc_text_button.dart';
import '../bloc/auth_cubit.dart';
import '../bloc/auth_state.dart';

class OtpWidget extends StatelessWidget {
  const OtpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                S.current.enterOtpCode,
                textAlign: TextAlign.right,
                style: theme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.grayPalette.shade900,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    S.current.otpSentTo(state.phoneNumber),
                    textAlign: TextAlign.right,

                    style: theme.bodyLarge!.copyWith(
                      color: AppColors.grayPalette.shade600,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => context.read<AuthCubit>().editPhoneNumber(),
                    child: RtcImage(
                      image: "$baseImage/edit.svg",
                      height: 24,
                      width: 24,
                    ),
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

                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              if (!state.isTimerExpired)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${(state.remainingSeconds ~/ 60).toString().padLeft(2, '0')}:${(state.remainingSeconds % 60).toString().padLeft(2, '0')}',

                      style: theme.labelLarge!.copyWith(
                        color: AppColors.grayPalette.shade600,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    RtcImage(
                      image: "$baseImage/clock.svg",
                      height: 20,
                      width: 20,
                    ),
                  ],
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RtcTextButton(
                      styleBtn: theme.labelLarge!.copyWith(
                        color: AppColors.brandPalette.shade600,
                        fontWeight: FontWeight.w600,
                      ),
                      title: S.current.resendSms,
                      onPressed: () => context.read<AuthCubit>().resendOtp(),
                    ),

                    Spacer(),
                    Container(
                      width: 1,
                      height: 32,
                      color: AppColors.grayPalette.shade300,
                    ),
                    Spacer(),

                    RtcTextButton(
                      styleBtn: theme.labelLarge!.copyWith(
                        color: AppColors.brandPalette.shade600,
                        fontWeight: FontWeight.w600,
                      ),
                      title: S.current.sendViaRubika,
                      onPressed: () =>
                          context.read<AuthCubit>().sendViaRubika(),
                    ),
                  ],
                ),
              const Spacer(),

              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: RtcButton(
                  title: S.current.confirm,
                  isActive: state.isOtpComplete,
                  isLoading: state.isLoading,
                  onPressed: () => context.read<AuthCubit>().submitOtp(),
                  styleBtn: theme.labelLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: state.isOtpComplete
                        ? Colors.white
                        : AppColors.grayPalette.shade300,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
