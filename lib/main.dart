import 'package:flutter/material.dart';
import 'package:shopmate/screens/home_screen.dart';
import 'package:shopmate/screens/list_screen.dart';
import 'package:shopmate/screens/login_screen.dart';
import 'package:shopmate/screens/new_list_screen.dart';
import 'package:shopmate/screens/register_screen.dart';
import 'package:shopmate/services/auth/auth_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AuthService.firebase().initialize;
  runApp(MaterialApp(
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 18, 32, 47)),
    ),
    home: const HomeScreen(),
    initialRoute: '/',
    routes: {
      '/login/': (context) => const LoginScreen(),
      '/register/': (context) => const RegisterScreen(),
      '/list/': (context) => const ListScreen(),
      '/new-list/': (context) => const CreateUpdateListScreen(),
    },
  ));
}
