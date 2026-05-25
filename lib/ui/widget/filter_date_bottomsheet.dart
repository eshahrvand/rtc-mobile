import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import '../presenters/products/widget/filter_option_item.dart';
import '../theme/colors.dart';
import 'rtc_button.dart';
import 'rtc_image.dart';
import 'rtc_text_button.dart';
import 'select_date_range.dart';

class FilterDateOption {
  final String id;
  final String title;
  final Jalali Function() getDateRange;

  FilterDateOption({
    required this.id,
    required this.title,
    required this.getDateRange,
  });
}

class FilterDateBottomSheet extends StatefulWidget {
  final Jalali? initialStartDate;
  final Jalali? initialEndDate;
  final String? initialOptionId;
  final void Function(Jalali? start, Jalali? end, String? optionId) onApply;
  final VoidCallback onClear;

  const FilterDateBottomSheet({
    super.key,
    this.initialStartDate,
    this.initialEndDate,
    this.initialOptionId,
    required this.onApply,
    required this.onClear,
  });

  static void show(
    BuildContext context, {
    Jalali? initialStartDate,
    Jalali? initialEndDate,
    String? initialOptionId,
    required void Function(Jalali? start, Jalali? end, String? optionId)
    onApply,
    required VoidCallback onClear,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return FilterDateBottomSheet(
          initialStartDate: initialStartDate,
          initialEndDate: initialEndDate,
          initialOptionId: initialOptionId,
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
  String? _selectedOptionId;

  final List<FilterDateOption> _options = [
    FilterDateOption(
      id: 'today',
      title: 'امروز',
      getDateRange: () => Jalali.now(),
    ),
    FilterDateOption(
      id: 'last_week',
      title: 'هفته گذشته',
      getDateRange: () => Jalali.now().addDays(-7),
    ),
    FilterDateOption(
      id: 'last_month',
      title: 'ماه قبل',
      getDateRange: () => Jalali.now().addMonths(-1),
    ),
    FilterDateOption(
      id: '3_months_ago',
      title: '۳ ماه قبل',
      getDateRange: () => Jalali.now().addMonths(-3),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tempStart = widget.initialStartDate;
    _tempEnd = widget.initialEndDate;
    _selectedOptionId = widget.initialOptionId;
  }

  bool get _hasFilter =>
      _tempStart != null || _tempEnd != null || _selectedOptionId != null;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDragHandle(),
            _buildHeader(context),
            _buildSubtitle(context),
            const SizedBox(height: 16),
            _buildOptionsList(),
            _buildCustomRangeSection(),
            const SizedBox(height: 32),
            _buildActions(context, bottomPadding),
          ],
        ),
      ),
    );
  }

  Widget _buildDragHandle() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        width: 32,
        height: 2,
        decoration: BoxDecoration(
          color: AppColors.brandPalette.shade600,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
      child: Row(
        children: [
          RtcImage(
            image: 'assets/images/filter.svg',
            width: 20,
            height: 20,
            color: AppColors.grayPalette.shade900,
          ),
          const SizedBox(width: 8),
          Text(
            S.current.registrationDate,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.grayPalette.shade900,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          RtcTextButton(
            title: S.current.clearFilter,
            onPressed: () {
              setState(() {
                _tempStart = null;
                _tempEnd = null;
                _selectedOptionId = null;
              });
              widget.onClear();
            },
            styleBtn: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: _hasFilter
                  ? AppColors.errorPalette.shade600
                  : AppColors.grayPalette.shade800,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          "تاریخ مورد نظر را انتخاب کنید",
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: AppColors.grayPalette.shade900,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildOptionsList() {
    return Column(
      children: [
        ..._options.map(
          (option) => FilterOptionItem(
            title: option.title,
            isSelected: _selectedOptionId == option.id,
            onTap: () {
              setState(() {
                _selectedOptionId = option.id;
                _tempStart = option.getDateRange();
                _tempEnd = Jalali.now();
              });
            },
            showDivider: false,
          ),
        ),
        FilterOptionItem(
          title: 'تاریخ دلخواه',
          isSelected: _selectedOptionId == 'custom',
          onTap: () {
            setState(() {
              _selectedOptionId = 'custom';
            });
          },
          showDivider: false,
        ),
      ],
    );
  }

  Widget _buildCustomRangeSection() {
    if (_selectedOptionId != 'custom') return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: SelectDateRangeWidget(
        initialStartDate: _tempStart,
        initialEndDate: _tempEnd,
        onDateRangeChanged: (start, end) {
          setState(() {
            _tempStart = start;
            _tempEnd = end;
          });
        },
      ),
    );
  }

  Widget _buildActions(BuildContext context, double bottomPadding) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = (screenWidth - 52) / 2;

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 16, 20, bottomPadding + 16),
      child: Row(
        spacing: 12,
        children: [
          RtcButton(
            title: S.current.back,
            width: buttonWidth,
            onPressed: () => Navigator.of(context).pop(),
            backgroundColor: Colors.white,
            borderColor: AppColors.grayPalette.shade300,
            styleBtn: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.grayPalette.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
          RtcButton(
            title: S.current.applyFilter,
            width: buttonWidth,
            onPressed: () {
              widget.onApply(_tempStart, _tempEnd, _selectedOptionId);
              Navigator.of(context).pop();
            },
            isActive: _hasFilter,
            styleBtn: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
