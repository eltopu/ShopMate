import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopmate/services/cloud/cloud_storage_constants.dart';

@immutable
class CloudList {
  final String documentId;
  final String ownerUserId;
  final String text;

  const CloudList({
    required this.documentId,
    required this.ownerUserId,
    required this.text,
  });

  CloudList.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerUserId = snapshot.data()[ownerUserIdFieldName],
        text = snapshot.data()[textFieldName] as String;
}
