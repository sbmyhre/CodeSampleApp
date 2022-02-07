import 'package:code_sample_app/authentication/authentication_bloc.dart';
import 'package:code_sample_app/authentication/authentication_provider.dart';
import 'package:code_sample_app/resources/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

/// Screen used for sign-up and login using [FlutterLogin].
class LoginPage extends StatefulWidget {
  static const routeName = '/auth';

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  AuthenticationBloc? bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = AuthenticationProvider.of(context);
  }

  @override
  void dispose() {
    if (bloc != null) {
      bloc!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (bloc == null) {
      throw Exception("Authentication bloc is null cannot start login.");
    }
    return Scaffold(
        body: FlutterLogin(
      userValidator: (value) {
        return bloc!.validateEmail(value);
      },
      passwordValidator: (value) {
        return bloc!.validatePw(value);
      },
      onLogin: (loginData) {
        return bloc!.signIn(loginData);
      },
      onSignup: (loginData) {
        return bloc!.signUp(loginData);
      },
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacementNamed(HomePage.routeName);
      },
      onRecoverPassword: (name) {
        // I don't currently support password recovery.
        return null;
      },
    ));
  }
}
