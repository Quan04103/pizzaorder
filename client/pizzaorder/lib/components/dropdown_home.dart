import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DropdownHome extends StatefulWidget {
  const DropdownHome({super.key});

  @override
  _DropdownHomeState createState() => _DropdownHomeState();
}

class _DropdownHomeState extends State<DropdownHome> {
  String selectedOption = '256 Phan Huy Ích';
  void _onPressFavoritesPage() {
    final router = GoRouter.of(context);
    router.go('/favoritepage');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
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
                  const Text('113 Phan Huy Ích',
                      style: TextStyle(
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
          icon: Icon(Icons.favorite_border_outlined),
          color: Colors.black,
          iconSize: 35,
        ),
      ],
    );
  }
}
