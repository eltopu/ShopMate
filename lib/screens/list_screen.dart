import 'package:flutter/material.dart';
import 'package:shopmate/services/auth/auth_service.dart';
import 'package:shopmate/services/cloud/cloud_lists.dart';
import 'package:shopmate/services/cloud/cloud_storage.dart';
import 'package:shopmate/utilities/delete_dialog.dart';
import 'package:shopmate/utilities/logout_dialog.dart';

enum MenuDrawer { logout }

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
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
      ),
      drawer: Drawer(
          child: Container(
        color: const Color(0xFFD9D9D9),
        width: 150,
        child: ListView(
          children: [
            ListTile(
              title: const Text(
                'Add Collaborator',
                textAlign: TextAlign.center,
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Text(
                'Manage Collaborator',
                textAlign: TextAlign.center,
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Text(
                'Profile Settings',
                textAlign: TextAlign.center,
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Text(
                'Logout',
                textAlign: TextAlign.center,
              ),
              onTap: () {
                showLogOutDialog(context);
              },
            ),
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            '/new-list/',
          );
        },
        backgroundColor: const Color(0xFFD9D9D9),
        child: const Icon(Icons.add_rounded, color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: (MediaQuery.of(context).size.width * 0.07),
          vertical: 30,
        ),
        child: StreamBuilder(
          stream: _listsService.allLists(ownerUserId: userId),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.active:
                if (snapshot.hasData) {
                  final allLists = snapshot.data as Iterable<CloudList>;
                  return ListView.builder(
                    itemCount: allLists.length,
                    itemBuilder: (context, index) {
                      final list = allLists.elementAt(index);
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          height: MediaQuery.of(context).size.width * 0.2,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFE4E4E4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: ListTile(
                            onLongPress: () {
                              showMenu(
                                context: context,
                                position: RelativeRect.fill,
                                items: <PopupMenuEntry>[
                                  const PopupMenuItem(
                                    value: 'delete',
                                    child: Text('Delete'),
                                  ),
                                ],
                                initialValue: null,
                              ).then(
                                (value) {
                                  if (value == 'delete') {
                                    showDeleteDialog(context);
                                  }
                                },
                              );
                            },
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                '/new-list/',
                                arguments: list,
                              );
                            },
                            title: Text(
                              list.text,
                              maxLines: 1,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
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
    );
  }
}
