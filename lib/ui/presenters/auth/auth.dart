import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';

import '../../../config/config.dart';
import '../../../generated/l10n.dart';
import '../../router/app_route.dart';
import '../../widget/rtc_image.dart';
import 'bloc/auth_cubit.dart';
import 'bloc/auth_state.dart';
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
            listener: (context, state) {
              if (state.status == AuthRequestStatus.success) {
                context.go(AppRoutes.dashboard);
              } else if (state.status == AuthRequestStatus.error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage)),
                );
              } else if (state.status == AuthRequestStatus.otpResent) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(S.current.otpResent)),
                );
              }
            },
          ),
        ],
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
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
