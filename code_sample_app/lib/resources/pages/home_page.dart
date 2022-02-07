import 'package:code_sample_app/authentication/authentication_bloc.dart';
import 'package:code_sample_app/authentication/authentication_provider.dart';
import 'package:code_sample_app/resources/buttons/settings_button.dart';
import 'package:flutter/material.dart';

/// This is the home page.
///
/// It isn't much right now, but it will serve great value in the code to come.
class HomePage extends StatefulWidget {
  static const routeName = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() =>
      _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? touchedIndex;
  AuthenticationBloc? authBloc;
  final TextEditingController toastController = TextEditingController();

  _HomePageState();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authBloc = AuthenticationProvider.of(context);
  }

  @override
  void dispose() {
    if (authBloc != null) {
      authBloc!.dispose();
    }
    toastController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // only add the listener if it hasn't been added yet, we only want one
    if (!toastController.hasListeners) {
      toastController.addListener(() {
        if (toastController.text.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(toastController.text),
          ));
          toastController.text = "";
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome Home"),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
            child: SettingsButton(),
          ),
        ],
      ),
      body: const SafeArea(
        child: Center(
          child: Text("default home page"),
        ),
      ),
    );
  }
}
