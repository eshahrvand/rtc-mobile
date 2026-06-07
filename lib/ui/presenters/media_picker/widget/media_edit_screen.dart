import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import '../bloc/model/media_item.dart';

class MediaEditScreen extends StatelessWidget {
  final MediaItem mediaItem;

  const MediaEditScreen({super.key, required this.mediaItem});

  static Future<MediaItem?> crop(BuildContext context, MediaItem item) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: item.file.path,
      compressQuality: 80,
      maxWidth: 2000,
      maxHeight: 2000,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'ویرایش تصویر',
          toolbarWidgetColor: AppColors.grayPalette.shade800,
          toolbarColor: Colors.white,
          hideBottomControls: false,
          lockAspectRatio: false,
        ),
        IOSUiSettings(title: 'ویرایش تصویر'),
      ],
    );

    if (croppedFile != null) {
      return item.copyWith(file: File(croppedFile.path));
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
                  child: Image.file(mediaItem.file, fit: BoxFit.contain),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
