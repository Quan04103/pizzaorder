import 'package:flutter/material.dart';
import 'package:pizzaorder/components/option_item_bagcart.dart';
import 'package:pizzaorder/components/product_item_bagcart.dart';

class GioHang extends StatefulWidget {
  const GioHang({super.key});
  @override
  _GioHangState createState() => _GioHangState();
}
class _GioHangState extends State<GioHang> {
  String _selectedOption = ''; // Khai báo biến _selectedOption ở đây
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
                      _buildInvoiceInfo(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
            Positioned(
              left: 0,right: 0,bottom: 0,child: _buildOrderSummary(),),
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
            Container( margin: const EdgeInsets.only(right: 13),width: 24,height: 24,),
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                // Đặt hành động khi button được nhấn ở đây
                print("Button Pressed");
              },
            ),
            const Text(
              'Giỏ hàng',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20, color: Color(0xFFFFFFFF),),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryAddress() {
    return Container(margin: const EdgeInsets.only(bottom: 15),decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Padding(
        padding: EdgeInsets.fromLTRB(18.9, 10, 33, 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Giao tới',style: TextStyle(fontWeight: FontWeight.w800,fontSize: 16,color: Color(0xFF000000),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                SizedBox(width: 17.2,height: 21.9,),SizedBox(width: 12.9),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on, color: Colors.red,),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('F-7, Ohio Complex, Bopal ',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color: Color(0xFF000000), ),),
                    Text('30 Mins',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 10,color: Color(0xFF000000),),),
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
            'Tùy chọn giao',style: TextStyle(fontWeight: FontWeight.w800,fontSize: 16,color: Color(0xFF000000),),
          ),
          const SizedBox(height: 10),
          DeliveryOptionItem(title: 'Ưu tiên',time: '< 15 phút',price: '39.000 đ',description: 'Đơn hàng ưu tiên, rút ngắn thời gian giao hàng.',selectedOption: _selectedOption,
            onSelected: (newOption) {
              setState(() {
                _selectedOption = newOption;
              });
            },
          ),
          DeliveryOptionItem(title: 'Nhanh',time: '15 phút',price: '34.000 đ',
            selectedOption: _selectedOption,
            onSelected: (newOption) {
              setState(() {
                _selectedOption = newOption;
              });
            },
          ),
          DeliveryOptionItem(title: 'Tiết kiệm', time: '30 phút',price: '30.000 đ',
            selectedOption: _selectedOption,
            onSelected: (newOption) {
              setState(() {
                _selectedOption = newOption;
              });
            },
          ),
          DeliveryOptionItem(
            title: 'Đặt giao sau',time: '',price: '',
            selectedOption: _selectedOption,
            onSelected: (newOption) {
              setState(() {
                _selectedOption = newOption;
              });
            },
          ),
        ],
      ),
    ),
  );
}

 Widget _buildOrder() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 19, right: 19),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Đơn hàng',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 16,color: Color(0xFF000000),),),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text('Thêm món',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 13,color: Colors.blue,),),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ProductItem(name: 'Tên sản phẩm',imgs: 'assets/images/ghati_2.png',price: '100.000đ',
              quanty: 1, // Sử dụng giá trị cố định cho quantity
              onIncrease: () {
                // Hành động khi bấm nút tăng
              },
              onDecrease: () {
                // Hành động khi bấm nút giảm
              },
            ),
          ],
        ),
      ),
    );
  }

Widget _buildPaymentMethod() {
  return Container(
    margin: const EdgeInsets.only(top: 40),
    decoration: BoxDecoration(color: const Color(0xFFFFFFFF),borderRadius: BorderRadius.circular(10),),
    child: const Padding(
        padding: EdgeInsets.only(top: 15,bottom: 10,left: 15,right: 15,),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Phương thức thanh toán',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 16, color: Color(0xFF000000),),),
                  Padding(padding: EdgeInsets.only(left: 20),
                    child: Text('Thanh toán khi nhận hàng',style: TextStyle( fontSize: 12,color: Color(0xFF000000),),),
                  ),
                ],
              ),
            ),
            Spacer(), Icon(Icons.arrow_drop_down,size: 30,),
          ],
        )),
  );
}
Widget _buildPromotionField() {
  return Container(
    margin: const EdgeInsets.only(top: 15),
    decoration: BoxDecoration(color: const Color(0xFFFFFFFF),borderRadius: BorderRadius.circular(10),),
    child: const Padding(
      padding: EdgeInsets.only(top: 15, bottom: 10,left: 15,right: 15,),
      child: Row(
        children: [
          Icon(Icons.local_offer, color: Colors.black),SizedBox(width: 10),
          Expanded(
            child: Text('Áp dụng ưu đãi để được giảm giá',style: TextStyle(fontSize: 16,color: Colors.black,),),),
          Icon(Icons.arrow_drop_down, size: 30, color: Colors.black),
        ],
      ),
    ),
  );
}

Widget _buildInvoiceInfo() {
  return Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Thông tin hóa đơn',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        _buildInvoiceRow('Tạm tính', '327.000 đ'),
        _buildInvoiceRow('Phí vận chuyển', '30.000 đ'),
        _buildInvoiceRow('Giảm giá', '0 đ'),
        const Divider(),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text( 'Tổng tiền',style: TextStyle( color: Colors.red,  fontWeight: FontWeight.bold,fontSize: 16,     ),),
            Text('357.000 đ',style: TextStyle(   fontWeight: FontWeight.bold,fontSize: 16,),),
          ],
        ),
      ],
    ),
  );
}

Widget _buildInvoiceRow(String title, String amount) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,style: const TextStyle(  fontSize: 14,),),
        Text(amount, style: const TextStyle(fontSize: 14,),),
      ],
    ),
  );
}

Widget _buildOrderSummary() {
  return Container(
    margin: const EdgeInsets.only(top: 10),
    decoration: BoxDecoration(color: const Color(0xFFEFEFEF),borderRadius: BorderRadius.circular(10),),
    child: Padding(padding: const EdgeInsets.all(15),
      child: Column(mainAxisSize: MainAxisSize.min,
        children: [
          const Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text( 'Tổng cộng',style: TextStyle(fontSize: 16,color: Colors.black,  fontWeight: FontWeight.bold,),),
              Text('357.000 đ', style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold,),),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(10),),
            child: TextButton(
              onPressed: () {},
              child: Container(padding: const EdgeInsets.symmetric(vertical: 15),
                child: const Center(
                  child: Text('Đặt đơn',style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold,),),
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
}