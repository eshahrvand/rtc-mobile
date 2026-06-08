import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rtc_mobile/config/snackbar.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';

import '../../../config/config.dart';
import '../../../generated/l10n.dart';
import '../../router/app_route.dart';
import '../../widget/rtc_image.dart';
import 'bloc/auth_cubit.dart';
import 'bloc/auth_state.dart';
import 'widget/auth_ui_helpers.dart';
import 'widget/otp_widget.dart';
import 'widget/phone_number_widget.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthCubit, AuthState>(
            listenWhen: (prev, curr) => prev.status != curr.status,
            listener: (context, state) =>
                AuthUiHelpers.handleStatusAction(context, state),
          ),
        ],
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 30.0),
                          RtcImage(
                            image: '$baseImage/rtc_logo.png',
                            height: 42.0,
                            width: 80.0,
                          ),
                          const SizedBox(height: 12.0),
                          Text(
                            S.current.companyName,
                            textAlign: TextAlign.center,
                            style: theme.titleSmall!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.grayPalette.shade900,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            S.current.appSubtitle,
                            textAlign: TextAlign.center,
                            style: theme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.grayPalette.shade600,
                            ),
                          ),
                          const SizedBox(height: 30.0),
                          Expanded(
                            child: BlocBuilder<AuthCubit, AuthState>(
                              buildWhen: (prev, curr) => prev.step != curr.step,
                              builder: (context, state) {
                                if (state.step == AuthStep.getPhoneNumber) {
                                  return const PhoneNumberWidget();
                                } else {
                                  return const OtpWidget();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
