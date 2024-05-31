import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pizzaorder/components/login_button_2.dart';
import 'package:http/http.dart' as http;
import '../pages/log_in.dart';
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

  void registerUser() async {
    _validateFields();
    if (!_isNotValidate) {
      var regBody = {
        "username": _userNameController.text,
        "password": _passwordController.text,
        "nameProfile": _nameController.text,
        "number": _phoneController.text,
        "address": "Tp.HCM",
        "email": _emailController.text
      };

      try {
        var response = await http.post(
          Uri.parse(
              'http://10.0.2.2:5000/registration'), // Adjust IP if using an emulator
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
            errorText: _isNotValidate && _emailController.text.isEmpty
                ? 'Đây là thông tin bắt buộc'
                : null,
          ),
          const SizedBox(
            height: 5,
          ),
          RoundedTextField(
            controller: _passwordController,
            labelText: 'Mật khẩu',
            height: 70,
            errorText: _isNotValidate && _passwordController.text.isEmpty
                ? 'Đây là thông tin bắt buộc'
                : null,
          ),
          const SizedBox(
            height: 5,
          ),
          RoundedTextField(
            controller: _confirmPasswordController,
            labelText: 'Xác nhận mật khẩu',
            height: 70,
            errorText: _isNotValidate && _confirmPasswordController.text.isEmpty
                ? 'Đây là thông tin bắt buộc'
                : null,
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
