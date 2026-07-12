import 'dart:io' show File;
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../config/constants.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';

class PreInvoiceStep4UploadPlaceholder extends StatelessWidget {
  final VoidCallback onTap;

  const PreInvoiceStep4UploadPlaceholder({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
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
        child: const PreInvoiceStep4UploadPlaceholderContent(),
      ),
    );
  }
}

class PreInvoiceStep4UploadPlaceholderContent extends StatelessWidget {
  const PreInvoiceStep4UploadPlaceholderContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
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
                style: theme.labelMedium!.copyWith(
                  color: AppColors.brandPalette.shade600,
                ),
              ),
              TextSpan(text: S.current.clickToUpload.split('بارگذاری عکس')[1]),
            ],
            style: theme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.grayPalette.shade700,
            ),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          S.current.uploadFormatInfo,
          style: theme.bodyMedium!.copyWith(
            color: AppColors.grayPalette.shade600,
          ),
        ),
      ],
    );
  }
}

class PreInvoiceStep4UploadBox extends StatelessWidget {
  final String? path;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const PreInvoiceStep4UploadBox({
    super.key,
    this.path,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
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
            ? const PreInvoiceStep4UploadPlaceholderContent()
            : Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: kIsWeb
                        ? Image.network(
                            path!,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const Center(
                                  child: Icon(
                                    Icons.image,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                ),
                          )
                        : Image.file(
                            File(path!),
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.contain,
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
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                        child: GestureDetector(
                          onTap: onRemove,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4, bottom: 4),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: RtcImage(
                                image: "$baseImage/delete_national_card.svg",
                                width: 20,
                                height: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
