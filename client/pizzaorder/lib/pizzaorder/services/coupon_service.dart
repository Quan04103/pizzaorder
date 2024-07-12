import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/coupon.dart'; 
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CouponService {
  final apiUrl = dotenv.env['API_URL'];
  CouponService();

  Future<List<CouponModel>> getAllCoupons() async {
    final response = await http.get(
      Uri.parse('$apiUrl/getAllCoupons'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<CouponModel> coupons = body
          .map((dynamic item) =>
              CouponModel.fromJson(item as Map<String, dynamic>))
          .toList();
      return coupons;
    } else {
      throw Exception('Failed to get coupons');
    }
  }

  Future<CouponModel> getCouponById(String id) async {
    final response = await http.get(
      Uri.parse('$apiUrl/getcoupon/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return CouponModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get coupon');
    }
  }
  Future<void> updateUsageCount(String id) async {
    final response = await http.put(
      Uri.parse('$apiUrl/updateUsageCount/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update usage count');
    }
  }
   Future<void> deleteCoupon(String id) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/deleteCoupon/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete coupon');
    }
  }

 
}
