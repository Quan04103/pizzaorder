import 'package:flutter/material.dart';
import 'package:pizzaorder/pages/home_page.dart';
import 'package:pizzaorder/pages/location_page.dart';
import 'package:pizzaorder/pages/history_page.dart';
import 'package:pizzaorder/components/pizza_card_gird.dart';
import 'package:pizzaorder/pages/all_product_page.dart';
import 'package:pizzaorder/pages/favorites_page.dart';

import 'ui/get_started.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
<<<<<<< HEAD
      home: Scaffold(body: AllProductPage()),
=======
      title: 'DOMINI PIZZA',
      home: GetStarted(),
      debugShowCheckedModeBanner: false,
>>>>>>> ca086a72241af67e7e0802b0b3fc697a1cf12ecc
    );
  }
}
