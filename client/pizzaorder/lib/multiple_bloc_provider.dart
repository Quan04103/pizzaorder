import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzaorder/pizzaorder/bloc/auth/auth_bloc.dart';
import 'package:pizzaorder/pizzaorder/bloc/cart/cart_bloc.dart';
import 'package:pizzaorder/pizzaorder/bloc/coupon/coupon_bloc.dart';
import 'package:pizzaorder/pizzaorder/bloc/favorite/favorite_bloc.dart';
import 'package:pizzaorder/pizzaorder/bloc/pizza/pizza_bloc.dart';
import 'package:pizzaorder/pizzaorder/services/order_service.dart';
import 'package:pizzaorder/pizzaorder/services/user_service.dart';

MultiRepositoryProvider createRepositoryAndBlocProviders(
    {required Widget child}) {
      final couponBloc = CouponBloc();
  return MultiRepositoryProvider(
    providers: [
      // Thêm các RepositoryProvider khác ở đây
      RepositoryProvider<UserService>(
        create: (context) => UserService(),
      ),
      RepositoryProvider<OrderService>(
        create: (context) => OrderService(),
      ),
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider<PizzaBloc>(
          create: (context) => PizzaBloc(),
        ),
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(couponBloc),
        ),
         BlocProvider<CouponBloc>(
          create: (context) => CouponBloc(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            RepositoryProvider.of<UserService>(context),
          ),
        ),
        // BlocProvider<AnotherBloc>(
        //   create: (context) => AnotherBloc(),
        // ),
        // Thêm các BlocProvider khác ở đây
        BlocProvider(
          create: (context) => FavoriteBloc(),
        ),
      ],
      child: child,
    ),
  );
}
