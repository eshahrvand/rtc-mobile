import 'package:cross_file/cross_file.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import '../../../../generated/l10n.dart';
import '../bloc/model/media_item.dart';

class MediaEditScreen extends StatelessWidget {
  final MediaItem mediaItem;

  const MediaEditScreen({super.key, required this.mediaItem});

  static Future<MediaItem?> crop(BuildContext context, MediaItem item, {bool showOverlay = false}) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: item.xFile.path,
      compressQuality: 80,
      maxWidth: 2000,
      maxHeight: 2000,
      aspectRatio: showOverlay ? const CropAspectRatio(ratioX: 85.6, ratioY: 53.98) : null,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'ویرایش تصویر',
          toolbarWidgetColor: AppColors.grayPalette.shade800,
          toolbarColor: Colors.white,
          hideBottomControls: false,
          lockAspectRatio: showOverlay,
        ),
        IOSUiSettings(title: S.current.editImage),
        WebUiSettings(
          context: context,
          presentStyle: WebPresentStyle.page,
          size: const CropperSize(width: 480, height: 480),
          zoomable: true,
          scalable: true,
          rotatable: true,
          initialAspectRatio: showOverlay ? 85.6 / 53.98 : null,
          translations: WebTranslations(
            title: S.current.editImage,
            rotateLeftTooltip: 'چرخش به چپ',
            rotateRightTooltip: 'چرخش به راست',
            cancelButton: 'انصراف',
            cropButton: 'تایید',
          ),
        ),
      ],
    );

    if (croppedFile != null) {
      return item.copyWith(xFile: XFile(croppedFile.path));
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      extendBody: false,
      extendBodyBehindAppBar: false,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              child: InteractiveViewer(
                child: Center(
                  child: kIsWeb
                      ? Image.network(mediaItem.xFile.path, fit: BoxFit.contain)
                      : Image.file(File(mediaItem.xFile.path), fit: BoxFit.contain),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
