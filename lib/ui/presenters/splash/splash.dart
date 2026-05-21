import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../router/app_route.dart';

import '../../widget/rtc_image.dart';
import 'bloc/splash_cubit.dart';
import 'bloc/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..init(),
      child: BlocListener<SplashCubit, SplashState>(
        listenWhen: (prev, curr) => prev.status != curr.status,
        listener: (context, state) {
          if (state.status == SplashStatus.tokenValid) {
            context.go(AppRoutes.auth);
          } else if (state.status == SplashStatus.tokenNotValid) {
            context.go(AppRoutes.auth);
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(child: RtcImage(image: "assets/images/rtc_logo.png")),
        ),
      ),
    );
  }
}
