import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopmate/utilities/select_image.dart';
import 'package:shopmate/widgets/button.dart';
import 'package:shopmate/widgets/text_input_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final TextEditingController _fullname;

  @override
  void initState() {
    _fullname = TextEditingController();
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
    setState(() {
      _image = img;
    });
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
                      onPressed: () {},
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
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
