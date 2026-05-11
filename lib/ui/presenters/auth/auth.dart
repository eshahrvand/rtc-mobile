import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../generated/l10n.dart';
import '../../router/app_route.dart';
import 'bloc/auth_cubit.dart';
import 'bloc/auth_state.dart';
import 'widget/otp_widget.dart';
import 'widget/phone_number_widget.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthCubit, AuthState>(
            listenWhen: (prev, curr) => prev.status != curr.status,
            listener: (context, state) {
              if (state.status == AuthRequestStatus.success) {
                context.go(AppRoutes.chatList);
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
          // TODO: replace with theme color
          backgroundColor: Colors.white,
          body: BlocBuilder<AuthCubit, AuthState>(
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
      ),
    );
  }
}
