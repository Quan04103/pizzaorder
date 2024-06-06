import 'package:flutter/material.dart';

class DropdownHome extends StatefulWidget {
  @override
  _DropdownHomeState createState() => _DropdownHomeState();
}

class _DropdownHomeState extends State<DropdownHome> {
  String selectedOption = '256 Phan Huy Ích';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.height * 1.2 / 3,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          )),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 8, 2),
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
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Icon(
                  Icons.near_me,
                  color: Colors.red[800],
                ),
              ),
              Text('113 Phan Huy Ích',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
