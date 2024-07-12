import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzaorder/components/BottomNavigationBar.dart';
import 'package:pizzaorder/components/product_item_bagcart.dart';
import 'package:pizzaorder/pages/emptycart.dart';
import 'package:pizzaorder/pages/giohang.dart';
import 'package:pizzaorder/pizzaorder/bloc/cart/cart_bloc.dart';
import 'package:pizzaorder/pizzaorder/bloc/cart/cart_state.dart';
import 'package:pizzaorder/pizzaorder/models/product.dart';
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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage>  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  int _cartItemCount = 0;
  bool _isCartAnimating = false;
  int _selectedIndex1 = 0;

  late CartBloc cartBloc;

  @override
  void initState() {
    super.initState();
    // Initialization moved to a method that is called within build method
  }
  void _onPressed () {
    final router = GoRouter.of(context);
    if (cartBloc.cartItems.isEmpty) {
      router.go('/emptycart');
    } else {
      router.go('/bagcart');
    }
  }
  void triggerCartAnimation() {
    setState(() {
      _cartItemCount++;
      _isCartAnimating = true;
    });

    // Reset animation flag after a short delay
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isCartAnimating = false;
      });
    });
  }

  void _onPressFavoritesPage() {
    final router = GoRouter.of(context);
    router.go('/favoritepage');
  }

  void _onItemTapped1(int index) {
    setState(() {
      _selectedIndex1 = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    cartBloc = BlocProvider.of<CartBloc>(context);

    return Scaffold(
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
                const SizedBox(height: 20),
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
                const SizedBox(height: 10),
                Search(),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: slide(),
                ),
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
                  _onPressed();
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex1: _selectedIndex1,
        onItemTapped1: _onItemTapped1,
      ),
    );
  }

  Widget _buildOrder() {
    return BlocBuilder<CartBloc, CartState>(
      bloc: cartBloc,
      builder: (context, state) {
        if (state.cartItems.isEmpty) {
          return const EmptyCart();
        } else {      
          return GioHang(); 
        }
      },
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

    if (pizzaBloc.state.products == null || !pizzaBloc.state.isLoaded) {
      // Nếu chưa tải, gửi sự kiện để tải sản phẩm mới nhất
      pizzaBloc.add(LoadProduct(loadNewest: true, categoryId: ''));
    }
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