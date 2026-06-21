import 'package:flutter/material.dart';
import '../../../../config/constants.dart';
import '../../../../core/models/order_model.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_image.dart';
import 'document_viewer_screen.dart';

class OrderDetailsDocumentItem extends StatelessWidget {
  final OrderDocumentModel doc;
  final VoidCallback? onDelete;
  final bool isLocalFile;

  const OrderDetailsDocumentItem({
    super.key,
    required this.doc,
    this.onDelete,
    this.isLocalFile = false,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 14.0),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grayPalette.shade200, width: 0.5),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        spacing: 14.0,
        children: [
          RtcImage(
            image: '$baseImage/featured-icon.svg',
            width: 32.0,
            height: 32.0,
          ),
          Column(
            spacing: 3.0,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doc.title,
                style: theme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.grayPalette.shade900,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                child: Text(
                  doc.fileName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.bodyMedium!.copyWith(
                    color: AppColors.grayPalette.shade600,
                  ),
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
              const SizedBox(height: 4.0),
              if (doc.url != null)
                Row(
                  spacing: 12.0,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DocumentViewerScreen(
                              url: doc.url!,
                              title: doc.title,
                              isLocalFile: isLocalFile,
                            ),
                          ),
                        );
                      },
                      child: RtcImage(
                        image: '$baseImage/eye-document.svg',
                        width: 20.0,
                        height: 20.0,
                      ),
                    ),
                    if (onDelete != null)
                      GestureDetector(
                        onTap: onDelete,
                        child: RtcImage(
                          image: '$baseImage/delete.svg',
                          width: 20.0,
                          height: 20.0,
                          color: AppColors.errorPalette.shade600,
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
