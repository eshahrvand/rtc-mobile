import 'package:flutter/services.dart';

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  static const separator = ',';
  static final RegExp _digitRegex = RegExp(r'[0-9۰-۹]');
  static final RegExp _nonDigitRegex = RegExp(r'[^0-9۰-۹]');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // حذف همه کاراکترهای غیرعددی (پشتیبانی از اعداد فارسی و انگلیسی)
    String digitsOnly = newValue.text.replaceAll(_nonDigitRegex, '');
    if (digitsOnly.isEmpty) {
      return newValue.copyWith(
          text: '', selection: const TextSelection.collapsed(offset: 0));
    }

    // موقعیت کرسر قبل از فرمت
    int numDigitsBeforeCursor = _countDigitsBeforeCursor(newValue);

    // ساخت رشته فرمت‌شده
    String formatted = _formatNumber(digitsOnly);

    // موقعیت جدید کرسر بعد از فرمت
    int newCursorPosition =
        _calculateCursorPosition(formatted, numDigitsBeforeCursor);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: newCursorPosition),
    );
  }

  /// شمارش تعداد ارقام قبل از کرسر
  int _countDigitsBeforeCursor(TextEditingValue value) {
    int count = 0;
    for (int i = 0;
        i < value.selection.baseOffset && i < value.text.length;
        i++) {
      if (_digitRegex.hasMatch(value.text[i])) {
        count++;
      }
    }
    return count;
  }

  /// فرمت کردن ارقام با ویرگول
  String _formatNumber(String digits) {
    final buffer = StringBuffer();
    int len = digits.length;
    for (int i = 0; i < len; i++) {
      if (i != 0 && (len - i) % 3 == 0) {
        buffer.write(separator);
      }
      buffer.write(digits[i]);
    }
    return buffer.toString();
  }

  /// محاسبه موقعیت کرسر جدید بر اساس تعداد ارقام قبل از آن
  int _calculateCursorPosition(String formattedText, int digitsBeforeCursor) {
    if (digitsBeforeCursor <= 0) return 0;

    int count = 0;
    for (int i = 0; i < formattedText.length; i++) {
      if (_digitRegex.hasMatch(formattedText[i])) {
        count++;
        if (count == digitsBeforeCursor) {
          return i + 1; // +1 چون می‌خوایم کرسر بعد از رقم قرار بگیره
        }
      }
    }
    return formattedText.length; // در صورت بروز مشکل، انتهای متن
  }
}
