import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzaorder/pages/home_page.dart';
import 'package:pizzaorder/pages/location_page.dart';
import 'package:pizzaorder/pages/history_page.dart';
import 'package:pizzaorder/components/pizza_card_gird.dart';
import 'package:pizzaorder/pages/all_product_page.dart';
import 'package:pizzaorder/pages/favorites_page.dart';
import 'package:pizzaorder/pages/giohang.dart';
import './pages/all_product_page.dart';
import 'pizzaorder/bloc/pizza/pizza_bloc.dart';
import 'pizzaorder/services/product_service.dart';
import './pages/giohang.dart';
import './pages/detail_Product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: PizzaDetails()),
    );
  }
}
