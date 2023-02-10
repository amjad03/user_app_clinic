import 'package:flutter/material.dart';

class ATheme {
  ATheme._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
      primarySwatch: const MaterialColor(0xFF000000, <int, Color>{
        50 : Color(0xFF000000),
        100 : Color(0xFF000000),
        200 : Color(0xFF000000),
        300 : Color(0xFF000000),
        400 : Color(0xFF000000),
        500 : Color(0xFF000000),
        600 : Color(0xFF000000),
        700 : Color(0xFF000000),
        800 : Color(0xFF000000),
        900 : Color(0xFF000000),
      })
  );
}