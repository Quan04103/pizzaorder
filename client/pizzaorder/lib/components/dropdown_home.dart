import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DropdownHome extends StatefulWidget {
  const DropdownHome({super.key});

  @override
  _DropdownHomeState createState() => _DropdownHomeState();
}

class _DropdownHomeState extends State<DropdownHome> {
  String idAddress = '';
  String address = '';
  List<dynamic> startDetails = [];

  @override
  void initState() {
    super.initState();
    getStart(idAddress);
  }

  Future<void> getStart(String input) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token') ?? '';
      print('token: $token');
      if (token.isNotEmpty) {
        Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(token);
        print(jwtDecodedToken);
        setState(() {
          idAddress = jwtDecodedToken['address'] ?? '';
          print(idAddress);
        });
      }
      final url = Uri.parse(
          'https://rsapi.goong.io/Place/Detail?place_id=$idAddress&api_key=IcniA2Z5Cpx1HXx0rMUj0L0kRro6hQ1uOkP1cuvV');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        // Assuming 'result' is a Map and contains 'formatted_address'
        var result = jsonResponse['result'];
        setState(() {
          address = result[
              'formatted_address']; // Directly access 'formatted_address'
          print(address);
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
        print("Error: ${response.body}");
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _onPressFavoritesPage() {
    final router = GoRouter.of(context);
    router.go('/favoritepage');
  }

  void onPressMapTracking() {
    final router = GoRouter.of(context);
    router.go('/maptracking');
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressMapTracking();
      },
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(
                0, 0, 0, 0), // Tạo khoảng cách đều hai bên
            width: MediaQuery.of(context).size.width - 100,
            //width: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 4, 8, 0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text('Giao tới',
                        style: TextStyle(
                            color: Colors.orange[700],
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 2),
                      child: Icon(
                        Icons.near_me,
                        color: Colors.red[800],
                      ),
                    ),
                    Text(address,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        )),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              _onPressFavoritesPage();
            },
            icon: const Icon(Icons.favorite_border_outlined),
            color: Colors.black,
            iconSize: 35,
          ),
        ],
      ),
    );
  }
}
