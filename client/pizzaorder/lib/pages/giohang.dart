import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pizzaorder/components/option_item_bagcart.dart';
import 'package:pizzaorder/components/product_item_bagcart.dart';
import 'package:pizzaorder/multiple_bloc_provider.dart';
import 'package:pizzaorder/pages/payment_page_.dart';
import 'package:pizzaorder/pizzaorder/bloc/cart/cart_bloc.dart';
import 'package:pizzaorder/pizzaorder/bloc/cart/cart_event.dart';
import 'package:pizzaorder/pizzaorder/bloc/cart/cart_state.dart';
import 'package:pizzaorder/pizzaorder/bloc/coupon/coupon_bloc.dart';
import 'package:pizzaorder/pizzaorder/bloc/coupon/coupon_event.dart';
import 'package:pizzaorder/pizzaorder/models/coupon.dart';
import 'package:pizzaorder/pizzaorder/services/coupon_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GioHang extends StatefulWidget {
  const GioHang({super.key});
  @override
  _GioHangState createState() => _GioHangState();
}

class _GioHangState extends State<GioHang> {
  String _selectedOption = ''; // Khai báo biến _selectedOption ở đây
  int _shippingFee = 0; // Biến để lưu trữ giá trị phí vận chuyển
  String _selectedPaymentMethod = 'Thanh toán khi nhận hàng';
  SharedPreferences? pref;
  late CartBloc cartBloc;
  late CouponBloc couponBloc;
  @override
  void initState() {
    super.initState();
    print('Init state GioHang');
    cartBloc = BlocProvider.of<CartBloc>(context);
    cartBloc.add(const LoadList());
    couponBloc = BlocProvider.of<CouponBloc>(context);
    _buildInvoiceRow('title', 'amount');
    initSharedPref();
    // couponBloc.add(const  LoadCoupon());
  }

  void initSharedPref() async {
    pref = await SharedPreferences.getInstance();
  }

