import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pizzaorder/components/login_button_2.dart';
import 'package:pizzaorder/components/textField.dart';
import 'package:pizzaorder/pages/account.dart';
import 'package:pizzaorder/pages/sign_up.dart';
import 'package:pizzaorder/pizzaorder/bloc/auth/auth_bloc.dart';
import 'package:pizzaorder/pizzaorder/bloc/auth/auth_event.dart';
import 'package:pizzaorder/pizzaorder/bloc/auth/auth_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isNotValidate = false;
  String? _errorMessage;
  late SharedPreferences pref;
  bool _isCompleted = false;

  void _onPressSignUp() {
    final router = GoRouter.of(context);
    router.go('/signup');
  }

  void _onLogginButtonPressed(String token) {
    final router = GoRouter.of(context);
    router.go('/account', extra: token);
  }

  void _validateFields() {
    setState(() {
      _isNotValidate =
          _userNameController.text.isEmpty || _passwordController.text.isEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    pref = await SharedPreferences.getInstance();
  }

  void loginUser() {
    _validateFields();
    if (!_isNotValidate) {
      BlocProvider.of<AuthBloc>(context).add(AuthLoginStarted(
        username: _userNameController.text,
        password: _passwordController.text,
      ));
      setState(() {
        _isCompleted = false;
      });
    } else {
      setState(() {
        _errorMessage = 'Vui lòng nhập tài khoản và mật khẩu.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
      child: BlocListener<AuthBloc, AuthState> (
        listener: (context, state) async {
          if (state is AuthLoginSuccess) {
            final token = pref.getString('token');
            setState(() {
              _isCompleted = true;
            });
            await Future.delayed(const Duration(seconds: 3));
            _onLogginButtonPressed(token ?? '');
          } else if (state is AuthLoginFailure) {
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
                  isPassword: false,
                ),
                RoundedTextField(
                  controller: _passwordController,
                  labelText: 'Mật khẩu',
                  errorText: _isNotValidate && _passwordController.text.isEmpty
                      ? 'Đây là thông tin bắt buộc'
                      : null,
                  height: 70,
                  isPassword: true,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _onPressSignUp();
                      },
                      child: const Text(
                        'Tạo tài khoản mới ?',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Quên mật khẩu ?',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                LoginButton2(
                  value: 'Đăng nhập',
                  height: 200,
                  width: 40,
                  fontSize: 30,
                  onPressed: loginUser,
                ),
                // BlocBuilder<AuthBloc, AuthState>(
                //   builder: (context, state) {
                //     if (state is AuthLoginInProgress) {
                //       return const Center(child: CircularProgressIndicator());
                //     }
                //     return const SizedBox.shrink();
                //   },
                // ),
                if (_errorMessage != null)
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
                bottom: 10,
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
    );
  }
}
