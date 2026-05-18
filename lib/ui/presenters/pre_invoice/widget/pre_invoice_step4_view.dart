import 'dart:io';

import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';
import 'package:rtc_mobile/ui/widget/rtc_text_button.dart';
import '../bloc/pre_invoice_cubit.dart';
import '../bloc/pre_invoice_state.dart';
import 'pre_invoice_document_item.dart';

class PreInvoiceStep4View extends StatelessWidget {
  const PreInvoiceStep4View({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return BlocBuilder<PreInvoiceCubit, PreInvoiceState>(
      builder: (context, state) {
        final cubit = context.read<PreInvoiceCubit>();

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.current.mandatoryDocument,
                      style: theme.labelLarge!.copyWith(
                        color: AppColors.grayPalette.shade900,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      S.current.nationalCardFront,
                      style: theme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.grayPalette.shade700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    _buildUploadBox(
                      context,
                      path: state.mandatoryDocPath,
                      onTap: () => cubit.pickMandatoryDoc(),
                      onRemove: () => cubit.removeMandatoryDoc(),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.current.optionalDocuments,
                          style: theme.labelLarge!.copyWith(
                            color: AppColors.grayPalette.shade900,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (state.optionalDocPaths.isNotEmpty)
                          RtcTextButton(
                            onPressed: () => cubit.pickOptionalDoc(),
                            title: S.current.add,
                            leftIcon: "$baseImage/plus.svg",
                            leftIconColor: AppColors.brandPalette.shade600,
                            styleBtn: theme.labelLarge!.copyWith(
                              color: AppColors.brandPalette.shade600,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        else
                          const SizedBox.shrink(),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ...state.optionalDocPaths.asMap().entries.map((entry) {
                      int index = entry.key;
                      String path = entry.value;
                      return PreInvoiceDocumentItem(
                        title: S.current.otherDocumentsLabel(index + 1),
                        fileName: path.split('/').last,
                        fileSize: '۱۶ MB',
                        // Mock size as in screenshot
                        onDelete: () => cubit.removeOptionalDoc(index),
                        onView: () {
                          // View logic if needed
                        },
                      );
                    }),
                    if (state.optionalDocPaths.isEmpty)
                      _buildUploadPlaceholder(
                        context,
                        onTap: () => cubit.pickOptionalDoc(),
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildUploadPlaceholder(
    BuildContext context, {
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 140,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.grayPalette.shade25,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.grayPalette.shade200, width: 1),
        ),
        child: Column(
          children: [
            const SizedBox(height: 14),
            RtcImage(
              image: "$baseImage/featured-icon.svg",
              width: 32,
              height: 32,
            ),
            const SizedBox(height: 12),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: S.current.clickToUpload.split('بارگذاری عکس')[0],
                  ),
                  TextSpan(
                    text: 'بارگذاری عکس ',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: AppColors.brandPalette.shade600,
                    ),
                  ),
                  TextSpan(
                    text: S.current.clickToUpload.split('بارگذاری عکس')[1],
                  ),
                ],
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.grayPalette.shade700,
                ),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              S.current.uploadFormatInfo,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.grayPalette.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadBox(
    BuildContext context, {
    String? path,
    required VoidCallback onTap,
    required VoidCallback onRemove,
  }) {
    return GestureDetector(
      onTap: path == null ? onTap : null,
      child: Container(
        height: 140,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.grayPalette.shade25,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.grayPalette.shade200, width: 1),
        ),
        child: path == null
            ? _buildUploadPlaceholderContent(context)
            : Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(path),
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(
                            child: Icon(
                              Icons.image,
                              size: 50,
                              color: Colors.grey,
                            ),
                          ),
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    left: 4,
                    child: GestureDetector(
                      onTap: onRemove,
                      child: RtcImage(
                        image: "$baseImage/delete-image.svg",
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildUploadPlaceholderContent(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 14),
        RtcImage(image: "$baseImage/featured-icon.svg", width: 32, height: 32),
        const SizedBox(height: 12),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: S.current.clickToUpload.split('بارگذاری عکس')[0]),
              TextSpan(
                text: 'بارگذاری عکس ',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: AppColors.brandPalette.shade600,
                ),
              ),
              TextSpan(text: S.current.clickToUpload.split('بارگذاری عکس')[1]),
            ],
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.grayPalette.shade700,
            ),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          S.current.uploadFormatInfo,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.grayPalette.shade600,
          ),
        ),
      ],
    );
  }
}
