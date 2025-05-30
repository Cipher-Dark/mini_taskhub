import 'package:flutter/material.dart';

class AppTheme {
  static const primaryColor = Color(0xFFFED36A);
  // Brand colors

  // Light Theme Colors
  static const secondaryColorlight = Color.fromARGB(255, 189, 221, 236);
  static const scaffoldColorLight = Colors.white;

  // Dark Theme Colors
  static const primaryColorDark = Color(0xFFFED36A);
  static const secondaryColorDark = Color(0xFF212832);
  static const tertiaryColorDark = Color.fromARGB(255, 76, 78, 85);
  static const scaffoldColorDark = Color(0xFF212832);

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: scaffoldColorDark,
    colorScheme: const ColorScheme.dark(
      primary: primaryColorDark,
      secondary: Color(0xFF8CAAB9),
      surface: Color(0xFF2A2E3B),
      tertiary: Color(0xFFacdde0),
      onPrimary: Colors.black87,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: secondaryColorDark,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFF455A64),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      border: OutlineInputBorder(borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColorDark)),
      hintStyle: TextStyle(color: Colors.white),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.white),
      labelMedium: TextStyle(fontSize: 12, color: Colors.white),
      labelLarge: TextStyle(fontSize: 18, color: Color(0xFF8CAAB9), fontWeight: FontWeight.normal),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColorDark,
        foregroundColor: Colors.black87,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: const RoundedRectangleBorder(),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    cardTheme: CardTheme(
      color: tertiaryColorDark,
    ),
  );

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: scaffoldColorLight,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: Color(0xFF8CAAB9),
      surface: Colors.white,
      tertiary: Color(0xFFacdde0),
      onPrimary: Colors.black87,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: Colors.black87,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: Colors.black87),
    ),
    iconTheme: const IconThemeData(color: Colors.black87),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFFF0F0F0),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      border: OutlineInputBorder(borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor)),
      hintStyle: TextStyle(color: Colors.black54),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.black87),
      labelMedium: TextStyle(fontSize: 12, color: Colors.black54),
      labelLarge: TextStyle(fontSize: 18, color: Color(0xFF8CAAB9), fontWeight: FontWeight.normal),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.black87,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: const RoundedRectangleBorder(),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    cardTheme: CardTheme(
      color: secondaryColorlight,
    ),
  );
}
