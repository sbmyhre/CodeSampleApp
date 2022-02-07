import 'package:code_sample_app/repository.dart';

/// Class that hosts the business logic for authentication.
class AuthenticationBloc {
  bool isUserSignedIn() => Repository().isUserSignedIn();
  Future<String?> signIn(dynamic loginData) => Repository().signIn(loginData);
  Future<String?> signUp(dynamic loginData) => Repository().signUp(loginData);
  Future<String?> signOut() => Repository().signOut();

  /// Returns null if [value] is considered a valid email.
  /// Otherwise, returns the user-friendly error text.
  dynamic validateEmail(dynamic value) {
    if (value.isEmpty) {
      return 'Email is empty';
    }
    if (!value.contains('@') || !value.endsWith('.com')) {
      return "Email must contain '@' and end with '.com'";
    }
    return null;
  }

  /// Returns null if [value] is considered a valid password.
  /// Otherwise, returns the user-friendly error text.
  dynamic validatePw(dynamic value) {
    if (value.isEmpty) {
      return 'Password is empty';
    }
    if (value.length < 6) {
      return 'Password is too short';
    }
    return null;
  }

  void dispose() {}
}
