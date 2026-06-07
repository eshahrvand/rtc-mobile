import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../generated/l10n.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_button.dart';
import '../../../widget/rtc_image.dart';
import '../../../widget/rtc_text_button.dart';
import 'filter_option_item.dart';

class FilterItem {
  final String id;
  final String title;

  const FilterItem({required this.id, required this.title});
}

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

  void _onItemTap(String id) {
    setState(() {
      if (_selectedId == id) {
        _selectedId = null; // Unselect if already selected
      } else {
        _selectedId =
            id; // Select new item (replaces previous in single selection)
      }
    });
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

            _buildSubtitle(context),
            const SizedBox(height: 16),
            _buildItemsList(),
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
            widget.title,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.grayPalette.shade900,
              fontWeight: FontWeight.w600,
            ),
          ),

          const Spacer(),
          RtcTextButton(
            title: S.current.clearFilter,
            onPressed: () {
              _onClear();
              context.pop();
            },
            styleBtn: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: _hasSelection
                  ? AppColors.errorPalette.shade600
                  : AppColors.grayPalette.shade300,
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
          widget.subtitle,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: AppColors.grayPalette.shade900,
            fontWeight: FontWeight.w600,
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
        final isSelected = _selectedId == item.id;
        return FilterOptionItem(
          title: item.title,
          isSelected: isSelected,
          onTap: () => _onItemTap(item.id),
          showDivider: false,
        );
      },
    );
  }

  Widget _buildActions(BuildContext context, double bottomPadding) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Padding 20px each side, gap 12px
    final buttonWidth = (screenWidth - 52) / 2;

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, bottomPadding + 16),
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
            onPressed: _onApply,
            isActive: _hasSelection,
            styleBtn: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.grayPalette.shade300,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
