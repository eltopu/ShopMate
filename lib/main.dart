import 'package:flutter/material.dart';
import 'package:shopmate/screens/list_screen.dart';
import 'package:shopmate/screens/login_screen.dart';
import 'package:shopmate/screens/register_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 18, 32, 47)),
    ),
    home: const LoginScreen(),
    initialRoute: '/',
    routes: {
      '/login/': (context) => const LoginScreen(),
      '/register/': (context) => const RegisterScreen(),
      '/list/': (context) => const ListScreen(),
    },
  ));
}
