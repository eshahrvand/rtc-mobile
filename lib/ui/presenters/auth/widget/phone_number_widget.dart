import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import '../../../../config/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/service/analytics_service.dart';
import '../../../../locator.dart';
import '../../../widget/rtc_button.dart';
import '../../../widget/rtc_image.dart';
import '../../../widget/rtc_text_field.dart';
import '../bloc/auth_cubit.dart';
import '../bloc/auth_state.dart';

class PhoneNumberWidget extends StatefulWidget {
  const PhoneNumberWidget({super.key});

  @override
  State<PhoneNumberWidget> createState() => _PhoneNumberWidgetState();
}

class _PhoneNumberWidgetState extends State<PhoneNumberWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<AuthCubit>();
    _controller = TextEditingController(text: cubit.state.phoneNumber);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              S.current.loginToSystem,
              textAlign: TextAlign.right,
              style: theme.titleMedium!.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.grayPalette.shade900,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              S.current.enterPhoneNumber,
              textAlign: TextAlign.right,
              style: theme.bodyLarge!.copyWith(
                color: AppColors.grayPalette.shade600,
              ),
            ),
            const SizedBox(height: 32.0),
            RtcTextField(
              autoFocus: true,
              controller: _controller,
              hintText: S.current.phoneNumberHint,
              hintStyle: theme.bodyLarge!.copyWith(
                color: AppColors.grayPalette.shade400,
              ),
              keyboardType: TextInputType.phone,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp("[0-9۰-۹\b]"))
              ],
              textAlign: TextAlign.right,
              onChanged: (value) =>
                  context.read<AuthCubit>().onPhoneChanged(value),
              prefix: RtcImage(
                image: "$baseImage/mobile.svg",
                width: 20.0,
                height: 20.0,
              ),
              maxLength: 11,
              helper: state.showPhoneError
                  ? Row(
                      spacing: 8.0,
                      children: [
                        RtcImage(
                          image: 'assets/images/alert.svg',
                          width: 14.0,
                          height: 14.0,
                          color: AppColors.errorPalette.shade600,
                        ),
                        Text(
                          S.current.phoneNumberWrong,
                          style: theme.bodySmall!.copyWith(
                            color: AppColors.errorPalette.shade600,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: RtcButton(
                title: S.current.getOtpCode,
                isActive: state.isPhoneValid,
                styleBtn: theme.labelLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: state.isPhoneValid
                      ? Colors.white
                      : AppColors.grayPalette.shade400,
                ),
                isLoading: state.isLoading,
                onPressed: () {
                  sl<AnalyticsService>().logButtonTap('get_otp_code');
                  context.read<AuthCubit>().submitPhone();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
