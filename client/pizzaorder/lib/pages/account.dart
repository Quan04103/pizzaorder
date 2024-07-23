import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pizzaorder/components/select_card.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pizzaorder/pages/edit_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    _decodeTokenAndSetName(widget.token);
  }

  void _comingSoon() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Chức năng này sẽ sớm ra mắt!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _onPressLogOut() {
    final router = GoRouter.of(context);
    router.go('/logout');
  }

  void _onPressBack() {
    final router = GoRouter.of(context);
    router.go('/home');
  }

  void _onPressedEdit(String token) async {
    final updatedToken = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditUserProfilePage(token: token),
      ),
    );

    if (updatedToken != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', updatedToken);
      _decodeTokenAndSetName(updatedToken);
    }
  }

  void _decodeTokenAndSetName(String token) {
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(token);
    setState(() {
      nameProfile = jwtDecodedToken['nameProfile'] ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    String initial = getInitialFromLastWord(nameProfile.trim());
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
                          onTap: _onPressBack,
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
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
                                padding: const EdgeInsets.all(3.0),
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  shape: BoxShape.circle,
                                ),
                                child: CircleAvatar(
                                  radius: 50.0,
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
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    final token = prefs.getString('token');
                                    _onPressedEdit(token ?? '');
                                  },
                                  child: const CircleAvatar(
                                    radius: 15.0,
                                    backgroundColor:
                                        Color.fromARGB(255, 255, 255, 255),
                                    child: CircleAvatar(
                                      radius: 12.0,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.edit,
                                        size: 20.0,
                                        color: Color.fromARGB(255, 37, 83, 188),
                                      ),
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          'Tài khoản của tôi',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SelectCard(
                          content: 'Yêu thích',
                          onPressed: () {
                            final router = GoRouter.of(context);
                            router.go('/favoritepage');
                          },
                        ),
                        SelectCard(
                          content: 'Phương thức thanh toán',
                          onPressed: _comingSoon,
                        ),
                        SelectCard(
                          content: 'Vị trí',
                          onPressed: () {
                            final router = GoRouter.of(context);
                            router.go('/maptracking');
                          },
                        ),
                        SelectCard(
                          content: 'Lịch sử đặt hàng',
                          onPressed: () {
                            final router = GoRouter.of(context);
                            router.go('/historypage');
                          },
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Tổng Quát',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SelectCard(
                          content: 'Trợ giúp',
                          onPressed: _comingSoon,
                        ),
                        SelectCard(
                          content: 'Cài đặt',
                          onPressed: _comingSoon,
                        ),
                        SelectCard(
                          content: 'Ngôn ngữ',
                          onPressed: _comingSoon,
                        ),
                        SelectCard(
                          content: 'Chia sẻ phản hồi',
                          onPressed: _comingSoon,
                        ),
                        SelectCard(
                          content: 'Về chúng tôi',
                          onPressed: _comingSoon,
                        ),
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
                    color: Color.fromARGB(66, 0, 0, 0),
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                    offset: Offset(2, 10),
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
                  SizedBox(width: 20),
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
              onTap: _onPressLogOut,
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
                      color: Color.fromARGB(66, 0, 0, 0),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                      offset: Offset(2, 10),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 10),
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
