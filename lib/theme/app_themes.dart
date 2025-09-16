// lib/theme/app_themes.dart
import 'package:flutter/material.dart';

// CENTRALIZED SPACING
class Spacing {
  static const double base = 4.0; // BASE SPACING UNIT = 4px !!

  // Calculate spacing by multiplying the base value
  static double of(int multiplier) {
    return base *
        multiplier; // 4px * multiplier (e.g., 4 * 2 = 8px/Spacing.of(2))
  }

  // This way, we can easily adjust the spacing of the entire app if need be
  // by just changing the base value
}

// COLORS
class AppColors {
  // DARK THEME
  static const darkBackground = Color(0xFF1E1E1E);
  static const darkPrimary = Color(0xFFFDFDFD);

  // LIGHT THEME
  static const lightBackground = Color(0xFFFDFDFD);
  static const lightPrimary = Color(0xFF1E1E1E);

  // SHARED
  static const accentOrange = Color(0xFFF45531);
  static const accentYellow = Color(0xFFEDE8CA);
  static const lineColor = Color(0xFFFDFDFD);
}

// DARK THEME DATA
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.darkBackground,
  primaryColor: AppColors.darkPrimary,
  colorScheme: const ColorScheme.dark(
    primary: AppColors.darkPrimary,
    secondary: AppColors.accentOrange,
    surface: AppColors.darkBackground,
  ),
  fontFamily: 'Poppins',
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'My_Soul',
      fontSize: 48,
      color: AppColors.darkPrimary,
    ),
    displayMedium: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 32,
      color: AppColors.darkPrimary,
    ),
    displaySmall: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 24,
      color: AppColors.darkPrimary,
    ),
    bodyLarge: TextStyle(fontSize: 16, color: AppColors.darkPrimary),
    bodyMedium: TextStyle(fontSize: 14, color: AppColors.darkPrimary),
  ),
);

// LIGHT THEME DATA
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.lightBackground,
  primaryColor: AppColors.lightPrimary,
  colorScheme: const ColorScheme.light(
    primary: AppColors.lightPrimary,
    secondary: AppColors.accentOrange,
    surface: AppColors.lightBackground,
  ),
  fontFamily: 'Poppins',
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'My_Soul',
      fontSize: 48,
      color: AppColors.lightPrimary,
    ),
    displayMedium: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 32,
      color: AppColors.lightPrimary,
    ),
    displaySmall: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 24,
      color: AppColors.lightPrimary,
    ),
    bodyLarge: TextStyle(fontSize: 16, color: AppColors.lightPrimary),
    bodyMedium: TextStyle(fontSize: 14, color: AppColors.lightPrimary),
  ),
);
