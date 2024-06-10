import 'package:equatable/equatable.dart';
import 'package:pizzaorder/pizzaorder/models/order.dart';
import 'package:pizzaorder/pizzaorder/models/order_item_in_cart.dart';
import 'package:pizzaorder/pizzaorder/models/product.dart';

class CartState extends Equatable {
  final bool isUpdated;
  final bool isError;
  final bool isSubmitted;
  final OrderModel? order;
  List<OrderItem>? cartItems;

  @override
  List<Object> get props =>
      [isUpdated, isError, isSubmitted, order ?? [], cartItems ?? []];

  @override
  String toString() {
    return 'CartState: isUpdated: $isUpdated, isSubmitted: $isSubmitted, order: $order, products: $cartItems';
  }

  CartState({
    required this.isUpdated,
    required this.isError,
    required this.isSubmitted,
    this.order,
    this.cartItems,
  });

  factory CartState.initial() {
    return CartState(
      isUpdated: false,
      isError: false,
      isSubmitted: false,
    );
  }

  factory CartState.updated(List<OrderItem> cartItem) {
    return CartState(
      isUpdated: true,
      isError: false,
      isSubmitted: false,
      cartItems: cartItem,
    );
  }

  factory CartState.error(String string) {
    return CartState(
      isUpdated: false,
      isError: true,
      isSubmitted: false,
    );
  }

  factory CartState.submitted(OrderModel order, List<OrderItem> cartItems) {
    return CartState(
        isUpdated: false,
        isError: false,
        isSubmitted: true,
        order: order,
        cartItems: cartItems);
  }
}
