import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:shopmate/services/auth/auth_service.dart';
import 'package:shopmate/services/cloud/cloud_user_details.dart';
import 'package:shopmate/utilities/error_snackbar.dart';
import 'package:shopmate/widgets/button.dart';
import 'package:shopmate/widgets/text_input_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _fullname;
  late final TextEditingController _dob;
  late final TextEditingController _gender;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _fullname = TextEditingController();
    _dob = TextEditingController();
    _gender = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _fullname.dispose();
    _dob.dispose();
    _gender.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthService.firebase().initialize;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Register',
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
              Column(
                children: [
                  TextInputField(
                    controller: _fullname,
                    hintText: 'Full Name',
                    icon: Icons.person,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                  ),
                  TextInputField(
                    controller: _email,
                    hintText: 'Email',
                    icon: Icons.email,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                  ),
                  TextInputField(
                    controller: _password,
                    hintText: 'Password',
                    icon: Icons.lock,
                    enableSuggestions: false,
                    obscureText: true,
                  ),
                ],
              ),
              Column(
                children: [
                  ButtonWidget(
                    text: 'Register',
                    onPressed: () async {
                      final fullName = _fullname.text;
                      final email = _email.text;
                      final password = _password.text;
                      try {
                        await AuthService.firebase().createUser(
                          email: email,
                          password: password,
                          fullName: fullName,
                        );
                        addUserDetails(fullName, email, password);
                        final user = AuthService.firebase().currentUser;
                        if (user != null) {
                          print('Success');
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/login/', (route) => false);
                        } else {
                          print('Failed');
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'invalid-email') {
                          await errorSnackbar(context, 'Invalid Email format');
                        } else {
                          await errorSnackbar(context, 'Error: ${e.code}');
                        }
                      } catch (e) {
                        await errorSnackbar(context, e.toString());
                      }
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('/login/', (route) => false);
                    },
                    child: const Text(
                      'Already registered? Login',
                      style: TextStyle(
                        color: Color(0xFF3486AA),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
