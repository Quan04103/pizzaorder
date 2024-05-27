import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pizzaorder/components/textField.dart';
import 'package:pizzaorder/ui/home.dart';
import 'dart:convert';
import 'login_button_2.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isNotValidate = false;
  void _validateFields() {
    setState(() {
      _isNotValidate =
          _usernameController.text.isEmpty || _passwordController.text.isEmpty;
    });
  }

  void _login() async {
    var response = {};
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: Center(
              child: Text(
                'Đăng nhập',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
          ),
          RoundedTextField(
            controller: _usernameController,
            labelText: 'Tài khoản',
            errorText: 'Vui lòng điền vào ô này',
            height: 70,
          ),
          RoundedTextField(
            controller: _passwordController,
            labelText: 'Mật khẩu',
            errorText: 'Vui lòng điền vào ô này',
            height: 70,
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 25),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
                child: const Text(
                  'Quên mật khẩu ?',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const LoginButton2(
            value: 'Đăng nhập',
            height: 200,
            width: 40,
            fontSize: 30,
          )
        ],
      ),
    );
  }
}
