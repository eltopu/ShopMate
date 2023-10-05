import 'package:flutter/material.dart';
import 'package:shopmate/services/auth/auth_service.dart';
import 'package:shopmate/utilities/logout_dialog.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          'My Shopping List',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white54,
        bottomOpacity: 0.0,
        actions: [
          IconButton(
              onPressed: () async {
                final logOut = await showLogOutDialog(context);
                if (logOut) {
                  await AuthService.firebase().logOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/login/', (route) => false);
                }
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ))
        ],
      ),
      body: Container(child: (const Text('To be added...😊'))),
    );
  }
}
