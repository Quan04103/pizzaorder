import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final Function(int) onItemTapped1;
  final int selectedIndex1;

  CustomBottomNavigationBar({
    required this.onItemTapped1,
    required this.selectedIndex1,
  });

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

void _onPressBack(BuildContext context) {
  final router = GoRouter.of(context);
  router.go('/home');
}

void _discounts(BuildContext context) {
  final router = GoRouter.of(context);
  router.go('/discounts');
}

void _all(BuildContext context) {
  final router = GoRouter.of(context);
  router.go('/all');
}

void _cart(BuildContext context) {
  final router = GoRouter.of(context);
  router.go('/giohang');
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  SharedPreferences? pref;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    pref = await SharedPreferences.getInstance();
  }

  void _onLogginButtonPressed(String token) {
    final router = GoRouter.of(context);
    router.go('/account', extra: token);
  }

  Widget build(BuildContext context) {
    return BottomAppBar(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFD8D5D5),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Container(
                padding: const EdgeInsets.fromLTRB(24, 6, 22.6, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildNavItem(
                      'assets/icons/house.png',
                      'Trang chủ',
                      0,
                    ),
                    _buildNavItem(
                      'assets/icons/discount-label.png',
                      'Ưu đãi',
                      1,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _all(context);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                              child: Text(
                                'Thực đơn',
                                style: GoogleFonts.getFont(
                                  'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: widget.selectedIndex1 == 2
                                      ? Colors.amber[800]
                                      : const Color(0xFF000000),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    _buildNavItem(
                      'assets/icons/delivery-man.png',
                      'Đơn hàng',
                      3,
                    ),
                    _buildNavItem(
                      'assets/icons/user.png',
                      'Tài khoản',
                      4,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: -30,
            left: MediaQuery.of(context).size.width / 2 - 34.5,
            child: GestureDetector(
              onTap: () {
                _all(context);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: const AssetImage('assets/icons/pizza.png'),
                    colorFilter: ColorFilter.mode(
                      widget.selectedIndex1 == 2
                          ? Colors.amber[800]!
                          : Colors.transparent,
                      BlendMode.srcATop,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(34.5),
                ),
                width: 69,
                height: 68,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String asset, String label, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          switch (index) {
            case 0: // Trang chủ
              _onPressBack(context);
              break;
            case 1: // Ưu đãi
              _discounts(context);
              break;
            case 3: // Đơn hàng
              _cart(context);
              break;
            case 4: // Tài khoản
              final token = pref?.getString('token');
              _onLogginButtonPressed(token ?? '');
              break;
            default:
              break;
          }
          widget.onItemTapped1(
              index); // Gọi hàm callback để cập nhật selectedIndex
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 8.7, 6),
              child: Image.asset(
                asset,
                width: 38,
                height: 38,
                color:
                    widget.selectedIndex1 == index ? Colors.amber[800] : null,
              ),
            ),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: GoogleFonts.getFont(
                'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: widget.selectedIndex1 == index
                    ? Colors.amber[800]
                    : const Color(0xFF000000),
              ),
              textAlign: TextAlign.center,
              child: Container(
                padding: const EdgeInsets.only(left: 2),
                child: Text(label),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
