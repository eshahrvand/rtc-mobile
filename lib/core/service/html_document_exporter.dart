import 'package:flutter/services.dart';
import 'package:flutter_native_html_to_pdf/flutter_native_html_to_pdf.dart';
import 'package:path_provider/path_provider.dart';

/// Same native HTML-to-PDF and Downloads path used by order pre-invoices.
class HtmlDocumentExporter {
  static const channel = MethodChannel('com.rtc_mobile/downloads');
  static Future<String> export(String html, String name) =>
      generateAndSave(html, name).then((result) => result.savedPath);

  static Future<({String generatedPath, String savedPath})> generateAndSave(
    String html,
    String name,
  ) => getTemporaryDirectory()
      .then(
        (directory) => HtmlToPdfConverter().convertHtmlToPdf(
          html: html,
          targetDirectory: directory.path,
          targetName: name,
        ),
      )
      .then(
        (file) => file
            .readAsBytes()
            .then(
              (bytes) => channel.invokeMethod<String>('saveToDownloads', {
                'fileName': name,
                'bytes': bytes,
              }),
            )
            .then((path) {
              if (path == null || path.isEmpty)
                throw StateError('PDF was not saved');
              return (generatedPath: file.path, savedPath: path);
            }),
      );
}
