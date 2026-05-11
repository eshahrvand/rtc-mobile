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
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
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
                            fontWeight: FontWeight.w600,
                            color: AppColors.grayPalette.shade900,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          S.current.appSubtitle,
                          textAlign: TextAlign.center,
                          style: theme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.grayPalette.shade600,
                          ),
                        ),
                        const SizedBox(height: 38),
                        Text(
                          S.current.loginToSystem,
                          textAlign: TextAlign.right,
                          style: theme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.grayPalette.shade900,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          S.current.enterPhoneNumber,
                          textAlign: TextAlign.right,
                          style: theme.bodyLarge!.copyWith(
                            color: AppColors.grayPalette.shade600,
                          ),
                        ),
                        const SizedBox(height: 32),
                        RtcTextField(
                          hintText: S.current.phoneNumberHint,
                          hintStyle: theme.bodyLarge!.copyWith(
                            color: AppColors.grayPalette.shade400,
                          ),
                          keyboardType: TextInputType.phone,
                          textAlign: TextAlign.right,
                          onChanged: (value) =>
                              context.read<AuthCubit>().onPhoneChanged(value),
                          prefix: RtcImage(
                            image: "$baseImage/mobile.svg",
                            width: 20,
                            height: 20,
                          ),

                          maxLength: 11,
                        ),
                        const Spacer(),

                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: RtcButton(
                            title: S.current.getOtpCode,
                            isActive: state.isPhoneValid,
                            styleBtn: theme.labelLarge!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: state.isPhoneValid
                                  ? Colors.white
                                  : AppColors.grayPalette.shade300,
                            ),
                            isLoading: state.isLoading,
                            onPressed: () =>
                                context.read<AuthCubit>().submitPhone(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
