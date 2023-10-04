import 'dart:ffi';
import 'package:shopmate/services/auth/auth_user.dart';

abstract class AuthProvider {
  Future<void> initialize();
  UserModel? get currentUser;
  Future<UserModel> logIn({
    required String email,
    required String password,
  });
  Future<UserModel> createUser({
    required String email,
    required String password,
  });
  Future<Void> logOut();
}
