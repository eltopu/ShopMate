import 'package:flutter/material.dart';
import 'package:shopmate/screens/list_view_screen.dart';
import 'package:shopmate/services/auth/auth_service.dart';
import 'package:shopmate/services/cloud/cloud_lists.dart';
import 'package:shopmate/services/cloud/cloud_storage.dart';
import 'package:shopmate/utilities/logout_dialog.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  String get userId => AuthService.firebase().currentUser!.id;

  late final FirebaseCloudStorage _listsService;

  @override
  void initState() {
    _listsService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          'Shopping List',
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
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/new-list/',
                );
              },
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              )),
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
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: (MediaQuery.of(context).size.width * 0.07),
            vertical: 30),
        child: Column(children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.width * 0.3,
            decoration: ShapeDecoration(
              color: const Color(0xFFE4E4E4),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
            child: StreamBuilder(
              stream: _listsService.allLists(ownerUserId: userId),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                    if (snapshot.hasData) {
                      final allLists = snapshot.data as Iterable<CloudList>;
                      return ListViewScreen(
                        lists: allLists,
                        onTap: (note) {
                          Navigator.of(context).pushNamed(
                            '/new-list/',
                            arguments: note,
                          );
                        },
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }

                  default:
                    return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ]),
      ),
    );
  }
}
