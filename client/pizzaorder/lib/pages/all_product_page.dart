import 'package:flutter/material.dart';
import 'package:pizzaorder/components/BottomNavigationBar.dart';
import '../components/pizza_card_gird.dart';
import '../components/category_carousel.dart';
import '../components/shopping_cart_btn.dart';
import '../components/dropdown_home.dart';
import '../components/search.dart';
// Assuming you place CustomBottomNavigationBar in a separate file

class AllProductPage extends StatefulWidget {
  const AllProductPage({Key? key}) : super(key: key);

  @override
  _AllProductPageState createState() => _AllProductPageState();
}

class _AllProductPageState extends State<AllProductPage> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        toolbarHeight: 25,
        backgroundColor: Colors.red,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
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
          const SizedBox(height: 15),
          Search(),
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
                  child: const PizzaCardGird(),
                ),
                Positioned(
                  bottom: 130,
                  right: 10,
                  child: ShoppingCartButton(
                    onPressed: () {
                      // Handle shopping cart button press
                    },
                  ),
                ),
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
