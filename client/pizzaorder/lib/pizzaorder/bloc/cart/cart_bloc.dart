import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:pizzaorder/pizzaorder/services/order_service.dart';
import 'cart_event.dart';
import 'cart_state.dart';
import '../../models/order.dart';
import '../../models/order_item_in_cart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<OrderItem> cartItems = [];
  final OrderService orderService = OrderService();

  CartBloc() : super(CartState.initial()) {
    on<AddProducts>((event, emit) async {
      try {
        // print('Adding products: ${event.products}');
        cartItems.add(event.products);
        emit(CartState.updated(cartItems));
        print('New state: updated');
        print(state.cartItems);
      } catch (e) {
        emit(CartState.error(e.toString()));
        print('New state: error - ${e.toString()}');
      }
    });

    on<IncreaseQuantityProduct>((event, emit) async {
      try {
        var product = cartItems
            .firstWhere((item) => item.idproduct == event.product.idproduct);
        product.quantity++;
        emit(CartState.updated(cartItems));
        print('New state: updated');
        print(state.cartItems);
      } catch (e) {
        emit(CartState.error(e.toString()));
      }
    });

    on<DecreaseQuantityProduct>((event, emit) async {
      try {
        var product = cartItems
            .firstWhere((item) => item.idproduct == event.product.idproduct);
        if (product.quantity > 1) {
          product.quantity--;
          emit(CartState.updated(cartItems));
          print('New state: updated');
          print(state.cartItems);
        } else {
          cartItems.remove(product);
        }
      } catch (e) {
        emit(CartState.error(e.toString()));
      }
    });

    on<RemoveProduct>((event, emit) async {
      try {
        var product = cartItems
            .firstWhere((item) => item.idproduct == event.product.idproduct);
        cartItems.remove(product);
        emit(CartState.updated(cartItems));
        print('New state: updated');
        print(state.cartItems);
      } catch (e) {
        emit(CartState.error(e.toString()));
      }
    });

    on<SubmitCart>((event, emit) async {
      try {
        var order = await orderService.addOrder(
          event.userId,
          cartItems,
          event.total,
          DateTime.now(),
        );
        cartItems.clear();
        emit(CartState.submitted(order, cartItems));
      } catch (e) {
        emit(CartState.error(e.toString()));
      }
    });
  }
}

  // Future<void> _mapSubmitOrderToState(
  //     SubmitOrder event, Emitter<CartState> emit) async {
  //   try {
  //     print('Submitting order...');
  //     await _orderService.addOrder(
  //         event.userId, state.products, event.price, DateTime.now());
  //     print('Order submitted successfully!');
  //     emit(const CartUpdated([])); // Clear cart after successful order
  //   } catch (e) {
  //     print('Error submitting order: $e');
  //     emit(CartError(e.toString()));
  //   }
  // }

