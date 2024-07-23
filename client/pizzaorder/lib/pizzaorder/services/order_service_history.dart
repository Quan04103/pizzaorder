import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dart:convert';
import '../models/order_history.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderService {
  final apiUrl = dotenv.env['API_URL'];

  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  Future<List<OrderModel>> fetchOrders() async {
    final token = await _getToken();
    if (token.isEmpty) {
      throw Exception('No token found');
    }
    // Decode the token to get the user ID
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    String userId = decodedToken['_id'] ?? '';

    // Make the API call using the user ID
    final response = await http.get(
      Uri.parse('$apiUrl/user_orders/$userId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<OrderModel> orders =
          data.map((json) => OrderModel.fromJson(json)).toList();

      // Fetch product details for each order item
      for (var order in orders) {
        for (var item in order.listorder) {
          var productDetails = await fetchProductDetails(item['idproduct']);
          item['name'] = productDetails['name'];
          item['image'] = productDetails['image'];
          item['price'] = productDetails['price'];
        }
      }

      return orders;
    } else {
      throw Exception('Failed to load orders');
    }
  }

  Future<Map<String, dynamic>> fetchProductDetails(String productId) async {
    final response = await http.get(
      Uri.parse('$apiUrl/product/$productId'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load product details');
    }
  }
}
