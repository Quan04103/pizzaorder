import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final double height;
  final String? errorText;
  final bool isPassword;

  const RoundedTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.height = 0,
    required this.errorText,
    required this.isPassword,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextField(
        obscureText: isPassword,
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          errorStyle: const TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
          errorText: errorText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                height / 2), // BorderRadius for the TextField
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                height / 2), // BorderRadius for the TextField when enabled
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 0, 0, 0), // Border color when enabled
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                height / 2), // BorderRadius for the TextField when focused
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 0, 0, 0), // Border color when focused
              width: 2.0,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
              vertical: 16.0, horizontal: 16.0), // Padding for the content
        ),
      ),
    );
  }
}
