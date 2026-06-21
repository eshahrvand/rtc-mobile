import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/constants.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import '../../../widget/rtc_appbar.dart';
import '../../../widget/rtc_search_appbar.dart';
import '../../orders/bloc/orders_cubit.dart';
import '../../orders/bloc/orders_state.dart';
import '../../products/bloc/product_cubit.dart';
import '../../products/bloc/product_state.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int index;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final ProductState productState;
  final OrdersState ordersState;

  const DashboardAppBar({
    super.key,
    required this.index,
    required this.scaffoldKey,
    required this.productState,
    required this.ordersState,
  });

  @override
  Widget build(BuildContext context) {
    return switch (index) {
      0 => RtcAppBar(
          onBack: () {
            scaffoldKey.currentState?.openDrawer();
          },
          backIconPath: "$baseImage/drawer_menu.svg",
        ),
      1 => RtcSearchAppBar(
          isSearchActive: productState.isSearchActive,
          showShadow: true,
          title: "",
          searchHint: S.current.searchProducts,
          onSearchChanged: (value) =>
              context.read<ProductCubit>().onSearchChanged(value),
          onSearchActivated: () => context.read<ProductCubit>().activateSearch(),
          onSearchDeactivated: () =>
              context.read<ProductCubit>().deactivateSearch(),
          scaffoldKey: scaffoldKey,
        ),
      2 => RtcSearchAppBar(
          isSearchActive: ordersState.isSearchActive,
          showShadow: true,
          title: '',
          searchHint: S.current.searchInProducts,
          onSearchChanged: (value) =>
              context.read<OrdersCubit>().onSearchChanged(value),
          onSearchActivated: () => context.read<OrdersCubit>().activateSearch(),
          onSearchDeactivated: () =>
              context.read<OrdersCubit>().deactivateSearch(),
          scaffoldKey: scaffoldKey,
        ),
      _ => const SizedBox.shrink(),
    };
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
