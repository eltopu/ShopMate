import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

@immutable
class UserModel {
  final String id;
  final String? email;
  const UserModel({
    required this.id,
    required this.email,
  });

  factory UserModel.fromFirebase(User user) => UserModel(
        email: user.email,
        id: user.uid,
      );
}
