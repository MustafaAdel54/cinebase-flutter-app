import 'package:flutter/material.dart';

const TextTheme appTextThemeLight = TextTheme(
  headlineLarge: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ),
  titleMedium: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  ),
  bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
  bodySmall: TextStyle(fontSize: 14, color: Colors.grey),
);

const TextTheme appTextThemeDark = TextTheme(
  headlineLarge: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
  titleMedium: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  ),
  bodyMedium: TextStyle(fontSize: 16, color: Colors.white70),
  bodySmall: TextStyle(fontSize: 14, color: Colors.grey),
);
