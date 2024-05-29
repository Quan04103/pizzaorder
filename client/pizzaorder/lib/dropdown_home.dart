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
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        value: selectedOption,
        onChanged: (String? newValue) {
          setState(() {
            selectedOption = newValue!;
          });
        },
        items: <String>[
          '256 Phan Huy Ích',
          '2561132 Phan Huy Ích',
          '101 Tân Thới Nhất 05'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
