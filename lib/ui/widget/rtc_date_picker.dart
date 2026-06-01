import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../../../generated/l10n.dart';
import 'rtc_button.dart';

class JalaliDatePicker extends StatefulWidget {
  final Jalali? initialDate;
  final void Function(Jalali selectedDate)? onDateSelected;

  const JalaliDatePicker({super.key, this.initialDate, this.onDateSelected});

  @override
  State<JalaliDatePicker> createState() => _JalaliDatePickerState();
}

class _JalaliDatePickerState extends State<JalaliDatePicker> {
  late int selectedDay;
  late int selectedMonth;
  late int selectedYear;

  late FixedExtentScrollController dayController;
  late FixedExtentScrollController monthController;
  late FixedExtentScrollController yearController;

  final Jalali today = Jalali.now();

  List<String> get monthNumbers {
    int count = 12;
    if (selectedYear == today.year) {
      count = today.month;
    }
    return List.generate(count, (i) => (i + 1).toString().padLeft(2, '0'));
  }

  List<int> get years {
    final allYears = List.generate(50, (i) => 1370 + i);
    return allYears.where((y) => y <= today.year).toList();
  }

  List<int> get days {
    final monthLength = Jalali(selectedYear, selectedMonth + 1, 1).monthLength;
    int count = monthLength;
    if (selectedYear == today.year && selectedMonth + 1 == today.month) {
      count = today.day;
    }
    return List.generate(count, (i) => i + 1);
  }

  @override
  void initState() {
    super.initState();
    final initDate = widget.initialDate ?? today;
    selectedDay = initDate.day;
    selectedMonth = initDate.month - 1;
    selectedYear = initDate.year;

    dayController = FixedExtentScrollController(initialItem: selectedDay - 1);
    monthController = FixedExtentScrollController(initialItem: selectedMonth);
    yearController = FixedExtentScrollController(
      initialItem: years.indexOf(selectedYear),
    );
  }

  void _adjustDayIfNeeded() {
    final maxDay = days.length;
    if (selectedDay > maxDay) {
      selectedDay = maxDay;
      dayController.jumpToItem(selectedDay - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    _adjustDayIfNeeded();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildPickerColumn(
                label: 'روز',
                items: days.map((e) => e.toString()).toList(),
                selectedIndex: selectedDay - 1,
                onChanged: (index) {
                  final newDay = index + 1;
                  if (Jalali(
                    selectedYear,
                    selectedMonth + 1,
                    newDay,
                  ).isAfter(today))
                    return;
                  setState(() {
                    selectedDay = newDay;
                    widget.onDateSelected?.call(
                      Jalali(selectedYear, selectedMonth + 1, selectedDay),
                    );
                  });
                },
                controller: dayController,
              ),
              const _DotSeparator(),
              _buildPickerColumn(
                label: 'ماه',
                items: monthNumbers,
                selectedIndex: selectedMonth,
                onChanged: (index) {
                  if (selectedYear == today.year && index + 1 > today.month)
                    return;
                  setState(() {
                    selectedMonth = index;
                    _adjustDayIfNeeded();
                    widget.onDateSelected?.call(
                      Jalali(selectedYear, selectedMonth + 1, selectedDay),
                    );
                  });
                },
                controller: monthController,
              ),
              const _DotSeparator(),
              _buildPickerColumn(
                label: 'سال',
                items: years.map((e) => e.toString()).toList(),
                selectedIndex: years.indexOf(selectedYear),
                onChanged: (index) {
                  final newYear = years[index];
                  if (newYear > today.year) return;
                  setState(() {
                    selectedYear = newYear;
                    _adjustDayIfNeeded();
                    widget.onDateSelected?.call(
                      Jalali(selectedYear, selectedMonth + 1, selectedDay),
                    );
                  });
                },
                controller: yearController,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPickerColumn({
    required String label,
    required List<String> items,
    required int selectedIndex,
    required void Function(int) onChanged,
    required FixedExtentScrollController controller,
  }) {
    return SizedBox(
      width: 90,
      height: 180,
      child: Column(
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: AppColors.grayPalette.shade600,
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 38,
                  child: Container(
                    width: 60,
                    height: 1,
                    color: AppColors.grayPalette.shade200,
                  ),
                ),
                Positioned(
                  bottom: 38,
                  child: Container(
                    width: 60,
                    height: 1,
                    color: AppColors.grayPalette.shade200,
                  ),
                ),
                ListWheelScrollView.useDelegate(
                  controller: controller,
                  itemExtent: 50,
                  perspective: 0.000001,
                  diameterRatio: 100,
                  physics: const FixedExtentScrollPhysics(),
                  onSelectedItemChanged: onChanged,
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: items.length,
                    builder: (context, index) {
                      final isSelected = index == selectedIndex;
                      return Center(
                        child: Text(
                          items[index],
                          style: isSelected
                              ? Theme.of(
                                  context,
                                ).textTheme.labelLarge!.copyWith(
                                  color: AppColors.grayPalette.shade800,
                                )
                              : Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  color: AppColors.grayPalette.shade400,
                                ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DotSeparator extends StatelessWidget {
  const _DotSeparator();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 48, left: 4, right: 4),
      child: Text(
        '●',
        style: TextStyle(fontSize: 6, color: AppColors.grayPalette.shade800),
      ),
    );
  }
}

showJalaliDatePickerSheet(
  BuildContext context,
  String title,
  void Function(Jalali selectedDate) onDateSelected,
) {
  Jalali selectedDate = Jalali.now();

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    isScrollControlled: true,
    builder: (context) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 2,
                width: 32,
                color: AppColors.brandPalette.shade600,
              ),
              const SizedBox(height: 40),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.grayPalette.shade800,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              JalaliDatePicker(
                onDateSelected: (date) {
                  selectedDate = date;
                },
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: RtcButton(
                      title: S.current.back,
                      backgroundColor: Colors.white,
                      borderColor: AppColors.grayPalette.shade300,
                      styleBtn: Theme.of(context).textTheme.labelLarge!
                          .copyWith(
                            color: AppColors.grayPalette.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),

                  Expanded(
                    child: RtcButton(
                      title: S.current.confirm,
                      size: RtcButtonSize.medium,
                      styleBtn: Theme.of(context).textTheme.labelLarge!
                          .copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                      onPressed: () {
                        onDateSelected(selectedDate);
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
    },
  );
}
