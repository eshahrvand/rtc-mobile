import 'package:cross_file/cross_file.dart';
import '../../data_source/remote/media/media_service.dart';
import '../../data_source/remote/media/model/media_dto_model.dart';

class MediaRepository {
  final MediaService _mediaService;

  MediaRepository(this._mediaService);

  Future<MediaDtoModel> uploadMedia({
    required String category,
    required XFile xFile,
  }) async {
    return await _mediaService.uploadMedia(
      category: category,
      xFile: xFile,
    );
  }
}
