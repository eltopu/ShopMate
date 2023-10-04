import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

@immutable //shows that this class and its sub-classes are not going to change upon initialization
class UserModel {
  final String? email;
  const UserModel({
    required this.email,
  });

  factory UserModel.fromFirebase(User user) => UserModel(email: user.email);
}
