import 'package:flutter/material.dart';

class AppTheme {
  static const primaryColor = Color(0XFFFED36A);
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    // colors
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: Color(0XFF8E8E93),
      surface: Colors.white,

      // adding complementary colors that work well with #acdde0
      tertiary: Color(0XFFacdde0),
      onPrimary: Colors.black87,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: primaryColor,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: 'regular',
      ),
      iconTheme: IconThemeData(color: Colors.black),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: primaryColor.withValues(alpha: .1),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryColor),
      ),
      hintStyle: TextStyle(
        color: Colors.grey.shade600,
      ),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black,
        fontFamily: 'regular',
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: Colors.black87,
        fontFamily: 'bold',
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Colors.black87,
        fontFamily: 'regular',
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        color: Colors.grey,
        fontFamily: 'regular',
      ),
    ),

    // Message bubble
    // cardTheme: CardTheme(
    //   color: primaryColor.withValues(alpha: .1),
    //   elevation: 0,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(16),
    //   ),
    // ),

    //Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.black87,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
