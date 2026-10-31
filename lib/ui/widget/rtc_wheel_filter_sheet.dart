import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../generated/l10n.dart';
import '../theme/colors.dart';
import 'rtc_button.dart';
import 'rtc_image.dart';
import 'rtc_text_button.dart';
import 'rtc_wheel_picker.dart';

class RtcWheelFilterSheet extends StatefulWidget {
  final String title;
  final String subtitle;
  final List<int> values;
  final List<String> labels;
  final int initialValue;
  final bool hasFilter;
  final ValueChanged<int> onApply;
  final VoidCallback onClear;

  const RtcWheelFilterSheet({
    super.key,
    required this.title,
    required this.subtitle,
    required this.values,
    required this.labels,
    required this.initialValue,
    required this.hasFilter,
    required this.onApply,
    required this.onClear,
  }) : assert(values.length == labels.length),
       assert(values.length > 0);

  static void show(
    BuildContext context, {
    required String title,
    required String subtitle,
    required List<int> values,
    required List<String> labels,
    required int initialValue,
    required bool hasFilter,
    required ValueChanged<int> onApply,
    required VoidCallback onClear,
  }) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => RtcWheelFilterSheet(
        title: title,
        subtitle: subtitle,
        values: values,
        labels: labels,
        initialValue: initialValue,
        hasFilter: hasFilter,
        onApply: onApply,
        onClear: onClear,
      ),
    );
  }

  @override
  State<RtcWheelFilterSheet> createState() => _RtcWheelFilterSheetState();
}

class _RtcWheelFilterSheetState extends State<RtcWheelFilterSheet> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    final index = widget.values.indexOf(widget.initialValue);
    _selectedIndex = index < 0 ? 0 : index;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 32,
                  height: 2,
                  decoration: BoxDecoration(
                    color: AppColors.brandPalette.shade600,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
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
                      style: theme.labelLarge?.copyWith(
                        color: AppColors.grayPalette.shade900,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    RtcTextButton(
                      title: S.current.clearFilter,
                      onPressed: () {
                        widget.onClear();
                        context.pop();
                      },
                      styleBtn: theme.bodyMedium?.copyWith(
                        color: widget.hasFilter
                            ? AppColors.errorPalette.shade600
                            : AppColors.grayPalette.shade300,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    widget.subtitle,
                    style: theme.labelLarge?.copyWith(
                      color: AppColors.grayPalette.shade900,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                RtcWheelPicker(
                  items: widget.labels,
                  initialIndex: _selectedIndex,
                  onChanged: (index) => _selectedIndex = index,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: RtcButton(
                        title: S.current.back,
                        onPressed: () => context.pop(),
                        backgroundColor: Colors.white,
                        borderColor: AppColors.grayPalette.shade300,
                        styleBtn: theme.labelLarge?.copyWith(
                          color: AppColors.grayPalette.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: RtcButton(
                        title: S.current.applyFilter,
                        onPressed: () {
                          widget.onApply(widget.values[_selectedIndex]);
                          context.pop();
                        },
                        styleBtn: theme.labelLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
