import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';

import '../../../../config/config.dart';
import '../../../../generated/l10n.dart';

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
              controller: _controller,
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
                      : AppColors.grayPalette.shade400,
                ),
                isLoading: state.isLoading,
                onPressed: () => context.read<AuthCubit>().submitPhone(),
              ),
            ),
          ],
        );
      },
    );
  }
}
