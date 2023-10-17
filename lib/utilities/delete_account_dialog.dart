import 'package:flutter/material.dart';
import 'package:shopmate/services/auth/auth_service.dart';
import 'package:shopmate/services/cloud/cloud_storage.dart';
import 'package:shopmate/services/cloud/cloud_users.dart';

Future<bool> showDeleteAccountDialog(BuildContext context) async {
  CloudUser? user;

  return await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Delete'),
            content: const Text('Are you sure you want to delete account?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // Cancel
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  // ignore: unnecessary_null_comparison
                  if (user != null) {
                    await FirebaseCloudStorage()
                        .deleteUser(documentId: user.documentId);
                  } else {
                    print('ERROR!');
                  }
                  await AuthService.firebase().deleteUser();
                },
                child: const Text('Delete'),
              ),
            ],
          );
        },
      ) ??
      false; // Return false if the dialog is dismissed
}
