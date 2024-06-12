import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pizzaorder/pizzaorder/models/product.dart';
import 'pages/home_page.dart';
import 'pages/detail_Product.dart';

class AppRouter {
  late GoRouter router;

  AppRouter()
      : router = GoRouter(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const HomePage(),
            ),
            GoRoute(
              path: '/detail',
              builder: (context, state) {
                final product = state.extra as ProductModel;
                return PizzaDetails(product: product);
              },
            ),
          ],
        );
}
