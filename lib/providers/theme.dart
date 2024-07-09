import 'package:flutter/material.dart';

class VocaTheme with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  ThemeData get currentTheme => _isDarkMode ? darkTheme : lightTheme;

  // Light Theme

  static final ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: const Color.fromRGBO(0, 166, 166, 1.0),
      scaffoldBackgroundColor: const Color.fromRGBO(234, 242, 255, 1.0),
      appBarTheme: const AppBarTheme(
          color: Colors.white, iconTheme: IconThemeData(color: Colors.white)),
      textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color.fromRGBO(0, 76, 159, 1)),
          bodyMedium: TextStyle(color: Colors.black)),
      iconTheme: const IconThemeData(color: Colors.black38));

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color.fromRGBO(0, 188, 188, 1.0),
    scaffoldBackgroundColor: const Color.fromRGBO(18, 30, 54, 1.0),
    appBarTheme: const AppBarTheme(
      color: Color.fromRGBO(30, 45, 75, 1.0),
      iconTheme: IconThemeData(color: Color.fromRGBO(0, 188, 188, 1.0)),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Color.fromRGBO(200, 200, 200, 1.0)),
    ),
    iconTheme: const IconThemeData(color: Colors.white70),
  );
}
