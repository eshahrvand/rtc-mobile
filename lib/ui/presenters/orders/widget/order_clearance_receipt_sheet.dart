import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_button.dart';
import '../../../widget/rtc_divider.dart';
import '../../../widget/rtc_image.dart';

class ReceiptField {
  final String label;
  final dynamic value;

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
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _OrderClearanceReceiptDragHandle(),
            const SizedBox(height: 40.0),
            const RtcImage(
              image: 'assets/images/check_circles_green.svg',
              width: 32.0,
              height: 32.0,
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.grayPalette.shade900,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 4.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  subtitle!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.grayPalette.shade600,
                      ),
                ),
              ),
            ],
            const SizedBox(height: 24.0),
            _OrderClearanceReceiptFieldsList(fields: fields),
            const SizedBox(height: 32.0),
            _OrderClearanceReceiptAction(
              bottomPadding: bottomPadding,
              onGotIt: onGotIt,
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderClearanceReceiptDragHandle extends StatelessWidget {
  const _OrderClearanceReceiptDragHandle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Container(
        width: 33.0,
        height: 2.0,
        decoration: BoxDecoration(color: AppColors.brandPalette.shade600),
      ),
    );
  }
}

class _OrderClearanceReceiptFieldsList extends StatelessWidget {
  final List<ReceiptField> fields;

  const _OrderClearanceReceiptFieldsList({required this.fields});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      itemCount: fields.length,
      separatorBuilder: (_, __) => RtcDivider(
        height: 0.5,
        isDashed: false,
        color: AppColors.grayPalette.shade200,
      ),
      itemBuilder: (_, index) {
        final field = fields[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                field.label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.grayPalette.shade600,
                    ),
              ),
              if (field.value is String)
                Text(
                  field.value,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.grayPalette.shade900,
                        fontWeight: FontWeight.w600,
                      ),
                )
              else if (field.value is Widget)
                field.value,
            ],
          ),
        );
      },
    );
  }
}

class _OrderClearanceReceiptAction extends StatelessWidget {
  final double bottomPadding;
  final VoidCallback onGotIt;

  const _OrderClearanceReceiptAction({
    required this.bottomPadding,
    required this.onGotIt,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.fromLTRB(20.0, 16.0, 20.0, bottomPadding + 16.0),
      child: RtcButton(
        title: S.current.gotItButton,
        styleBtn: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
        onPressed: () {
          Navigator.of(context).pop();
          onGotIt();
        },
        width: double.infinity,
      ),
    );
  }
}
