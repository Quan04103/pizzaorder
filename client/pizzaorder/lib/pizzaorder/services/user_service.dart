import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';

class UserService {
  final String baseUrl;

  UserService(this.baseUrl);

  Future<UserModel> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
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
      Uri.parse('$baseUrl/getUserInfo'),
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
