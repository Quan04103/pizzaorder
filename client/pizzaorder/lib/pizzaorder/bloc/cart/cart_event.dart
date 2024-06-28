import 'package:equatable/equatable.dart';
import '../../models/order_item_in_cart.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}
class LoadList extends CartEvent {

  const LoadList();
}

class AddProducts extends CartEvent {
  final OrderItem products;

  const AddProducts(this.products);

  @override
  List<Object> get props => [products];
}

class IncreaseQuantityProduct extends CartEvent {
  final OrderItem product;

  const IncreaseQuantityProduct(this.product);

  @override
  List<Object> get props => [product];
}

class DecreaseQuantityProduct extends CartEvent {
  final OrderItem product;

  const DecreaseQuantityProduct(this.product);
}

class RemoveProduct extends CartEvent {
  final OrderItem product;

  const RemoveProduct(this.product);
}

class SubmitCart extends CartEvent {
  final double total;

  const SubmitCart(this.total);
}