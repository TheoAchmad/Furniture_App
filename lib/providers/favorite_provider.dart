import 'package:flutter/foundation.dart';
import '../models/product_model.dart';

class FavoriteProvider with ChangeNotifier {
  final List<ProductModel> _favorites = [];

  List<ProductModel> get favorites => _favorites;

  bool isFavorite(String id) => _favorites.any((p) => p.id == id);

  void toggleFavorite(ProductModel product) {
    if (isFavorite(product.id)) {
      _favorites.removeWhere((p) => p.id == product.id);
    } else {
      _favorites.add(product);
    }
    notifyListeners();
  }
}