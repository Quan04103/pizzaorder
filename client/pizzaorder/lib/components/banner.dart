import 'package:flutter/material.dart';

Widget banner(int color) {
  return Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(15),
    width: 350,
    height: 150,
    decoration: BoxDecoration(
      color: Color(color),
      borderRadius: BorderRadius.circular(35),
    ),
    child: Stack(
      children: [
        // Phần text và button
        Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Món mới đề xuất\n dành cho bạn',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10), // Sử dụng SizedBox để tạo khoảng cách
              const Text(
                'Pizzar ngon nhất bạn có\n thể tìm tại Việt Nam.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
              ),
              const SizedBox(height: 10), // Sử dụng SizedBox để tạo khoảng cách
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.red,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(60, 30),
                ),
                onPressed: () {},
                child: const Text('199.000'),
              ),
            ],
          ),
        ),
        //Phần hình ảnh
        Padding(
          padding: const EdgeInsets.fromLTRB(100, 0, 0, 0),
          child: Container(
            width: 200,
            height: 200,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage('assets/pizza.jpg'),
                //'images/image_banner1.png'
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
