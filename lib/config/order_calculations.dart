import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class OrderCalculations {
  /// Formats the current date and time into a Jalali string.
  static String formatCurrentJalaliDateTime() {
    final now = DateTime.now().toLocal();
    final jalali = Jalali.fromDateTime(now);
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    final year = jalali.year;
    final month = jalali.month.toString().padLeft(2, '0');
    final day = jalali.day.toString().padLeft(2, '0');

    return '$hour:$minute - $year/$month/$day';
  }

  /// Masks a phone number (e.g., 0912***34).
  static String maskPhoneNumber(String phone) {
    if (phone.length <= 6) return phone;
    final firstPart = phone.substring(0, 4);
    final lastPart = phone.substring(phone.length - 2);
    final maskedPart = '*' * (phone.length - 6);
    return '$lastPart$maskedPart$firstPart';
  }
}
