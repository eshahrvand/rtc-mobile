import 'dart:typed_data';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cross_file/cross_file.dart';

part 'media_item.freezed.dart';

enum MediaType {
  image,
  pdf,
}

@freezed
class MediaItem with _$MediaItem {
  const factory MediaItem({
    required XFile xFile,
    required MediaType type,
    Uint8List? thumbnail,
    String? assetId,
    String? fileName,
  }) = _MediaItem;
}
