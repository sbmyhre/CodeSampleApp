import 'package:code_sample_app/app.dart';
import 'package:flutter/material.dart';

void main() {
  // Call ensureInitialized because App returns async
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}
