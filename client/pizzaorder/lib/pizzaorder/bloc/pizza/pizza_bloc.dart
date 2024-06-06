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
        switch (event) {
          case LoadProduct.load:
            products = await productService
                .getProductByCategoryId('6646fc283146973b72ad5eb2');
            break;
          case LoadProduct.loadNewest:
            products = await productService.getNewestProduct();
            break;
          default:
            products = [];
            break;
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
