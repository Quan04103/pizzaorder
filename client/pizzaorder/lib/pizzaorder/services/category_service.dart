import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/category.dart'; // Ensure you have a Category model similar to ProductModel
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CategoryService {
  final apiUrl = dotenv.env['API_URL'];
  
  CategoryService();

  Future<List<CategoryModel>> getAllCategories() async {
    final response = await http.get(
      Uri.parse('$apiUrl/getAllCategories'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<CategoryModel> categories = body
          .map((dynamic item) =>
              CategoryModel.fromJson(item as Map<String, dynamic>))
          .toList();
      return categories;
    } else {
      throw Exception('Failed to get categories');
    }
  }

  Future<CategoryModel> getCategoryById(String categoryId) async {
    final response = await http.get(
      Uri.parse('$apiUrl/getCategory/$categoryId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      CategoryModel category = CategoryModel.fromJson(body);
      return category;
    } else {
      throw Exception('Failed to get category info');
    }
  }
}