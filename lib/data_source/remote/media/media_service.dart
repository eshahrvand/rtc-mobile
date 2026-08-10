import 'package:cross_file/cross_file.dart';
import 'package:dio/dio.dart' as dio;
import 'model/media_dto_model.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class MediaService {
  final dio.Dio _dio;

  MediaService(this._dio);

  /// Uploads a file to the server.
  /// 
  /// The [xFile] name is preserved if present, otherwise a defensive fallback
  /// name is generated based on the mime type to ensure server compatibility.
  Future<MediaDtoModel> uploadMedia({
    required String category,
    required XFile xFile,
  }) async {
    final formData = dio.FormData();
    formData.fields.add(MapEntry('category', category));

    final filename = _getSafeFileName(xFile);
    final filePart = await _createMultipartFile(xFile, filename);
    
    formData.files.add(MapEntry('file', filePart));

    final response = await _dio.post(
      'media/files',
      data: formData,
    );

    return MediaDtoModel.fromJson(response.data);
  }

  /// Creates a [dio.MultipartFile] from the given [xFile] and [filename].
  /// 
  /// Uses [fromBytes] for Web to handle Blob URLs correctly, 
  /// and [fromFile] for Mobile to benefit from streaming large files.
  Future<dio.MultipartFile> _createMultipartFile(XFile xFile, String filename) async {
    if (kIsWeb || xFile.path.isEmpty) {
      final bytes = await xFile.readAsBytes();
      return dio.MultipartFile.fromBytes(
        bytes,
        filename: filename,
      );
    } else {
      return await dio.MultipartFile.fromFile(
        xFile.path,
        filename: filename,
      );
    }
  }

  /// Returns a safe filename for the given [xFile].
  /// 
  /// This is a defensive fallback to ensure the multipart request has a 
  /// non-empty 'filename', which is required by many servers (like Django).
  String _getSafeFileName(XFile xFile) {
    if (xFile.name.isNotEmpty) {
      return xFile.name;
    }
    
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final extension = _extensionFromMime(xFile.mimeType);
    return 'upload_$timestamp$extension';
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
