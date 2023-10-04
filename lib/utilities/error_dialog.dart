import 'package:flutter/material.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) async {
  final scaffoldMessenger = ScaffoldMessenger.of(context);

  scaffoldMessenger.showSnackBar(
    SnackBar(
      content: Text(text),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {
          scaffoldMessenger.hideCurrentSnackBar();
        },
      ),
    ),
  );
}
