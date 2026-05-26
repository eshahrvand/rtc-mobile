import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_dto_model.freezed.dart';
part 'media_dto_model.g.dart';

@freezed
class MediaDtoModel with _$MediaDtoModel {
  const factory MediaDtoModel({
    required String id,
    required String category,
    @JsonKey(name: 'original_name') required String originalName,
    @JsonKey(name: 'mime_type') required String mimeType,
    @JsonKey(name: 'size_bytes') required int sizeBytes,
    @JsonKey(name: 'uploaded_by_id') String? uploadedById,
    @JsonKey(name: 'is_deleted') required bool isDeleted,
    @JsonKey(name: 'created_at') required String createdAt,
  }) = _MediaDtoModel;

  factory MediaDtoModel.fromJson(Map<String, dynamic> json) => _$MediaDtoModelFromJson(json);
}
