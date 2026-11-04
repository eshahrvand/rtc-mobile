import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../../../../core/models/product_chip_model.dart';
import '../../../../core/models/filter_item.dart';
import '../../products/widget/filter_bottom_sheet.dart';
import '../../../../generated/l10n.dart';
import '../../../widget/rtc_chip_list.dart';
import '../../../widget/rtc_wheel_filter_sheet.dart';
import '../bloc/commission_report_cubit.dart';
import '../bloc/commission_report_state.dart';

class CommissionReportFilters extends StatelessWidget {
  final CommissionReportState state;

  const CommissionReportFilters({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CommissionReportCubit>();
    return RtcChipList(
      chips: [
        ProductChipModel(
          id: 1,
          label: S.current.commissionStoreFilter,
          opensBottomSheet: true,
        ),
        ProductChipModel(id: 2, label: S.current.year, opensBottomSheet: true),
        ProductChipModel(id: 3, label: S.current.month, opensBottomSheet: true),
      ],
      isChipSelected: (_, chip) => switch (chip.id) {
        1 => state.selectedStoreId != null,
        2 => state.selectedYear != null,
        3 => state.selectedMonth != null,
        _ => false,
      },
      onChipClose: (_, chip) {
        switch (chip.id) {
          case 1:
            cubit.selectStore(null);
          case 2:
            cubit.selectYear(null);
          case 3:
            cubit.selectMonth(null);
        }
      },
      onChipTap: (_, chip) {
        switch (chip.id) {
          case 1:
            cubit.loadStores();
            FilterBottomSheet.show<
              CommissionReportCubit,
              CommissionReportState
            >(
              context,
              title: S.current.commissionStoreFilter,
              subtitle: S.current.commissionSelectStores,
              items: state.storeOptions
                  .map((store) => FilterItem(id: store.id, title: store.name))
                  .toList(),
              bloc: cubit,
              itemsSelector: (current) => current.storeOptions
                  .map((store) => FilterItem(id: store.id, title: store.name))
                  .toList(),
              loadingSelector: (current) => current.isStoreOptionsLoading,
              errorSelector: (current) => current.storeOptionsError,
              onRetry: cubit.loadStores,
              initialSelectedId: state.selectedStoreId,
              onApply: (item) => cubit.selectStore(item?.id),
              onClear: () => cubit.selectStore(null),
            );
          case 2:
            RtcWheelFilterSheet.show(
              context,
              title: S.current.year,
              subtitle: S.current.commissionSelectYear,
              values: state.years,
              labels: state.years.map((year) => year.toString()).toList(),
              initialValue: state.selectedYear ?? Jalali.now().year,
              hasFilter: state.selectedYear != null,
              onApply: cubit.selectYear,
              onClear: () => cubit.selectYear(null),
            );
          case 3:
            RtcWheelFilterSheet.show(
              context,
              title: S.current.month,
              subtitle: S.current.commissionSelectMonth,
              values: List.generate(12, (index) => index + 1),
              labels: List.generate(
                12,
                (index) => Jalali(1405, index + 1, 1).formatter.mN,
              ),
              initialValue: state.selectedMonth ?? Jalali.now().month,
              hasFilter: state.selectedMonth != null,
              onApply: cubit.selectMonth,
              onClear: () => cubit.selectMonth(null),
            );
        }
      },
    );
  }
}
