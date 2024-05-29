import 'package:flutter/material.dart';
import 'pizza_card.dart';

class PizzaCardGird extends StatelessWidget {
  const PizzaCardGird({Key? key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GridView.count(
        crossAxisCount: 2,
        // Thêm aspectRatio để điều chỉnh tỷ lệ khung hình của mỗi ô
        // Ở đây, giả sử bạn muốn mỗi ô có chiều rộng gấp đôi chiều cao
        // Bạn có thể thay đổi giá trị của aspectRatio để phù hợp với nhu cầu của bạn
        childAspectRatio: 1 / 1.35,
        children: List.generate(10, (index) {
          return const Center(child: PizzaCard());
        }),
      ),
    );
  }
}


