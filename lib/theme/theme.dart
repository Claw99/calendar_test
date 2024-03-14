import 'package:flutter/material.dart';

class ThemeClass {
  List<Color> colors = [];

  Color cream = const Color.fromRGBO(218, 184, 139, 1);
  Color white = const Color.fromRGBO(243, 233, 221, 1);
  Color blue = const Color.fromRGBO(75, 101, 135, 1);
  Color grey = const Color.fromRGBO(200, 198, 198, 1);

  static ThemeData lightTheme = ThemeData(
      colorScheme: const ColorScheme.light().copyWith(
          primary: _themeClass.cream,
          secondary: _themeClass.blue,
          error: Colors.red),
      fontFamily: 'Lato',
      useMaterial3: true,
      iconTheme: IconThemeData(color: _themeClass.blue),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: _themeClass.blue,
      ),
      scaffoldBackgroundColor: _themeClass.white,
      primaryColor: _themeClass.grey);
}

ThemeClass _themeClass = ThemeClass();
