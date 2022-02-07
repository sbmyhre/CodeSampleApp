import 'package:flutter/material.dart';

class  AppTheme {
  /// default theme for this app
  final ThemeData defaultTheme = _buildDefaultTheme();

  static ThemeData _buildDefaultTheme() {
    return ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      canvasColor: Colors.white,
    );
  }
}