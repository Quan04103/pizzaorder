import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pizzaorder/pages/search_page.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SearchPage()),
        );
      },
      child: Container(
        height: 40,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: AbsorbPointer(
          child: CupertinoSearchTextField(
            placeholder: 'Bạn muốn ăn gì không?',
            backgroundColor: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
