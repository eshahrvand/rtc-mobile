import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:rtc_mobile/config/auth_calculations.dart';
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
        const double kTitleBottomSpacing = 10.0;
        const double kEditIconSize = 24.0;
        const double kOtpTopSpacing = 32.0;
        const double kOtpCharSpacing = 18.0;
        const double kOtpFieldSize = 56.0;
        const double kTimerTopSpacing = 24.0;
        const double kClockIconSize = 20.0;
        const double kResendDividerHeight = 32.0;
        const double kButtonBottomPadding = 16.0;

        return Column(
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
            const SizedBox(height: kTitleBottomSpacing),
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
                const Spacer(),
                GestureDetector(
                  onTap: () => context.read<AuthCubit>().editPhoneNumber(),
                  child: RtcImage(
                    image: "$baseImage/edit.svg",
                    height: kEditIconSize,
                    width: kEditIconSize,
                  ),
                ),
              ],
            ),
            const SizedBox(height: kOtpTopSpacing),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Pinput(
                separatorBuilder: (index) =>
                    const SizedBox(width: kOtpCharSpacing),
                length: 5,
                onChanged: (value) =>
                    context.read<AuthCubit>().onOtpChanged(value),
                defaultPinTheme: PinTheme(
                  width: kOtpFieldSize,
                  height: kOtpFieldSize,
                  textStyle: theme.displaySmall!.copyWith(
                    color: AppColors.grayPalette.shade900,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: kTimerTopSpacing),
            if (!state.isTimerExpired)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AuthCalculations.formatRemainingTime(state.remainingSeconds),
                    style: theme.labelLarge!.copyWith(
                      color: AppColors.grayPalette.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 10),
                  RtcImage(
                    image: "$baseImage/clock.svg",
                    height: kClockIconSize,
                    width: kClockIconSize,
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
                  const Spacer(),
                  Container(
                    width: 1,
                    height: kResendDividerHeight,
                    color: AppColors.grayPalette.shade300,
                  ),
                  const Spacer(),
                  RtcTextButton(
                    styleBtn: theme.labelLarge!.copyWith(
                      color: AppColors.brandPalette.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                    title: S.current.sendViaRubika,
                    onPressed: () => context.read<AuthCubit>().sendViaRubika(),
                  ),
                ],
              ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: kButtonBottomPadding),
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
        );
      },
    );
  }
}
