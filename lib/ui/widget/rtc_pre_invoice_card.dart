import 'package:flutter/material.dart';
import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import '../../generated/l10n.dart';
import 'rtc_image.dart';

class RtcPreInvoiceCard extends StatelessWidget {
  final VoidCallback onTap;

  const RtcPreInvoiceCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    var theme = Theme
        .of(context)
        .textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.grayPalette.shade900,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 2,
              spreadRadius: 0,
              color: AppColors.shadowColorTop,
            ),
            BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 3,
              spreadRadius: 0,
              color: AppColors.shadowColorDown,
            ),
          ],
        ),
        child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
            child: Row(
              spacing: 8,
              children: [
            RtcImage(
            image: '$baseImage/asset_report.svg',
              width: 24,
              height: 24,
            ), ¬

            Text(
            S.current.releaseFactor,
            style: theme.labelLarge!.copyWith(color: Colors.white),
      ),
      Spacer(),
      RtcImage(
        image: "$baseImage/angle-left.svg",
        width: 24,
        height: 24,
      ),
      ],
    ),)
    ,
    )
    ,
    );
  }
}
