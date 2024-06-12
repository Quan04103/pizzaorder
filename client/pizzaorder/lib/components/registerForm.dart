import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pizzaorder/components/login_button_2.dart';
import 'package:pizzaorder/components/textField.dart';
import 'package:pizzaorder/pages/log_in.dart';
import 'package:pizzaorder/pizzaorder/bloc/auth/auth_bloc.dart';
import 'package:pizzaorder/pizzaorder/bloc/auth/auth_event.dart';
import 'package:pizzaorder/pizzaorder/bloc/auth/auth_state.dart';

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
  String? _errorMessage;
  bool _isNotValidate = false;
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();
    _errorMessage = '';
  }

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
      BlocProvider.of<AuthBloc>(context).add(AuthRegisterStarted(
        username: _userNameController.text,
        password: _passwordController.text,
        nameProfile: _nameController.text,
        phone: _phoneController.text,
        email: _emailController.text,
        address: 'Trống',
      ));
      setState(() {
        _isCompleted = false;
      });
    } else {
      setState(() {
        _errorMessage = 'Vui lòng nhập tất cả các trường được yêu cầu';
      });
    }
  }

  void _onPressLogin() {
    final router = GoRouter.of(context);
    router.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) async {
            if (state is AuthRegisterSuccess) {
              setState(() {
                _isCompleted = true;
              });
              await Future.delayed(const Duration(seconds: 3));
              _onPressLogin();
            } else if (state is AuthRegisterFailure) {
              setState(() {
                _errorMessage = state.message;
              });
            }
          },
          child: Stack(
            children: [
              Column(
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
                    isPassword: false,
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
                    isPassword: false,
                    errorText:
                        _isNotValidate && _userNameController.text.isEmpty
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
                    isPassword: false,
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
                    isPassword: false,
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
                    isPassword: true,
                    errorText:
                        _isNotValidate && _passwordController.text.isEmpty
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
                    isPassword: true,
                    errorText: _isNotValidate &&
                            _confirmPasswordController.text.isEmpty
                        ? 'Đây là thông tin bắt buộc'
                        : null,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: GestureDetector(
                        onTap: () {
                          _onPressLogin();
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
                  ),
                  // BlocBuilder<AuthBloc, AuthState>(
                  //   builder: (context, state) {
                  //     if (state is AuthRegisterInProgress) {
                  //       return const Center(child: CircularProgressIndicator());
                  //     }
                  //     return const SizedBox.shrink();
                  //   },
                  // ),if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
              if (_isCompleted)
                Positioned(
                  top: 20,
                  child: Container(
                    height: size.height * 0.4,
                    width: size.width * 0.9,
                    decoration: const BoxDecoration(
                        // color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
