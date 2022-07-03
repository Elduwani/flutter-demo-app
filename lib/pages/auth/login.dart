import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'dart:developer' as devtools show log;

import '../../components/input.dart';

class LoginPage extends StatefulWidget {
  // Fields in a Widget subclass are always marked "final".
  final VoidCallback toggleScreen;
  const LoginPage({
    Key? key,
    required this.toggleScreen,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _username = 'Elduwani';
  static const _unit = 8.0;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {}
      if (e.code == 'wrong-password') {}
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign In',
                style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: _unit * 3),
              ),
              const SizedBox(height: _unit),
              Text('Welcome back, $_username'),

              //INPUT 1
              const SizedBox(height: _unit * 6),
              Input(
                placeholder: 'Enter email',
                controller: _emailController,
              ),

              //INPUT 2
              const SizedBox(height: _unit * 2),
              Input(
                placeholder: "Enter Password",
                controller: _passwordController,
                obscureText: true,
              ),

              //BUTTON
              const SizedBox(height: _unit * 2),
              GestureDetector(
                onTap: signIn,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: _unit * 3),
                  child: Container(
                    padding: const EdgeInsets.all(_unit * 2),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(_unit),
                    ),
                    child: const Center(
                        child: Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ),
              ),

              //Text
              const SizedBox(height: _unit * 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Not a member? "),
                  GestureDetector(
                    onTap: widget.toggleScreen,
                    child: Text(
                      "Register now",
                      style: TextStyle(
                        color: Colors.blue[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
