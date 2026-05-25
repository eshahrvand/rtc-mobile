import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import '../theme/colors.dart';
import 'rtc_text_field.dart';
import 'rtc_date_picker.dart';

class SelectDateRangeWidget extends StatefulWidget {
  final Jalali? initialStartDate;
  final Jalali? initialEndDate;
  final void Function(Jalali? start, Jalali? end) onDateRangeChanged;
  final String? dateRangeErrorMessage;

  const SelectDateRangeWidget({
    super.key,
    this.initialStartDate,
    this.initialEndDate,
    required this.onDateRangeChanged,
    this.dateRangeErrorMessage,
  });

  @override
  State<SelectDateRangeWidget> createState() => _SelectDateRangeWidgetState();
}

class _SelectDateRangeWidgetState extends State<SelectDateRangeWidget> {
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;
  Jalali? _startDate;
  Jalali? _endDate;

  @override
  void initState() {
    super.initState();
    _startDate = widget.initialStartDate;
    _endDate = widget.initialEndDate;
    _startDateController = TextEditingController(
      text: _formatJalali(_startDate),
    );
    _endDateController = TextEditingController(text: _formatJalali(_endDate));
  }

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  String _formatJalali(Jalali? date) {
    if (date == null) return '';
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
  }

  void _onStartDateTap() {
    showJalaliDatePickerSheet(context, S.current.selectStartDate, (selected) {
      setState(() {
        _startDate = selected;
        _startDateController.text = _formatJalali(_startDate);
      });
      widget.onDateRangeChanged(_startDate, _endDate);
    });
  }

  void _onEndDateTap() {
    showJalaliDatePickerSheet(context, S.current.selectEndDate, (selected) {
      setState(() {
        _endDate = selected;
        _endDateController.text = _formatJalali(_endDate);
      });
      widget.onDateRangeChanged(_startDate, _endDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: RtcTextField(
                controller: _startDateController,
                readOnly: true,
                labelText: S.current.fromDate,
                hintText: S.current.startDate,
                suffix: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.calenderDark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: GestureDetector(
                    onTap: _onStartDateTap,
                    child: RtcImage(
                      image: '$baseImage/calendar.svg',
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: RtcTextField(
                controller: _endDateController,
                readOnly: true,
                labelText: S.current.toDate,

                hintText: S.current.endDate,

                suffix: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.calenderDark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),

                  child: GestureDetector(
                    onTap: _onEndDateTap,
                    child: RtcImage(
                      image: '$baseImage/calendar.svg',
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        if (widget.dateRangeErrorMessage != null) ...[
          const SizedBox(height: 8),
          Text(
            widget.dateRangeErrorMessage!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: AppColors.errorPalette.shade600,
            ),
          ),
        ],
      ],
    );
  }
}
