import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:go_router/go_router.dart';
import 'package:pizzaorder/pizzaorder/bloc/cart/cart_state.dart';

class PaymentPage extends StatefulWidget {
  final double totalSales;
  const PaymentPage({super.key, required this.totalSales});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? _selectedMethod;
  String? apiUrl;

  @override
  void initState() {
    super.initState();
    apiUrl = dotenv.env['API_URL'];
    print('API URL: $apiUrl'); // Debug line to verify API URL
  }

  Future<void> _initiatePayment() async {
    final response = await http.post(
      Uri.parse('$apiUrl/payment'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: json.encode({
        'app_user': 'test_user',
        'amount': widget.totalSales
      }), // Replace with actual data
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      final paymentUrl =
          result['order_url']; // Adjust based on your backend response

      if (paymentUrl != null) {
        _launchURL(paymentUrl);
      } else {
        print('Payment URL not found in response');
      }
    } else {
      print('Failed to create payment');
    }
  }

  void _launchURL(String url) async {
    try {
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url, mode: LaunchMode.externalApplication);
        GoRouter.of(context).go('/paymentCompelete');
      } else {
        print('Could not launch $url');
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              GoRouter.of(context).go('/');
            },
          ),
          title: const Text(
            'Phương thức thanh toán',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
        backgroundColor: Colors.green[50],
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            margin: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                ),
              ],
            ),
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8.0),
              children: <Widget>[
                RadioListTile<String>(
                  title: const Row(
                    children: <Widget>[
                      Icon(Icons.attach_money_rounded,
                          color: Color.fromARGB(255, 59, 23, 11)),
                      SizedBox(width: 10),
                      Text('Thanh toán khi nhận hàng'),
                    ],
                  ),
                  value: 'Thanh toán khi nhận hàng',
                  groupValue: _selectedMethod,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedMethod = value!;
                      if (_selectedMethod == 'Thanh toán khi nhận hàng') {
                        GoRouter.of(context).go('/paymentCompelete');
                      }
                    });
                  },
                ),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: const Divider()),
                RadioListTile<String>(
                  title: Row(
                    children: <Widget>[
                      Image.asset('assets/images/img_logo_zalopay.png',
                          height: 40),
                      const SizedBox(width: 10),
                      const Text('ZaloPay'),
                    ],
                  ),
                  value: 'ZaloPay',
                  groupValue: _selectedMethod,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedMethod = value!;
                      _initiatePayment();
                    });
                  },
                ),
              ],
            ),
          ),
        ]));
  }
}
