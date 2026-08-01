import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/models/filter_item.dart';
import '../../../../generated/l10n.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_button.dart';
import '../../../widget/rtc_image.dart';
import '../../../widget/rtc_text_button.dart';
import 'filter_option_item.dart';

class FilterBottomSheet extends StatefulWidget {
  final String title;
  final String subtitle;
  final List<FilterItem> items;
  final String? initialSelectedId;
  final List<String>? initialSelectedIds;
  final bool isMultiSelect;
  final ValueChanged<FilterItem?>? onApply;
  final ValueChanged<List<FilterItem>>? onApplyMulti;
  final VoidCallback? onClear;
  final VoidCallback? onLoadMore;
  final bool isLoadingMore;
  final String? iconPath;
  final String? clearButtonTitle;

  const FilterBottomSheet({
    super.key,
    required this.title,
    required this.subtitle,
    required this.items,
    this.initialSelectedId,
    this.initialSelectedIds,
    this.isMultiSelect = false,
    this.onApply,
    this.onApplyMulti,
    this.onClear,
    this.onLoadMore,
    this.isLoadingMore = false,
    this.iconPath,
    this.clearButtonTitle,
  });

  static Future<void> show<B extends StateStreamableSource<STATE>, STATE>(
    BuildContext context, {
    required String title,
    required String subtitle,
    required List<FilterItem> items,
    B? bloc,
    List<FilterItem> Function(STATE)? itemsSelector,
    bool Function(STATE)? loadingSelector,
    String? initialSelectedId,
    List<String>? initialSelectedIds,
    bool isMultiSelect = false,
    ValueChanged<FilterItem?>? onApply,
    ValueChanged<List<FilterItem>>? onApplyMulti,
    VoidCallback? onClear,
    VoidCallback? onLoadMore,
    bool isLoadingMore = false,
    String? iconPath,
    String? clearButtonTitle,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        final content = FilterBottomSheet(
          title: title,
          subtitle: subtitle,
          items: items,
          initialSelectedId: initialSelectedId,
          initialSelectedIds: initialSelectedIds,
          isMultiSelect: isMultiSelect,
          onApply: onApply,
          onApplyMulti: onApplyMulti,
          onClear: onClear,
          onLoadMore: onLoadMore,
          isLoadingMore: isLoadingMore,
          iconPath: iconPath,
          clearButtonTitle: clearButtonTitle,
        );

        if (bloc != null && itemsSelector != null) {
          return BlocProvider.value(
            value: bloc,
            child: BlocBuilder<B, STATE>(
              builder: (context, state) {
                return FilterBottomSheet(
                  title: title,
                  subtitle: subtitle,
                  items: itemsSelector(state),
                  initialSelectedId: initialSelectedId,
                  initialSelectedIds: initialSelectedIds,
                  isMultiSelect: isMultiSelect,
                  onApply: onApply,
                  onApplyMulti: onApplyMulti,
                  onClear: onClear,
                  onLoadMore: onLoadMore,
                  isLoadingMore: loadingSelector?.call(state) ?? isLoadingMore,
                  iconPath: iconPath,
                  clearButtonTitle: clearButtonTitle,
                );
              },
            ),
          );
        }

        return content;
      },
    );
  }

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String? _selectedId;
  late List<String> _selectedIds;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _selectedId = widget.initialSelectedId;
    _selectedIds = List.from(widget.initialSelectedIds ?? []);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (widget.onLoadMore != null &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.8) {
      widget.onLoadMore?.call();
    }
  }

  bool get _hasSelection =>
      widget.isMultiSelect ? _selectedIds.isNotEmpty : _selectedId != null;

  FilterItem? get _selectedItem => _selectedId == null
      ? null
      : widget.items.firstWhere((item) => item.id == _selectedId);

  List<FilterItem> get _selectedItems =>
      widget.items.where((item) => _selectedIds.contains(item.id)).toList();

  void _onClear() {
    setState(() {
      _selectedId = null;
      _selectedIds.clear();
    });
    widget.onClear?.call();
  }

  void _onApply() {
    if (widget.isMultiSelect) {
      widget.onApplyMulti?.call(_selectedItems);
    } else {
      widget.onApply?.call(_selectedItem);
    }
    Navigator.of(context).pop();
  }

  void _onItemTap(String id) {
    setState(() {
      if (widget.isMultiSelect) {
        if (_selectedIds.contains(id)) {
          _selectedIds.remove(id);
        } else {
          _selectedIds.add(id);
        }
      } else {
        if (_selectedId == id) {
          _selectedId = null; // Unselect if already selected
        } else {
          _selectedId =
              id; // Select new item (replaces previous in single selection)
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
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
            Flexible(child: _buildItemsList()),

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
            image: widget.iconPath ?? 'assets/images/filter.svg',
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
            title: widget.clearButtonTitle ?? S.current.clearFilter,
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
      controller: _scrollController,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: widget.items.length + (widget.isLoadingMore ? 1 : 0),
      itemBuilder: (_, index) {
        if (index == widget.items.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          );
        }

        final item = widget.items[index];
        final isSelected = widget.isMultiSelect
            ? _selectedIds.contains(item.id)
            : _selectedId == item.id;
        return FilterOptionItem(
          title: item.title,
          isSelected: isSelected,
          isMultiSelect: widget.isMultiSelect,
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
            onPressed: _onApply,
            isActive: _hasSelection,
            styleBtn: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: _hasSelection
                  ? Colors.white
                  : AppColors.grayPalette.shade300,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
