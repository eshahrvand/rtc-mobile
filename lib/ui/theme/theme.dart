import 'package:flutter/material.dart';
import 'package:rtc_mobile/ui/theme/text_theme.dart';

import 'colors.dart';

ThemeData appTheme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.grayPalette.shade25,
    useMaterial3: true,
    textTheme: textThemeFa,
    colorScheme: ColorScheme.light(
      brightness: Brightness.light,
      primary: AppColors.brandPalette.shade500,
      primaryContainer: AppColors.brandPalette.shade100,
      secondary: AppColors.blueLightPalette.shade500,
      secondaryContainer: AppColors.blueLightPalette.shade100,
      error: AppColors.errorPalette.shade500,
      errorContainer: AppColors.errorPalette.shade100,
      surface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onError: Colors.white,
      onSurface: AppColors.grayPalette.shade900,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
