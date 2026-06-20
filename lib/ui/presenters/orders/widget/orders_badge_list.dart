import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/core/enums/order_status.dart';
import 'package:rtc_mobile/ui/presenters/products/widget/filter_bottom_sheet.dart';
import 'package:rtc_mobile/ui/widget/filter_date_bottomsheet.dart';
import 'package:rtc_mobile/ui/widget/rtc_chip_list.dart';
import '../../../../core/models/product_chip_model.dart';
import '../../../../generated/l10n.dart';
import '../bloc/orders_cubit.dart';
import '../bloc/orders_state.dart';

class OrdersBadgeList extends StatelessWidget {
  final OrdersState state;

  const OrdersBadgeList({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OrdersCubit>();
    final chips = [
      ProductChipModel(id: 1, label: S.current.status, opensBottomSheet: true),
      ProductChipModel(id: 2, label: S.current.plan, opensBottomSheet: true),
      ProductChipModel(
        id: 3,
        label: S.current.registrationDate,
        opensBottomSheet: true,
      ),
    ];

    return RtcChipList(
      chips: chips,
      isChipSelected: (index, chip) {
        if (chip.id == 1) return state.selectedStatusId != null;
        if (chip.id == 2) return state.selectedSubPlanId != null;
        if (chip.id == 3) {
          return state.startDate != null || state.endDate != null;
        }
        return false;
      },
      onChipTap: (index, chip) {
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
    final statusItems = [
      FilterItem(
        id: 'pre_invoice',
        title: OrderStatus.preInvoice.toDisplayString(),
      ),
      FilterItem(
        id: 'under_review',
        title: OrderStatus.underReview.toDisplayString(),
      ),
      FilterItem(id: 'approved', title: OrderStatus.approved.toDisplayString()),
      FilterItem(id: 'rejected', title: OrderStatus.rejected.toDisplayString()),
      FilterItem(
        id: 'awaiting_settlement',
        title: OrderStatus.awaitingSettlement.toDisplayString(),
      ),
      FilterItem(id: 'expired', title: OrderStatus.expired.toDisplayString()),
    ];

    FilterBottomSheet.show(
      context,
      title: S.current.status,
      subtitle: S.current.selectOrderStatusSubtitle,
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
      title: S.current.plan,
      subtitle: S.current.selectCreditPlanSubtitle,
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
