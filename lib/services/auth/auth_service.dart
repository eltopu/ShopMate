import 'dart:ffi';

import 'package:shopmate/services/auth/auth_provider.dart';
import 'package:shopmate/services/auth/auth_user.dart';
import 'package:shopmate/services/auth/firebase_auth_provider.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;
  const AuthService(this.provider);

  factory AuthService.firebase() => AuthService(
        FirebaseAuthProvider(),
      );

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) =>
      provider.createUser(
        email: email,
        password: password,
      );

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) =>
      provider.logIn(
        email: email,
        password: password,
      );

  @override
  Future<Void> logOut() => provider.logOut();

  @override
  Future<void> initialize() => provider.initialize();
}
