import 'dart:io';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'model/media_dto_model.dart';

part 'media_service.g.dart';

@RestApi()
abstract class MediaService {
  factory MediaService(Dio dio, {String baseUrl}) = _MediaService;

  @POST('media/files')
  @MultiPart()
  Future<MediaDtoModel> uploadMedia({
    @Part(name: 'category') required String category,
    @Part(name: 'file') required File file,
  });
}
