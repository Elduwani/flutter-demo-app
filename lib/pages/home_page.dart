import 'package:demo_app/components/input.dart';
import 'package:demo_app/pages/mine_sweeper.dart';
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
    return const MineSweeper();
    // return Scaffold(
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         // const MineSweeper(),
    //         Text("Hello ${FirebaseAuth.instance.currentUser?.email}"),
    //         const SizedBox(height: _unit * 2),
    //         Button(
    //           function: signOut,
    //           text: "Sign Out",
    //           color: Colors.grey[900],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
