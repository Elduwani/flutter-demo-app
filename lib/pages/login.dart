import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  // Fields in a Widget subclass are always marked "final".
  final String title;

  const LoginPage({Key? key, required this.title}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _username = 'Elduwani';
  static const _unit = 8.0;

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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: _unit * 3),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Padding(
                    padding: EdgeInsets.only(left: _unit * 2),
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Enter Email"),
                    ),
                  ),
                ),
              ),

              //INPUT 2
              const SizedBox(height: _unit),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: _unit * 3),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(_unit)),
                  child: const Padding(
                    padding: EdgeInsets.only(left: _unit * 2),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Enter Password"),
                    ),
                  ),
                ),
              ),

              //BUTTON
              const SizedBox(height: _unit),
              Padding(
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

              //Text
              const SizedBox(height: _unit * 1.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Not a member? "),
                  Text(
                    "Register now",
                    style: TextStyle(
                      color: Colors.blue[600],
                      fontWeight: FontWeight.bold,
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
