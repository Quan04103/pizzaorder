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
import 'package:pizzaorder/pizzaorder/bloc/coupon/coupon_bloc.dart';
import 'package:pizzaorder/pizzaorder/bloc/coupon/coupon_event.dart';
import 'package:pizzaorder/pizzaorder/bloc/coupon/coupon_state.dart';
import 'package:pizzaorder/pizzaorder/models/coupon.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<OrderItem> cartItems = [];
  final OrderService orderService = OrderService();
  final CouponBloc couponBloc;
  double total = 0;
  //tính tổng tiền
  double calculateTotalPrice(List<OrderItem> cartItems) {
    double totalAllPrice = 0;
    for (var item in cartItems) {
      totalAllPrice += item.totalPrice;
    }
    return totalAllPrice;
  }

  CartBloc(this.couponBloc) : super(CartState.initial()) {
    on<LoadList>((event, emit) async {
      try {
        add(UpdateTotalPrice()); // Thêm sự kiện UpdateTotalPrice
        // print('Adding products: ${event.products}');
        emit(CartState.updated(cartItems, total));
        print('New state loadlist: updated');
        print(state.toString());
        print(state.cartItems);
      } catch (e) {
        emit(CartState.error(e.toString()));
        print('New state: error - ${e.toString()}');
      }
    });

    on<UpdateTotalPrice>((event, emit) async {
      print(
          'UpdateTotalPrice event started'); // Thêm dòng này để biết sự kiện bắt đầu
      try {
        print(
            'Calculating total price'); // Thêm dòng này trước khi tính toán tổng giá
        total = calculateTotalPrice(cartItems);
        print(
            'Total price calculated: $total'); // In ra tổng giá sau khi tính toán
        emit(CartState.updated(cartItems,
            total)); // Giả sử bạn có trạng thái này để cập nhật tổng giá tiền
        print(
            'CartState updated with total price'); // Thêm dòng này sau khi trạng thái được cập nhật
      } catch (e) {
        print('Error occurred: $e'); // In ra lỗi nếu có
        emit(CartState.error(e.toString()));
      }
    });

    on<AddProducts>((event, emit) async {
      try {
        final existingProductIndex = cartItems
            .indexWhere((item) => item.idproduct == event.products.idproduct);

        if (existingProductIndex == -1) {
          cartItems.add(event.products);
          print('New product added to cart');
        }
        add(UpdateTotalPrice()); // Thêm sự kiện UpdateTotalPrice
        emit(CartState.updated(cartItems, total));
        print('New state: updated');
      } catch (e) {
        emit(CartState.error(e.toString()));
        print('New state: error - ${e.toString()}');
      }
    });

    on<IncreaseQuantityProduct>((event, emit) async {
      try {
        // Tăng số lượng của sản phẩm trực tiếp
        final existingProductIndex = cartItems
            .indexWhere((item) => item.idproduct == event.product.idproduct);

        if (existingProductIndex != -1) {
          cartItems[existingProductIndex].quantity++;
          print(
              'Product quantity increased: ${cartItems[existingProductIndex].quantity}');
        } else {
          cartItems.add(event.product);
          print('New product added to cart');
        }
        add(UpdateTotalPrice()); // Thêm sự kiện UpdateTotalPrice

        emit(CartState.updated(cartItems, total));
        print('New state: updated increase quantity');
      } catch (e) {
        emit(CartState.error(e.toString()));
      }
    });

    on<DecreaseQuantityProduct>((event, emit) async {
      try {
        var productIndex = state.cartItems
            .indexWhere((item) => item.idproduct == event.product.idproduct);
        if (productIndex != -1) {
          var product = state.cartItems[productIndex];
          if (product.quantity > 1) {
            product.quantity--;
          } else {
            state.cartItems.removeWhere((item) =>
                item.idproduct == event.product.idproduct &&
                item.quantity <= 1);
          }
          add(UpdateTotalPrice()); // Thêm sự kiện UpdateTotalPrice
          emit(CartState.updated(state.cartItems, total));
          print('New state decrease: updated');
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
        var product = state.cartItems
            .firstWhere((item) => item.idproduct == event.product.idproduct);
        state.cartItems.remove(product);
        add(UpdateTotalPrice()); // Thêm sự kiện UpdateTotalPrice
        emit(CartState.updated(List.from(state.cartItems),
            total)); // Cập nhật state với danh sách mới
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
        print('Token: $token'); // Debug log to check for token
        var order = await orderService.addOrder(
            cartItems, event.total, DateTime.now(), token);
        cartItems.clear();
        emit(CartState.submitted(order, cartItems));
      } catch (e) {
        emit(CartState.error(e.toString()));
      }
    });
  }
}
