import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../presenters/auth/auth.dart';
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
    GoRoute(
      path: AppRoutes.auth,
      builder: (context, state) => const AuthScreen(),
    ),
  ],
);
