import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:rtc_mobile/config/auth_calculations.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import '../../../../config/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../widget/rtc_button.dart';
import '../../../widget/rtc_image.dart';
import '../../../widget/rtc_text_button.dart';
import '../bloc/auth_cubit.dart';
import '../bloc/auth_state.dart';

class OtpWidget extends StatefulWidget {
  const OtpWidget({super.key});

  @override
  State<OtpWidget> createState() => _OtpWidgetState();
}

class _OtpWidgetState extends State<OtpWidget> {
  final TextEditingController _pinController = TextEditingController();

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Stack(
          children: [
            Column(
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
                const SizedBox(height: 10.0),
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
                        height: 24.0,
                        width: 24.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32.0),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Pinput(
                    controller: _pinController,
                    separatorBuilder: (index) => const SizedBox(width: 18.0),
                    length: 5,
                    onChanged: (value) =>
                        context.read<AuthCubit>().onOtpChanged(value),
                    defaultPinTheme: PinTheme(
                      width: 56.0,
                      height: 56.0,
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
                const SizedBox(height: 24.0),
                if (!state.isTimerExpired)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AuthCalculations.formatRemainingTime(
                          state.remainingSeconds,
                        ),
                        style: theme.labelLarge!.copyWith(
                          color: AppColors.grayPalette.shade600,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 10),
                      RtcImage(
                        image: "$baseImage/clock.svg",
                        height: 20.0,
                        width: 20.0,
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
                        isLoading: state.isLoading,
                        onPressed: () => context.read<AuthCubit>().resendOtp(),
                      ),
                      const Spacer(),
                      Container(
                        width: 1,
                        height: 32.0,
                        color: AppColors.grayPalette.shade300,
                      ),
                      const Spacer(),
                      RtcTextButton(
                        styleBtn: theme.labelLarge!.copyWith(
                          color: AppColors.brandPalette.shade600,
                          fontWeight: FontWeight.w600,
                        ),
                        title: S.current.sendViaRubika,
                        isLoading: state.isLoading,
                        onPressed: () =>
                            context.read<AuthCubit>().sendViaRubika(),
                      ),
                    ],
                  ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: RtcButton(
                    title: S.current.confirm,
                    isActive: state.isOtpComplete,
                    isLoading: state.isLoading,
                    onPressed: () => context.read<AuthCubit>().submitOtp(),
                    styleBtn: theme.labelLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color:
                          state.isOtpComplete
                              ? Colors.white
                              : AppColors.grayPalette.shade300,
                    ),
                  ),
                ),
              ],
            ),
            Opacity(
              opacity: 0,
              child: PinFieldAutoFill(
                onCodeChanged: (code) {
                  if (code != null && code.length == 5) {
                    _pinController.text = code;
                    context.read<AuthCubit>().updateAutoFillState();
                    context.read<AuthCubit>().onOtpChanged(code);
                    context.read<AuthCubit>().submitOtp();
                  }
                },
                autoFocus: false,
              ),
            ),
          ],
        );
      },
    );
  }
}
