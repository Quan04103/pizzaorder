import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzaorder/pizzaorder/bloc/auth/auth_bloc.dart';
import 'package:pizzaorder/pizzaorder/bloc/cart/cart_bloc.dart';
import 'package:pizzaorder/pizzaorder/bloc/pizza/pizza_bloc.dart';
import 'package:pizzaorder/pizzaorder/services/user_service.dart';

MultiRepositoryProvider createRepositoryAndBlocProviders(
    {required Widget child}) {
  return MultiRepositoryProvider(
    providers: [
      // Thêm các RepositoryProvider khác ở đây
      RepositoryProvider<UserService>(
        create: (context) => UserService(),
      ),
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider<PizzaBloc>(
          create: (context) => PizzaBloc(),
        ),
        BlocProvider(
          create: (context) => CartBloc(),
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
      ],
      child: child,
    ),
  );
}
