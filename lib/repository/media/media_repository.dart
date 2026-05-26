import 'dart:io';
import '../../data_source/remote/media/media_service.dart';
import '../../data_source/remote/media/model/media_dto_model.dart';

class MediaRepository {
  final MediaService _mediaService;

  MediaRepository(this._mediaService);

  Future<MediaDtoModel> uploadOrderDocument(File file) async {
    return await _mediaService.uploadMedia(
      category: 'order_document',
      file: file,
    );
  }
}
