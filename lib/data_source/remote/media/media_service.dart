import 'package:cross_file/cross_file.dart';
import 'package:dio/dio.dart' as dio;
import 'model/media_dto_model.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class MediaService {
  final dio.Dio _dio;

  MediaService(this._dio);

  Future<MediaDtoModel> uploadMedia({
    required String category,
    required XFile xFile,
  }) async {
    final formData = dio.FormData();
    formData.fields.add(MapEntry('category', category));

    final safeName = xFile.name.isNotEmpty
        ? xFile.name
        : 'upload_${DateTime.now().millisecondsSinceEpoch}${_extensionFromMime(xFile.mimeType)}';

    if (kIsWeb) {
      final bytes = await xFile.readAsBytes();
      formData.files.add(MapEntry(
        'file',
        dio.MultipartFile.fromBytes(
          bytes,
          filename: safeName,
        ),
      ));
    } else {
      formData.files.add(MapEntry(
        'file',
        await dio.MultipartFile.fromFile(
          xFile.path,
          filename: safeName,
        ),
      ));
    }

    final response = await _dio.post(
      'media/files',
      data: formData,
    );

    return MediaDtoModel.fromJson(response.data);
  }

  String _extensionFromMime(String? mime) {
    switch (mime) {
      case 'image/png':
        return '.png';
      case 'image/jpeg':
        return '.jpg';
      case 'application/pdf':
        return '.pdf';
      default:
        return '';
    }
  }
}
