import 'dart:async';
import 'package:bloc/bloc.dart';
import 'search_event.dart';
import 'search_state.dart';
import '../../models/product.dart';
import '../../services/search_service.dart';

class SearchBloc extends Bloc<LoadProduct, SearchState> {
  final SearchService productService;
  // Declare the productController as a StreamController that handles a list of ProductModel
  final StreamController<List<ProductModel>> productController =
      StreamController<List<ProductModel>>();

  SearchBloc({required this.productService}) : super(SearchState.initial()) {
    on<LoadProduct>((event, emit) async {
      emit(SearchState.loading());
      try {
        List<ProductModel> products = [];
        if (event is SearchProduct) {
          products = await productService.getProductByName(event.query);
        }
        emit(SearchState.loaded(products));
        // Add the products to the stream
        productController.sink.add(products);
      } catch (e) {
        emit(SearchState.error());
        // In case of error, you might want to add an empty list or handle errors differently
        productController.sink.add([]);
      }
    });
  }

  // Override the close method to close the StreamController when the Bloc is closed
  @override
  Future<void> close() {
    productController.close();
    return super.close();
  }
}
