import 'dart:io';
import 'dart:typed_data';
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
      ResolutionPreset.max,
      enableAudio: false,
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
        _isCapturing)
      return;

    setState(() {
      _isCapturing = true;
    });

    try {
      final screenSize = MediaQuery.of(context).size;
      final XFile photo = await _controller!.takePicture();
      final bytes = await photo.readAsBytes();

      // Auto-crop logic
      final File croppedFile = await _autoCrop(bytes, screenSize);

      if (mounted) {
        Navigator.of(context).pop(croppedFile);
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

  Future<File> _autoCrop(Uint8List bytes, Size screenSize) async {
    img.Image? image = img.decodeImage(bytes);
    if (image == null) throw Exception('Could not decode image');

    // Handle orientation. XFile.readAsBytes() usually gives us the image
    // in its native sensor orientation (often landscape for back cameras).
    // We want to match what the user sees on screen.
    // Most mobile portrait screens will have height > width.
    if (screenSize.height > screenSize.width && image.width > image.height) {
      image = img.copyRotate(image, angle: 90);
    }

    // Fixed aspect ratio for ID card (ISO 7810 ID-1)
    const double idAspectRatio = 1.58;

    // Calculate the scale to match the 'cover' behavior of the preview
    // Screen dimensions vs Image dimensions
    final double scale =
        (screenSize.width / image.width > screenSize.height / image.height)
        ? screenSize.width / image.width
        : screenSize.height / image.height;

    final double visibleWidth = screenSize.width / scale;
    final double visibleHeight = screenSize.height / scale;

    final double offsetX = (image.width - visibleWidth) / 2;
    final double offsetY = (image.height - visibleHeight) / 2;

    // Overlay dimensions in screen (logical) pixels
    final double rectWidth =
        screenSize.width - (26 * 2); // padding: right: 26, left: 26
    final double rectHeight = 206; // height: 206
    final double rectLeft = 26;
    final double rectTop =
        (screenSize.height - rectHeight) /
        2; // Center vertically by default in Stack

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

    final directory = await getTemporaryDirectory();
    final path =
        '${directory.path}/cropped_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final resultFile = File(path);
    await resultFile.writeAsBytes(img.encodeJpg(cropped));

    return resultFile;
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
              boxFit: BoxFit.fill),
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
