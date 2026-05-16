import 'package:go_router/go_router.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../presenters/auth/auth.dart';
import '../presenters/customers/customers.dart';
import '../presenters/orders/orders.dart';
import '../presenters/orders/bloc/orders_cubit.dart';
import '../presenters/orders/widget/order_detail_view.dart';
import '../presenters/pre_invoice/pre_invoice.dart';
import '../presenters/dashboard/dashboard.dart';
import '../presenters/dashboard/widget/profile.dart';
import '../presenters/product_detail/product_detail.dart';
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
    GoRoute(
      path: AppRoutes.dashboard,
      builder: (context, state) => const DashboardScreen(),
    ),

    GoRoute(
      path: AppRoutes.profile,
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: AppRoutes.productDetail,
      builder: (context, state) => ProductDetailScreen(
        productId: (state.extra as Map<String, dynamic>)['productId'] as String,
      ),
    ),
    GoRoute(
      path: AppRoutes.customers,
      builder: (context, state) => const CustomersScreen(),
    ),
    GoRoute(
      path: AppRoutes.orders,
      builder: (context, state) => const OrdersScreen(),
    ),
    GoRoute(
      path: AppRoutes.orderDetail,
      builder: (context, state) {
        final cubit = state.extra as OrdersCubit;
        return BlocProvider.value(
          value: cubit,
          child: const OrderDetailView(),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.preInvoice,
      builder: (context, state) => const PreInvoiceScreen(),
    ),
  ],
);
