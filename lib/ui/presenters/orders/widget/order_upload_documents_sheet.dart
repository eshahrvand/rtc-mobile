import 'package:flutter/material.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';
import '../../../../config/config.dart';
import '../../../../data/models/order_model.dart';
import '../../../theme/colors.dart';
import '../../../widget/rtc_button.dart';
import 'order_details_document_item.dart';

class OrderUploadDocumentsSheet extends StatelessWidget {
  final VoidCallback onConfirm;

  const OrderUploadDocumentsSheet({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 33,
              height: 2,
              decoration: BoxDecoration(color: AppColors.brandPalette.shade600),
            ),
          ),
          const SizedBox(height: 8),

          // Header
          Row(
            children: [
              Text(
                S.current.clearanceDocumentsTitle,
                style: theme.labelLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.grayPalette.shade900,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: RtcImage(
                  image: "$baseImage/close.svg",
                  width: 20,
                  height: 20,
                  color: AppColors.grayPalette.shade700,
                  boxFit: BoxFit.fill,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 24),

          // Instruction Text
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              S.current.uploadClearanceInstruction,
              style: theme.bodyLarge!.copyWith(
                color: AppColors.grayPalette.shade900,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // File Card
          OrderDetailsDocumentItem(
            doc: OrderDocumentModel(
              title: S.current.paymentDocuments,
              fileName: 'national_card_front',
              fileSize: '۱۶ MB',
              iconPath: '$baseImage/featured-icon.svg',
            ),
          ),
          const SizedBox(height: 32),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: RtcButton(
                  title: S.current.confirmAndSend,
                  styleBtn: theme.labelLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  onPressed: onConfirm,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: RtcButton(
                  title: S.current.cancel,
                  backgroundColor: Colors.white,
                  borderColor: AppColors.grayPalette.shade300,
                  styleBtn: theme.labelLarge!.copyWith(
                    color: AppColors.grayPalette.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
