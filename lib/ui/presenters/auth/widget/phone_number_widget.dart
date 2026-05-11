import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';

import '../../../../generated/l10n.dart';
import '../../../../config/config.dart';
import '../../../../widget/rtc_button.dart';
import '../../../../widget/rtc_image.dart';
import '../../../../widget/rtc_text_field.dart';
import '../bloc/auth_cubit.dart';
import '../bloc/auth_state.dart';

class PhoneNumberWidget extends StatelessWidget {
  const PhoneNumberWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 30),
                RtcImage(
                  image: '$baseImage/rtc_logo.png',
                  height: 42,
                  width: 80,
                ),
                const SizedBox(height: 12),
                Text(
                  S.current.companyName,
                  textAlign: TextAlign.center,
                  style: theme.titleSmall!.copyWith(
                    color: AppColors.grayPalette.shade900,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  S.current.appSubtitle,
                  textAlign: TextAlign.center,

                  style: theme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500 , color: AppColors.grayPalette.shade600
                  )
                ),
                const SizedBox(height: 60),
                Text(
                  S.current.loginToSystem,
                  textAlign: TextAlign.right,
                  // TODO: replace with AppTextStyle
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  S.current.enterPhoneNumber,
                  textAlign: TextAlign.right,
                  // TODO: replace with AppTextStyle
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 32),
                RtcTextField(
                  hintText: S.current.phoneNumberHint,
                  keyboardType: TextInputType.phone,
                  textAlign: TextAlign.right,
                  onChanged: (value) =>
                      context.read<AuthCubit>().onPhoneChanged(value),
                  suffix: const Icon(Icons.phone_android_outlined),
                  // TODO: handle directionality or prefix/suffix as per Figma
                ),
                const SizedBox(height: 100),
                RtcButton(
                  title: S.current.getOtpCode,
                  isActive: state.isPhoneValid,
                  isLoading: state.isLoading,
                  onPressed: () => context.read<AuthCubit>().submitPhone(),
                  width: double.infinity,
                  // TODO: replace with theme color
                  backgroundColor: state.isPhoneValid
                      ? Colors.blue
                      : Colors.grey,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
