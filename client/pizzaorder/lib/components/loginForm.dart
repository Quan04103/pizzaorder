import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pizzaorder/components/textField.dart';
import 'dart:convert';
import 'login_button_2.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isNotValidate = false;
  void _validateFields() {
    setState(() {
      _isNotValidate =
          _userNameController.text.isEmpty || _passwordController.text.isEmpty;
    });
  }

  void loginUser() async {
    _validateFields();
    if (!_isNotValidate) {
      var regBody = {
        "username": _userNameController.text,
        "password": _passwordController.text
      };

      try {
        var response = await http.post(
          Uri.parse('http://10.0.2.2:5000/login'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody),
        );

        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);
          print(jsonResponse['status']);
        } else {
          print('Request failed with status: ${response.statusCode}.');
          // Hiển thị thông báo lỗi từ server
        }

        print("Data : $regBody");
      } catch (e) {
        print('Error: $e');
      }
    } else {
      print("Please fill all fields");
    }
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
            controller: _userNameController,
            labelText: 'Tài khoản',
            errorText: _isNotValidate && _userNameController.text.isEmpty
                ? 'Đây là thông tin bắt buộc'
                : null,
            height: 70,
          ),
          RoundedTextField(
            controller: _passwordController,
            labelText: 'Mật khẩu',
            errorText: _isNotValidate && _passwordController.text.isEmpty
                ? 'Đây là thông tin bắt buộc'
                : null,
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
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const HomePage(),
                  //   ),
                  // );
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
          LoginButton2(
            value: 'Đăng nhập',
            height: 200,
            width: 40,
            fontSize: 30,
            onPressed: loginUser,
          )
        ],
      ),
    );
  }
}
