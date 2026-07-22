import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../locator.dart';
import '../../../core/service/analytics_service.dart';
import '../presenters/auth/auth.dart';
import '../presenters/customers/customers.dart';
import '../presenters/orders/bloc/orders_cubit.dart';
import '../presenters/orders/widget/order_detail_view.dart';
import '../presenters/pre_invoice/pre_invoice.dart';
import '../presenters/wallet/wallet.dart';
import '../presenters/wallet/transaction_list.dart';
import '../presenters/wallet/bloc/wallet_cubit.dart';
import '../presenters/dashboard/dashboard.dart';
import '../presenters/dashboard/widget/profile.dart';
import '../../../data_source/remote/profile/model/user_profile_dto_model.dart';
import '../presenters/product_detail/product_detail.dart';
import '../presenters/splash/splash.dart';
import '../presenters/report/report.dart';
import '../presenters/report/report_step.dart';
import 'app_route.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: AppRoutes.splash,
  observers: [
    sl<AnalyticsService>().observer,
  ],
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      name: 'SplashScreen',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.auth,
      name: 'AuthScreen',
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: AppRoutes.dashboard,
      name: 'DashboardScreen',
      builder: (context, state) {
        final indexStr = state.uri.queryParameters['index'];
        final index = int.tryParse(indexStr ?? '0') ?? 0;
        return DashboardScreen(
          initialIndex: index,
        );
      },
    ),

    GoRoute(
      path: AppRoutes.profile,
      name: 'ProfileScreen',
      builder: (context, state) {
        final profile = state.extra as UserProfileDtoModel?;
        return ProfileScreen(userProfile: profile);
      },
    ),
    GoRoute(
      path: AppRoutes.productDetail,
      name: 'ProductDetailScreen',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return ProductDetailScreen(
          productId: extra['productId'] as String,
          subPlanId: extra['subPlanId'] as String?,
          subPlanName: extra['subPlanName'] as String?,
          showPrice: extra['showPrice'] as bool? ?? true,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.customers,
      name: 'CustomersScreen',
      builder: (context, state) => const CustomersScreen(),
    ),
    GoRoute(
      path: AppRoutes.orders,
      name: 'OrdersScreen',
      builder: (context, state) => const DashboardScreen(initialIndex: 2),
    ),
    GoRoute(
      path: AppRoutes.orderDetail,
      name: 'OrderDetailView',
      builder: (context, state) {
        final orderId = state.extra as String;
        return BlocProvider(
          create: (context) => OrdersCubit()..fetchOrderDetail(orderId),
          child: const OrderDetailView(),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.preInvoice,
      name: 'PreInvoiceScreen',
      builder: (context, state) => const PreInvoiceScreen(),
    ),
    GoRoute(
      path: AppRoutes.wallet,
      name: 'WalletScreen',
      builder: (context, state) => const WalletScreen(),
    ),
    GoRoute(
      path: AppRoutes.transactionList,
      name: 'TransactionListScreen',
      builder: (context, state) {
        final cubit = state.extra as WalletCubit;
        return BlocProvider.value(
          value: cubit,
          child: const TransactionListScreen(),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.reports,
      name: 'ReportScreen',
      builder: (context, state) {
        final step = state.extra as ReportStep? ?? ReportStep.sales;
        return ReportScreen(initialStep: step);
      },
    ),
  ],
);
