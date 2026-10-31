import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../../../../core/models/product_chip_model.dart';
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
      isChipEnabled: (_, chip) => chip.id != 1,
      isChipSelected: (_, chip) => switch (chip.id) {
        2 => state.selectedYear != null,
        3 => state.selectedMonth != null,
        _ => false,
      },
      onChipClose: (_, chip) {
        switch (chip.id) {
          case 2:
            cubit.selectYear(null);
          case 3:
            cubit.selectMonth(null);
        }
      },
      onChipTap: (_, chip) {
        switch (chip.id) {
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
