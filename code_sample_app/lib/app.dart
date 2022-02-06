import 'package:code_sample_app/resources/themes/app_theme.dart';
import 'package:flutter/material.dart';

/// Application running as a widget.
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme().defaultTheme,
        title: 'Flutter Demo',
        home: const Text("Hello world")
    );
  }
}