  Future<void> increaseProductQuantity() async {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.green[50],
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 30, left: 15, right: 15),
                    child: Column(
                      children: [
                        _buildDeliveryAddress(),
                        _buildDeliveryOptions(),
                        _buildOrder(),
                        _buildPaymentMethod(),
                        _buildPromotionField(),
                        _buildInvoiceInfo(context),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildOrderSummary(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(color: Color(0xFFE6361D)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 13),
              width: 24,
              height: 24,
            ),
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                // Đặt hành động khi button được nhấn ở đây
                GoRouter.of(context).go('/home');
              },
            ),
            const Text(
              'Giỏ hàng',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryAddress() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Padding(
        padding: EdgeInsets.fromLTRB(18.9, 10, 33, 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Giao tới',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16,
                color: Color(0xFF000000),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                SizedBox(
                  width: 17.2,
                  height: 21.9,
                ),
                SizedBox(width: 12.9),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.red,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'F-7, Ohio Complex, Bopal ',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(0xFF000000),
                      ),
                    ),
                    Text(
                      '30 Mins',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                        color: Color(0xFF000000),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryOptions() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 13, 19, 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tùy chọn giao',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16,
                color: Color(0xFF000000),
              ),
            ),
            const SizedBox(height: 10),
            DeliveryOptionItem(
              title: 'Ưu tiên',
              time: '< 15 phút',
              price: '39.000 đ',
              description: 'Đơn hàng ưu tiên, rút ngắn thời gian giao hàng.',
              selectedOption: _selectedOption,
              onSelected: (newOption) {
                setState(() {
                  _selectedOption = newOption;
                  _shippingFee = 39000;
                });
              },
            ),
            DeliveryOptionItem(
              title: 'Nhanh',
              time: '15 phút',
              price: '34.000 đ',
              selectedOption: _selectedOption,
              onSelected: (newOption) {
                setState(() {
                  _selectedOption = newOption;
                  _shippingFee = 34000;
                });
              },
            ),
            DeliveryOptionItem(
              title: 'Tiết kiệm',
              time: '30 phút',
              price: '30.000 đ',
              selectedOption: _selectedOption,
              onSelected: (newOption) {
                setState(() {
                  _selectedOption = newOption;
                  _shippingFee = 30000;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrder() {
    return BlocBuilder<CartBloc, CartState>(
      bloc: cartBloc,
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Đơn hàng',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        color: Color(0xFF000000),
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        GoRouter.of(context).go('/');
                      },
                      child: const Text(
                        'Thêm món',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                if (state.cartItems.isEmpty)
                  const Center(
                    child: Text(
                      'Không có sản phẩm nào trong giỏ hàng',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 231, 16, 16),
                      ),
                    ),
                  ),
                if (state.cartItems.isNotEmpty)
                  // Use ListView.builder to display the list of products
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: constraints.maxHeight,
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics:
                              const NeverScrollableScrollPhysics(), // Để tránh cuộn bên trong ListView
                          itemCount: state.cartItems.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                if (index > 0) const SizedBox(height: 1),
                                ProductItemBagCart(
                                    cartItems: state.cartItems[index]),
                              ],
                            );
                          },
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPaymentMethod() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 15,
          bottom: 10,
          left: 15,
          right: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Phương thức thanh toán',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      color: Color(0xFF000000),
                    ),
                  ),
                  const SizedBox(
                      height: 4), // Thêm khoảng cách giữa hai dòng chữ
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      _selectedPaymentMethod,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF000000),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuButton<String>(
              icon: const Icon(
                Icons.arrow_drop_down,
                size: 30,
              ),
              onSelected: (String value) {
                setState(() {
                  _selectedPaymentMethod = value;
                });
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem<String>(
                    value: 'Thanh toán khi nhận hàng',
                    child: Text('Thanh toán khi nhận hàng'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Thanh toán qua ví',
                    child: Text('Thanh toán qua ví'),
                  ),
                ];
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromotionField() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 15,
          bottom: 10,
          left: 15,
          right: 15,
        ),
        child: Row(
          children: [
            const Icon(Icons.local_offer, color: Colors.black),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                'Áp dụng ưu đãi để được giảm giá',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.arrow_forward_ios,
              ),
              onPressed: () {
                // Đặt hành động khi button được nhấn ở đây
                GoRouter.of(context).go('/discounts');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInvoiceInfo(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      bloc: cartBloc,
      builder: (context, state) {
        int discount = 0;
        final couponState = context.watch<CouponBloc>().state;
        final data1 = pref?.getString('data1');
        final data2 = pref?.getInt('data2');

        return Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Thông tin hóa đơn',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              _buildInvoiceRow(
                'Tạm tính',
                '${state.total?.toStringAsFixed(0) ?? '0'} đ',
              ),
              _buildInvoiceRow(
                'Phí vận chuyển',
                '$_shippingFee đ',
              ),
              if (couponState.coupons != null &&
                  couponState.coupons!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInvoiceRow(
                      'Giảm giá ${data1 ?? ''}',
                      '${data2 ?? 0} đ',
                    ),
                  ],
                ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tổng tiền',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    '${state.total != null ? (state.total! + _shippingFee - discount).toStringAsFixed(0) : '0'} đ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInvoiceRow(String title, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return BlocBuilder<CartBloc, CartState>(
      bloc: cartBloc, // Provide your CartBloc instance here
      builder: (context, state) {
        double subtotal = state.total ?? 0;
        final couponState = context.watch<CouponBloc>().state;
        double discount = 0;
        if (couponState.isLoaded && couponState.coupons != null) {
          for (CouponModel coupon in couponState.coupons!) {
            discount += coupon.value ?? 0;
          }
        }
        double totalSales = subtotal + _shippingFee - discount;
        return Container(
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFEFEFEF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Tổng cộng',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${totalSales.toStringAsFixed(0)} đ', // Dynamically display the total from the state
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      if (_selectedOption.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Vui lòng chọn tùy chọn giao hàng.'),
                          ),
                        );
                      } else {
                        cartBloc.add(SubmitCart(totalSales));
                        final couponService = CouponService();
                        //  final couponId = await couponService.getCouponById(couponState.coupons![0].id!.toString());
                        //  context.read<CouponBloc>().add(UpdateUsageCount(couponId as String));
                        couponBloc.add(ClearCoupon());

                        setState(() {
                          _selectedOption = '';
                          _shippingFee = 0;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PaymentPage(totalSales: totalSales),
                          ),
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: const Center(
                        child: Text(
                          'Đặt đơn',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
