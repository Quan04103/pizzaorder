import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SearchService {
  final apiUrl = dotenv.env['API_URL'];
  SearchService();

  Future<List<ProductModel>> getProductByName(String name) async {
    final response = await http.get(
      Uri.parse('$apiUrl/search/$name'),
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
      return products;
    } else {
      throw Exception('Failed to get product info');
    }
  }
}
