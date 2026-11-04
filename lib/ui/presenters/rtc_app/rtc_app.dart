import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../generated/l10n.dart';
import '../../router/router.dart';
import '../../theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../locator.dart';
import '../../../../data_source/local/prefs/prefs.dart';
import '../../router/app_route.dart';
import '../workspace/bloc/workspace_cubit.dart';
import '../terms/terms_gate.dart';

class RtcApp extends StatefulWidget {
  const RtcApp({super.key});

  @override
  State<RtcApp> createState() => _RtcAppState();
}

class _RtcAppState extends State<RtcApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && sl<Prefs>().accessToken != null) {
      sl<WorkspaceCubit>().refreshMe().catchError((Object _) {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<WorkspaceCubit>(),
      child: MaterialApp.router(
        routerConfig: router,
        title: 'Rtc',
        theme: appTheme(),
        debugShowCheckedModeBanner: false,
        locale: const Locale('fa'),
        localizationsDelegates: const [
          S.delegate,
          PersianMaterialLocalizations.delegate,
          PersianCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        builder: (context, child) {
          return ResponsiveBreakpoints.builder(
            breakpoints: [
              const Breakpoint(start: 0, end: 360, name: MOBILE),
              const Breakpoint(start: 360, end: 800, name: TABLET),
              const Breakpoint(start: 801, end: 1920, name: DESKTOP),
              const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
            ],
            child: TermsGate(
              child: child!,
              onLogout: () {
                sl<Prefs>().clearTokens().then((_) {
                  sl<WorkspaceCubit>().reset();
                  router.go(AppRoutes.auth);
                });
              },
            ),
          );
        },
      ),
    );
  }
}
