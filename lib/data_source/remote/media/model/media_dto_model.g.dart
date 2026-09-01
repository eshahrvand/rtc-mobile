// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_dto_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MediaDtoModelImpl _$$MediaDtoModelImplFromJson(Map<String, dynamic> json) =>
    _$MediaDtoModelImpl(
      id: json['id'] as String,
      category: json['category'] as String,
      originalName: json['original_name'] as String,
      mimeType: json['mime_type'] as String,
      sizeBytes: (json['size_bytes'] as num).toInt(),
      uploadedById: json['uploaded_by_id'] as String?,
      isDeleted: json['is_deleted'] as bool,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$$MediaDtoModelImplToJson(_$MediaDtoModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'original_name': instance.originalName,
      'mime_type': instance.mimeType,
      'size_bytes': instance.sizeBytes,
      'uploaded_by_id': instance.uploadedById,
      'is_deleted': instance.isDeleted,
      'created_at': instance.createdAt,
    };
