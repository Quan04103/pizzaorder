import 'package:equatable/equatable.dart';
import 'package:pizzaorder/pizzaorder/models/order.dart';
import 'package:pizzaorder/pizzaorder/models/order_item_in_cart.dart';
//import 'package:pizzaorder/pizzaorder/models/product.dart';

class CartState extends Equatable {
  final List<OrderItem> cartItems;
  final bool isUpdated;
  final bool isError;
  final bool isSubmitted;
  final OrderModel? order;

  @override
  const CartState({
    required this.cartItems,
    required this.isUpdated,
    required this.isError,
    required this.isSubmitted,
    this.order,
  });

  factory CartState.initial() {
    return const CartState(
      cartItems: [],
      isUpdated: false,
      isError: false,
      isSubmitted: false,
    );
  }

  factory CartState.updated(List<OrderItem> cartItems) {
    return CartState(
      cartItems: cartItems,
      isUpdated: true,
      isError: false,
      isSubmitted: false,
    );
  }

  factory CartState.error(String error) {
    return const CartState(
      cartItems: [],
      isUpdated: false,
      isError: true,
      isSubmitted: false,
    );
  }

  factory CartState.submitted(OrderModel order, List<OrderItem> cartItems) {
    return CartState(
      cartItems: cartItems,
      isUpdated: false,
      isError: false,
      isSubmitted: true,
      order: order,
    );
  }

  @override
  List<Object?> get props =>
      [cartItems, isUpdated, isError, isSubmitted, order];

  @override
  String toString() {
    return 'CartState: isUpdated: $isUpdated, isSubmitted: $isSubmitted, order: $order, products: $cartItems';
  }
}
