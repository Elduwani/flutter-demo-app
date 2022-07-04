import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  final String text;
  const Box({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        color: Colors.grey[300],
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}

class Bomb extends StatelessWidget {
  final String text;
  const Bomb({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        color: Colors.grey[700],
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
