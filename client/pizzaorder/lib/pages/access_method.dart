//import 'package:domini_pizza/Constants.dart';

import 'package:flutter/material.dart';
import 'package:pizzaorder/components/login_button.dart';
import 'package:pizzaorder/pages/log_in.dart';
import 'package:pizzaorder/pages/sign_up.dart';

class AccessMethod extends StatefulWidget {
  const AccessMethod({super.key});

  @override
  State<AccessMethod> createState() => _AccessMethodState();
}

class _AccessMethodState extends State<AccessMethod> {
  //final Constants _constants = Constants();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/access.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 140,
            left: 0,
            right: 0,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: LoginButton(
                  value: 'Đăng nhập',
                  height: 200,
                  width: 50,
                  fontSize: 18,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: LoginButton(
                  value: 'Đăng kí',
                  height: 200,
                  width: 50,
                  fontSize: 18,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUp(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 20, bottom: 20),
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const HomePage()));
                },
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Bỏ qua đăng nhập',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.only(left: 4.0),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
