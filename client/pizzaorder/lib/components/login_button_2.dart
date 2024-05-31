import 'package:flutter/material.dart';

class LoginButton2 extends StatelessWidget {
  final String value;
  final double height;
  final double width;
  final double fontSize;
  final VoidCallback? onPressed;

  const LoginButton2({
    super.key,
    required this.value,
    required this.height,
    required this.width,
    required this.fontSize,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    //Constants constants = Constants();
    return Container(
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(131, 3, 3, 3),
            Color.fromARGB(255, 0, 0, 0),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
          elevation: MaterialStateProperty.all<double>(0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        child: Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
