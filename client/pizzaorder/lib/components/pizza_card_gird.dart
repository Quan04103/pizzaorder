import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzaorder/pizzaorder/bloc/pizza/pizza_event.dart';
import 'pizza_card.dart';
import '../pizzaorder/bloc/pizza/pizza_bloc.dart';
import '../pizzaorder/bloc/pizza/pizza_state.dart';

class PizzaCardGird extends StatefulWidget {
  const PizzaCardGird({super.key});

  @override
  _PizzaCardGirdState createState() => _PizzaCardGirdState();
}

class _PizzaCardGirdState extends State<PizzaCardGird> {
  late PizzaBloc pizzaBloc;

  @override
  void initState() {
    super.initState();
    pizzaBloc = PizzaBloc();
    pizzaBloc.add(LoadProduct(loadNewest: true, categoryId: ''));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PizzaBloc, PizzaState>(
      bloc: pizzaBloc,
      builder: (context, state) {
        print('State: $state');
        if (state.isLoading) {
          return const CircularProgressIndicator();
        } else if (state.products == null || !state.isLoaded) {
          return const SizedBox();
        } else {
          return SizedBox(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.35,
              children: List.generate(state.products!.length, (index) {
                return Center(
                    child: PizzaCard(product: state.products![index]));
              }),
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    pizzaBloc.close();
    super.dispose();
  }
}
