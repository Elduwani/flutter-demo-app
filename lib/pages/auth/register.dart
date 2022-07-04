import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../components/input.dart';

class RegisterPage extends StatefulWidget {
  // Fields in a Widget subclass are always marked "final".
  final VoidCallback toggleScreen;
  const RegisterPage({
    Key? key,
    required this.toggleScreen,
  }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  static const _unit = 8.0;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (confirmedPassword()) {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
    }
  }

  bool confirmedPassword() => _passwordController == _confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Register',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: _unit * 3,
                ),
              ),
              const SizedBox(height: _unit),
              const Text('Register to create an account'),

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

              //INPUT 3
              const SizedBox(height: _unit * 2),
              Input(
                placeholder: "Confirm Password",
                controller: _confirmPasswordController,
                obscureText: true,
              ),

              //BUTTON
              const SizedBox(height: _unit * 2),
              Button(function: signUp, text: "Sign Up"),

              //Text
              const SizedBox(height: _unit * 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: widget.toggleScreen,
                    child: Text(
                      "Sign In",
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
