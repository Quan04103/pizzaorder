import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pizzaorder/pages/search_page.dart';

class Search extends StatelessWidget {
  Search({super.key});
  final TextEditingController _textEditingController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const SearchPage()), // Đảm bảo bạn đã tạo trang SearchPage
        );
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: AbsorbPointer(
          child: CupertinoSearchTextField(
            backgroundColor: Colors.white,
            controller: _textEditingController,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
