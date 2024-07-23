import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pizzaorder/pizzaorder/bloc/coupon/coupon_bloc.dart';
import 'package:pizzaorder/pizzaorder/bloc/coupon/coupon_event.dart';
import 'package:pizzaorder/pizzaorder/bloc/coupon/coupon_state.dart';
import 'package:pizzaorder/pizzaorder/models/coupon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VoucherPage extends StatefulWidget {
  const VoucherPage({super.key});

  @override
  State<VoucherPage> createState() => _VoucherPageState();
}

void _onPressBack(BuildContext context) {
  final router = GoRouter.of(context);
  router.go('/home');
}

class _VoucherPageState extends State<VoucherPage> {
  int _selectedIndex = 0;
  int _selectedIndex1 = 1;
  SharedPreferences? pref;
  @override
  void initState() {
    super.initState();
    context.read<CouponBloc>().add(LoadCoupon());
    initSharedPref();
  }

  void _onItemTapped1(int index) {
    setState(() {
      _selectedIndex1 = index;
    });
  }

  void initSharedPref() async {
    pref = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CouponBloc, CouponState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.green[50],
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                _onPressBack(context); // Handle back action
              },
            ),
            title: const Text(
              'Ưu đãi',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 48.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: 'Nhập mã ưu đãi',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        if (state.isLoaded && state.coupons != null) {
                          final CouponModel selectedCoupon =
                              state.coupons![_selectedIndex];
                          debugPrint('Applying coupon: $selectedCoupon');
                          final data1 =
                              pref!.setString('data1', selectedCoupon.code!);
                          final data2 =
                              pref!.setInt('data2', selectedCoupon.value!);
                          context
                              .read<CouponBloc>()
                              .add(ApplyCoupon(selectedCoupon));
                          final router = GoRouter.of(context);
                          router.go('/bagcart');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Áp dụng'),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Builder(
                    builder: (context) {
                      if (state.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state.isLoaded) {
                        return ListView.builder(
                          itemCount: state.coupons?.length ?? 0,
                          itemBuilder: (context, index) {
                            CouponModel coupon = state.coupons![index];
                            return _buildVoucherCard(
                              coupon: coupon,
                              isSelected: _selectedIndex == index,
                              onTap: () {
                                setState(() {
                                  _selectedIndex = index;
                                });
                              },
                            );
                          },
                        );
                      } else {
                        return const Center(
                            child: Text('Không có dữ liệu voucher.'));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: CustomBottomNavigationBar(
            selectedIndex1: _selectedIndex1,
            onItemTapped1: _onItemTapped1,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Thêm xử lý để load lại danh sách voucher khi nhấn vào nút này
              context.read<CouponBloc>().add(LoadCoupon());
            },
            child: const Icon(Icons.refresh),
          ),
        );
      },
    );
  }

  Widget _buildVoucherCard({
    required CouponModel coupon,
    required bool isSelected,
    required Function() onTap,
  }) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(coupon.expiryDate!);
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(
                color: isSelected ? Colors.orange : Colors.grey,
                width: isSelected ? 2.0 : 1.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: const Color(0xFF61AF89),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: Text(
                                    coupon.code ?? '',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: Text(
                                    'Tất cả hình thức thanh toán',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                coupon.discount ?? '',
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                coupon.description ?? '',
                                style: const TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                'Hết hạn: $formattedDate',
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Icon(
                    isSelected
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: isSelected ? Colors.orange : Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          if (coupon.usageCount != null && coupon.usageCount! > 1)
            Positioned(
              right: 0,
              top: 15,
              child: Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  'x${coupon.usageCount}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex1;
  final Function(int) onItemTapped1;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex1,
    required this.onItemTapped1,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Trang chủ',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_offer),
          label: 'Ưu đãi',
        ),
      ],
      currentIndex: selectedIndex1,
      onTap: onItemTapped1,
    );
  }
}
