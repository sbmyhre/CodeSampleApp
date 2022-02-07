import 'package:code_sample_app/authentication/authentication_bloc.dart';
import 'package:code_sample_app/authentication/authentication_provider.dart';
import 'package:code_sample_app/resources/pages/login_page.dart';
import 'package:flutter/material.dart';

/// This is button that opens the pop out menu with the currently signed in
/// user's settings options. Assumes there is a signed in user. Do Not use this
/// button if no user is signed in
class SettingsButton extends StatefulWidget {
  SettingsButton({Key? key}) : super(key: key);

  @override
  _SettingsButtonState createState() => _SettingsButtonState();
}

enum Settings{sign_out}
class _SettingsButtonState extends State<SettingsButton> {
  AuthenticationBloc? auth;
  _SettingsButtonState({Key? key});

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    auth = AuthenticationProvider.of(context);
  }

  @override
  void dispose() {
    if (auth != null) {
      auth!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      child: Icon(
        Icons.settings,
        color: Theme.of(context).canvasColor,
      ),
      onSelected: (Settings result) {
        if (result == Settings.sign_out) {
          // sign the user out
          auth!.signOut();
          // clean up the page stack
          while (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
          // launch the login page
          Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Settings>>[
        const PopupMenuItem<Settings>(
          value: Settings.sign_out,
          child: Text('Log out'),
        ),
      ],
    );
  }
}