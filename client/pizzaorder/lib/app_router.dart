import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pizzaorder/pages/access_method.dart';
import 'package:pizzaorder/pages/account.dart';
import 'package:pizzaorder/pages/edit_user.dart';
import 'package:pizzaorder/pages/get_started.dart';
import 'package:pizzaorder/pages/log_in.dart';
import 'package:pizzaorder/pages/log_out.dart';
import 'package:pizzaorder/pages/sign_up.dart';
import 'package:pizzaorder/pages/start_order.dart';
import 'package:pizzaorder/pizzaorder/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/home_page.dart';
import 'pages/detail_Product.dart';

class AppRouter {
  late GoRouter router;
  late SharedPreferences pref;

  AppRouter() {
    initSharedPref();
    router = GoRouter(
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/detail',
          builder: (context, state) {
            final product = state.extra as ProductModel;
            return PizzaDetails(product: product);
          },
        ),
        GoRoute(
          path: '/startorder',
          builder: (context, state) => const StartOrder(),
        ),
        GoRoute(
          path: '/accessmethod',
          builder: (context, state) => const AccessMethod(),
        ),
        GoRoute(
          path: '/',
          builder: (context, state) => const GetStarted(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const Login(),
        ),
        GoRoute(
          path: '/signup',
          builder: (context, state) => const SignUp(),
        ),
        GoRoute(
          path: '/logout',
          builder: (context, state) => const LogOut(),
        ),
        GoRoute(
          path: '/account',
          builder: (context, state) {
            final token = state.extra as String;
            return Account(token: token);
          },
        ),
        GoRoute(
          path: '/editUser',
          builder: (context, state) => const EditUserProfilePage(),
        ),
        // GoRoute(
        //   path: '/',
        //   builder: (context, state) => const GetStarted(),
        // ),
        // GoRoute(
        //   path: '/',
        //   builder: (context, state) => const StartOrder(),
        // ),
      ],
    );
  }

  void initSharedPref() async {
    pref = await SharedPreferences.getInstance();
  }
}
