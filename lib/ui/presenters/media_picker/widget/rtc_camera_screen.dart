import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:rtc_mobile/config/config.dart';
import 'package:rtc_mobile/ui/widget/rtc_button.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';

class RtcCameraScreen extends StatefulWidget {
  const RtcCameraScreen({super.key});

  static Future<File?> open(BuildContext context) async {
    return await Navigator.of(
      context,
    ).push<File>(MaterialPageRoute(builder: (_) => const RtcCameraScreen()));
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

    // Use the first back camera
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
    if (_controller == null ||
        !_controller!.value.isInitialized ||
        _isCapturing) {
      return;
    }

    setState(() {
      _isCapturing = true;
    });

    try {
      final screenSize = MediaQuery.of(context).size;
      final XFile photo = await _controller!.takePicture();
      final bytes = await photo.readAsBytes();
      final directory = await getTemporaryDirectory();
      final tempPath =
          '${directory.path}/cropped_${DateTime.now().millisecondsSinceEpoch}.jpg';

      // Offload image processing to a background isolate to keep UI responsive
      final String? resultPath = await compute(_processImage, {
        'bytes': bytes,
        'screenWidth': screenSize.width,
        'screenHeight': screenSize.height,
        'tempPath': tempPath,
      });

      if (mounted && resultPath != null) {
        Navigator.of(context).pop(File(resultPath));
      } else if (mounted) {
        setState(() {
          _isCapturing = false;
        });
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
    if (!_isInitialized || _controller == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Camera Preview
          Positioned.fill(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller!.value.previewSize?.height ?? 1,
                height: _controller!.value.previewSize?.width ?? 1,
                child: CameraPreview(_controller!),
              ),
            ),
          ),

          // Overlay
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
            top: 20,
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
            bottom: 40,
            left: 20,
            right: 20,
            child: RtcButton(
              title: 'گرفتن عکس',
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
          Positioned(
            top: 130,
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
    );
  }
}

/// Top-level function for background image processing
Future<String?> _processImage(Map<String, dynamic> params) async {
  try {
    final Uint8List bytes = params['bytes'];
    final double screenWidth = params['screenWidth'];
    final double screenHeight = params['screenHeight'];
    final String tempPath = params['tempPath'];

    img.Image? image = img.decodeImage(bytes);
    if (image == null) return null;

    // Handle orientation.
    // If screen is portrait and image is landscape, rotate it.
    if (screenHeight > screenWidth && image.width > image.height) {
      image = img.copyRotate(image, angle: 90);
    }

    // Calculate the scale to match the 'cover' behavior of the preview
    final double scale =
        (screenWidth / image.width > screenHeight / image.height)
        ? screenWidth / image.width
        : screenHeight / image.height;

    final double visibleWidth = screenWidth / scale;
    final double visibleHeight = screenHeight / scale;

    final double offsetX = (image.width - visibleWidth) / 2;
    final double offsetY = (image.height - visibleHeight) / 2;

    // Overlay dimensions in screen (logical) pixels (MUST MATCH UI)
    final double rectWidth = screenWidth - (26 * 2);
    final double rectHeight = 206;
    final double rectLeft = 26;
    final double rectTop = (screenHeight - rectHeight) / 2;

    // Map screen rect to image pixels
    final int pixelX = (offsetX + (rectLeft / scale)).toInt();
    final int pixelY = (offsetY + (rectTop / scale)).toInt();
    final int pixelWidth = (rectWidth / scale).toInt();
    final int pixelHeight = (rectHeight / scale).toInt();

    // Ensure we don't crop outside image bounds
    final int safeX = pixelX.clamp(0, image.width - 1);
    final int safeY = pixelY.clamp(0, image.height - 1);
    final int safeWidth = pixelWidth.clamp(1, image.width - safeX);
    final int safeHeight = pixelHeight.clamp(1, image.height - safeY);

    img.Image cropped = img.copyCrop(
      image,
      x: safeX,
      y: safeY,
      width: safeWidth,
      height: safeHeight,
    );

    final resultFile = File(tempPath);
    await resultFile.writeAsBytes(img.encodeJpg(cropped, quality: 85));

    return tempPath;
  } catch (e) {
    debugPrint('Error in _processImage: $e');
    return null;
  }
}
