import 'dart:async';
import 'package:bloc/bloc.dart';
import 'pizza_event.dart';
import 'pizza_state.dart';
import '../../models/product.dart';
import '../../services/product_service.dart';

class PizzaBloc extends Bloc<LoadProduct, PizzaState> {
  final ProductService productService = ProductService();

  PizzaBloc() : super(PizzaState.initial()) {
    on<LoadProduct>((event, emit) async {
      try {
        List<ProductModel> products;
        if (event.loadNewest) {
          products = await productService.getNewestProduct();
        } else {
          products =
              await productService.getProductByCategoryId(event.categoryId);
        }
        emit(PizzaState.loadded(products));
        print('New state: loaded');
      } catch (e) {
        emit(PizzaState.error(e.toString()));
        print('New state: error - ${e.toString()}');
      }
    });
  }
}
