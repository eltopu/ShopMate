import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopmate/model/cloud_user_model.dart';
import 'package:shopmate/services/cloud/cloud_users.dart';
import 'package:shopmate/utilities/delete_account_dialog.dart';
import 'package:shopmate/utilities/select_image.dart';
import 'package:shopmate/widgets/button.dart';
import 'package:shopmate/widgets/text_input_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class UserController extends GetxController {
  static final myUser = Rx<CloudUserModel?>(null);
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final TextEditingController _fullname;
  String name = '';
  CloudUser? user;

  @override
  void initState() {
    _fullname = TextEditingController();
    getUserInfo();
    super.initState();
  }

  @override
  void dispose() {
    _fullname.dispose();
    super.dispose();
  }

  Uint8List? _image;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    final compressedImage = await FlutterImageCompress.compressWithList(
      img,
      quality: 90,
    );

    setState(
      () {
        _image = compressedImage;
      },
    );
    String uid = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot =
        await usersCollection.where('user_id', isEqualTo: uid).get();
    String documentId = querySnapshot.docs.first.id;
    final userDoc =
        FirebaseFirestore.instance.collection('users').doc(documentId);
    final userDocSnapshot = await userDoc.get();
    if (userDocSnapshot.exists) {
      // The document exists, update it
      await userDoc.update({'profile_picture': _image});
    } else {
      // The document doesn't exist, create it
      await userDoc.set({'profile_picture': _image});
    }
  }

  getUserInfo() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot =
        await usersCollection.where('user_id', isEqualTo: uid).get();
    String documentId = querySnapshot.docs.first.id;
    FirebaseFirestore.instance
        .collection('users')
        .doc(documentId)
        .snapshots()
        .listen(
      (event) {
        if (event.exists) {
          final data = event.data() as Map<String, dynamic>;
          final fullName = data['full_name'] as String;
          name = fullName;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Profile Settings',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 0,
            )),
        centerTitle: true,
        backgroundColor: Colors.white54,
        bottomOpacity: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 65, backgroundImage: MemoryImage(_image!))
                      : const CircleAvatar(
                          radius: 65,
                          backgroundImage:
                              AssetImage('assets/profileimage.png'),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: () {
                        selectImage();
                      },
                      icon: const Icon(Icons.add_a_photo_outlined),
                    ),
                  )
                ],
              ),
              // Text(UserController.myUser.value?.fullName ?? 'Full Name'),
              Stack(
                children: [
                  Text(name),
                  Positioned(
                    left: 30,
                    // top: 0,
                    child: IconButton(
                      onPressed: () async {
                        String name = _fullname.text;
                        String uid = FirebaseAuth.instance.currentUser!.uid;
                        CollectionReference usersCollection =
                            FirebaseFirestore.instance.collection('users');
                        QuerySnapshot querySnapshot = await usersCollection
                            .where('user_id', isEqualTo: uid)
                            .get();
                        String documentId = querySnapshot.docs.first.id;
                        final userDoc = FirebaseFirestore.instance
                            .collection('users')
                            .doc(documentId);
                        final userDocSnapshot = await userDoc.get();

                        if (userDocSnapshot.exists) {
                          // The document exists, update it
                          await userDoc.update({'full_name': name});
                        } else {
                          // The document doesn't exist, create it
                          await userDoc.set({'full_name': name});
                        }

                        // Call getUserInfo() again to fetch the updated name
                        getUserInfo();
                      },
                      icon: const Icon(Icons.edit_note),
                    ),
                  ),
                ],
              ),

              Container(
                width: 300,
                height: 200,
                decoration: ShapeDecoration(
                  color: const Color(0xFFD9D9D9),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text('Personal Details',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          )),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Contact Details',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          )),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Preferences',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          )),
                    ),
                    TextButton(
                      onPressed: () {
                        showDeleteAccountDialog(context);
                      },
                      child: const Text('Delete Account',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          )),
                    ),
                  ],
                ),
              ),
              TextInputField(
                controller: _fullname,
                hintText: 'Full Name',
                icon: Icons.person,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
              ),
              ButtonWidget(
                text: 'Update',
                onPressed: () async {
                  String name = _fullname.text;
                  String uid = FirebaseAuth.instance.currentUser!.uid;
                  CollectionReference usersCollection =
                      FirebaseFirestore.instance.collection('users');
                  QuerySnapshot querySnapshot = await usersCollection
                      .where('user_id', isEqualTo: uid)
                      .get();
                  String documentId = querySnapshot.docs.first.id;
                  final userDoc = FirebaseFirestore.instance
                      .collection('users')
                      .doc(documentId);
                  final userDocSnapshot = await userDoc.get();

                  if (userDocSnapshot.exists) {
                    // The document exists, update it
                    await userDoc.update({'full_name': name});
                  } else {
                    // The document doesn't exist, create it
                    await userDoc.set({'full_name': name});
                  }

                  // Call getUserInfo() again to fetch the updated name
                  getUserInfo();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
