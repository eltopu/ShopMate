import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopmate/services/cloud/cloud_storage_constants.dart';

@immutable
class CloudUser {
  final String documentId;
  final String ownerUserId;
  final String fullName;
  final String profilePicture;

  const CloudUser({
    required this.documentId,
    required this.ownerUserId,
    required this.fullName,
    required this.profilePicture,
  });

  CloudUser.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerUserId = snapshot.data()[ownerUserIdFieldName],
        fullName = snapshot.data()[fullNameFieldName],
        profilePicture = snapshot.data()[profilePictureFieldName];
}
