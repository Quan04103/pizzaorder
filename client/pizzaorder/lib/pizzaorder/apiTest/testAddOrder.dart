import 'package:pizzaorder/pizzaorder/models/order.dart';
import 'package:pizzaorder/pizzaorder/models/order_item_in_cart.dart';
import '../services/order_service.dart';

void main() async {
  OrderService orderService = OrderService();
  OrderModel order = await orderService.addOrder('testUser',
      [OrderItem(idproduct: '1', quantity: 1)], 10.0, DateTime.now());
  print('Received user ID: ${order.userId}');
  print('Received price: ${order.price}');
}
