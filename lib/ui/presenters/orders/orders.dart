import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/ui/presenters/products/widget/filter_bottom_sheet.dart';
import 'package:rtc_mobile/ui/widget/filter_date_bottomsheet.dart';
import '../../../../data/models/product_chip_model.dart';
import '../../widget/rtc_chip_list.dart';
import '../../widget/rtc_image.dart';
import '../../widget/rtc_search_appbar.dart';
import 'bloc/orders_cubit.dart';
import 'bloc/orders_state.dart';
import 'widget/orders_list_widget.dart';

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

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<OrdersCubit, OrdersState>(
          listenWhen: (prev, curr) => prev.status != curr.status,
          listener: (context, state) {
            if (state.status == OrdersRequestStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
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
            appBar: RtcSearchAppBar(
              isSearchActive: state.searchQuery.isNotEmpty,
              showShadow: false,
              title: 'سفارشات',
              titleStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              searchLabel: 'جستجو در سفارشات',
              onSearchChanged: (value) => cubit.onSearchChanged(value),
              onSearchActivated: () => cubit.onSearchChanged(' '),
              onSearchDeactivated: () => cubit.onSearchChanged(''),
              scaffoldKey: scaffoldKey,
              searchSuffix: RtcImage(
                image: '$baseImage/search.svg',
                width: 20,
                height: 20,
              ),
            ),
            body: Column(
              children: [
                const SizedBox(height: 16),
                _buildBadgeList(context, state),
                const SizedBox(height: 8),
                const Expanded(child: OrdersListWidget()),
              ],
            ),
          );
        },
      ),
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
        if (index == 0) return state.selectedStatusId != null;
        if (index == 1) return state.selectedSubPlanId != null;
        if (index == 2) return state.startDate != null || state.endDate != null;
        return false;
      },
      onChipTap: (index, chip) {
        if (index == 0) {
          _showStatusFilter(context, cubit, state);
        } else if (index == 1) {
          _showPlanFilter(context, cubit, state);
        } else if (index == 2) {
          _showDateFilter(context, cubit, state);
        }
      },
    );
  }

  void _showStatusFilter(
    BuildContext context,
    OrdersCubit cubit,
    OrdersState state,
  ) {
    final statusItems = [
      const FilterItem(id: 'pre_invoice', title: 'پیش فاکتور'),
      const FilterItem(id: 'approved', title: 'تایید شده'),
      const FilterItem(id: 'rejected', title: 'رد شده'),
      const FilterItem(id: 'waiting_settlement', title: 'در انتظار تسویه'),
      const FilterItem(id: 'expired', title: 'منقضی شده'),
      const FilterItem(
        id: 'pending_sales_review',
        title: 'در انتظار بررسی فروش',
      ),
      const FilterItem(
        id: 'pending_finance_review',
        title: 'در انتظار بررسی مالی',
      ),
      const FilterItem(id: 'returned_for_revision', title: 'بازگشت برای اصلاح'),
      const FilterItem(id: 'unassigned_sales', title: 'تخصیص نیافته - فروش'),
      const FilterItem(id: 'unassigned_finance', title: 'تخصیص نیافته - مالی'),
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
