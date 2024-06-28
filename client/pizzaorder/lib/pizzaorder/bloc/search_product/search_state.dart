import 'package:pizzaorder/pizzaorder/models/product.dart';

class SearchState {
  final bool isLoading;
  final bool isLoaded;
  final bool isError;
  final List<ProductModel>? products;

  @override
  String toString() {
    return 'ProductState: isLoading: $isLoading, isLoaded: $isLoaded,isError: $isError,  products: $products';
  }

  SearchState({
    required this.isLoading,
    required this.isLoaded,
    required this.isError,
    this.products,
  });

  factory SearchState.initial() => SearchState(
      isLoading: false, isLoaded: false, isError: false, products: []);
  factory SearchState.loading() => SearchState(
      isLoading: true, isLoaded: false, isError: false, products: []);
  factory SearchState.loaded(List<ProductModel> products) => SearchState(
      isLoading: false, isLoaded: true, isError: false, products: products);
  factory SearchState.error() => SearchState(
      isLoading: false, isLoaded: false, isError: true, products: []);
}
