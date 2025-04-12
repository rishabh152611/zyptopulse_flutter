import 'package:flutter/material.dart';

class AppTheme {
  static final darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.green,
    colorScheme: const ColorScheme.dark(
      primary: Colors.green,
      secondary: Colors.greenAccent,
    ),
  );

  static final lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.green,
    colorScheme: const ColorScheme.light(
      primary: Colors.green,
      secondary: Colors.greenAccent,
    ),
  );
}
