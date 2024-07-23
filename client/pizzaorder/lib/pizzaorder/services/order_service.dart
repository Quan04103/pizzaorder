import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dart:convert';
import '../models/order_item_in_cart.dart';
import '../models/order.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderService {
  final apiUrl = dotenv.env['API_URL'];
  //token test bắt buộc phải login bên postman để lấy token,
  //vì chưa có chức năng login trong ứng dụng
  //Nếu khi đã đăng nhập thì sẽ dùng token của user đó được lưu trong bloc hoặc shared_preferences
  // final token =
  //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NjUzOTUxOWZkMWI4NjU4N2Y2ZjI5YmIiLCJ1c2VybmFtZSI6InRlc3QxMjMxMjMiLCJpYXQiOjE3MTc5NzEzMzksImV4cCI6MTcxNzk3NDkzOX0.HqBiiAgAX4hicJkxBuA2s3Q_epvaktWl4TCrM5Gk_90';

  OrderService();

  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  Future<OrderModel> addOrder(List<OrderItem> listOrder, double price,
      DateTime dateAdded, String token) async {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    final response = await http.post(
      Uri.parse('$apiUrl/addOrder'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        'iduser': decodedToken['_id'] ?? '',
        'listorder': listOrder.map((item) => item.toJson()).toList(),
        'price': price,
        'dateadded': dateAdded.toIso8601String(),
      }),
    );

    if (response.statusCode == 200) {
      return OrderModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
          'Failed to add order. Status code: ${response.statusCode}. Response body: ${response.body}');
    }
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
        for (var item in order.orderItems) {
          var productDetails = await fetchProductDetails(item.idproduct);
          item.name = productDetails['name'];
          item.image = productDetails['image'];
          item.price = productDetails['price'];
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
