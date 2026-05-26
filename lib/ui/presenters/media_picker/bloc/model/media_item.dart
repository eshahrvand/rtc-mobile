import 'dart:io';
import 'dart:typed_data';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_item.freezed.dart';

enum MediaType {
  image,
}

@freezed
class MediaItem with _$MediaItem {
  const factory MediaItem({
    required File file,
    required MediaType type,
    Uint8List? thumbnail,
    String? assetId,
  }) = _MediaItem;
}
