import 'dart:ffi';
import 'package:shopmate/model/user_model.dart';

abstract class AuthProvider {
  Future<void> initialize();
  UserModel? get currentUser;
  Future<UserModel> logIn({
    required String email,
    required String password,
  });
  Future<UserModel> createUser({
    required String fullName,
    required String email,
    required String password,
  });
  Future<UserModel> deleteUser();
  Future<Void> logOut();
}
