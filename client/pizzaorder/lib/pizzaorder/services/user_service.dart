import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pizzaorder/pizzaorder/bloc/auth/auth_event.dart';
import 'package:pizzaorder/pizzaorder/bloc/auth/auth_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user.dart';
import '../bloc/Result.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserService {
  final apiUrl = dotenv.env['API_URL'];
  UserService();

  Future<Result<UserModel>> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> result = jsonDecode(response.body);
        UserModel user = UserModel(
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
        return Success(user);
      } else {
        return Failure('Failed to login: ${response.body}');
      }
    } catch (e) {
      return Failure('Failed to login: $e');
    }
  }

  Future<Result<UserModel>> register(String username, String password,
      String nameProfile, String phone, String email, String address) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/registration'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "username": username,
          "password": password,
          "nameProfile": nameProfile,
          "number": phone,
          "email": email,
          "address": address
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> result = jsonDecode(response.body);
        UserModel user = UserModel(
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
        return Success(user);
      } else {
        return Failure('Failed to register: ${response.body}');
      }
    } catch (e) {
      return Failure('Failed to register: $e');
    }
  }

  Future<Result<UserModel>> getUserInfo(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/getUserInfo'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> result = jsonDecode(response.body);
        UserModel user = UserModel(
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
        return Success(user);
      } else {
        return Failure('Failed to get user info: ${response.body}');
      }
    } catch (e) {
      return Failure('Failed to get user info: $e');
    }
  }

  Future<Result<UserModel>> updateAddress(
      String token, String newAddress) async {
    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      final response = await http.put(
        Uri.parse('$apiUrl/updateAddress'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, String>{
          'iduser': decodedToken['_id'] ?? '',
          'newAddress': newAddress,
        }),
      );

      if (response.statusCode == 200) {
        String newToken = jsonDecode(response.body)['token'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', newToken);

        print('Token updated: $newToken');
        Map<String, dynamic> result = jsonDecode(response.body);
        UserModel user = UserModel.fromJson(
            result); // Assuming UserModel has a fromMap constructor
        return Success(user);
      } else {
        print(
            'Failed to update address. Status code: ${response.statusCode}, Body: ${response.body}');
        return Failure('Failed to update address: ${response.body}');
      }
    } catch (e) {
      return Failure('Failed to update address: Exception=$e');
    }
  }

  void _onTimeout(AuthTimeOut event, Emitter<AuthState> emit) {
    emit(AuthLoginFailure('Đăng nhập quá thời gian'));
  }
}
