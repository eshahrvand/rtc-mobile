import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'media_picker_state.dart';
import 'model/media_item.dart';

class MediaPickerCubit extends Cubit<MediaPickerState> {
  final bool isMultiSelection;

  MediaPickerCubit({this.isMultiSelection = false})
      : super(MediaPickerState(isMultiSelection: isMultiSelection));

  final ImagePicker _picker = ImagePicker();
  final Map<String, Uint8List?> _thumbCache = {};

  Future<Uint8List?> getThumb(AssetEntity asset) async {
    if (_thumbCache.containsKey(asset.id)) {
      return _thumbCache[asset.id];
    }
    final thumb = await asset.thumbnailDataWithSize(
      const ThumbnailSize(300, 300),
    );
    _thumbCache[asset.id] = thumb;
    return thumb;
  }

  Future<void> loadInitialGallery() async {
    emit(state.copyWith(
      isLoadingGallery: true,
      currentPage: 0,
      loadedAssetIds: [],
      hasMore: true,
    ));

    try {
      final PermissionState ps = await PhotoManager.requestPermissionExtend();
      if (!ps.isAuth) {
        emit(state.copyWith(
          error: 'دسترسی به گالری رد شد',
          isLoadingGallery: false,
        ));
        return;
      }

      final albums = await PhotoManager.getAssetPathList(
        onlyAll: true,
        type: RequestType.image, // Strictly image
      );

      if (albums.isEmpty) {
        emit(state.copyWith(isLoadingGallery: false, hasMore: false));
        return;
      }

      final album = albums[0];
      final newAssets = await album.getAssetListPaged(
        page: 0,
        size: state.pageSize,
      );

      emit(state.copyWith(
        loadedAssetIds: newAssets.map((e) => e.id).toList(),
        isLoadingGallery: false,
        currentPage: 1,
        hasMore: newAssets.length == state.pageSize,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: 'خطا در بارگذاری گالری: $e',
        isLoadingGallery: false,
      ));
    }
  }

  Future<void> loadNextPage() async {
    if (state.isLoadingMore || !state.hasMore) return;
    emit(state.copyWith(isLoadingMore: true));

    try {
      final albums = await PhotoManager.getAssetPathList(
        onlyAll: true,
        type: RequestType.image,
      );
      if (albums.isEmpty) {
        emit(state.copyWith(isLoadingMore: false));
        return;
      }

      final album = albums[0];
      final page = state.currentPage;
      final newAssets = await album.getAssetListPaged(
        page: page,
        size: state.pageSize,
      );

      final updated = List<String>.from(state.loadedAssetIds)
        ..addAll(newAssets.map((e) => e.id));

      emit(state.copyWith(
        loadedAssetIds: updated,
        currentPage: page + 1,
        hasMore: newAssets.length == state.pageSize,
        isLoadingMore: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoadingMore: false, error: 'خطا در صفحه بندی: $e'));
    }
  }

  Future<void> addMediaFromAsset(AssetEntity asset) async {
    try {
      final file = await asset.file;
      if (file == null) return;

      Uint8List? thumb = await getThumb(asset);

      final newMedia = MediaItem(
        file: file,
        type: MediaType.image,
        thumbnail: thumb,
        assetId: asset.id,
      );

      final List<MediaItem> updatedList = state.isMultiSelection
          ? (List<MediaItem>.from(state.selectedMedia)..add(newMedia))
          : [newMedia];

      emit(state.copyWith(selectedMedia: updatedList));
      
      if (!state.isMultiSelection) {
        confirmSelection(); // Auto-confirm for single selection
      }
    } catch (e) {
      emit(state.copyWith(error: 'خطا در انتخاب فایل: $e'));
    }
  }

  void removeMediaByAssetId(String id) {
    final updated = List<MediaItem>.from(state.selectedMedia)
      ..removeWhere((m) => m.assetId == id);
    emit(state.copyWith(selectedMedia: updated));
  }

  Future<void> pickFromCamera() async {
    emit(state.copyWith(isOpeningCamera: true));
    try {
      final result = await _picker.pickImage(source: ImageSource.camera);
      if (result == null) {
        emit(state.copyWith(isOpeningCamera: false));
        return;
      }

      final file = File(result.path);
      final newMedia = MediaItem(
        file: file,
        type: MediaType.image,
        thumbnail: await file.readAsBytes(),
      );

      final List<MediaItem> updatedList = state.isMultiSelection
          ? (List<MediaItem>.from(state.selectedMedia)..add(newMedia))
          : [newMedia];

      emit(state.copyWith(
        selectedMedia: updatedList,
        isOpeningCamera: false,
      ));

      if (!state.isMultiSelection) {
        confirmSelection();
      }
    } catch (e) {
      emit(state.copyWith(
        error: 'خطا در باز کردن دوربین: $e',
        isOpeningCamera: false,
      ));
    }
  }

  void confirmSelection() {
    if (state.selectedMedia.isEmpty) return;
    emit(state.copyWith(confirmed: true));
  }

  void reset() {
    emit(MediaPickerState(isMultiSelection: isMultiSelection));
  }
}
