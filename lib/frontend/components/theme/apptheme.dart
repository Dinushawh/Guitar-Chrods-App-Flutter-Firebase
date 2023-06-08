// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

mixin appThemeData {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: const MaterialColor(
        0xFFEE1453,
        <int, Color>{
          50: Color(0xFFEE1453),
          100: Color(0xFFEE1453),
          200: Color(0xFFEE1453),
          300: Color(0xFFEE1453),
          400: Color(0xFFEE1453),
          500: Color(0xFFEE1453),
          600: Color(0xFFEE1453),
          700: Color(0xFFEE1453),
          800: Color(0xFFEE1453),
          900: Color(0xFFEE1453),
        },
      ),
    ).copyWith(
      secondary: const Color(0xFFEE1453),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    colorScheme: ColorScheme.fromSwatch(
        primarySwatch: const MaterialColor(
      0xFF000000,
      <int, Color>{
        50: Color(0xFF000000),
        100: Color(0xFF000000),
        200: Color(0xFF000000),
        300: Color(0xFF000000),
        400: Color(0xFF000000),
        500: Color(0xFF000000),
        600: Color(0xFF000000),
        700: Color(0xFF000000),
        800: Color(0xFF000000),
        900: Color(0xFF000000),
      },
    )).copyWith(
      secondary: const Color(0xEEEEEEEE),
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: Color(0xEEEEEEEE),
      ),
      headline2: TextStyle(
        color: Color(0xEEEEEEEE),
      ),
      headline3: TextStyle(
        color: Color(0xEEEEEEEE),
      ),
      headline4: TextStyle(
        color: Color(0xEEEEEEEE),
      ),
      headline5: TextStyle(
        color: Color(0xEEEEEEEE),
      ),
      headline6: TextStyle(
        color: Color(0xEEEEEEEE),
      ),
      subtitle1: TextStyle(
        color: Color(0xEEEEEEEE),
      ),
      subtitle2: TextStyle(
        color: Color(0xEEEEEEEE),
      ),
      bodyText1: TextStyle(
        color: Color(0xEEEEEEEE),
      ),
      bodyText2: TextStyle(
        color: Color(0xEEEEEEEE),
      ),
      caption: TextStyle(
        color: Color(0xEEEEEEEE),
      ),
      overline: TextStyle(
        color: Color(0xEEEEEEEE),
      ),
      button: TextStyle(
        color: Color(0xEEEEEEEE),
      ),
    ),
  );
}
