import 'dart:io' show File;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../generated/l10n.dart';

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

  bool _isPdf(String path) {
    return path.toLowerCase().endsWith('.pdf');
  }

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
        child: _isPdf(url)
            ? (isLocalFile
                ? (kIsWeb
                    ? FutureBuilder<Uint8List>(
                        future: Dio()
                            .get(url, options: Options(responseType: ResponseType.bytes))
                            .then((r) => r.data as Uint8List),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return SfPdfViewer.memory(snapshot.data!);
                          }
                          return const CircularProgressIndicator(color: Colors.white);
                        },
                      )
                    : SfPdfViewer.file(File(url)))
                : SfPdfViewer.network(url))
            : InteractiveViewer(
                minScale: 0.5,
                maxScale: 4.0,
                child: isLocalFile
                    ? (kIsWeb
                        ? Image.network(
                            url,
                            errorBuilder: (context, error, stackTrace) =>
                                const _ErrorPlaceholder(),
                          )
                        : Image.file(
                            File(url),
                            errorBuilder: (context, error, stackTrace) =>
                                const _ErrorPlaceholder(),
                          ))
                    : CachedNetworkImage(
                        imageUrl: url,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(
                                color: Colors.white),
                        errorWidget: (context, url, error) =>
                            const _ErrorPlaceholder(),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.error, color: Colors.white, size: 48.0),
        const SizedBox(height: 16.0),
        Text(
          S.current.imageLoadError,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
