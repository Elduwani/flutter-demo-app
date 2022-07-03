import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const _unit = 8.0;

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hello ${FirebaseAuth.instance.currentUser?.email}",
            ),
            const SizedBox(height: _unit * 2),
            GestureDetector(
              onTap: signOut,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: _unit * 3),
                child: Container(
                  padding: const EdgeInsets.all(_unit * 2),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(_unit),
                  ),
                  child: const Center(
                      child: Text(
                    'Sign Out',
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
