class ProductModel {
  final String id;
  final String name;
  final String category;
  final double price;
  final String imagePath;
  final double rating;
  final int reviewCount;
  final String description;
  final List<String> colors;

  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.imagePath,
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.colors,
  });
}

class CartItem {
  final ProductModel product;
  int quantity;
  String selectedColor;

  CartItem({
    required this.product,
    this.quantity = 1,
    required this.selectedColor,
  });
}