import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product.dart';

class ProductService {
  final String baseUrl;

  ProductService(this.baseUrl);

  Future<List<ProductModel>> getProduct() async {
  final response = await http.get(
    Uri.parse('$baseUrl/getProduct'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body);
    List<ProductModel> products = body.map((dynamic item) => ProductModel.fromJson(item as Map<String, dynamic>)).toList();
    return products;
  } else {
    throw Exception('Failed to get product info');
  }
}
}
