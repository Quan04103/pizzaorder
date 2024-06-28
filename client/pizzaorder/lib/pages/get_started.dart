import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';

import 'package:pizzaorder/pages/start_order.dart'; // Import thư viện để sử dụng Timer
import 'package:pizzaorder/pages/home_page.dart'; // Import trang chuyển đến

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  void initState() {
    final router = GoRouter.of(context);

    super.initState();
    // Tạo một Timer để đếm ngược 5 giây và sau đó chuyển đến trang mới
    Timer(const Duration(seconds: 5), () {
      router.go('/startorder');
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const StartOrder(),
      //   ),
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/get_started.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: Text(
            'DOMINI PIZZA',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Schuyler',
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
