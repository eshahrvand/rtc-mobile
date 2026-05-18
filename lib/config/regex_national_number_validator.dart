import 'dart:developer';

bool isNationalIDValid(String nc) {
  if (nc.trim() == '') {
    return false;
  } else if (nc.length != 10) {
    return false;
  } else {
    int sum = 0;

    for (int i = 0; i < 9; i++) {
      sum += int.parse(nc[i]) * (10 - i);
    }

    int lastDigit;
    int divideRemaining = sum % 11;

    if (divideRemaining < 2) {
      lastDigit = divideRemaining;
    } else {
      lastDigit = 11 - (divideRemaining);
    }

    if (int.parse(nc[9]) == lastDigit) {
      return true;
    } else {
      return false;
    }
  }
}
