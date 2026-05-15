import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/config/config.dart';
import '../../widget/rtc_image.dart';
import 'bloc/dashboard_cubit.dart';
import 'bloc/dashboard_state.dart';
import 'widget/dashboard_body.dart';
import '../products/widget/products_body.dart';
import '../products/bloc/product_cubit.dart';
import '../products/bloc/product_state.dart';
import '../orders/bloc/orders_cubit.dart';
import '../orders/bloc/orders_state.dart';
import '../orders/widget/orders_body.dart';
import '../../widget/rtc_bottom_nav.dart';
import '../../widget/rtc_drawer.dart';
import '../../widget/rtc_appbar.dart';
import '../../widget/rtc_products_appbar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DashboardCubit()..init()),
        BlocProvider(create: (context) => ProductCubit()..init()),
        BlocProvider(create: (context) => OrdersCubit()..init()),
      ],
      child: const MainView(),
    );
  }
}

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return MultiBlocListener(
      listeners: [
        BlocListener<DashboardCubit, DashboardState>(
          listenWhen: (prev, curr) => prev.status != curr.status,
          listener: (context, state) {
            if (state.status == DashboardRequestStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor:
                      Colors.red, // TODO: replace with theme values
                ),
              );
            }
          },
        ),
        BlocListener<ProductCubit, ProductState>(
          listenWhen: (prev, curr) => prev.status != curr.status,
          listener: (context, state) {
            if (state.status == ProductRequestStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor:
                      Colors.red, // TODO: replace with theme values
                ),
              );
            }
          },
        ),
        BlocListener<OrdersCubit, OrdersState>(
          listenWhen: (prev, curr) => prev.status != curr.status,
          listener: (context, state) {
            if (state.status == OrdersRequestStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red, // TODO: replace with theme values
                ),
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
                    appBar: _buildAppBar(
                      context,
                      dashboardState.selectedNavIndex,
                      scaffoldKey,
                      productState,
                      ordersState,
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

  PreferredSizeWidget? _buildAppBar(
    BuildContext context,
    int index,
    GlobalKey<ScaffoldState> scaffoldKey,
    ProductState productState,
    OrdersState ordersState,
  ) {
    if (index == 0) {
      return RtcAppBar(
        onBack: () {
          scaffoldKey.currentState?.openDrawer();
        },
        backIconPath: "$baseImage/drawer_menu.svg",
      );
    } else if (index == 1) {
      return RtcProductsAppBar(
        isSearchActive: productState.isSearchActive,
        searchQuery: productState.searchQuery,
        scaffoldKey: scaffoldKey,
        cubit: context.read<ProductCubit>(),
      );
    } else if (index == 2) {
      return RtcAppBar(
        title: 'سفارشات',
        onBack: () => scaffoldKey.currentState?.openDrawer(),
        backIconPath: "$baseImage/drawer_menu.svg",
        actions: [
          IconButton(
            onPressed: () {},
            icon: RtcImage(image: "$baseImage/search.svg", width: 20, height: 20),
          ),
        ],
      );
    }
    return null;
  }
}
