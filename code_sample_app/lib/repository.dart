import 'package:code_sample_app/authentication/authentication_provider.dart';

/// An API layer that abstracts the db code implementation.
///
/// In the future, or if the database needs to be changed, this API layer
/// will stay the same. This layer could also cache the returned
/// values if the optimization is necessary.
class Repository {
  static final Repository _instance = Repository._internal();

  factory Repository() {
    return _instance;
  }

  Repository._internal();

  final _auth = AuthenticationProvider().init();

  /// Auth
  bool isUserSignedIn() => _auth.isUserSignedIn();
  Future<String?> signIn(dynamic loginData) => _auth.signIn(loginData);
  Future<String?> signUp(dynamic loginData) => _auth.signUp(loginData);
  Future<String?> signOut() => _auth.signOut();
}
