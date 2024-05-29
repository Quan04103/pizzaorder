import 'package:flutter/material.dart';
import 'package:pizzaorder/home_page.dart';
import 'package:pizzaorder/location_page.dart';
import 'package:pizzaorder/history_page.dart';
import 'package:pizzaorder/pizza_card_gird.dart';
import 'package:pizzaorder/all_product_page.dart';
import 'package:pizzaorder/favorites_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: AllProductPage()),
    );
  }
}
