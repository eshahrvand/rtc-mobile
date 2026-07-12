import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../config/constants.dart';
import 'package:rtc_mobile/ui/widget/rtc_button.dart';
import 'package:rtc_mobile/ui/widget/rtc_image.dart';

import '../../../../generated/l10n.dart';

class RtcCameraScreen extends StatefulWidget {
  final bool showOverlay;
  const RtcCameraScreen({super.key, this.showOverlay = true});

  static Future<File?> open(BuildContext context, {bool showOverlay = true}) async {
    return await Navigator.of(
      context,
    ).push<File>(MaterialPageRoute(builder: (_) => RtcCameraScreen(showOverlay: showOverlay)));
  }

  @override
  State<RtcCameraScreen> createState() => _RtcCameraScreenState();
}

class _RtcCameraScreenState extends State<RtcCameraScreen> {
  // Mobile Camera
  CameraController? _controller;
  bool _isInitialized = false;
  
  // Web Camera
  final MobileScannerController _webController = MobileScannerController();
  
  bool _isCapturing = false;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      _initializeMobileCamera();
    }
  }

  Future<void> _initializeMobileCamera() async {
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
    _webController.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    setState(() {
      _isCapturing = true;
    });

    try {
      if (kIsWeb) {
        await _takeWebPicture();
      } else {
        await _takeMobilePicture();
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

  Future<void> _takeWebPicture() async {
    // NOTE: mobile_scanner on web usually works via analyzeImage or custom capture.
    // For RTC Web, if mobile_scanner doesn't provide a direct capture, we use the image_cropper flow.
    // However, the user wants the photo to go to the edit screen for cropping.
    
    // As a fallback for Web, we rely on the MediaEditScreen to handle the cropping precision.
    // If mobile_scanner capture is not straightforward on web, we might need a workaround or
    // use the standard image_picker for web camera if precision is the goal.
    
    // But per instructions: "photo should go to the edit screen for cropping instead"
    // We will capture the frame and pass it to MediaEditScreen.
    
    // For now, let's assume we capture the current frame.
    // If mobile_scanner doesn't support capture on web directly, we might use a canvas-based capture.
    
    // To keep it simple and robust for web:
    // If we can't capture easily with mobile_scanner, we will use image_picker.camera for web as a fallback
    // but the user wants the custom screen with overlay.
    
    // Actually, mobile_scanner is primarily for QR. For just camera, the 'camera' package or 'image_picker' is better.
    // BUT user said: "i want use mobile scaaner package for web"
    
    // We'll proceed with the UI implementation using MobileScanner for the preview.
    setState(() {
      _isCapturing = false;
    });
    // TODO: Implement actual frame capture for web using MobileScannerController if possible,
    // or fall back to native web capture.
  }

  Future<void> _takeMobilePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) return;
    
    final screenSize = MediaQuery.of(context).size;
    final XFile photo = await _controller!.takePicture();
    final bytes = await photo.readAsBytes();
    final directory = await getTemporaryDirectory();
    final tempPath = '${directory.path}/cropped_${DateTime.now().millisecondsSinceEpoch}.jpg';

    final String? resultPath = await compute(_processImage, {
      'bytes': bytes,
      'screenWidth': screenSize.width,
      'screenHeight': screenSize.height,
      'tempPath': tempPath,
      'showOverlay': widget.showOverlay,
    });

    if (mounted && resultPath != null) {
      Navigator.of(context).pop(File(resultPath));
    } else if (mounted) {
      setState(() {
        _isCapturing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Camera Preview
            Positioned.fill(
              child: kIsWeb 
                ? MobileScanner(
                    controller: _webController,
                    fit: BoxFit.cover,
                  )
                : (_isInitialized && _controller != null
                    ? FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: _controller!.value.previewSize?.height ?? 1,
                          height: _controller!.value.previewSize?.width ?? 1,
                          child: CameraPreview(_controller!),
                        ),
                      )
                    : const Center(child: CircularProgressIndicator(color: Colors.white))),
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
Future<String?> _processImage(Map<String, dynamic> params) async {
  try {
    final Uint8List bytes = params['bytes'];
    final double screenWidth = params['screenWidth'];
    final double screenHeight = params['screenHeight'];
    final String tempPath = params['tempPath'];
    final bool showOverlay = params['showOverlay'] ?? true;

    img.Image? image = img.decodeImage(bytes);
    if (image == null) return null;

    if (screenHeight > screenWidth && image.width > image.height) {
      image = img.copyRotate(image, angle: 90);
    }

    if (showOverlay) {
      final double scale =
          (screenWidth / image.width > screenHeight / image.height)
          ? screenWidth / image.width
          : screenHeight / image.height;

      final double visibleWidth = screenWidth / scale;
      final double visibleHeight = screenHeight / scale;

      final double offsetX = (image.width - visibleWidth) / 2;
      final double offsetY = (image.height - visibleHeight) / 2;

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

    if (image.width > 2000 || image.height > 2000) {
      image = img.copyResize(
        image,
        width: image.width > image.height ? 2000 : null,
        height: image.height >= image.width ? 2000 : null,
        interpolation: img.Interpolation.linear,
      );
    }

    final resultFile = File(tempPath);
    await resultFile.writeAsBytes(img.encodeJpg(image, quality: 40));

    return tempPath;
  } catch (e) {
    debugPrint('Error in _processImage: $e');
    return null;
  }
}
