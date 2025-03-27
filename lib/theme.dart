import 'package:flutter/material.dart';

enum AppThemeMode {
  light,
  dark,
  pink,
  pastel,
  borcelle
}

class AppTheme {
  static ThemeData getTheme(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return _lightTheme;
      case AppThemeMode.dark:
        return _darkTheme;
      case AppThemeMode.pink:
        return _pinkTheme;
      case AppThemeMode.pastel:
        return _pastelTheme;
      case AppThemeMode.borcelle:
        return _borcelleTheme;
    }
  }

  static final ThemeData _lightTheme = ThemeData(
    primaryColor: const Color(0xFF8C1B2F),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF8C1B2F),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black87),
      bodyMedium: TextStyle(color: Colors.black87),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 2,
    ),
    colorScheme: ColorScheme.light(
      primary: const Color(0xFF8C1B2F),
      secondary: const Color(0xFFA65168),
      surface: Colors.white,
      background: Colors.white,
      error: Colors.red,
    ),
  );

  static final ThemeData _darkTheme = ThemeData(
    primaryColor: const Color(0xFF8C1B2F),
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
    ),
    cardTheme: CardTheme(
      color: const Color(0xFF1E1E1E),
      elevation: 2,
    ),
    colorScheme: ColorScheme.dark(
      primary: const Color(0xFF8C1B2F),
      secondary: const Color(0xFFA65168),
      surface: const Color(0xFF1E1E1E),
      background: const Color(0xFF121212),
      error: Colors.red,
    ),
  );

  static final ThemeData _pinkTheme = ThemeData(
    primaryColor: Colors.pink,
    scaffoldBackgroundColor: Colors.pink[50],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.pink,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.pink[900]),
      bodyMedium: TextStyle(color: Colors.pink[900]),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 2,
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.pink,
      secondary: Colors.pink[300]!,
      surface: Colors.white,
      background: Colors.pink[50]!,
      error: Colors.red,
    ),
  );

  static final ThemeData _pastelTheme = ThemeData(
    primaryColor: Colors.blue[300],
    scaffoldBackgroundColor: Colors.blue[50],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue[300],
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.blue[900]),
      bodyMedium: TextStyle(color: Colors.blue[900]),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 2,
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.blue[300]!,
      secondary: Colors.blue[200]!,
      surface: Colors.white,
      background: Colors.blue[50]!,
      error: Colors.red,
    ),
  );

  static final ThemeData _borcelleTheme = ThemeData(
    primaryColor: const Color(0xFF8C1B2F),
    scaffoldBackgroundColor: const Color(0xFFF2F0E4),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF8C1B2F),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF8C1B2F)),
      bodyMedium: TextStyle(color: Color(0xFFA65168)),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: const Color(0xFFA65168).withOpacity(0.3)),
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: const Color(0xFF8C1B2F),
      secondary: const Color(0xFFA65168),
      surface: Colors.white,
      background: const Color(0xFFF2F0E4),
      error: Colors.red,
    ),
  );
} 