import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pizzaorder/components/BottomNavigationBar.dart';
import 'package:pizzaorder/pizzaorder/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/category_carousel.dart';
import '../components/pizza_card.dart';
import '../components/shopping_cart_btn.dart';
import '../components/dropdown_home.dart';
import '../components/slide.dart';
import '../components/pizza_suggest.dart';
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

final ScrollController _scrollController = ScrollController();

class _HomePageState extends State<HomePage> {

  void _onPressFavoritesPage() {
    final router = GoRouter.of(context);
    router.go('/favoritepage');
  }

  int _selectedIndex1 = 0;

  void _onItemTapped1(int index) {
    setState(() {
      _selectedIndex1 = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 25,
          backgroundColor: Colors.red,
        ),
        backgroundColor: Colors.green[50],
        body: Stack(
          children: [
            ListView(
              controller: _scrollController,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DropdownHome(),
                    // IconButton(
                    //   onPressed: () {
                    //     _onPressFavoritesPage();
                    //   },
                    //   icon: Icon(Icons.favorite_border),
                    //   color: Colors.black,
                    //   iconSize: 35,
                    // ),
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
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    'Loại sản phẩm',
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
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    'Sản phẩm mới nhất',
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
                const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    'Dành cho bạn',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 2000,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: PizzaSuggest(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      10, 0, 10, 60), // Loại bỏ padding
                  child: Align(
                    alignment: Alignment.center, // Căn giữa màn hình
                    child: SizedBox(
                      width: 30, // Chiều rộng 50
                      height: 30, // Chiều cao 50
                      child: FloatingActionButton(
                        backgroundColor: Colors.white, // Màu nền
                        onPressed: () {
                          _scrollController.animateTo(
                            0.0,
                            curve: Curves.easeOut,
                            duration: const Duration(milliseconds: 300),
                          );
                        },
                        child: const Icon(Icons.arrow_upward),
                      ),
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
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex1: _selectedIndex1,
          onItemTapped1: _onItemTapped1,
        ),
      ),
    );
  }

  // @override
  // void dispose() {
  //   _scrollController.dispose();
  //   super.dispose();
  // }
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
    if (pizzaBloc.state.products == null || !pizzaBloc.state.isLoaded) {
      pizzaBloc.add(LoadProduct.loadNewest);
    }
    //pizzaBloc.add(LoadProduct.loadNewest);
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
