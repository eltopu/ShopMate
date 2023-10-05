import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shopmate/firebase_options.dart';
import 'package:shopmate/providers/auth_provider.dart';
import 'package:shopmate/model/user_model.dart';

class FirebaseAuthProvider implements AuthProvider {
  @override
  Future<UserModel> createUser({
    required String email,
    required String password,
  }) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = currentUser;
    if (user != null) {
      return user;
    } else {
      throw Exception();
    }
  }

  @override
  UserModel? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return UserModel.fromFirebase(user);
    } else {
      return null;
    }
  }

  @override
  Future<UserModel> logIn({
    required String email,
    required String password,
  }) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = currentUser;
    if (user != null) {
      return user;
    } else {
      throw Exception();
    }
  }

  @override
  Future<Void> logOut() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      throw Exception();
    }
    throw Exception();
  }

  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}

class UserNotLoggdInAuthException implements Exception {}
