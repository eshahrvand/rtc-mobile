import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/config/snackbar.dart';
import 'package:rtc_mobile/ui/presenters/products/widget/filter_bottom_sheet.dart';
import 'package:rtc_mobile/ui/widget/filter_date_bottomsheet.dart';
import '../../../../core/enums/order_status.dart';
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
              rtcSnackBar(
                context: context,
                type: SnackBarType.error,
                message: state.errorMessage,
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
              title: '',
              titleStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              searchHint: "",
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
        if (chip.id == 1) return state.selectedStatusId != null;
        if (chip.id == 2) return state.selectedSubPlanId != null;
        if (chip.id == 3) return state.startDate != null || state.endDate != null;
        return false;
      },
      onChipTap: (index, chip) {
        debugPrint('>> OrdersScreen: Chip tapped: ${chip.label} (ID: ${chip.id})');
        if (chip.id == 1) {
          debugPrint('>> OrdersScreen: Opening Status Filter');
          _showStatusFilter(context, cubit, state);
        } else if (chip.id == 2) {
          debugPrint('>> OrdersScreen: Opening Plan Filter');
          _showPlanFilter(context, cubit, state);
        } else if (chip.id == 3) {
          debugPrint('>> OrdersScreen: Opening Date Filter');
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
    debugPrint('>> OrdersScreen: _showStatusFilter called');
    final statusItems = [
      FilterItem(
        id: 'pre_invoice',
        title: OrderStatus.preInvoice.toDisplayString(),
      ),
      FilterItem(
        id: 'under_review',
        title: OrderStatus.underReview.toDisplayString(),
      ),
      FilterItem(
        id: 'approved',
        title: OrderStatus.approved.toDisplayString(),
      ),
      FilterItem(
        id: 'rejected',
        title: OrderStatus.rejected.toDisplayString(),
      ),
      FilterItem(
        id: 'awaiting_settlement',
        title: OrderStatus.awaitingSettlement.toDisplayString(),
      ),
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
    debugPrint('>> OrdersScreen: _showPlanFilter called');
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
    debugPrint('>> OrdersScreen: _showDateFilter called');
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
