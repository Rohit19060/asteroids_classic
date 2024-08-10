import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  colorScheme: const ColorScheme(
    primary: Colors.red,
    onPrimary: Colors.white,
    secondary: Colors.white,
    onSecondary: Colors.red,
    surface: Colors.black,
    onSurface: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    brightness: Brightness.dark,
  ),
);
