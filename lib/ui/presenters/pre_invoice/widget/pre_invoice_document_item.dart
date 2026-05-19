import 'package:flutter/material.dart';
import '../../../../config/config.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_image.dart';

class PreInvoiceDocumentItem extends StatelessWidget {
  final String title;
  final String fileName;
  final String fileSize;
  final VoidCallback onDelete;
  final VoidCallback onView;
  final bool showDeleteButton;

  const PreInvoiceDocumentItem({
    super.key,
    required this.title,
    required this.fileName,
    required this.fileSize,
    required this.onDelete,
    required this.onView,
    this.showDeleteButton = true,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grayPalette.shade200, width: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        spacing: 14,
        children: [
          // Icon on the right (first in RTL Row)
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.brandPalette.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: RtcImage(
              image: '$baseImage/featured-icon.svg',
              width: 32,
              height: 32,
            ),
          ),
          // Text content in the middle
          Expanded(
            child: Column(
              spacing: 3,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.grayPalette.shade900,
                  ),
                ),
                Text(
                  fileName,
                  style: theme.bodyMedium!.copyWith(
                    color: AppColors.grayPalette.shade600,
                  ),
                ),
              ],
            ),
          ),
          // Actions on the left (last in RTL Row)
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                fileSize,
                style: theme.bodyMedium!.copyWith(
                  color: AppColors.grayPalette.shade600,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                spacing: 12,
                children: [
                  if (showDeleteButton)
                    GestureDetector(
                      onTap: onDelete,
                      child: RtcImage(
                        image: '$baseImage/delete.svg',
                        width: 18,
                        height: 18,
                      ),
                    ),
                  GestureDetector(
                    onTap: onView,
                    child: RtcImage(
                      image: '$baseImage/eye-document.svg',
                      width: 18,
                      height: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
