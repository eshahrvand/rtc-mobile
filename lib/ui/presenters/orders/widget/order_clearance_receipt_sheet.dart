import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_button.dart';
import '../../../widget/rtc_divider.dart';
import '../../../widget/rtc_image.dart';

class ReceiptField {
  final String label;
  final String value;

  ReceiptField({required this.label, required this.value});
}

class OrderClearanceReceiptSheet extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<ReceiptField> fields;
  final VoidCallback onGotIt;

  const OrderClearanceReceiptSheet({
    super.key,
    required this.title,
    this.subtitle,
    required this.fields,
    required this.onGotIt,
  });

  static Future<void> show(
    BuildContext context, {
    required String title,
    String? subtitle,
    required List<ReceiptField> fields,
    required VoidCallback onGotIt,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => OrderClearanceReceiptSheet(
        title: title,
        subtitle: subtitle,
        fields: fields,
        onGotIt: onGotIt,
      ),
    );
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
            const SizedBox(height: 32),
            const RtcImage(
              image: 'assets/images/check_circles_green.svg',
              width: 44,
              height: 44,
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.grayPalette.shade900,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  subtitle!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.grayPalette.shade600,
                      ),
                ),
              ),
            ],
            const SizedBox(height: 32),
            _buildFieldsList(context),
            const SizedBox(height: 32),
            _buildAction(context, bottomPadding),
          ],
        ),
      ),
    );
  }

  Widget _buildDragHandle() {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Container(
        width: 33,
        height: 2,
        decoration: BoxDecoration(
          color: AppColors.brandPalette.shade600,
        ),
      ),
    );
  }

  Widget _buildFieldsList(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: fields.length,
      separatorBuilder: (_, __) => const RtcDivider(height: 1, isDashed: false),
      itemBuilder: (_, index) {
        final field = fields[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                field.label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.grayPalette.shade600,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              Text(
                field.value,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.grayPalette.shade900,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAction(BuildContext context, double bottomPadding) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 16, 20, bottomPadding + 16),
      child: RtcButton(
        title: S.current.gotItButton,
        onPressed: () {
          Navigator.of(context).pop();
          onGotIt();
        },
        width: double.infinity,
      ),
    );
  }
}
