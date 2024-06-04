import 'dart:async';
import 'package:bloc/bloc.dart';
import './product_event.dart';
import './product_state.dart';
import '../../models/product.dart';
import '../../services/product_service.dart';

class ProductBloc {
  final _stateController = StreamController<ProductState>();
  final ProductService productService = ProductService('http://10.0.2.2:5000');

  @override
  Stream<ProductState> get state => _stateController.stream;

  ProductBloc() {
    send(LoadProduct.load);
  }

  void send(LoadProduct event) async {
    switch (event) {
      case LoadProduct.load:
        try {
          List<ProductModel> products = await productService.getProduct();
          _stateController.sink.add(ProductState.loadded(products));
          print('New state: loaded');
        } catch (e) {
          _stateController.sink.add(ProductState.error(e.toString()));
          print('New state: error - ${e.toString()}');
        }
    }
  }

  void dispose() {
    _stateController.close();
  }
}
