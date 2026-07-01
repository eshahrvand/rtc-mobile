import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
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
    emit(
      state.copyWith(
        isLoadingGallery: true,
        currentPage: 0,
        loadedAssetIds: [],
        hasMore: true,
      ),
    );

    try {
      // COMMENT: Explicitly requesting permission using PhotoManager.
      // This should trigger the OS permission dialog.
      print(">> [MEDIA PICKER] Requesting permissions...");
      final PermissionState ps = await PhotoManager.requestPermissionExtend();
      print(">> [MEDIA PICKER] Permission State: $ps");

      if (!ps.isAuth && ps != PermissionState.limited) {
        print(">> [MEDIA PICKER] Permission denied");
        emit(
          state.copyWith(
            error:
                'دسترسی به گالری تایید نشد. لطفا دسترسی را در تنظیمات فعال کنید.',
            isLoadingGallery: false,
          ),
        );
        return;
      }

      print(">> [MEDIA PICKER] Fetching albums...");
      final albums = await PhotoManager.getAssetPathList(
        onlyAll: true,
        type: RequestType.image, // Strictly image
        filterOption: FilterOptionGroup(
          orders: [
            const OrderOption(type: OrderOptionType.createDate, asc: false),
          ],
        ),
      );
      print(">> [MEDIA PICKER] Albums found: ${albums.length}");

      if (albums.isEmpty) {
        print(">> [MEDIA PICKER] No albums found");
        emit(state.copyWith(isLoadingGallery: false, hasMore: false));
        return;
      }

      final album = albums[0];
      print(">> [MEDIA PICKER] Loading assets from album: ${album.name}");
      final newAssets = await album.getAssetListPaged(
        page: 0,
        size: state.pageSize,
      );
      print(">> [MEDIA PICKER] Assets loaded: ${newAssets.length}");

      emit(
        state.copyWith(
          loadedAssetIds: newAssets.map((e) => e.id).toList(),
          isLoadingGallery: false,
          currentPage: 1,
          hasMore: newAssets.length == state.pageSize,
        ),
      );
    } catch (e) {
      print(">> [MEDIA PICKER] ERROR: $e");
      emit(
        state.copyWith(
          error: 'خطا در بارگذاری گالری: $e',
          isLoadingGallery: false,
        ),
      );
    }
  }

  Future<void> loadNextPage() async {
    if (state.isLoadingMore || !state.hasMore) return;
    emit(state.copyWith(isLoadingMore: true));

    try {
      final albums = await PhotoManager.getAssetPathList(
        onlyAll: true,
        type: RequestType.image,
        filterOption: FilterOptionGroup(
          orders: [
            const OrderOption(type: OrderOptionType.createDate, asc: false),
          ],
        ),
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

      emit(
        state.copyWith(
          loadedAssetIds: updated,
          currentPage: page + 1,
          hasMore: newAssets.length == state.pageSize,
          isLoadingMore: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoadingMore: false, error: 'خطا در صفحه بندی: $e'));
    }
  }

  Future<MediaItem?> getMediaFromAsset(AssetEntity asset) async {
    try {
      final file = await asset.file;
      if (file == null) return null;

      Uint8List? thumb = await getThumb(asset);

      return MediaItem(
        file: file,
        type: MediaType.image,
        thumbnail: thumb,
        assetId: asset.id,
      );
    } catch (e) {
      emit(state.copyWith(error: 'خطا در انتخاب فایل: $e'));
      return null;
    }
  }

  void addEditedMedia(MediaItem newMedia) {
    final List<MediaItem> updatedList = state.isMultiSelection
        ? (List<MediaItem>.from(state.selectedMedia)..add(newMedia))
        : [newMedia];

    emit(state.copyWith(selectedMedia: updatedList));

    if (!state.isMultiSelection) {
      confirmSelection(); // Auto-confirm for single selection
    }
  }

  Future<void> addMediaFromAsset(AssetEntity asset) async {
    final media = await getMediaFromAsset(asset);
    if (media != null) {
      addEditedMedia(media);
    }
  }

  void removeMediaByAssetId(String id) {
    final updated = List<MediaItem>.from(state.selectedMedia)
      ..removeWhere((m) => m.assetId == id);
    emit(state.copyWith(selectedMedia: updated));
  }

  Future<MediaItem?> captureFromCamera() async {
    emit(state.copyWith(isOpeningCamera: true));
    try {
      final result = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 2000,
        maxHeight: 2000,
      );
      if (result == null) {
        emit(state.copyWith(isOpeningCamera: false));
        return null;
      }

      final file = File(result.path);
      final newMedia = MediaItem(
        file: file,
        type: MediaType.image,
        thumbnail: await file.readAsBytes(),
      );

      emit(state.copyWith(isOpeningCamera: false));
      return newMedia;
    } catch (e) {
      emit(
        state.copyWith(
          error: 'خطا در باز کردن دوربین: $e',
          isOpeningCamera: false,
        ),
      );
      return null;
    }
  }

  Future<void> pickFromCamera() async {
    final media = await captureFromCamera();
    if (media != null) {
      addEditedMedia(media);
    }
  }

  Future<void> pickFile() async {
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.single.path != null) {
        final file = File(result.files.single.path!);
        final media = MediaItem(file: file, type: MediaType.pdf);
        addEditedMedia(media);
      }
    } catch (e) {
      emit(state.copyWith(error: 'خطا در انتخاب فایل: $e'));
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
