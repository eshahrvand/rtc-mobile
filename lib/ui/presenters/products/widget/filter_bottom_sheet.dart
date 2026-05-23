import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../../widget/rtc_button.dart' show RtcButton;
import '../../../widget/rtc_divider.dart';
import 'filter_option_item.dart';

/// Data model for each selectable filter option.
class FilterItem {
  final String id;
  final String title;

  const FilterItem({required this.id, required this.title});
}

/// A single-select filter bottom sheet with RTL support.
///
/// Usage:
/// ```dart
/// FilterBottomSheet.show(
///   context,
///   title: 'طرح',
///   subtitle: 'طرح مورد نظر را انتخاب کنید',
///   items: [
///     FilterItem(id: '1', title: 'اسنپ - ۱۲ ماهه'),
///     FilterItem(id: '2', title: 'اسنپ - ۶ ماهه'),
///   ],
///   initialSelectedId: null,
///   onApply: (selectedItem) => print(selectedItem?.title),
///   onClear: () => print('filter cleared'),
/// );
/// ```
class FilterBottomSheet extends StatefulWidget {
  final String title;
  final String subtitle;
  final List<FilterItem> items;
  final String? initialSelectedId;
  final ValueChanged<FilterItem?>? onApply;
  final VoidCallback? onClear;

  const FilterBottomSheet({
    super.key,
    required this.title,
    required this.subtitle,
    required this.items,
    this.initialSelectedId,
    this.onApply,
    this.onClear,
  });

  static Future<void> show(
    BuildContext context, {
    required String title,
    required String subtitle,
    required List<FilterItem> items,
    String? initialSelectedId,
    ValueChanged<FilterItem?>? onApply,
    VoidCallback? onClear,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => FilterBottomSheet(
        title: title,
        subtitle: subtitle,
        items: items,
        initialSelectedId: initialSelectedId,
        onApply: onApply,
        onClear: onClear,
      ),
    );
  }

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String? _selectedId;

  @override
  void initState() {
    super.initState();
    _selectedId = widget.initialSelectedId;
  }

  bool get _hasSelection => _selectedId != null;

  FilterItem? get _selectedItem => _selectedId == null
      ? null
      : widget.items.firstWhere((item) => item.id == _selectedId);

  void _onClear() {
    setState(() => _selectedId = null);
    widget.onClear?.call();
  }

  void _onApply() {
    widget.onApply?.call(_selectedItem);
    Navigator.of(context).pop();
  }

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
            RtcDivider(),
            _buildSubtitle(context),
            _buildItemsList(),
            RtcDivider(),
            _buildActions(context, bottomPadding),
          ],
        ),
      ),
    );
  }

  /// ── Drag handle at top center ──
  Widget _buildDragHandle() {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: AppColors.grayPalette.shade300,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  /// ── Header: [icon + title] ········ [حذف فیلتر] ──
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          // Trailing (left in RTL): clear filter
          GestureDetector(
            onTap: _onClear,
            behavior: HitTestBehavior.opaque,
            child: Text(
              'حذف فیلتر',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.grayPalette.shade500,
              ),
            ),
          ),
          const Spacer(),
          // Leading (right in RTL): title + filter icon
          Text(
            widget.title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.grayPalette.shade900,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.filter_alt_outlined,
            color: Colors.black,
            size: 20,
          ),
        ],
      ),
    );
  }

  /// ── Instruction subtitle ──
  Widget _buildSubtitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          widget.subtitle,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.grayPalette.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  /// ── Scrollable list of FilterOptionItem ──
  Widget _buildItemsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.items.length,
      itemBuilder: (_, index) {
        final item = widget.items[index];
        return FilterOptionItem(
          title: item.title,
          isSelected: _selectedId == item.id,
          onTap: () => setState(() => _selectedId = item.id),
          showDivider: index < widget.items.length - 1,
        );
      },
    );
  }

  Widget _buildActions(BuildContext context, double bottomPadding) {
    final screenWidth = MediaQuery.of(context).size.width;
    // 40px side padding total + 12px gap between buttons → each button ≈ (width - 52) / 2
    final buttonWidth = (screenWidth - 52) / 2;

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 16, 20, bottomPadding + 16),
      child: Row(
        children: [
          RtcButton(
            title: 'بازگشت',
            width: buttonWidth,
            onPressed: () => Navigator.of(context).pop(),
            backgroundColor: Colors.white,
            borderColor: AppColors.grayPalette.shade300,
          ),
          const SizedBox(width: 12),

          RtcButton(
            title: 'اعمال فیلتر',
            width: buttonWidth,
            onPressed: _hasSelection ? _onApply : () {},
            isActive: _hasSelection,
          ),
        ],
      ),
    );
  }
}
