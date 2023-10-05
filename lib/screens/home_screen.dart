import 'package:flutter/material.dart';
import 'package:shopmate/services/auth/auth_service.dart';
import 'package:shopmate/widgets/button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService.firebase().initialize;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/homepage.jpeg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                const Text(
                  "SHOPMATE APP",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(height: 235),
                const Center(
                  child: SizedBox(
                    width: 300,
                    child: Text(
                      "Welcome to ShopMate App,your comprehensive solution for modernizing the way you manage your shopping list.ShopMate eliminates the need for paper-lists and forgetfulness by encapsulating everything you need in an easy to use mobile application.Join Us , and make your shopping experience, more organized and collaborative",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'IBM Plex Sans Thai Looped',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 200,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonWidget(
                      text: "Register",
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/login/', (route) => false);
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ButtonWidget(
                      text: 'Login',
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/login/', (route) => false);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
