import 'package:flutter/material.dart';
import 'package:shopmate/services/auth/auth_service.dart';
// import 'package:shopmate/utilities/generic_dialog.dart';

// Future<bool> showLogOutDialog(BuildContext context) {
//   return showGenericDialog<bool>(
//     context: context,
//     title: 'Log out',
//     content: 'Are you sure you want to log out?',
//     optionsBuilder: () => {
//       'Cancel': false,
//       'Log out': true,
//       if (true) {
//         Navigator.of(context).pushNamedAndRemoveUntil('/login/', (route) => false);
//       }
//     },
//   ).then(
//     (value) => value ?? false,
//   );
// }

Future<bool> showLogOutDialog(BuildContext context) async {
  return await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Log out'),
            content: const Text('Are you sure you want to log out?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // Cancel
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true); // Log out
                  AuthService.firebase().logOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/login/', (route) => false);
                },
                child: const Text('Log out'),
              ),
            ],
          );
        },
      ) ??
      false; // Return false if the dialog is dismissed
}
