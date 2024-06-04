import 'package:pizzaorder/pizzaorder/models/product.dart';

class ProductState {
  final bool isLoading;
  final bool isLoaded;
  final bool isError;
  List<ProductModel>? products;

  @override
  String toString() {
    return 'ProductState: isLoading: $isLoading, isLoaded: $isLoaded, products: $products';
  }

  ProductState({
    required this.isLoading,
    required this.isLoaded,
    required this.isError,
    this.products,
  });

  factory ProductState.initial() {
    return ProductState(
      isLoading: false,
      isLoaded: false,
      isError: false,
    );
  }
  factory ProductState.loadding() {
    return ProductState(
      isLoading: true,
      isLoaded: false,
      isError: false,
    );
  }
  factory ProductState.loadded(List<ProductModel> products) {
    return ProductState(
      isLoading: false,
      isLoaded: true,
      isError: false,
      products: products,
    );
  }

  factory ProductState.error(String string) {
    return ProductState(
      isLoading: false,
      isLoaded: false,
      isError: true,
    );
  }
}
