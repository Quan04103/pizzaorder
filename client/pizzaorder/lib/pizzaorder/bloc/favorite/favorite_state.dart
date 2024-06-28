import 'package:equatable/equatable.dart';
import 'package:pizzaorder/pizzaorder/models/product.dart';

abstract class FavoriteState extends Equatable {
  @override
  List<Object> get props => [];
}

class FavoritesLoading extends FavoriteState {}

class FavoritesLoaded extends FavoriteState {
  final List<ProductModel> favorites;

  FavoritesLoaded(this.favorites);

  @override
  List<Object> get props => [favorites];
}

class FavoritesUpdated extends FavoriteState {
  final List<ProductModel> favorites;

  FavoritesUpdated({required this.favorites});

  @override
  List<Object> get props => [favorites];
}

class FavoritesError extends FavoriteState {}


// class FavoriteState {
//   final bool isLoading;
//   final bool isLoaded;
//   final bool isError;
//   List<ProductModel>? products;

//   @override
//   String toString() {
//     return 'ProductState: isLoading: $isLoading, isLoaded: $isLoaded, products: $products';
//   }

//   FavoriteState({
//     required this.isLoading,
//     required this.isLoaded,
//     required this.isError,
//     this.products,
//   });

//   factory FavoriteState.initial() {
//     return FavoriteState(
//       isLoading: false,
//       isLoaded: false,
//       isError: false,
//     );
//   }
//   factory FavoriteState.loadding() {
//     return FavoriteState(
//       isLoading: true,
//       isLoaded: false,
//       isError: false,
//     );
//   }
//   factory FavoriteState.loadded(List<ProductModel> products) {
//     return FavoriteState(
//       isLoading: false,
//       isLoaded: true,
//       isError: false,
//       products: products,
//     );
//   }

//   factory FavoriteState.error(String string) {
//     return FavoriteState(
//       isLoading: false,
//       isLoaded: false,
//       isError: true,
//     );
//   }
// }