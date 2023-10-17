import 'dart:ffi';
import 'dart:developer' as devtools show log;
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException, User;
import 'package:shopmate/firebase_options.dart';
import 'package:shopmate/model/user_model.dart';
import 'package:shopmate/providers/auth_provider.dart';
import 'package:shopmate/services/cloud/cloud_user_details.dart';
import 'package:shopmate/utilities/exceptions/auth_exception.dart';

class FirebaseAuthProvider implements AuthProvider {
  @override
  Future<UserModel> createUser({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        //we put await since it returns a future
        email: email,
        password: password,
      );
      addUserDetails(fullName, email, password);
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggdInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        devtools.log('Invalid e-mail format');
        throw InvalidEmailAuthException();
      } else if (e.code == 'weak-password') {
        devtools.log('Weak Password!');
        throw WeakPasswordAuthException();
      } else if (e.code == 'email-already-in-use') {
        devtools.log('Émail is already in use');
        throw EmailAlreadyInUseAuthException();
      } else {
        throw GenericExceptionAuthException();
      }
    } catch (_) {
      throw GenericExceptionAuthException();
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
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggdInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      devtools.log(e.code);
      if (e.code == 'user-not-found') {
        devtools.log('User not found');
        throw UserNotFoundAuthException();
      } else if (e.code == 'wrong-password') {
        devtools.log('Wrong Password!');
        throw WrongPasswordAuthException;
      } else {
        throw GenericExceptionAuthException();
      }
    } catch (_) {
      throw GenericExceptionAuthException();
    }
  }

  @override
  Future<Void> logOut() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseAuth.instance.signOut();
      } else {
        throw UserNotLoggdInAuthException();
      }
    } catch (e) {
      throw GenericExceptionAuthException();
    }
    throw GenericExceptionAuthException();
    // final user = FirebaseAuth.instance.currentUser;
    // if (user != null) {
    //   await FirebaseAuth.instance.signOut();
    // } else {
    //   throw UserNotLoggdInAuthException();
    // }
    // throw GenericExceptionAuthException();
  }

  // @override
  // Future<Void> sendEmailVerification() async {
  //   final user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     await user.sendEmailVerification();
  //   } else {
  //     throw UserNotLoggdInAuthException();
  //   }
  //   throw GenericExceptionAuthException();
  // }

  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
      //initialize app before instance...copied from firebase_options.dart
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Future<UserModel> deleteUser() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.delete();
        print('User account deleted');
      } else {
        print('No user signed in.');
      }
    } catch (e) {
      throw CouldNotDeleteAccountAuthException(
          'Failed to delete the user account: $e');
    }
    throw GenericExceptionAuthException();
  }
}
