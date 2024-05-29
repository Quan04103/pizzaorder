import 'package:flutter/material.dart';
import '../components/pizza_card_gird.dart';
import '../components/category_carousel.dart';
import '../components/shopping_cart_btn.dart';
import '../components/dropdown_home.dart';
import '../components/search.dart';

class AllProductPage extends StatelessWidget {
  const AllProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.green[50],
        appBar: AppBar(
          toolbarHeight: 25,
          backgroundColor: Colors.red,
        ),
        body: Column(
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
              height: 15,
            ),
            Search(),

            // Phần dưới chiếm 2/3 của màn hình
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: MediaQuery.of(context).size.height *
                        0.2, // 20% of the height
                    child: const CategoriesCarousel(),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height *
                        0.2, // Starting from 20% of the height
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
                        // Xử lý khi nhấn vào nút giỏ hàng
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
