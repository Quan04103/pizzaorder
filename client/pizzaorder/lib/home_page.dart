import 'package:flutter/material.dart';
import 'category_carousel.dart';
import 'pizza_card.dart';
import 'shopping_cart_btn.dart';
import 'dropdown_home.dart';
import 'slide.dart';
import 'search.dart';

class HomePage extends StatelessWidget {
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
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
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
                SizedBox(
                  height: 10,
                ),
                Search(),
                SizedBox(
                  height: 10,
                ),
                slide(),
                Padding(
                  padding: EdgeInsets.only(right: 270),
                  child: Text(
                    'Categories',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  height: 100,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: CategoriesCarousel(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 300),
                  child: Text(
                    'Newest',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
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
    );
  }
}

class ProductsCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(width: 20), // Khoảng cách từ lề bên trái
          PizzaCard(),
          SizedBox(width: 20), // Khoảng cách giữa các PizzaCard
          PizzaCard(),
          SizedBox(width: 20), // Khoảng cách giữa các PizzaCard
          PizzaCard(),
          SizedBox(width: 20), // Khoảng cách giữa các PizzaCard
          PizzaCard(),
          SizedBox(width: 20), // Khoảng cách từ lề bên phải
        ],
      ),
    );
  }
}
