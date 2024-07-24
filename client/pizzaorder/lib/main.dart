import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pizzaorder/pages/home_page.dart';
import 'package:pizzaorder/pages/location_page.dart';
import 'package:pizzaorder/pages/history_page.dart';
import 'package:pizzaorder/components/pizza_card_gird.dart';
import 'package:pizzaorder/pages/all_product_page.dart';
import 'package:pizzaorder/pages/favorites_page.dart';
import 'package:pizzaorder/pages/giohang.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './pages/all_product_page.dart';
import 'pizzaorder/bloc/pizza/pizza_bloc.dart';
import 'pizzaorder/services/product_service.dart';
import './pages/giohang.dart';
import './pages/detail_Product.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app_router.dart';
import 'multiple_bloc_provider.dart';

late SharedPreferences sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await dotenv.load();
  final AppRouter appRouter = AppRouter();
  runApp(
    createRepositoryAndBlocProviders(
      child: MyApp(router: appRouter.router),
    ),
  );
}

class MyApp extends StatelessWidget {
  final GoRouter router;
  const MyApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
      debugShowCheckedModeBanner: false,
    );
  }
}
