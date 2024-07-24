import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pizzaorder/components/BottomNavigationBar.dart';
import 'package:pizzaorder/pizzaorder/bloc/coupon/coupon_bloc.dart';
import 'package:pizzaorder/pizzaorder/bloc/coupon/coupon_event.dart';
import 'package:pizzaorder/pizzaorder/bloc/coupon/coupon_state.dart';
import 'package:pizzaorder/pizzaorder/models/coupon.dart';

class MyVoucher extends StatefulWidget {
  const MyVoucher({super.key});

  @override
  State<MyVoucher> createState() => _MyVoucherState();
}

class _MyVoucherState extends State<MyVoucher> {
  @override
  void initState() {
    super.initState();
    context.read<CouponBloc>().add(LoadCoupon());
  }

  int _selectedIndex1 = 1;
  void _onItemTapped1(int index) {
    setState(() {
      _selectedIndex1 = index;
    });
  }

  void _onPressBack(BuildContext context) {
    final router = GoRouter.of(context);
    router.go('/home');
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
              'Ưu đãi của bạn',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
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
                            return _buildVoucherCard(coupon: coupon);
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
          // Xóa nút reload (floatingActionButton)
          bottomNavigationBar: CustomBottomNavigationBar(
            selectedIndex1: _selectedIndex1,
            onItemTapped1: _onItemTapped1,
          ),
        );
      },
    );
  }

  Widget _buildVoucherCard({
    required CouponModel coupon,
  }) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(coupon.expiryDate!);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
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
            if (coupon.usageCount != null && coupon.usageCount! > 1)
              Container(
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
          ],
        ),
      ),
    );
  }
}
