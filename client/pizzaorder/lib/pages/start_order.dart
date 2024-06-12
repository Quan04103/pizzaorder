import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pizzaorder/pages/access_method.dart';

class StartOrder extends StatefulWidget {
  const StartOrder({super.key});

  @override
  State<StartOrder> createState() => _StartOrderState();
}

class _StartOrderState extends State<StartOrder> {
  void _onPressAccessMethod() {
    final router = GoRouter.of(context);
    router.go('/accessmethod');
  }

  //final Constants _constants = Constants();
  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "assets/images/get_started_2.jpg"), // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Centered button
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: ElevatedButton(
                onPressed: () {
                  _onPressAccessMethod();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 0, 0),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 16,
                  ), // Adjust padding
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon
                    // Add space between icon and text
                    Text(
                      'Order tại đây    ',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ), // Text with increased font size
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
