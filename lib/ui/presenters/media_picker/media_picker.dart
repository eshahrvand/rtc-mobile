import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import '../../../../config/constants.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';

import 'bloc/media_picker_cubit.dart';
import 'bloc/media_picker_state.dart';
import 'bloc/model/media_item.dart';
import 'package:rtc_mobile/config/snackbar.dart';
import 'widget/media_edit_screen.dart';
import 'package:rtc_mobile/ui/presenters/media_picker/widget/rtc_camera_screen.dart';

class MediaPickerBottomSheet extends StatefulWidget {
  final bool isMultiSelection;
  final bool showCameraOverlay;

  const MediaPickerBottomSheet({
    super.key,
    this.isMultiSelection = false,
    this.showCameraOverlay = true,
  });

  static Future<List<MediaItem>?> show(
    BuildContext context, {
    bool isMultiSelection = false,
    bool showCameraOverlay = true,
  }) {
    return showModalBottomSheet<List<MediaItem>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocProvider(
        create: (context) =>
            MediaPickerCubit(isMultiSelection: isMultiSelection),
        child: MediaPickerBottomSheet(
          isMultiSelection: isMultiSelection,
          showCameraOverlay: showCameraOverlay,
        ),
      ),
    );
  }

  @override
  State<MediaPickerBottomSheet> createState() => _MediaPickerBottomSheetState();
}

class _MediaPickerBottomSheetState extends State<MediaPickerBottomSheet> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<MediaPickerCubit>().loadInitialGallery();

    _scrollController.addListener(() {
      final cubit = context.read<MediaPickerCubit>();
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 300) {
        cubit.loadNextPage();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MediaPickerCubit, MediaPickerState>(
      listenWhen: (prev, curr) =>
          prev.error != curr.error || prev.confirmed != curr.confirmed,
      listener: (context, state) {
        if (state.confirmed) {
          Navigator.of(context).pop(state.selectedMedia);
        }
        if (state.error != null) {
          rtcSnackBar(
            context: context,
            type: SnackBarType.error,
            message: state.error!,
          );
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Container(
            height: kIsWeb
                ? (widget.isMultiSelection && state.selectedMedia.isNotEmpty
                      ? 400
                      : 340)
                : MediaQuery.of(context).size.height * 0.85,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                _buildHeader(context),
                Expanded(child: _buildGallery(context, state)),
                if (widget.isMultiSelection && state.selectedMedia.isNotEmpty)
                  _buildConfirmFooter(state),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Column(
        children: [
          Container(
            width: 32,
            height: 2,
            decoration: BoxDecoration(
              color: AppColors.brandPalette.shade600,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  S.current.uploadDocuments,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.grayPalette.shade900,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: RtcImage(
                  image: "$baseImage/close.svg",
                  width: 24,
                  height: 24,
                  color: AppColors.grayPalette.shade700,
                  boxFit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGallery(BuildContext context, MediaPickerState state) {
    if (state.isLoadingGallery && state.loadedAssetIds.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(4),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: state.loadedAssetIds.length + (kIsWeb ? 3 : 2),
      itemBuilder: (context, index) {
        if (kIsWeb) {
          // Web: Camera (0), Gallery (1), File (2)
          if (index == 0) return _buildCameraItem(context);
          if (index == 1) return _buildWebGalleryItem(context);
          if (index == 2) return _buildFileItem(context);
        } else {
          // Mobile: Camera (0), File (1)
          if (index == 0) return _buildCameraItem(context);
          if (index == 1) return _buildFileItem(context);
        }

        final assetId = state.loadedAssetIds[index - (kIsWeb ? 3 : 2)];
        return KeyedSubtree(
          key: ValueKey(assetId),
          child: FutureBuilder<AssetEntity?>(
            future: AssetEntity.fromId(assetId),
            builder: (context, snapshot) {
              final asset = snapshot.data;
              if (asset == null) {
                return Container(color: AppColors.grayPalette.shade100);
              }
              return _buildAssetItem(context, asset, state);
            },
          ),
        );
      },
    );
  }

  Widget _buildWebGalleryItem(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<MediaPickerCubit>().pickFromGalleryWeb(
        context,
        widget.showCameraOverlay,
      ),
      child: Container(
        color: AppColors.grayPalette.shade100,
        child: Icon(
          Icons.photo_library,
          size: 32,
          color: AppColors.grayPalette.shade600,
        ),
      ),
    );
  }

  void _handleCameraTap(BuildContext context) async {
    final cubit = context.read<MediaPickerCubit>();
    final File? croppedFile = await RtcCameraScreen.open(
      context,
      showOverlay: widget.showCameraOverlay,
    );
    if (croppedFile != null && context.mounted) {
      final media = MediaItem(
        file: croppedFile,
        type: MediaType.image,
        thumbnail: kIsWeb ? null : await croppedFile.readAsBytes(),
        fileName: croppedFile.path.split('/').last,
      );
      cubit.addEditedMedia(media);
    }
  }

  Widget _buildFileItem(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<MediaPickerCubit>().pickFile(),
      child: Container(
        color: AppColors.grayPalette.shade100,
        child: Icon(
          Icons.attach_file,
          size: 32,
          color: AppColors.grayPalette.shade600,
        ),
      ),
    );
  }

  Widget _buildCameraItem(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleCameraTap(context),
      child: Container(
        color: AppColors.grayPalette.shade100,
        child: Icon(
          Icons.camera_alt,
          size: 32,
          color: AppColors.grayPalette.shade600,
        ),
      ),
    );
  }

  Widget _buildAssetItem(
    BuildContext context,
    AssetEntity asset,
    MediaPickerState state,
  ) {
    final isSelected = state.selectedMedia.any((m) => m.assetId == asset.id);

    return Stack(
      fit: StackFit.expand,
      children: [
        GestureDetector(
          onTap: () async {
            final cubit = context.read<MediaPickerCubit>();
            final media = await cubit.getMediaFromAsset(asset);
            if (media != null && context.mounted) {
              final edited = await MediaEditScreen.crop(
                context,
                media,
                showOverlay: widget.showCameraOverlay,
              );
              if (edited != null) {
                cubit.addEditedMedia(edited);
              }
            }
          },
          child: FutureBuilder<Uint8List?>(
            future: context.read<MediaPickerCubit>().getThumb(asset),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Image.memory(snapshot.data!, fit: BoxFit.cover);
              }
              return Container(color: AppColors.grayPalette.shade100);
            },
          ),
        ),
        if (widget.isMultiSelection)
          Positioned(
            right: 8,
            top: 8,
            child: GestureDetector(
              onTap: () async {
                final cubit = context.read<MediaPickerCubit>();
                if (isSelected) {
                  cubit.removeMediaByAssetId(asset.id);
                } else {
                  final media = await cubit.getMediaFromAsset(asset);
                  if (media != null && context.mounted) {
                    final edited = await MediaEditScreen.crop(
                      context,
                      media,
                      showOverlay: widget.showCameraOverlay,
                    );
                    if (edited != null) {
                      cubit.addEditedMedia(edited);
                    }
                  }
                }
              },
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.brandPalette.shade600
                      : Colors.black26,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
                child: isSelected
                    ? const Icon(Icons.check, size: 16, color: Colors.white)
                    : null,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildConfirmFooter(MediaPickerState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.grayPalette.shade200)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '${state.selectedMedia.length} تصویر انتخاب شده',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: () =>
                context.read<MediaPickerCubit>().confirmSelection(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.brandPalette.shade600,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(S.current.confirm),
          ),
        ],
      ),
    );
  }
}
