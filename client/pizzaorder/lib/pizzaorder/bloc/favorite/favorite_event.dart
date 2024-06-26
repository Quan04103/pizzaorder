import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pizzaorder/pizzaorder/models/product.dart';

abstract class FavoriteEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddFavorite extends FavoriteEvent {
  final ProductModel product;

  AddFavorite(this.product);

  @override
  List<Object> get props => [product];
}

class RemoveFavorite extends FavoriteEvent {
  final ProductModel product;

  RemoveFavorite(this.product);

  @override
  List<Object> get props => [product];
}

class ToggleFavoriteEvent extends FavoriteEvent {
  final ProductModel product;

  ToggleFavoriteEvent(this.product);

  @override
  List<Object> get props => [product];
}