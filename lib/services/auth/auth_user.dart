import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

@immutable //shows that this class and its sub-classes are not going to change upon initialization
class AuthUser {
  final String? email;
  const AuthUser({
    required this.email,
  });

  factory AuthUser.fromFirebase(User user) => AuthUser(email: user.email);
}
