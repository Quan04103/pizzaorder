import 'package:flutter_test/flutter_test.dart';
import 'package:pizzaorder/pizzaorder/models/order.dart';
import 'package:pizzaorder/pizzaorder/models/order_item_in_cart.dart';
import 'package:pizzaorder/pizzaorder/services/order_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// flutter test test/order_test.dart để chạy test
void main() async {
  await dotenv.load();
  test('Test addOrder', () async {
    OrderService orderService = OrderService();
    OrderModel order = await orderService.addOrder(
        '66662a60aaf17bb8aad053a3',
        [
           OrderItem(idproduct: '6648c85407ad9afaf88501e9', quantity: 1),
           OrderItem(idproduct: '6648c85407ad9afaf88501e8', quantity: 2)
        ],
        320000,
        DateTime.now());
    print('Received user ID: ${order.userId}');
    print('Received price: ${order.price}');
  });
}
