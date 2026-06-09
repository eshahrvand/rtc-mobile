import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/config/snackbar.dart';
import 'bloc/dashboard_cubit.dart';
import 'bloc/dashboard_state.dart';
import 'widget/dashboard_app_bar.dart';
import 'widget/dashboard_body.dart';
import '../products/widget/products_body.dart';
import '../products/bloc/product_cubit.dart';
import '../products/bloc/product_state.dart';
import '../orders/bloc/orders_cubit.dart';
import '../orders/bloc/orders_state.dart';
import '../orders/orders_body.dart';
import '../../widget/rtc_bottom_nav.dart';
import '../../widget/rtc_drawer.dart';

class DashboardScreen extends StatelessWidget {
  final int initialIndex;

  const DashboardScreen({super.key, this.initialIndex = 0});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              DashboardCubit(initialIndex: initialIndex)..init(),
        ),
        BlocProvider(create: (context) => ProductCubit()..init()),
        BlocProvider(create: (context) => OrdersCubit()..init()),
      ],
      child: const MainView(),
    );
  }
}

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return MultiBlocListener(
      listeners: [
        BlocListener<DashboardCubit, DashboardState>(
          listenWhen: (prev, curr) =>
              prev.selectedNavIndex != curr.selectedNavIndex,
          listener: (context, state) {
            // Reset search/filters when leaving Products or Orders tabs
            if (state.selectedNavIndex != 1) {
              context.read<ProductCubit>().clearAllFilters();
            }

            if (state.selectedNavIndex != 2) {
              context.read<OrdersCubit>().resetSearchAndFilters();
            }

            // Always refresh orders when entering the tab
            if (state.selectedNavIndex == 2) {
              context.read<OrdersCubit>().fetchOrders();
            }
          },
        ),
        BlocListener<DashboardCubit, DashboardState>(
          listenWhen: (prev, curr) => prev.status != curr.status,
          listener: (context, state) {
            if (state.status == DashboardRequestStatus.error) {
              rtcSnackBar(
                context: context,
                type: SnackBarType.error,
                message: state.errorMessage,
              );
            }
          },
        ),
        BlocListener<ProductCubit, ProductState>(
          listenWhen: (prev, curr) => prev.status != curr.status,
          listener: (context, state) {
            if (state.status == ProductRequestStatus.error) {
              rtcSnackBar(
                context: context,
                type: SnackBarType.error,
                message: state.errorMessage,
              );
            }
          },
        ),
        BlocListener<OrdersCubit, OrdersState>(
          listenWhen: (prev, curr) => prev.status != curr.status,
          listener: (context, state) {
            if (state.status == OrdersRequestStatus.error) {
              rtcSnackBar(
                context: context,
                type: SnackBarType.error,
                message: state.errorMessage,
              );
            }
          },
        ),
      ],
      child: BlocBuilder<DashboardCubit, DashboardState>(
        buildWhen: (prev, curr) =>
            prev.selectedNavIndex != curr.selectedNavIndex,
        builder: (context, dashboardState) {
          return BlocBuilder<ProductCubit, ProductState>(
            builder: (context, productState) {
              return BlocBuilder<OrdersCubit, OrdersState>(
                builder: (context, ordersState) {
                  return Scaffold(
                    key: scaffoldKey,
                    drawer: RtcDrawer(scaffoldKey: scaffoldKey),
                    appBar: DashboardAppBar(
                      index: dashboardState.selectedNavIndex,
                      scaffoldKey: scaffoldKey,
                      productState: productState,
                      ordersState: ordersState,
                    ),
                    body: IndexedStack(
                      index: dashboardState.selectedNavIndex,
                      children: const [
                        DashboardBody(),
                        ProductsBody(),
                        OrdersBody(),
                      ],
                    ),
                    bottomNavigationBar: RtcBottomNav(
                      selectedIndex: dashboardState.selectedNavIndex,
                      onItemSelected: (index) {
                        context.read<DashboardCubit>().onNavItemSelected(index);
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
