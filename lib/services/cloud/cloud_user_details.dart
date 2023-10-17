import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopmate/services/auth/auth_service.dart';

Future<void> addUserDetails([
  String? userId,
  String? fullName,
  String? email,
  String? password,
  Uint8List? base64Image,
]) async {
  String? image = base64Image != null ? base64Encode(base64Image) : null;
  await FirebaseFirestore.instance.collection('users').add({
    'full_name': fullName,
    'email': email,
    'password': password,
    'profile_picture': image,
    'user_id': AuthService.firebase().currentUser?.id
  });
}
