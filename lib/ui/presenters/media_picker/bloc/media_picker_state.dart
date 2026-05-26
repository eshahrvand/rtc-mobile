import 'package:freezed_annotation/freezed_annotation.dart';
import 'model/media_item.dart';

part 'media_picker_state.freezed.dart';

@freezed
class MediaPickerState with _$MediaPickerState {
  const factory MediaPickerState({
    @Default([]) List<MediaItem> selectedMedia,
    String? error,
    @Default(false) bool confirmed,
    @Default(false) bool isLoadingGallery,
    @Default([]) List<String> loadedAssetIds,
    @Default(0) int currentPage,
    @Default(true) bool hasMore,
    @Default(false) bool isLoadingMore,
    @Default(40) int pageSize,
    @Default(false) bool isOpeningCamera,
    @Default(false) bool isMultiSelection,
  }) = _MediaPickerState;
}
