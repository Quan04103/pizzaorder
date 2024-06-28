import 'package:flutter/material.dart';

class FavoriteModel extends ChangeNotifier {
  bool _isFavorite = false;

  bool get isFavorite => _isFavorite;

  void toggleFavorite() {
    _isFavorite = !_isFavorite;
    notifyListeners();
  }
}