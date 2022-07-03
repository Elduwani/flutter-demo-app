import 'package:demo_app/pages/auth/login.dart';
import 'package:demo_app/pages/auth/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../home_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          }
          return const AuthPage();
        },
      ),
    );
  }
}

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  //Initially show the login page
  bool showLoginPage = true;

  void toggleScreen() => setState(() => showLoginPage = !showLoginPage);

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(toggleScreen: toggleScreen);
    }
    return RegisterPage(toggleScreen: toggleScreen);
  }
}
