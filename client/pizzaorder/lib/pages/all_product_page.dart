import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pizzaorder/components/BottomNavigationBar.dart';
import 'package:pizzaorder/pizzaorder/bloc/cart/cart_bloc.dart';
import 'package:pizzaorder/pages/product_category_page.dart';
import '../components/pizza_card_gird.dart';
import '../components/category_carousel.dart';
import '../components/shopping_cart_btn.dart';
import '../components/dropdown_home.dart';
import '../components/search.dart';
// Assuming you place CustomBottomNavigationBar in a separate file

class AllProductPage extends StatefulWidget {
  final String categoryId;
  const AllProductPage({super.key, required this.categoryId});

  @override
  State<AllProductPage> createState() => _AllProductPageState();
}

class _AllProductPageState extends State<AllProductPage> {
  int _selectedIndex = 2;
  // late CartBloc cartBloc;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // void _onPressed() {
  //   final router = GoRouter.of(context);
  //   if (cartBloc.cartItems.isEmpty) {
  //     router.go('/emptycart');
  //   } else {
  //     router.go('/bagcart');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // cartBloc = BlocProvider.of<CartBloc>(context);
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        toolbarHeight: 25,
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DropdownHome(),
            ],
          ),
          const SizedBox(height: 15),
          const Search(),
          // Main content with stack for carousel and pizza cards
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: const CategoriesCarousel(),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.2,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  //child: const PizzaCardGird(),
                  child: ProductPage(
                    categoryId: widget.categoryId,
                  ),
                ),
                // Positioned(
                //   bottom: 130,
                //   right: 10,
                //   child: ShoppingCartButton(
                //     onPressed: () {
                //       _onPressed();
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        onItemTapped1: _onItemTapped,
        selectedIndex1: _selectedIndex,
      ),
    );
  }
}
