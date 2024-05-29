import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Search extends StatelessWidget {
  Search({super.key});
  final TextEditingController _textEditingController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Center(
        child: CupertinoSearchTextField(
          backgroundColor: Colors.white,
          controller: _textEditingController,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
