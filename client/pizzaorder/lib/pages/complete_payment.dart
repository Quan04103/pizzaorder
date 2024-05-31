import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pizzaorder/components/login_button.dart';
import 'package:pizzaorder/pages/sign_up.dart';

class CompletePayment extends StatefulWidget {
  const CompletePayment({super.key});

  @override
  State<CompletePayment> createState() => _CompletePaymentState();
}

class _CompletePaymentState extends State<CompletePayment> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(235, 227, 255, 232),
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: size.width * .6,
              height: size.height * .4,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Image.asset(
                'assets/images/done.gif',
                width: 120,
                height: 120,
              ),
            ),
            const Text(
              'Đơn hàng của bạn đang được chuẩn bị !',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Vui lòng chờ ít phút nhé !',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: LoginButton(
                value: 'Theo dõi đơn hàng',
                height: 200,
                width: 50,
                fontSize: 18,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUp(),
                      //builder: (context) => const TrackingOrder(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
