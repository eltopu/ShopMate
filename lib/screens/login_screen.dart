import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shopmate/firebase_options.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
        title: const Text('Login',
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                  TextButton(
                    onPressed: () {},
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Forgot your password?',
                        style: TextStyle(
                          color: Color(0xFF3486AA),
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: MediaQuery.of(context).size.height * .06,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF3486AA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
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
                      child: TextButton(
                        onPressed: () async {
                          final email = _email.text;
                          final password = _password.text;
                          try {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: email, password: password);
                            final user = FirebaseAuth.instance.currentUser;
                            if (user != null) {
                              print('Success');
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/list/', (route) => false);
                            } else {
                              print('User not found');
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/register/', (route) => false);
                    },
                    child: const Align(
                      child: Text(
                        'Already have an account? Register',
                        style: TextStyle(
                          color: Color(0xFF3486AA),
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
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