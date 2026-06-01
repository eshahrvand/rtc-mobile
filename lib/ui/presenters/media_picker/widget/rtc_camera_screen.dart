import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:rtc_mobile/ui/theme/colors.dart';

class RtcCameraScreen extends StatefulWidget {
  const RtcCameraScreen({super.key});

  static Future<File?> open(BuildContext context) async {
    return await Navigator.of(context).push<File>(
      MaterialPageRoute(builder: (_) => const RtcCameraScreen()),
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
    if (_controller == null || !_controller!.value.isInitialized || _isCapturing) return;

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
    final double scale = (screenSize.width / image.width > screenSize.height / image.height)
        ? screenSize.width / image.width
        : screenSize.height / image.height;

    final double visibleWidth = screenSize.width / scale;
    final double visibleHeight = screenSize.height / scale;

    final double offsetX = (image.width - visibleWidth) / 2;
    final double offsetY = (image.height - visibleHeight) / 2;

    // Overlay dimensions in screen (logical) pixels
    final double rectWidth = screenSize.width * 0.9;
    final double rectHeight = rectWidth / idAspectRatio;
    final double rectLeft = (screenSize.width - rectWidth) / 2;
    final double rectTop = (screenSize.height - rectHeight) / 2;

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
    final path = '${directory.path}/cropped_${DateTime.now().millisecondsSinceEpoch}.jpg';
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
          Positioned.fill(
            child: CustomPaint(
              painter: _IDCardOverlayPainter(),
            ),
          ),

          // Top Controls
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),

          // Bottom Controls
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: _takePicture,
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                  ),
                  child: _isCapturing
                      ? const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                        )
                      : Container(
                          margin: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                ),
              ),
            ),
          ),
          
          // Instruction Text
          Positioned(
            bottom: 130,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'کارت ملی را در کادر قرار دهید',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IDCardOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withAlpha(160) // Slightly darker overlay
      ..style = PaintingStyle.fill;

    // Outer rectangle (entire screen)
    final outerPath = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // Inner rectangle (ID card frame)
    const double idAspectRatio = 1.58;
    final double rectWidth = size.width * 0.9;
    final double rectHeight = rectWidth / idAspectRatio;
    final double rectLeft = (size.width - rectWidth) / 2;
    final double rectTop = (size.height - rectHeight) / 2;

    final innerRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(rectLeft, rectTop, rectWidth, rectHeight),
      const Radius.circular(16), // Softer corners
    );

    final innerPath = Path()..addRRect(innerRect);

    // Subtract inner from outer
    final overlayPath = Path.combine(PathOperation.difference, outerPath, innerPath);

    canvas.drawPath(overlayPath, paint);

    // Draw border for the hole
    final borderPaint = Paint()
      ..color = AppColors.brandPalette.shade500.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    canvas.drawRRect(innerRect, borderPaint);
    
    // Draw corner guides
    final cornerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;
      
    final double cornerSize = 40; // Larger corners
    
    // Top Left
    canvas.drawPath(
      Path()
        ..moveTo(rectLeft, rectTop + cornerSize)
        ..lineTo(rectLeft, rectTop)
        ..lineTo(rectLeft + cornerSize, rectTop),
      cornerPaint,
    );
    
    // Top Right
    canvas.drawPath(
      Path()
        ..moveTo(rectLeft + rectWidth - cornerSize, rectTop)
        ..lineTo(rectLeft + rectWidth, rectTop)
        ..lineTo(rectLeft + rectWidth, rectTop + cornerSize),
      cornerPaint,
    );
    
    // Bottom Left
    canvas.drawPath(
      Path()
        ..moveTo(rectLeft, rectTop + rectHeight - cornerSize)
        ..lineTo(rectLeft, rectTop + rectHeight)
        ..lineTo(rectLeft + cornerSize, rectTop + rectHeight),
      cornerPaint,
    );
    
    // Bottom Right
    canvas.drawPath(
      Path()
        ..moveTo(rectLeft + rectWidth - cornerSize, rectTop + rectHeight)
        ..lineTo(rectLeft + rectWidth, rectTop + rectHeight)
        ..lineTo(rectLeft + rectWidth, rectTop + rectHeight - cornerSize),
      cornerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
