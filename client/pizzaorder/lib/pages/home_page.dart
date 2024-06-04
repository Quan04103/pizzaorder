import 'package:flutter/material.dart';
import '../components/category_carousel.dart';
import '../components/pizza_card.dart';
import '../components/shopping_cart_btn.dart';
import '../components/dropdown_home.dart';
import '../components/slide.dart';
import '../components/search.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DropdownHome(),
                      const Icon(
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
                    // Xử lý khi nhấn vào nút giỏ hàng
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

class ProductsCarousel extends StatelessWidget {
  const ProductsCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          // SizedBox(width: 20), // Khoảng cách từ lề bên trái
          // PizzaCard(),
          // SizedBox(width: 20), // Khoảng cách giữa các PizzaCard
          // PizzaCard(),
          // SizedBox(width: 20), // Khoảng cách giữa các PizzaCard
          // PizzaCard(),
          // SizedBox(width: 20), // Khoảng cách giữa các PizzaCard
          // PizzaCard(),
          // SizedBox(width: 20), // Khoảng cách từ lề bên phải
        ],
      ),
    );
  }
}
