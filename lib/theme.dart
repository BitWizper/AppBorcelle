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
    primaryColor: Color(0xFF8C1B2F),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF8C1B2F),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black87),
      bodyMedium: TextStyle(color: Colors.black87),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 2,
    ),
  );

  static final ThemeData _darkTheme = ThemeData(
    primaryColor: Color(0xFF8C1B2F),
    scaffoldBackgroundColor: Color(0xFF121212),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
    ),
    cardTheme: CardTheme(
      color: Color(0xFF1E1E1E),
      elevation: 2,
    ),
  );

  static final ThemeData _pinkTheme = ThemeData(
    primaryColor: Color(0xFFE91E63),
    scaffoldBackgroundColor: Color(0xFFFFF0F5),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFFE91E63),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF4A4A4A)),
      bodyMedium: TextStyle(color: Color(0xFF4A4A4A)),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 2,
    ),
  );

  static final ThemeData _pastelTheme = ThemeData(
    primaryColor: Color(0xFF98D8AA),
    scaffoldBackgroundColor: Color(0xFFF5F5F5),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF98D8AA),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF4A4A4A)),
      bodyMedium: TextStyle(color: Color(0xFF4A4A4A)),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 2,
    ),
  );

  static final ThemeData _borcelleTheme = ThemeData(
    primaryColor: Color(0xFFD4AF37),
    scaffoldBackgroundColor: Color(0xFFFFF8E7),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFFD4AF37),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF4A4A4A)),
      bodyMedium: TextStyle(color: Color(0xFF4A4A4A)),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 2,
    ),
  );
} 