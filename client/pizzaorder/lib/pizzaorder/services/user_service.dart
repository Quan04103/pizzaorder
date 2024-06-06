import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserService {
  final apiUrl = dotenv.env['API_URL'];
  UserService();

  Future<UserModel> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(response.body);
      return UserModel(
        token: result['token'],
        status: response.statusCode,
        id: result['id'],
        username: result['username'],
        password: result['password'],
        nameProfile: result['nameProfile'],
        email: result['email'],
        phone: result['phone'],
        address: result['address'],
      );
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<UserModel> getUserInfo(String token) async {
    final response = await http.get(
      Uri.parse('$apiUrl/getUserInfo'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(response.body);
      return UserModel(
        token: token,
        status: response.statusCode,
        id: result['id'],
        username: result['username'],
        password: result['password'],
        nameProfile: result['nameProfile'],
        email: result['email'],
        phone: result['phone'],
        address: result['address'],
      );
    } else {
      throw Exception('Failed to get user info');
    }
  }
}
