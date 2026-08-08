import 'package:avat_media_picker/avat_media_picker.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'model/media_item.dart';

class MediaPickerBottomSheet {
  MediaPickerBottomSheet._();

  /// Shows the media picker bottom sheet.
  ///
  /// [isMultiSelection] controls if multiple images can be selected from the gallery.
  /// [showCameraOverlay] enables the national card scan mode (rectangular overlay).
  static Future<List<MediaItem>?> show(
    BuildContext context, {
    bool isMultiSelection = false,
    bool showCameraOverlay = true,
  }) async {
    final result = await AvatMediaPicker.pick(
      context,
      config: AvatMediaPickerConfig(
        allowGalleryMultiSelect: isMultiSelection,
        showNationalCardOverlay: showCameraOverlay,
        allowCamera: true,
        allowGallery: true,
        allowPdfOrFile: true,
        allowedFileExtensions: ['pdf'],
        theme: AvatMediaPickerThemeData.fa().copyWith(
          primaryColor: AppColors.brandPalette.shade500,
          scaffoldBackgroundColor: AppColors.grayPalette.shade50,
          surfaceColor: Colors.white,
          textColor: AppColors.grayPalette.shade800,
          mediumShadow: AppColors.mediumShadow,
          fontFamily: 'IranYekan',
        ),
      ),
    );

    if (result is AvatMediaSuccess) {
      return result.files.map((file) {
        return MediaItem(
          xFile: file.path != null
              ? XFile(file.path!)
              : XFile.fromData(file.bytes, name: file.fileName),
          type: file.type == AvatMediaType.pdf ? MediaType.pdf : MediaType.image,
          thumbnail: file.type == AvatMediaType.image ? file.bytes : null,
          fileName: file.fileName,
        );
      }).toList();
    }

    return null;
  }
}
