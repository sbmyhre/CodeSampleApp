import 'package:flutter/material.dart';

/// This screen displays when the app is loading.
class LoadingPage extends StatefulWidget {
  static const routeName = '/loading';

  LoadingPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loading..."),
      ),
      body: Container(),
    );
  }
}