import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../router/app_route.dart';
import '../../widget/rtc_appbar.dart';
import '../../widget/rtc_chip_list.dart';
import '../../widget/rtc_order_item.dart';
import '../../widget/rtc_orders_appbar.dart';
import '../../../../data/models/product_chip_model.dart';
import 'bloc/orders_cubit.dart';
import 'bloc/orders_state.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersCubit()..init(),
      child: const OrdersView(),
    );
  }
}

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return MultiBlocListener(
      listeners: [
        BlocListener<OrdersCubit, OrdersState>(
          listenWhen: (prev, curr) => prev.status != curr.status,
          listener: (context, state) {
            if (state.status == OrdersRequestStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  // TODO: replace with theme color
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        ),
      ],
      child: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          final cubit = context.read<OrdersCubit>();
          
          return Scaffold(
            key: scaffoldKey,
            appBar: RtcOrdersAppBar(
              isSearchActive: state.searchQuery.isNotEmpty,
              searchQuery: state.searchQuery,
              scaffoldKey: scaffoldKey,
              cubit: cubit,
            ),
            body: Column(
              children: [
                const SizedBox(height: 16),
                _buildBadgeList(context, state),
                const SizedBox(height: 8),
                Expanded(
                  child: state.status == OrdersRequestStatus.loading
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: state.filteredOrders.length,
                          itemBuilder: (context, index) {
                            final order = state.filteredOrders[index];
                            return RtcOrderItem(
                              order: order,
                              onTap: () {
                                cubit.onOrderTapped(order);
                                context.push(AppRoutes.orderDetail, extra: cubit);
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBadgeList(BuildContext context, OrdersState state) {
    // Mock chips for filtering orders
    final chips = [
      ProductChipModel(id: 1, label: 'وضعیت', opensBottomSheet: true),
      ProductChipModel(id: 2, label: 'طرح', opensBottomSheet: true),
      ProductChipModel(id: 3, label: 'تاریخ ثبت', opensBottomSheet: true),
    ];

    return RtcChipList(
      chips: chips,
      selectedIndex: -1, // No single selection logic in spec for badges list here
      onChipTap: (index, chip) {
        // Handle filter logic
      },
    );
  }
}
