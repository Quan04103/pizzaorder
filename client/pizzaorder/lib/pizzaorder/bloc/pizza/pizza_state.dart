import 'package:pizzaorder/pizzaorder/models/product.dart';

class PizzaState {
  final bool isLoading;
  final bool isLoaded;
  final bool isError;
  List<ProductModel>? products;

  @override
  String toString() {
    return 'ProductState: isLoading: $isLoading, isLoaded: $isLoaded, products: $products';
  }

  PizzaState({
    required this.isLoading,
    required this.isLoaded,
    required this.isError,
    this.products,
  });

  factory PizzaState.initial() {
    return PizzaState(
      isLoading: false,
      isLoaded: false,
      isError: false,
    );
  }
  factory PizzaState.loadding() {
    return PizzaState(
      isLoading: true,
      isLoaded: false,
      isError: false,
    );
  }
  factory PizzaState.loadded(List<ProductModel> products) {
    return PizzaState(
      isLoading: false,
      isLoaded: true,
      isError: false,
      products: products,
    );
  }

  factory PizzaState.error(String string) {
    return PizzaState(
      isLoading: false,
      isLoaded: false,
      isError: true,
    );
  }
}
