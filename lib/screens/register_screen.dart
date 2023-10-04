import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shopmate/firebase_options.dart';
import 'package:shopmate/widgets/button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * .07,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFE4E4E4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Row(children: [
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Email',
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
                          ),
                          controller: _email,
                          autocorrect: false,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      const Icon(
                        Icons.email,
                        color: Color(0xFF838383),
                      )
                    ]),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * .07,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFE4E4E4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Row(children: [
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Password',
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
                          ),
                          controller: _password,
                          autocorrect: false,
                          obscureText: true,
                          enableSuggestions: false,
                        ),
                      ),
                      const Icon(
                        Icons.lock,
                        color: Color(0xFF838383),
                      )
                    ]),
                  ),
                ],
              ),
              Column(
                children: [
                  ButtonWidget(
                    text: 'Register',
                    onPressed: () async {
                      final email = _email.text;
                      final password = _password.text;
                      try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: email, password: password);
                        final user = FirebaseAuth.instance.currentUser;
                        if (user != null) {
                          print('Success');
                        } else {
                          print('Failed');
                        }
                      } catch (e) {
                        print(e);
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
