import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_button.dart';
import '../../../widget/rtc_image.dart';
import '../../../widget/rtc_text_button.dart';
import '../../products/widget/filter_bottom_sheet.dart';
import '../../products/widget/filter_option_item.dart';

class SettlementMethodBottomSheet extends StatefulWidget {
  final String? initialSelectedId;
  final ValueChanged<String>? onSelect;

  const SettlementMethodBottomSheet({
    super.key,
    this.initialSelectedId,
    this.onSelect,
  });

  static Future<void> show(
    BuildContext context, {
    String? initialSelectedId,
    ValueChanged<String>? onSelect,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SettlementMethodBottomSheet(
        initialSelectedId: initialSelectedId,
        onSelect: onSelect,
      ),
    );
  }

  @override
  State<SettlementMethodBottomSheet> createState() =>
      _SettlementMethodBottomSheetState();
}

class _SettlementMethodBottomSheetState
    extends State<SettlementMethodBottomSheet> {
  String? _selectedId;

  final List<FilterItem> _methods = [
    FilterItem(id: 'wallet', title: S.current.walletSettlement),
    const FilterItem(id: 'online', title: 'درگاه پرداخت آنلاین'),
    const FilterItem(id: 'cash', title: 'تسویه نقدی (لینک پرداخت)'),
    const FilterItem(id: 'offline', title: 'ثبت فیش واریزی'),
  ];

  @override
  void initState() {
    super.initState();
    _selectedId = widget.initialSelectedId;
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
          color: AppColors.grayPalette.shade300,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: Row(
        children: [
          Text(
            S.current.settlementMethod,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.grayPalette.shade900,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.close, color: AppColors.grayPalette.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _methods.length,
      itemBuilder: (_, index) {
        final item = _methods[index];
        final isSelected = _selectedId == item.id;
        return FilterOptionItem(
          title: item.title,
          isSelected: isSelected,
          onTap: () => setState(() => _selectedId = item.id),
          showDivider: index != _methods.length - 1,
        );
      },
    );
  }

  Widget _buildActions(BuildContext context, double bottomPadding) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 16, 20, bottomPadding + 16),
      child: RtcButton(
        title: 'تایید روش انتخاب شده',
        width: double.infinity,
        onPressed: () {
          if (_selectedId != null) {
            widget.onSelect?.call(_selectedId!);
            Navigator.pop(context);
          }
        },
        isActive: _selectedId != null,
        styleBtn: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
