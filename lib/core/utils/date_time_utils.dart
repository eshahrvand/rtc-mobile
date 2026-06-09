import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class DateTimeUtils {
  /// Parses a date string and converts it to local time.
  static DateTime? parseToLocal(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return null;
    try {
      final dateTime = DateTime.parse(dateStr);
      return dateTime.toLocal();
    } catch (_) {
      return null;
    }
  }

  /// Converts a DateTime to Jalali (Shamsi) ensuring it's in local time.
  static Jalali toJalali(DateTime dateTime) {
    return Jalali.fromDateTime(dateTime.toLocal());
  }

  /// Formats a date string into a Jalali string with time: "HH:mm | yyyy/MM/dd"
  static String formatToJalali(String dateStr, {String separator = ' | '}) {
    final localDateTime = parseToLocal(dateStr);
    if (localDateTime == null) return dateStr;

    final jalali = Jalali.fromDateTime(localDateTime);
    final hour = localDateTime.hour.toString().padLeft(2, '0');
    final minute = localDateTime.minute.toString().padLeft(2, '0');
    final year = jalali.year;
    final month = jalali.month.toString().padLeft(2, '0');
    final day = jalali.day.toString().padLeft(2, '0');

    return '$hour:$minute$separator$year/$month/$day';
  }

  /// Formats a date string into a Jalali date only: "yyyy/MM/dd"
  static String formatToJalaliDate(String dateStr) {
    final localDateTime = parseToLocal(dateStr);
    if (localDateTime == null) return dateStr;

    final jalali = Jalali.fromDateTime(localDateTime);
    final year = jalali.year;
    final month = jalali.month.toString().padLeft(2, '0');
    final day = jalali.day.toString().padLeft(2, '0');

    return '$year/$month/$day';
  }
}
