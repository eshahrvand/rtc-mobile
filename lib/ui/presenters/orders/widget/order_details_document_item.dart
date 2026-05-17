import 'package:flutter/material.dart';
import '../../../../config/config.dart';
import '../../../../data/models/order_model.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_image.dart';

class OrderDetailsDocumentItem extends StatelessWidget {
  final OrderDocumentModel doc;

  const OrderDetailsDocumentItem({super.key, required this.doc});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grayPalette.shade200, width: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        spacing: 14,
        children: [
          RtcImage(
            image: '$baseImage/featured-icon.svg',
            width: 32,
            height: 32,
          ),
          Column(
            spacing: 3,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doc.title,
                style: theme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.grayPalette.shade900,
                ),
              ),
              Text(
                doc.fileName,
                style: theme.bodyMedium!.copyWith(
                  color: AppColors.grayPalette.shade600,
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                doc.fileSize,
                style: theme.bodyMedium!.copyWith(
                  color: AppColors.grayPalette.shade600,
                ),
              ),
              const SizedBox(height: 4),
              RtcImage(
                image: '$baseImage/eye-document.svg',
                width: 20,
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
