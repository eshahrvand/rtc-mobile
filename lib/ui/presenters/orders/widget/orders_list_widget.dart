import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../data/models/order_model.dart';
import '../../../router/app_route.dart';
import '../bloc/orders_cubit.dart';
import '../bloc/orders_state.dart';
import 'rtc_order_item.dart';

class OrdersListWidget extends StatelessWidget {
  const OrdersListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        final cubit = context.read<OrdersCubit>();

        // Orders list view
        return state.status == OrdersRequestStatus.loading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: state.filteredOrders.length,
                itemBuilder: (context, index) {
                  final OrderSummaryModel order = state.filteredOrders[index];
                  return RtcOrderItem(
                    order: order,
                    onTap: () {
                      cubit.onOrderTapped(order);
                      context.push(AppRoutes.orderDetail, extra: cubit);
                    },
                  );
                },
              );
      },
    );
  }
}
