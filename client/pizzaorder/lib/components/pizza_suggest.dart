import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:pizzaorder/pizzaorder/bloc/cart/cart_bloc.dart';
import 'package:pizzaorder/pizzaorder/bloc/cart/cart_event.dart';
import 'package:pizzaorder/pizzaorder/models/order_item_in_cart.dart';
import 'package:pizzaorder/pizzaorder/models/product.dart';
import 'package:http/http.dart' as http;

class PizzaSuggest extends StatefulWidget {
  const PizzaSuggest({super.key});

  @override
  _PizzaSuggestState createState() => _PizzaSuggestState();
}

class _PizzaSuggestState extends State<PizzaSuggest> {
  final apiUrl = dotenv.env['API_URL'];
  List<ProductModel> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final fetchedProducts =
        await getProductByCategoryId('6646fc283146973b72ad5eb2', limit: 4);
    setState(() {
      products = fetchedProducts;
    });
  }

  Future<List<ProductModel>> getProductByCategoryId(String categoryId,
      {required int limit}) async {
    final response = await http.get(
      Uri.parse('$apiUrl/getProduct/$categoryId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<ProductModel> products = body
          .map((dynamic item) =>
              ProductModel.fromJson(item as Map<String, dynamic>))
          .toList();

      if (products.length > limit) {
        return products.take(limit).toList();
      }
      return products;
    } else {
      throw Exception('Failed to get product info');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(product
                          .image!), // Adjust according to your ProductModel
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text(product.name!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row(
                        //   children: [
                        //     const Icon(Icons.star, color: Colors.orange),
                        //     const SizedBox(width: 4),
                        //     Text('${product.rating} • Pizza'),
                        //   ],
                        // ),
                        const SizedBox(height: 4),
                        Text(product.description!),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(child: Container()),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: InkWell(
                                onTap: () {
                                  OrderItem orderItem = OrderItem(
                                    idproduct: product.id ?? '',
                                    quantity: 1,
                                    name: product.name ?? '',
                                    price: product.price ?? 0,
                                    image: product.image ?? '',
                                  );
                                  context
                                      .read<CartBloc>()
                                      .add(AddProducts(orderItem));
                                },
                                child: Text(
                                  product.price != null
                                      ? '${NumberFormat("#,##0", "vi_VN").format(product.price)} VND'
                                      : 'N/A',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
