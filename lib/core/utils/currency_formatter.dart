import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String format(String? value) {
    if (value == null || value.isEmpty) return '0';
    
    // Remove any existing separators or non-digit characters except minus sign
    String cleanValue = value.replaceAll(RegExp(r'[^\d-]'), '');
    
    double? numValue = double.tryParse(cleanValue);
    if (numValue == null) return value;

    final formatter = NumberFormat('#,###');
    return formatter.format(numValue);
  }
}

extension CurrencyStringExtension on String {
  String get formatCurrency => CurrencyFormatter.format(this);
}
