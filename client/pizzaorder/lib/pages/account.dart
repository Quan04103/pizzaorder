import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:pizzaorder/components/select_card.dart';

class UserAvatar extends StatelessWidget {
  final String name;

  const UserAvatar({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    String initial = getInitialFromLastWord(name);
    return Scaffold(
      backgroundColor: const Color.fromARGB(235, 255, 255, 255),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .3,
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 10, left: 20),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Positioned(
                            top: 120,
                            left: 50,
                            child: Text(
                              name.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(
                                    3.0), // Độ dày của viền
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(
                                      255, 255, 255, 255), // Màu của viền
                                  shape: BoxShape.circle,
                                ),
                                child: CircleAvatar(
                                  radius:
                                      50.0, // Tăng kích thước để có đủ không gian cho icon
                                  backgroundColor:
                                      const Color.fromARGB(255, 235, 224, 150),
                                  child: Text(
                                    initial,
                                    style: TextStyle(
                                      color: Colors.lime[800],
                                      fontSize: 42.0,
                                    ),
                                  ),
                                ),
                              ),
                              const Positioned(
                                bottom: 0,
                                right: 0,
                                child: CircleAvatar(
                                  radius:
                                      15.0, // Tăng kích thước để có viền cho icon
                                  backgroundColor: Color.fromARGB(
                                      255, 255, 255, 255), // Màu viền của icon
                                  child: CircleAvatar(
                                    radius: 24.0,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.edit,
                                      size: 20.0,
                                      color: Color.fromARGB(255, 37, 83, 188),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .7,
                color: const Color.fromARGB(255, 255, 255, 255),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 20),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Tài khoản của tôi',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      SelectCard(content: 'Yêu thích'),
                      SelectCard(content: 'Phương thức thanh toán'),
                      SelectCard(content: 'Vị trí'),
                      SelectCard(content: 'Lịch sử đặt hàng'),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Tổng Quát',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      SelectCard(
                        content: 'Trợ giúp',
                      ),
                      SelectCard(content: 'Cài đặt'),
                      SelectCard(content: 'Ngôn ngữ'),
                      SelectCard(content: 'Chia sẻ phản hồi'),
                      SelectCard(content: 'Về chúng tôi'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 240,
            left: 55,
            width: MediaQuery.of(context).size.width * .7,
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.yellow[300],
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(66, 0, 0, 0), // Màu của bóng
                    blurRadius: 10.0, // Độ mờ của bóng
                    spreadRadius: 2.0, // Độ rộng của bóng
                    offset: Offset(2, 10), // Vị trí của bóng
                  ),
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Đăng kí thành viên VIP',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 17,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 55,
            width: MediaQuery.of(context).size.width * .7,
            child: Container(
              height: 40,
              width: 80,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 78, 194, 28),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(66, 0, 0, 0), // Màu của bóng
                    blurRadius: 10.0, // Độ mờ của bóng
                    spreadRadius: 2.0, // Độ rộng của bóng
                    offset: Offset(2, 10), // Vị trí của bóng
                  ),
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Đăng xuất',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Phương thức lấy ký tự đầu tiên của từ cuối cùng
String getInitialFromLastWord(String name) {
  if (name.isEmpty) {
    return '?';
  }

  List<String> words = name.trim().split(' ');
  String lastWord = words.last;

  return lastWord.isNotEmpty ? lastWord[0].toUpperCase() : '?';
}
