import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  static const _unit = 8.0;
  final TextEditingController controller;
  final String? placeholder;
  final bool obscureText;

  const Input({
    Key? key,
    required this.controller,
    required this.placeholder,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: _unit * 3),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(_unit)),
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple),
              borderRadius: BorderRadius.all(Radius.circular(_unit))),
          hintText: placeholder,
          fillColor: Colors.grey[200],
          filled: true,
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final function;
  final String text;
  final Color? color;
  final Color? textColor;
  static const _unit = 8.0;
  const Button({
    Key? key,
    required this.function,
    required this.text,
    this.color = Colors.deepPurple,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: _unit * 3),
        child: Container(
          padding: const EdgeInsets.all(_unit * 2),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(_unit),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
