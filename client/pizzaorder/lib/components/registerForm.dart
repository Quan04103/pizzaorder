import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pizzaorder/components/login_button_2.dart';
import 'package:http/http.dart' as http;
import '../ui/log_in.dart';
import 'textField.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  bool _isNotValidate = false;

  void _validateFields() {
    setState(() {
      _isNotValidate = _nameController.text.isEmpty ||
          _phoneController.text.isEmpty ||
          _emailController.text.isEmpty ||
          _userNameController.text.isEmpty ||
          _passwordController.text.isEmpty ||
          _confirmPasswordController.text.isEmpty ||
          _passwordController.text != _confirmPasswordController.text;
    });
  }

  // void registerUser() async {
  //   if (_nameController.text.isNotEmpty &&
  //       _phoneController.text.isNotEmpty &&
  //       _emailController.text.isNotEmpty &&
  //       _userNameController.text.isNotEmpty &&
  //       _passwordController.text.isNotEmpty &&
  //       _confirmPasswordController.text.isNotEmpty) {
  //     if (_passwordController.text == _confirmPasswordController.text) {
  //       var regBody = {
  //         "email": _emailController.text,
  //       };
  //       print('ok');
  //     }
  //   } else {
  //     setState(() {
  //       _isNotValidate = true;
  //     });
  //   }
  // }

  void registerUser() async {
    _validateFields();
    if (!_isNotValidate) {
      var regBody = {
        "nameProfile": _nameController.text,
        "number": _phoneController.text,
        "email": _emailController.text,
        "username": _userNameController.text,
        "password": _passwordController.text,
        "address": null
      };

      var response = await http.post(
        Uri.parse('http://localhost:5000/registration'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );
      var jsonResponse = jsonDecode(response.body);

      print(jsonResponse['status']);

      //print("Data : $regBody");
    }
    // username, password, nameProfile, number, address, email   IPv4 Address. . . . . . . . . . . : 192.168.1.9
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
                'Đăng kí mới',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
          ),
          RoundedTextField(
            controller: _nameController,
            labelText: 'Họ và tên',
            height: 70,
            errorText: _isNotValidate && _nameController.text.isEmpty
                ? 'Đây là thông tin bắt buộc'
                : null,
          ),
          const SizedBox(
            height: 5,
          ),
          RoundedTextField(
            controller: _userNameController,
            labelText: 'Tài khoản',
            height: 70,
            errorText: _isNotValidate && _userNameController.text.isEmpty
                ? 'Đây là thông tin bắt buộc'
                : null,
          ),
          const SizedBox(
            height: 5,
          ),
          RoundedTextField(
            controller: _phoneController,
            labelText: 'Số điện thoại',
            height: 70,
            errorText: _isNotValidate && _phoneController.text.isEmpty
                ? 'Đây là thông tin bắt buộc'
                : null,
          ),
          const SizedBox(
            height: 5,
          ),
          RoundedTextField(
            controller: _emailController,
            labelText: 'Địa chỉ email',
            height: 70,
            errorText: _isNotValidate ? 'Đây là thông tin bắt buộc' : null,
          ),
          const SizedBox(
            height: 5,
          ),
          RoundedTextField(
            controller: _passwordController,
            labelText: 'Mật khẩu',
            height: 70,
            errorText: _isNotValidate ? 'Đây là thông tin bắt buộc' : null,
          ),
          const SizedBox(
            height: 5,
          ),
          RoundedTextField(
            controller: _confirmPasswordController,
            labelText: 'Xác nhận mật khẩu',
            height: 70,
            errorText: _isNotValidate ? 'Đây là thông tin bắt buộc' : null,
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
                      builder: (context) => const Login(),
                    ),
                  );
                },
                child: const Text(
                  'Đã có tài khoản ?',
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
            value: 'Đăng kí',
            height: 200,
            width: 40,
            fontSize: 30,
            onPressed: registerUser,
          )
        ],
      ),
    );
  }
}
