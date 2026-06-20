import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String format(dynamic value) {
    if (value == null) return '0';

    double numValue;
    if (value is num) {
      numValue = value.toDouble();
    } else if (value is String) {
      if (value.isEmpty) return '0';
      // Remove any existing separators or non-digit characters except minus sign and decimal point
      String cleanValue = value.replaceAll(RegExp(r'[^\d.-]'), '');
      if (cleanValue.isEmpty || cleanValue == '-') return '0';
      numValue = double.tryParse(cleanValue) ?? 0;
    } else {
      return value.toString();
    }

    final formatter = NumberFormat('#,###', 'en_US');
    // We use toInt() to match existing behavior of removing decimals
    String formatted = formatter.format(numValue.abs().toInt());
    return numValue < 0 ? '\u200E-$formatted' : formatted;
  }
}

extension CurrencyStringExtension on String {
  String get formatCurrency => CurrencyFormatter.format(this);
}

extension CurrencyDoubleExtension on double {
  String get formatCurrency => CurrencyFormatter.format(this);
}

extension CurrencyIntExtension on int {
  String get formatCurrency => CurrencyFormatter.format(this);
}
