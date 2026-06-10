import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rtc_mobile/ui/widget/rtc_text_button.dart';

import '../../../generated/l10n.dart';
import '../../router/app_route.dart';
import '../../theme/colors.dart';
import '../../widget/rtc_button.dart';
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
          print('>> SPLASH UI: Status changed to ${state.status}');
          if (state.status == SplashStatus.tokenValid) {
            print('>> SPLASH UI: Navigating to DASHBOARD');
            context.go(AppRoutes.dashboard);
          } else if (state.status == SplashStatus.tokenNotValid) {
            print('>> SPLASH UI: Navigating to AUTH');
            context.go(AppRoutes.auth);
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: BlocBuilder<SplashCubit, SplashState>(
            builder: (context, state) {
              return SafeArea(
                child: Stack(
                  children: [
                    Center(
                      child: const RtcImage(
                        image: "assets/images/rtc_logo.png",
                      ),
                    ),
                    if (state.status == SplashStatus.internetError ||
                        state.status == SplashStatus.vpnError)
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: 32,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                state.status == SplashStatus.internetError
                                    ? S.current.internetError
                                    : S.current.vpnError,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              const SizedBox(height: 30),
                              RtcTextButton(
                                title: S.current.retry,
                                styleBtn: Theme.of(context).textTheme.bodyLarge!
                                    .copyWith(
                                      color: AppColors.brandPalette.shade600,
                                    ),
                                onPressed: () {
                                  context.read<SplashCubit>().init();
                                },
                                rightIcon: "assets/images/restart.svg",
                                rightIconColor: AppColors.brandPalette.shade600,
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
