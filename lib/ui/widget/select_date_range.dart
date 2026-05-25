
import 'package:axino/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../../../../config/constant.dart';
import '../../../../generated/l10n.dart';
import '../../../theme/colors.dart';
import '../../widget/axino_icon_button.dart';
import '../../widget/axino_text_field.dart';
import '../../widget/date_picker_widget.dart';
import '../bloc/history_cubit.dart';
import 'filter_bootom_sheets/filter_date_bottom_sheet.dart';

class SelectDateRangeWidget extends StatefulWidget {
  const SelectDateRangeWidget({
    this.dateRangeErrorMessage,
    super.key,
  });

  final String? dateRangeErrorMessage;

  @override
  State<SelectDateRangeWidget> createState() => _SelectDateRangeWidgetState();
}

class _SelectDateRangeWidgetState extends State<SelectDateRangeWidget> {
  @override
  Widget build(BuildContext context) {
    bool isDark = isDarkMode(context);
    return Column(
      spacing: 8,
      children: [
        Row(
          children: [
            Expanded(
              child: AxinoTextField(
                suffix: Container(
                  decoration: BoxDecoration(
                      color: isDark ? AppColors.primaryDark : AppColors.primaryDark,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10))),
                  child: AxinoIconButton(
                    icon: '$baseImage/calendar.svg',
                    color: isDark ? AppColors.grayPalette.shade100 : null,
                    onPressed: () async {
                      showJalaliDatePickerSheet(
                          context, S.current.selectStartDate,
                              (Jalali selected) {
                            if (selected != null) {
                              context
                                  .read<HistoryCubit>()
                                  .updateStartRangeDate(selected);
                            }
                          });
                    },
                  ),
                ),
                controller: startDateController,
                readOnly: true,
                labelText: S.current.fromDate,
                hintText: S.current.startDate,
                hintStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: isDark
                        ? AppColors.grayPalette.shade500
                        : AppColors.grayPalette.shade400),
                labelStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: isDark
                        ? AppColors.grayPalette.shade200
                        : AppColors.grayPalette.shade700),
                textStyle: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: AxinoTextField(
                suffix: Container(
                  decoration: BoxDecoration(
                      color: isDark ? AppColors.primaryDark : AppColors.primaryDark,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10))),
                  child: AxinoIconButton(
                    icon: '$baseImage/calendar.svg',
                    onPressed: () async {
                      showJalaliDatePickerSheet(
                          context, S.current.selectEndDate, (formattedDate) {
                        if (formattedDate != null) {
                          context
                              .read<HistoryCubit>()
                              .updateEndRangeDate(formattedDate);
                        }
                      });
                    },
                  ),
                ),
                controller: endDateController,
                readOnly: true,
                labelText: S.current.toDate,
                hintText: S.current.endDate,
                hintStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: isDark
                        ? AppColors.grayPalette.shade500
                        : AppColors.grayPalette.shade400),
                labelStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: isDark
                        ? AppColors.grayPalette.shade200
                        : AppColors.grayPalette.shade700),
                textStyle: Theme.of(context).textTheme.displayLarge,
              ),
            ),
          ],
        ),
        widget.dateRangeErrorMessage != null
            ? Text(
          textAlign: TextAlign.center,
          widget.dateRangeErrorMessage!,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: AppColors.warningPalette.shade600),
        )
            : SizedBox(
          width: 0,
          height: 0,
        ),
      ],
    );
  }
}
