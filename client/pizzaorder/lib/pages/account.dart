import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pizzaorder/components/select_card.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class Account extends StatefulWidget {
  final String token;

  const Account({super.key, required this.token});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  late String nameProfile;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    nameProfile = jwtDecodedToken['nameProfile'] ?? '';
  }

  void _onPressLogOut() {
    final router = GoRouter.of(context);
    router.go('/home');
  }

  void _onPressBack(BuildContext context) {
    final router = GoRouter.of(context);
    router.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    String initial = getInitialFromLastWord(nameProfile);
    return Scaffold(
      backgroundColor: const Color.fromARGB(235, 255, 255, 255),
      body: Stack(
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
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 20),
                        child: GestureDetector(
                          onTap: () {
                            _onPressBack(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            nameProfile.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
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
              Expanded(
                child: Container(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Remaining widgets
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
              ),
            ],
          ),
          Positioned(
            top: 240,
            left: 55,
            height: MediaQuery.of(context).size.height * .05,
            width: MediaQuery.of(context).size.width * .7,
            child: Container(
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
            child: GestureDetector(
              onTap: () {
                _onPressLogOut();
              },
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
          ),
        ],
      ),
    );
  }

  String getInitialFromLastWord(String name) {
    List<String> words = name.split(' ');
    if (words.isNotEmpty) {
      return words.last[0].toUpperCase();
    }
    return '';
  }
}
