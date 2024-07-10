import 'package:flutter/material.dart';
import 'package:pizzaorder/components/pizza_card.dart';
import 'package:pizzaorder/pizzaorder/models/product.dart';

import '../pizzaorder/services/product_service.dart';
import '../pizzaorder/models/product.dart';

class ProductPage extends StatefulWidget {
  final String categoryId;

  const ProductPage({Key? key, required this.categoryId}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late List<ProductModel> products = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  _fetchProducts() async {
    final productService = ProductService();
    // Sửa đổi ở đây: sử dụng `this.products` để cập nhật state variable, không phải local variable
    this.products =
        await productService.getProductByCategoryId(widget.categoryId);
    setState(() {}); // Gọi setState để cập nhật UI
  }

  @override
  Widget build(BuildContext context) {
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
}
