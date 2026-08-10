import 'dart:io';
import 'dart:math';
import 'package:cross_file/cross_file.dart';

class FileUtils {
  static Future<String> getXFileSizeString(XFile xFile) async {
    try {
      if (xFile.path.isNotEmpty) {
        final file = File(xFile.path);
        if (file.existsSync()) {
          return formatFileSize(file.lengthSync());
        }
      }
      final len = await xFile.length();
      if (len > 0) return formatFileSize(len);
      final bytes = await xFile.readAsBytes();
      return formatFileSize(bytes.length);
    } catch (_) {
      try {
        final bytes = await xFile.readAsBytes();
        return formatFileSize(bytes.length);
      } catch (_) {
        return '\u200e۰ B';
      }
    }
  }

  static String getFileSizeString(String filePath) {
    try {
      final file = File(filePath);
      if (!file.existsSync()) return '0 B';

      int bytes = file.lengthSync();
      return formatFileSize(bytes);
    } catch (e) {
      return '0 B';
    }
  }

  static String formatFileSize(int bytes) {
    if (bytes <= 0) return "\u200e۰ B";

    const suffixes = ["B", "KB", "MB", "GB", "TB"];
    var i = (log(bytes) / log(1024)).floor();

    // Use Persian digits and format to one decimal place if needed
    double size = bytes / pow(1024, i);
    String sizeStr = size.toStringAsFixed(size < 10 && i > 0 ? 1 : 0);

    return '\u200e${_toPersianDigits(sizeStr)} ${suffixes[i]}';
  }

  static String _toPersianDigits(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const persian = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

    String result = input;
    for (int i = 0; i < english.length; i++) {
      result = result.replaceAll(english[i], persian[i]);
    }
    return result;
  }
}
