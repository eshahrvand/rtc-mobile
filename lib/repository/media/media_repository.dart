import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path/path.dart' as p;
import 'package:http_parser/http_parser.dart';
import '../../data_source/remote/media/media_service.dart';
import '../../data_source/remote/media/model/media_dto_model.dart';

class MediaRepository {
  final MediaService _mediaService;

  MediaRepository(this._mediaService);

  /// Original logic for Android/iOS
  Future<MediaDtoModel> uploadOrderDocument(File file) async {
    return await _mediaService.uploadMedia(
      category: 'order_document',
      file: file,
    );
  }

  /// New dedicated function for Flutter Web
  Future<MediaDtoModel> uploadOrderDocumentWeb(String blobUrl) async {
    // We use plain Dio here to avoid the File-type limitation of the Retrofit service on Web
    final dio = Dio(BaseOptions(baseUrl: (_mediaService as dynamic).baseUrl ?? ''));
    
    // Fetch bytes from the Blob URL
    final response = await Dio().get(
      blobUrl,
      options: Options(responseType: ResponseType.bytes),
    );

    final List<int> bytes = response.data as List<int>;
    
    String extension = 'jpg';
    MediaType contentType = MediaType('image', 'jpeg');
    
    if (bytes.length > 4 && 
        bytes[0] == 0x25 && bytes[1] == 0x50 && 
        bytes[2] == 0x44 && bytes[3] == 0x46) {
      extension = 'pdf';
      contentType = MediaType('application', 'pdf');
    }

    final filename = 'upload_${DateTime.now().millisecondsSinceEpoch}.$extension';

    final formData = FormData.fromMap({
      'category': 'order_document',
      'file': MultipartFile.fromBytes(
        bytes,
        filename: filename,
        contentType: contentType,
      ),
    });

    final apiResponse = await dio.post('media/files', data: formData);
    return MediaDtoModel.fromJson(apiResponse.data);
  }
}
