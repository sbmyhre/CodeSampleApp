import 'package:code_sample_app/authentication/authentication_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// Handles authentication layer service calls.
/// see https://firebase.flutter.dev/docs/auth/usage/
class AuthenticationProvider extends InheritedWidget {
  static const String errorMessage = "Unknown error, please try again later. If the issue persists please contact us at support@app.com";

  static AuthenticationBloc? of(BuildContext context) {
    AuthenticationProvider? pro =
    (context.dependOnInheritedWidgetOfExactType<AuthenticationProvider>());
    return pro?.bloc;
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final bloc = AuthenticationBloc();

  AuthenticationProvider({Key? key, Widget? child})
      : super(key: key, child: child ?? Container());

  AuthenticationProvider init() {
    // listen for auth state changes
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    return this;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  /// Returns true if there is a user currently signed in.
  bool isUserSignedIn() {
    return auth.currentUser != null;
  }

  /// Returns null if succeeded, otherwise returns a user friendly error message.
  Future<String?> signIn(dynamic loginData) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: loginData.name,
        password: loginData.password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email. Did you mean to click \'SignUp\'?.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    } catch (e) {
      return errorMessage;
    }

    return null;
  }

  /// Returns null if succeeded, otherwise returns a user friendly error message.
  /// If no error message exists, but an error was hit, default message is used.
  Future<String?> signUp(dynamic loginData) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: loginData.name,
        password: loginData.password,
      );
    } on FirebaseAuthException catch (e) {
      // Translate code into user friendly text
      if (e.code.compareTo('weak-password') == 0) {
        return 'The password provided is too weak.';
      } else if (e.code.compareTo('email-already-in-use') == 0) {
        return 'The account already exists for that email.';
      }
      return errorMessage;
    } catch (e) {
      return errorMessage;
    }
    return null;
  }

  /// Signs the current user out of the app.
  /// Returns null if succeeded, otherwise returns a user friendly error message.
  /// If no error message exists, but an error was hit, default message is used.
  Future<String?> signOut() async {
    try {
      await auth.signOut();
    } on FirebaseAuthException catch (e) {
      return errorMessage;
    }
    return null;
  }
}
