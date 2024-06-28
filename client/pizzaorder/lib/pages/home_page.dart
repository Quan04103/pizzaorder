
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pizzaorder/pizzaorder/models/product.dart';
import '../components/category_carousel.dart';
import '../components/pizza_card.dart';
import '../components/shopping_cart_btn.dart';
import '../components/dropdown_home.dart';
import '../components/slide.dart';
import '../components/search.dart';
import '../pizzaorder/bloc/pizza/pizza_bloc.dart';
import '../pizzaorder/bloc/pizza/pizza_state.dart';
import '../pizzaorder/bloc/pizza/pizza_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 25,
          backgroundColor: Colors.red,
        ),
        backgroundColor: Colors.green[50],
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DropdownHome(),
                      Icon(
                        Icons.favorite_border,
                        color: Colors.black,
                        size: 35,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Search(),
                  const SizedBox(
                    height: 10,
                  ),
                  slide(),
                  const Padding(
                    padding: EdgeInsets.only(right: 270),
                    child: Text(
                      'Categories',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const SizedBox(
                    height: 100,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: CategoriesCarousel(),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 300),
                    child: Text(
                      'Newest',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const SizedBox(
                    height: 280,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: ProductsCarousel(),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 130,
                right: 10,
                child: ShoppingCartButton(
                  onPressed: () {
                    GoRouter.of(context).go('/bagcart');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductsCarousel extends StatefulWidget {
  const ProductsCarousel({super.key});
  @override
  _ProductsCarouselState createState() => _ProductsCarouselState();
}

class _ProductsCarouselState extends State<ProductsCarousel> {
  late PizzaBloc pizzaBloc;

  @override
  void initState() {
    super.initState();
    pizzaBloc = BlocProvider.of<PizzaBloc>(context);
    pizzaBloc.add(LoadProduct.loadNewest);
  }

  void _onProductPressed(ProductModel product) {
    final router = GoRouter.of(context);
    router.go('/detail', extra: product);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PizzaBloc, PizzaState>(
      bloc: pizzaBloc,
      builder: (context, state) {
        if (state.isLoading) {
          return const CircularProgressIndicator();
        } else if (state.products == null || !state.isLoaded) {
          return const SizedBox();
        } else {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.products!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  _onProductPressed(state.products![index]);
                },
                child: PizzaCard(
                  product: state.products![index],
                ),
              );
            },
          );
        }
      },
    );
  }
}
