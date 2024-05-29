import 'package:flutter/material.dart';

class PizzaCard extends StatefulWidget {
  const PizzaCard({super.key});

  @override
  _PizzaCardState createState() => _PizzaCardState();
}

class _PizzaCardState extends State<PizzaCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      elevation: 10,
      child: SizedBox(
        width: 170,
        height: 260,
        child: Stack(
          clipBehavior: Clip.none, // Sử dụng clipBehavior thay vì overflow
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 110,
                  decoration: BoxDecoration(
                    color: isFavorite
                        ? Colors.orange
                        : Colors.red, // Chuyển màu của Container từ đỏ sang cam
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(30.0),
                    ),
                  ),
                ),
              ],
            ),
            const Positioned(
              top: 30, // Điều chỉnh giá trị này để ảnh nổi lên
              left: 0,
              right: 0,
              child: Center(
                child: Image(
                  image: AssetImage('assets/pizza.jpg'),
                  width: 160, // Điều chỉnh kích thước của hình ảnh
                  height: 160,
                ),
              ),
            ),
            Positioned(
              top: 20,
              right: 15,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isFavorite =
                        !isFavorite; // Thay đổi trạng thái khi click vào Icons.favorite
                  });
                },
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(
                    Icons.favorite,
                    color: isFavorite ? Colors.orange : Colors.black,
                  ),
                ),
              ),
            ),
            const Positioned(
              top: 155,
              left: 0,
              right: 0,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Spicy Diablo',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 45, // Điều chỉnh khoảng cách từ dưới lên
              left: 0,
              right: 0,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Classic Tomato Sauce, Mozzarella Cheese, Fresh Basil Leaves',
                    style: TextStyle(
                      fontSize: 9,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.left, // Căn giữa dòng chữ
                  ),
                ),
              ),
            ),
            const Positioned(
              bottom: 10, // Điều chỉnh khoảng cách từ dưới lên
              left: 15,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '\$62',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left, // Căn giữa dòng chữ
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              height: 45,
              width: 45,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                ),
                child: IconButton(
                  icon: const Icon(Icons.add, color: Colors.white),
                  onPressed: () {
                    // Add your onPressed code here!
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
