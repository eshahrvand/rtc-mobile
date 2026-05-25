import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import '../theme/colors.dart';
import 'rtc_button.dart';
import 'select_date_range.dart';

class FilterDateBottomSheet extends StatefulWidget {
  final Jalali? initialStartDate;
  final Jalali? initialEndDate;
  final void Function(Jalali? start, Jalali? end) onApply;
  final VoidCallback onClear;

  const FilterDateBottomSheet({
    super.key,
    this.initialStartDate,
    this.initialEndDate,
    required this.onApply,
    required this.onClear,
  });

  static void show(
    BuildContext context, {
    Jalali? initialStartDate,
    Jalali? initialEndDate,
    required void Function(Jalali? start, Jalali? end) onApply,
    required VoidCallback onClear,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return FilterDateBottomSheet(
          initialStartDate: initialStartDate,
          initialEndDate: initialEndDate,
          onApply: onApply,
          onClear: onClear,
        );
      },
    );
  }

  @override
  State<FilterDateBottomSheet> createState() => _FilterDateBottomSheetState();
}

class _FilterDateBottomSheetState extends State<FilterDateBottomSheet> {
  Jalali? _tempStart;
  Jalali? _tempEnd;

  @override
  void initState() {
    super.initState();
    _tempStart = widget.initialStartDate;
    _tempEnd = widget.initialEndDate;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    final hasFilter = _tempStart != null || _tempEnd != null;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 4,
              width: 48,
              decoration: BoxDecoration(
                color: AppColors.grayPalette.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                S.current.registrationDate,
                style: theme.titleMedium!.copyWith(
                  color: AppColors.grayPalette.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                S.current.selectDate,
                style: theme.bodyMedium!.copyWith(
                  color: AppColors.grayPalette.shade600,
                ),
              ),
            ),
            const SizedBox(height: 24),
            SelectDateRangeWidget(
              initialStartDate: _tempStart,
              initialEndDate: _tempEnd,
              onDateRangeChanged: (start, end) {
                setState(() {
                  _tempStart = start;
                  _tempEnd = end;
                });
              },
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: RtcButton(
                    title: S.current.applyFilter,
                    onPressed: () {
                      widget.onApply(_tempStart, _tempEnd);
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: RtcButton(
                    title: S.current.clearFilter,
                    backgroundColor: Colors.white,
                    styleBtn: theme.titleMedium!.copyWith(
                      color: hasFilter
                          ? AppColors.errorPalette.shade600
                          : AppColors.grayPalette.shade400,
                    ),
                    borderColor: hasFilter
                        ? AppColors.errorPalette.shade600
                        : AppColors.grayPalette.shade300,
                    onPressed: () {
                      widget.onClear();
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
