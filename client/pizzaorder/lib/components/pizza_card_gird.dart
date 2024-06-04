import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzaorder/pizzaorder/bloc/product/product_event.dart';
import 'pizza_card.dart';
import '../pizzaorder/bloc/product/product_bloc.dart';
import '../pizzaorder/bloc/product/product_state.dart';

import '../pizzaorder/bloc/product/product_bloc.dart';
import '../pizzaorder/bloc/product/product_state.dart';

class PizzaCardGird extends StatefulWidget {
  const PizzaCardGird({super.key});

  @override
  _PizzaCardGirdState createState() => _PizzaCardGirdState();
}

class _PizzaCardGirdState extends State<PizzaCardGird> {
  late ProductBloc productBloc;

  @override
  void initState() {
    super.initState();
    productBloc = ProductBloc();
    productBloc.send(LoadProduct.load);
  }

  @override 
  Widget build(BuildContext context) {
    return StreamBuilder<ProductState>(
      stream: productBloc.state,
      builder: (context, snapshot) {
        final state = snapshot.data;
        print('State: $state');
        if (state == null) {
          return const CircularProgressIndicator();
        } else if (state.isLoading) {
          return const CircularProgressIndicator();
        } else if (state.isLoaded) {
          final products = state.products;
          if (products == null) {
            return const SizedBox();
          } else {
            return SizedBox(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.35,
                children: List.generate(products.length, (index) {
                  return Center(child: PizzaCard(product: products[index]));
                }),
              ),
            );
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }

  @override
  void dispose() {
    productBloc.dispose();
    super.dispose();
  }
}
