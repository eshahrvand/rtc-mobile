bool validatePostalCode(String postalCode) {
  if (postalCode.isEmpty) {
    return false;
  }

  // Postal code must be exactly 10 digits
  if (postalCode.length != 10) {
    return false;
  }

  final RegExp postalCodeRegex = RegExp(
    r"\b(?!(\d)\1{3})[13-9]{4}[1346-9][013-9]{5}\b",
  );

  return postalCodeRegex.hasMatch(postalCode);
}
