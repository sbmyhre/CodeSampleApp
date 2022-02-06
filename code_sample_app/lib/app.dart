import 'package:flutter/material.dart';

/// Application running as a widget.
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Flutter Demo',
        home: Text("Hello world")
    );
  }
}