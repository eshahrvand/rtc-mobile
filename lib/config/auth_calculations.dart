class AuthCalculations {
  /// Formats seconds into a MM:SS string.
  static String formatRemainingTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remSeconds';
  }
}
