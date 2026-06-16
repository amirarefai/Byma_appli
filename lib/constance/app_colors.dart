import 'package:flutter/material.dart';

class AppTheme {
  // ألوان تطبيق BYMA حسب القيم المعطاة
  static const Color kPrimaryColor = Color(0xFF00695C); // #00695C
  static const Color kSecondaryColor = Color(0xFF70D6FF); // #70D6FF
  static const Color kBackgroundColor = Color(0xFFECEFF1); // #ECEFF1
  static const Color kTextColor = Color(0xFF37474F); // #37474F
  static const Color kSubTextColor = Color(0xFF90A4AE); // #90A4AE
  static const Color kWhite = Color(0xFFFFFFFF); // #FFFFFF

  // ألوان الحالات الثابتة
  static const Color kColorSuccess = Color(0xFF10B981);
  static const Color kColorDanger = Color(0xFFEF4444);

  // ☀️ إعدادات الوضع الفاتح (Light Theme)
  static final lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Inter',
    brightness: Brightness.light,
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: kBackgroundColor,
    cardColor: kWhite,
    colorScheme: ColorScheme.light(
      primary: kPrimaryColor,
      secondary: kSecondaryColor,
      surface: kWhite,
      onPrimary: kWhite,
      onSurface: kTextColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: kWhite,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: kPrimaryColor, width: 2.2),
      ),
    ),
  );

  // 🌙 إعدادات الوضع الداكن (Dark Theme)
  static final darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Inter',
    brightness: Brightness.dark,
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: const Color(0xFF121B1C),
    cardColor: const Color(0xFF1E292B),
    colorScheme: ColorScheme.dark(
      primary: kPrimaryColor,
      secondary: kSecondaryColor,
      surface: const Color(0xFF1E292B),
      onPrimary: kWhite,
      onSurface: kWhite,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1E292B),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: kWhite.withOpacity(0.1), width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: kPrimaryColor, width: 2.2),
      ),
    ),
  );
}