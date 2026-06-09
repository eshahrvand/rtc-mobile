import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DocumentViewerScreen extends StatelessWidget {
  final String url;
  final String title;
  final bool isLocalFile;

  const DocumentViewerScreen({
    super.key,
    required this.url,
    required this.title,
    required this.isLocalFile,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 0.5,
          maxScale: 4.0,
          child: isLocalFile
              ? Image.file(
                  File(url),
                  errorBuilder: (context, error, stackTrace) => const _ErrorPlaceholder(),
                )
              : CachedNetworkImage(
                  imageUrl: url,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(color: Colors.white),
                  errorWidget: (context, url, error) => const _ErrorPlaceholder(),
                ),
        ),
      ),
    );
  }
}

class _ErrorPlaceholder extends StatelessWidget {
  const _ErrorPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error, color: Colors.white, size: 48.0),
        SizedBox(height: 16.0),
        Text(
          'خطا در بارگذاری تصویر',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
