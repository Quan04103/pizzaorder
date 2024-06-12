import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/order_item_in_cart.dart';
import '../models/order.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OrderService {
  final apiUrl = dotenv.env['API_URL'];
  //token test bắt buộc phải login bên postman để lấy token,
  //vì chưa có chức năng login trong ứng dụng
  //Nếu khi đã đăng nhập thì sẽ dùng token của user đó được lưu trong bloc hoặc shared_preferences
  final token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NjUzOTUxOWZkMWI4NjU4N2Y2ZjI5YmIiLCJ1c2VybmFtZSI6InRlc3QxMjMxMjMiLCJpYXQiOjE3MTc5NzEzMzksImV4cCI6MTcxNzk3NDkzOX0.HqBiiAgAX4hicJkxBuA2s3Q_epvaktWl4TCrM5Gk_90';
  OrderService();

  Future<OrderModel> addOrder(String idUser, List<OrderItem> listOrder,
      double price, DateTime dateAdded) async {
    final response = await http.post(
      Uri.parse('$apiUrl/addOrder'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        'iduser': idUser,
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
}
