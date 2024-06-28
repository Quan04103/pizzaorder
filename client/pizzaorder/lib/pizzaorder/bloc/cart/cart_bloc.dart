import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:pizzaorder/pizzaorder/models/product.dart';
import 'package:pizzaorder/pizzaorder/services/order_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cart_event.dart';
import 'cart_state.dart';
import '../../models/order.dart';
import '../../models/order_item_in_cart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CartBloc extends Bloc<CartEvent, CartState> {
  
  List<OrderItem> cartItems = [];
  final OrderService orderService = OrderService();
  //tính tổng tiền
double calculateTotalPrice(List<OrderItem> cartItems) {
  double totalAllPrice = 0;
  for (var item in cartItems) {
    totalAllPrice += item.totalPrice;
  }
  return totalAllPrice;
}

  CartBloc() : super(CartState.initial()) {
    on<LoadList>((event, emit) async {
      try {
        // print('Adding products: ${event.products}');
        emit(CartState.updated(state.cartItems));
        print('New state: updated');
        print(state.cartItems);
      } catch (e) {
        emit(CartState.error(e.toString()));
        print('New state: error - ${e.toString()}');
      }
    });
on<AddProducts>((event, emit) async {
  try {
    
    // Kiểm tra xem sản phẩm đã tồn tại trong giỏ hàng chưa
    final existingProductIndex = state.cartItems.indexWhere((item) => item.idproduct == event.products.idproduct);
    if (existingProductIndex != -1) {
      // Nếu sản phẩm đã tồn tại, tăng số lượng sản phẩm
       cartItems[existingProductIndex].quantity++;
    } else {  
      // Nếu sản phẩm chưa tồn tại, thêm sản phẩm mới vào giỏ hàng
      cartItems.add(event.products);
    }
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
    final existingProductIndex = state.cartItems.indexWhere((item) => item.idproduct == event.product.idproduct);
    if (existingProductIndex != -1) {
      // If the product already exists, increase its quantity
      cartItems[existingProductIndex].quantity = cartItems[existingProductIndex].quantity + 1;
      print('Product quantity increased: ${cartItems[existingProductIndex].quantity}');
    } else {  
      // If the product does not exist, add the new product to the cart
      cartItems.add(event.product);
      print('New product added to cart');
    }
    
    emit(CartState.updated(cartItems));
    print('New state: updated increase quantity');
  } catch (e) {
    emit(CartState.error(e.toString()));
  }
});

on<DecreaseQuantityProduct>((event, emit) async {
  try {
    var productIndex = state.cartItems.indexWhere((item) => item.idproduct == event.product.idproduct);
    if (productIndex != -1) {
      var product = state.cartItems[productIndex];
      if (product.quantity > 1) {
        product.quantity--;
      } else {
        state.cartItems.removeWhere((item) => item.idproduct == event.product.idproduct && item.quantity <= 1);
      }
      emit(CartState(
        cartItems: List.from(state.cartItems),
        isUpdated: state.cartItems.isNotEmpty,
        isError: false,
        isSubmitted: false,
        order: null,
      ));
      print('New state: updated');
      print(state.cartItems);
    } else {
      throw Exception("Product not found in cart");
    }
  } catch (e) {
    emit(CartState.error(e.toString()));
    print('New state: error - ${e.toString()}');
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
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String token = prefs.getString('token') ?? '';
        var order = await orderService.addOrder(
          cartItems,
          event.total,
          DateTime.now(),
          token
        );
        cartItems.clear();
        emit(CartState.submitted(order, cartItems));
      } catch (e) {
        emit(CartState.error(e.toString()));
      }
    });


  }
}
