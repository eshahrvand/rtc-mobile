import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../presenters/splash/splash.dart';
import 'app_route.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    //   GoRoute(
    //     path: AppRoutes.auth,
    //     builder: (context, state) => const Scaffold(body: Center(child: Text('Auth Screen'))),
    //   ),
    //   GoRoute(
    //     path: AppRoutes.chatList,
    //     builder: (context, state) => const Scaffold(body: Center(child: Text('Chat List Screen'))),
    //   ),
  ],
);
