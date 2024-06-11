import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:pizzaorder/pizzaorder/bloc/auth/auth_event.dart';
import 'package:pizzaorder/pizzaorder/bloc/auth/auth_state.dart';
import 'dart:convert';
import '../models/user.dart';
import '../bloc/Result.dart';

class UserService {
  final String baseUrl;

  UserService(this.baseUrl);

  Future<Result<UserModel>> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
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
        Uri.parse('$baseUrl/registration'),
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
        Uri.parse('$baseUrl/getUserInfo'),
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

  void _onTimeout(AuthTimeOut event, Emitter<AuthState> emit) {
    emit(AuthLoginFailure('Đăng nhập quá thời gian'));
  }
}
