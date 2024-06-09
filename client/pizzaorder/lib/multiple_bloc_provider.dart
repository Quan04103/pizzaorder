import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzaorder/pizzaorder/bloc/pizza/pizza_bloc.dart';

MultiBlocProvider createBlocProviders({required Widget child}) {
  return MultiBlocProvider(
    providers: [
      BlocProvider<PizzaBloc>(
        create: (context) => PizzaBloc(),
      ),
      // BlocProvider<AnotherBloc>(
      //   create: (context) => AnotherBloc(),
      // ),
      // Thêm các BlocProvider khác ở đây
    ],
    child: child,
  );
}
