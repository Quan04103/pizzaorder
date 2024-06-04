import 'package:flutter/material.dart';
import '../components/pizza_card.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.green[50],
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              // Handle back action
            },
          ),
          title: const Text(
            'Yêu thích',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
        body: SizedBox(
          child: GridView.count(
            crossAxisCount: 2,
            // Thêm aspectRatio để điều chỉnh tỷ lệ khung hình của mỗi ô
            // Ở đây, giả sử bạn muốn mỗi ô có chiều rộng gấp đôi chiều cao
            // Bạn có thể thay đổi giá trị của aspectRatio để phù hợp với nhu cầu của bạn
            childAspectRatio: 1 / 1.35,
            // children: List.generate(10, (index) {
            //   return const Center(child: PizzaCard());
            // }),
          ),
        ),
      ),
    );
  }
}
