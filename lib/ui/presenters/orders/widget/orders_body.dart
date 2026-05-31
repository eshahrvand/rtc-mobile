import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rtc_mobile/ui/presenters/products/widget/filter_bottom_sheet.dart';
import 'package:rtc_mobile/ui/widget/filter_date_bottomsheet.dart';
import '../../../router/app_route.dart';
import '../../../widget/rtc_chip_list.dart';
import 'rtc_order_item.dart';
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
              child:
                  state.status == OrdersRequestStatus.loading &&
                      state.filteredOrders.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: state.filteredOrders.length,
                      itemBuilder: (context, index) {
                        final OrderSummaryModel order =
                            state.filteredOrders[index];
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
    final cubit = context.read<OrdersCubit>();
    final chips = [
      ProductChipModel(id: 1, label: 'وضعیت', opensBottomSheet: true),
      ProductChipModel(id: 2, label: 'طرح', opensBottomSheet: true),
      ProductChipModel(id: 3, label: 'تاریخ ثبت', opensBottomSheet: true),
    ];

    return RtcChipList(
      chips: chips,
      isChipSelected: (index, chip) {
        if (chip.id == 1) return state.selectedStatusId != null;
        if (chip.id == 2) return state.selectedSubPlanId != null;
        if (chip.id == 3)
          return state.startDate != null || state.endDate != null;
        return false;
      },
      onChipTap: (index, chip) {
        debugPrint(
          '>> OrdersBody: Chip tapped: ${chip.label} (ID: ${chip.id})',
        );
        if (chip.id == 1) {
          _showStatusFilter(context, cubit, state);
        } else if (chip.id == 2) {
          _showPlanFilter(context, cubit, state);
        } else if (chip.id == 3) {
          _showDateFilter(context, cubit, state);
        }
      },
      onChipClose: (index, chip) {
        if (chip.id == 1) {
          cubit.onStatusFilterChanged(null);
        } else if (chip.id == 2) {
          cubit.onSubPlanFilterChanged(null);
        } else if (chip.id == 3) {
          cubit.clearDateFilter();
        }
      },
    );
  }

  void _showStatusFilter(
    BuildContext context,
    OrdersCubit cubit,
    OrdersState state,
  ) {
    debugPrint('>> OrdersBody: _showStatusFilter called');
    final statusItems = [
      const FilterItem(id: 'pre_invoice', title: 'پیش فاکتور'),
      const FilterItem(id: 'under_review', title: 'در انتظار تایید'),
      const FilterItem(id: 'approved', title: 'تایید شده'),
      const FilterItem(id: 'rejected', title: 'رد شده'),
    ];

    FilterBottomSheet.show(
      context,
      title: 'وضعیت',
      subtitle: 'وضعیت سفارش را انتخاب کنید',
      items: statusItems,
      initialSelectedId: state.selectedStatusId,
      onApply: (item) => cubit.onStatusFilterChanged(item?.id),
      onClear: () => cubit.onStatusFilterChanged(null),
    );
  }

  void _showPlanFilter(
    BuildContext context,
    OrdersCubit cubit,
    OrdersState state,
  ) {
    debugPrint('>> OrdersBody: _showPlanFilter called');
    final planItems = state.subPlans
        .map((p) => FilterItem(id: p.id, title: p.name))
        .toList();

    FilterBottomSheet.show(
      context,
      title: 'طرح',
      subtitle: 'طرح اعتباری را انتخاب کنید',
      items: planItems,
      initialSelectedId: state.selectedSubPlanId,
      onApply: (item) => cubit.onSubPlanFilterChanged(item?.id),
      onClear: () => cubit.onSubPlanFilterChanged(null),
    );
  }

  void _showDateFilter(
    BuildContext context,
    OrdersCubit cubit,
    OrdersState state,
  ) {
    debugPrint('>> OrdersBody: _showDateFilter called');
    FilterDateBottomSheet.show(
      context,
      initialStartDate: state.startDate,
      initialEndDate: state.endDate,
      initialOptionId: state.selectedDateOptionId,
      onApply: (start, end, optionId) =>
          cubit.onDateFilterChanged(start, end, optionId),
      onClear: () => cubit.clearDateFilter(),
    );
  }
}
