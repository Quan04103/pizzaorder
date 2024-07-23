import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pizzaorder/mapTracking.dart';
import 'package:pizzaorder/pages/access_method.dart';
import 'package:pizzaorder/pages/account.dart';
import 'package:pizzaorder/pages/complete_payment.dart';
import 'package:pizzaorder/pages/edit_user.dart';
import 'package:pizzaorder/pages/emptycart.dart';
import 'package:pizzaorder/pages/favorites_page.dart';
import 'package:pizzaorder/pages/all_product_page.dart';
import 'package:pizzaorder/pages/get_started.dart';
import 'package:pizzaorder/pages/giohang.dart';
import 'package:pizzaorder/pages/history_page.dart';
import 'package:pizzaorder/pages/log_in.dart';
import 'package:pizzaorder/pages/log_out.dart';
import 'package:pizzaorder/pages/myVoucher.dart';
import 'package:pizzaorder/pages/payment_page_.dart';
import 'package:pizzaorder/pages/sign_up.dart';
import 'package:pizzaorder/pages/start_order.dart';
import 'package:pizzaorder/pages/voucher_page.dart';
import 'package:pizzaorder/pizzaorder/models/product.dart';
import 'package:pizzaorder/testmap.dart';
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
          path: '/bagcart',
          builder: (context, state) => const GioHang(),
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
          path: '/logout',
          builder: (context, state) => const LogOut(),
        ),
        GoRoute(
          path: '/signup',
          builder: (context, state) => const SignUp(),
        ),
        GoRoute(
          path: '/edituser',
          builder: (context, state) {
            final token = state.extra as String;
            return EditUserProfilePage(token: token);
          },
        ),
        GoRoute(
          path: '/paymentCompelete',
          builder: (context, state) => const CompletePayment(),
        ),
        // GoRoute(
        //   path: '/payment',
        //   builder: (context, state) => const PaymentPage(totalSales: null,),
        // ),
        GoRoute(
          path: '/map',
          builder: (context, state) => const FullMapTest(),
        ),
        GoRoute(
          path: '/discounts',
          builder: (context, state) => const VoucherPage(),
        ),
        GoRoute(
          path: '/myvoucher',
          builder: (context, state) => const MyVoucher(),
        ),
        GoRoute(
          path: '/emptycart',
          builder: (context, state) => const EmptyCart(),
        ),
        GoRoute(
          path: '/all',
          builder: (context, state) => const AllProductPage(
            categoryId: '6646fc283146973b72ad5eb2',
          ),
        ),
        GoRoute(
          path: '/historypage',
          builder: (context, state) => const HistoryPage(),
        ),

        GoRoute(
          path: '/maptracking',
          builder: (context, state) => const MapTracking(),
        ),

        GoRoute(
          path: '/account',
          builder: (context, state) {
            final token = state.extra as String;
            return Account(token: token);
          },
        ),
        // GoRoute(
        //   path: '/',
        //   builder: (context, state) => const GetStarted(),
        // ),
        // GoRoute(
        //   path: '/',
        //   builder: (context, state) => const StartOrder(),
        // ),
        GoRoute(
          path: '/favoritepage',
          builder: (context, state) => FavoritePage(),
        ),
      ],
    );
  }

  void initSharedPref() async {
    pref = await SharedPreferences.getInstance();
  }
}
