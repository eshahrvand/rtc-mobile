import 'dart:io';
import 'dart:math';

class FileUtils {
  static String getFileSizeString(String filePath) {
    try {
      final file = File(filePath);
      if (!file.existsSync()) return '0 B';
      
      int bytes = file.lengthSync();
      if (bytes <= 0) return "0 B";
      
      const suffixes = ["B", "KB", "MB", "GB", "TB"];
      var i = (log(bytes) / log(1024)).floor();
      
      // Use Persian digits and format to one decimal place if needed
      double size = bytes / pow(1024, i);
      String sizeStr = size.toStringAsFixed(size < 10 && i > 0 ? 1 : 0);
      
      return '${_toPersianDigits(sizeStr)} ${suffixes[i]}';
    } catch (e) {
      return '0 B';
    }
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
