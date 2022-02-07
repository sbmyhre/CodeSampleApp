import 'package:code_sample_app/authentication/authentication_provider.dart';
import 'package:code_sample_app/repository.dart';
import 'package:code_sample_app/resources/pages/home_page.dart';
import 'package:code_sample_app/resources/pages/loading_page.dart';
import 'package:code_sample_app/resources/pages/login_page.dart';
import 'package:code_sample_app/resources/themes/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

/// Application running as a widget.
///
/// Initializes FlutterFire and loads appropriate landing page for our user.
/// Displays [LoadingPage] until initialization future returns with value.
class App extends StatelessWidget {
  // The Firebase initialization Future lives outside of [build] to avoid reInit
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const MaterialApp(home: Text("Error Page"));
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return AuthenticationProvider(
              child: MaterialApp(
                theme: AppTheme().defaultTheme,
                initialRoute: getInitialRoute(),
                routes: {
                  "/": (context) => const HomePage(),
                  HomePage.routeName: (context) => const HomePage(),
                  LoginPage.routeName: (context) => LoginPage(),
                  LoadingPage.routeName: (context) => LoadingPage(),
                },
              ));
        }

        // Otherwise, show [LoadingScreen] whilst waiting for initialization to complete
        return MaterialApp(home: LoadingPage());
      },
    );
  }

  /// Returns the appropriate initial route for the current user.
  ///
  /// For Example: If user not logged in, [LoginScreen.routeName] is returned.
  String? getInitialRoute() {
    return showUserLoginScreen() ? LoginPage.routeName : null;
  }

  /// Returns true when the app should display the login screen to the user.
  bool showUserLoginScreen() {
    return !Repository().isUserSignedIn();
  }
}