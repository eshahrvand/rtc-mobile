import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../router/app_route.dart';
import '../../../widget/rtc_chip_list.dart';
import '../../../widget/rtc_order_item.dart';
import '../../../../data/models/product_chip_model.dart';
import '../../../../data/models/order_model.dart';
import '../bloc/orders_cubit.dart';
import '../bloc/orders_state.dart';

class OrdersBody extends StatelessWidget {
  const OrdersBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        final cubit = context.read<OrdersCubit>();

        return Column(
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
                        final OrderSummaryModel order = state.filteredOrders[index];
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
        );
      },
    );
  }

  Widget _buildBadgeList(BuildContext context, OrdersState state) {
    final chips = [
      ProductChipModel(id: 1, label: 'وضعیت', opensBottomSheet: true),
      ProductChipModel(id: 2, label: 'طرح', opensBottomSheet: true),
      ProductChipModel(id: 3, label: 'تاریخ ثبت', opensBottomSheet: true),
    ];

    return RtcChipList(
      chips: chips,
      selectedIndex: -1,
      onChipTap: (index, chip) {},
    );
  }
}
