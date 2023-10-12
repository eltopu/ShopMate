import 'package:flutter/material.dart';
import 'package:shopmate/services/cloud/cloud_lists.dart';
import 'package:shopmate/services/cloud/cloud_storage.dart';

Future<bool> showDeleteDialog(BuildContext context) async {
  CloudList? list;

  return await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Delete'),
            content: const Text('Are you sure you want to delete?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // Cancel
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  await FirebaseCloudStorage()
                      .deleteList(documentId: list!.documentId);
                },
                child: const Text('Delete'),
              ),
            ],
          );
        },
      ) ??
      false; // Return false if the dialog is dismissed
}
