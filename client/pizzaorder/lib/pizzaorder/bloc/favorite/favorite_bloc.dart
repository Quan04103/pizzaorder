import 'dart:convert';
import 'package:pizzaorder/pizzaorder/models/product.dart';
import 'favorite_event.dart';
import 'favorite_state.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  // Khởi tạo danh sách yêu thích rỗng
  final List<ProductModel> listFavorites = [];
  //Set<ProductModel> favorites = {};
  FavoriteBloc() : super(FavoritesLoading()) {
    on<AddFavorite>((event, emit) {
      // Kiểm tra nếu sản phẩm chưa có trong danh sách
      if (!listFavorites.contains(event.product)) {
        listFavorites.add(event.product); // Thêm vào danh sách
        print(event.product);
        print(listFavorites.toString());
        _saveFavorites();

        emit(FavoritesUpdated(favorites: listFavorites));
      }
    });

    on<RemoveFavorite>((event, emit) {
      // Kiểm tra nếu sản phẩm có trong danh sách
      if (listFavorites.contains(event.product)) {
        listFavorites.remove(event.product); // Xóa khỏi danh sách
        print(listFavorites.toString());
        _saveFavorites();
        emit(FavoritesUpdated(favorites: listFavorites));
      }
    });

    on<ToggleFavoriteEvent>((event, emit) {
      if (listFavorites.contains(event.product)) {
        listFavorites.remove(event.product);
      } else {
        listFavorites.add(event.product);
      }
      emit(FavoritesUpdated(favorites: listFavorites.toList()));
    });
    _loadFavorites();
  }
  bool isFavorite(ProductModel product) => listFavorites.contains(product);

  void _loadFavorites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? favoritesJson = prefs.getString('favorites');
    if (favoritesJson != null) {
      final List<dynamic> favoritesList = json.decode(favoritesJson);
      listFavorites.clear();
      listFavorites
          .addAll(favoritesList.map((e) => ProductModel.fromJson(e)).toList());
      emit(FavoritesUpdated(favorites: listFavorites));
    }
  }

  // Phương thức lưu danh sách yêu thích vào Shared Preferences
  void _saveFavorites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String favoritesJson =
        json.encode(listFavorites.map((e) => e.toJson()).toList());
    await prefs.setString('favorites', favoritesJson);
  }
}
// class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
//   // Khởi tạo danh sách yêu thích rỗng dưới dạng Set để đảm bảo tính duy nhất
//   final List<ProductModel> _favorites = [];

//   FavoriteBloc() : super(FavoritesLoading()) {
//     on<AddFavorite>((event, emit) {
//       // Thêm sản phẩm vào danh sách, Set tự động loại bỏ trùng lặp
//       _favorites.add(event.product);
//       emit(FavoritesUpdated(favorites: _favorites));
//     });

//     on<RemoveFavorite>((event, emit) {
//       // Xóa sản phẩm khỏi danh sách
//       _favorites.remove(event.product);
//       emit(FavoritesUpdated(favorites: _favorites));
//     });
//   }

//   // Kiểm tra xem sản phẩm có phải là yêu thích không
//   bool isFavorite(ProductModel product) => _favorites.contains(product);
// }