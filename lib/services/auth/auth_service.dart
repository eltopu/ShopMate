import 'dart:ffi';

import 'package:shopmate/providers/auth_provider.dart';
import 'package:shopmate/model/user_model.dart';
import 'package:shopmate/providers/firebase_auth_provider.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;
  const AuthService(this.provider);

  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  Future<UserModel> createUser({
    required String fullName,
    required String email,
    required String password,
  }) =>
      provider.createUser(
        email: email,
        password: password,
        fullName: fullName,
      );

  @override
  UserModel? get currentUser => provider.currentUser;

  @override
  Future<UserModel> logIn({
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

  @override
  Future<UserModel> deleteUser() => provider.deleteUser();
}
