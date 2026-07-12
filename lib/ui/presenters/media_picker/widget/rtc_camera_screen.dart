import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import '../../../../config/constants.dart';
import 'package:rtc_mobile/ui/widget/rtc_button.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';

import '../../../../generated/l10n.dart';

class RtcCameraScreen extends StatefulWidget {
  final bool showOverlay;

  const RtcCameraScreen({super.key, this.showOverlay = true});

  static Future<File?> open(
    BuildContext context, {
    bool showOverlay = true,
  }) async {
    return await Navigator.of(context).push<File>(
      MaterialPageRoute(
        builder: (_) => RtcCameraScreen(showOverlay: showOverlay),
      ),
    );
  }

  @override
  State<RtcCameraScreen> createState() => _RtcCameraScreenState();
}

class _RtcCameraScreenState extends State<RtcCameraScreen> {
  CameraController? _controller;
  bool _isInitialized = false;
  bool _isCapturing = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) return;

    final backCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.back,
      orElse: () => cameras.first,
    );

    _controller = CameraController(
      backCamera,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    try {
      await _controller!.initialize();
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e) {
      debugPrint('Error initializing camera: $e');
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    setState(() {
      _isCapturing = true;
    });

    try {
      final XFile photo = await _controller!.takePicture();
      final bytes = await photo.readAsBytes();
      
      final mediaQuery = MediaQuery.of(context);
      final double safeWidth = mediaQuery.size.width - mediaQuery.padding.left - mediaQuery.padding.right;
      final double safeHeight = mediaQuery.size.height - mediaQuery.padding.top - mediaQuery.padding.bottom;

      final Uint8List? processedBytes = await compute(_processImageBytes, {
        'bytes': bytes,
        'screenWidth': safeWidth,
        'screenHeight': safeHeight,
        'showOverlay': widget.showOverlay,
      });

      if (processedBytes == null) {
        if (mounted) {
          setState(() {
            _isCapturing = false;
          });
        }
        return;
      }

      if (kIsWeb) {
        // On Web, return a File object pointing to the Blob URL
        final blobUrl = XFile.fromData(
          processedBytes,
          mimeType: 'image/jpeg',
          name: 'cropped_${DateTime.now().millisecondsSinceEpoch}.jpg',
        ).path;
        if (mounted) {
          Navigator.of(context).pop(File(blobUrl));
        }
      } else {
        // Mobile: Save to temp file
        final directory = await getTemporaryDirectory();
        final tempPath = '${directory.path}/cropped_${DateTime.now().millisecondsSinceEpoch}.jpg';
        final resultFile = File(tempPath);
        await resultFile.writeAsBytes(processedBytes);
        
        if (mounted) {
          Navigator.of(context).pop(resultFile);
        }
      }
    } catch (e) {
      debugPrint('Error taking picture: $e');
      if (mounted) {
        setState(() {
          _isCapturing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Camera Preview (Same for Mobile and Web)
            Positioned.fill(
              child: (_isInitialized && _controller != null
                  ? FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _controller!.value.previewSize?.height ?? 1,
                        height: _controller!.value.previewSize?.width ?? 1,
                        child: CameraPreview(_controller!),
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    )),
            ),

            // Overlay
            if (widget.showOverlay)
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 26, left: 26),
                  child: RtcImage(
                    image: 'assets/images/subtract.svg',
                    boxFit: BoxFit.fill,
                    height: 206,
                    width: double.infinity,
                  ),
                ),
              ),

            // Top Controls
            Positioned(
              top: 10,
              left: 16,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: RtcImage(
                  image: "$baseImage/close.svg",
                  color: Colors.white,
                  width: 24,
                  height: 24,
                  boxFit: BoxFit.fill,
                ),
              ),
            ),

            // Bottom Controls
            Positioned(
              bottom: 16,
              left: 20,
              right: 20,
              child: RtcButton(
                title: S.current.takePhoto,
                isLoading: _isCapturing,
                onPressed: _takePicture,
                width: double.infinity,
                styleBtn: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),

            // Instruction Text
            if (widget.showOverlay)
              Positioned(
                top: 120,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    "تصویر روی کارت ملی خود را با کارت زیر مطابقت دهید",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Top-level function for background image processing
Future<Uint8List?> _processImageBytes(Map<String, dynamic> params) async {
  try {
    final Uint8List bytes = params['bytes'];
    final double screenWidth = params['screenWidth'];
    final double screenHeight = params['screenHeight'];
    final bool showOverlay = params['showOverlay'] ?? true;

    img.Image? image = img.decodeImage(bytes);
    if (image == null) return null;

    if (showOverlay) {
      // Calculate scale factor for BoxFit.cover
      final double scale =
          (screenWidth / image.width > screenHeight / image.height)
              ? screenWidth / image.width
              : screenHeight / image.height;

      final double visibleWidth = screenWidth / scale;
      final double visibleHeight = screenHeight / scale;

      final double offsetX = (image.width - visibleWidth) / 2;
      final double offsetY = (image.height - visibleHeight) / 2;

      // Overlay UI values (matching RtcCameraScreen layout)
      final double rectWidth = screenWidth - (26 * 2);
      final double rectHeight = 206;
      final double rectLeft = 26;
      final double rectTop = (screenHeight - rectHeight) / 2;

      final int pixelX = (offsetX + (rectLeft / scale)).toInt();
      final int pixelY = (offsetY + (rectTop / scale)).toInt();
      final int pixelWidth = (rectWidth / scale).toInt();
      final int pixelHeight = (rectHeight / scale).toInt();

      final int safeX = pixelX.clamp(0, image.width - 1);
      final int safeY = pixelY.clamp(0, image.height - 1);
      final int safeWidth = pixelWidth.clamp(1, image.width - safeX);
      final int safeHeight = pixelHeight.clamp(1, image.height - safeY);

      image = img.copyCrop(
        image,
        x: safeX,
        y: safeY,
        width: safeWidth,
        height: safeHeight,
      );
    }

    // Resize if too large to save memory/bandwidth
    if (image.width > 2000 || image.height > 2000) {
      image = img.copyResize(
        image,
        width: image.width > image.height ? 2000 : null,
        height: image.height >= image.width ? 2000 : null,
        interpolation: img.Interpolation.linear,
      );
    }

    return Uint8List.fromList(img.encodeJpg(image, quality: 40));
  } catch (e) {
    debugPrint('Error in _processImageBytes: $e');
    return null;
  }
}
