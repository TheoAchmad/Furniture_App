import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../providers/cart_provider.dart';
import '../providers/favorite_provider.dart';
import '../data/dummy_data.dart';
import 'rating_screen.dart';

// Definisi Model di dalam file untuk mencegah error "Merah"
class ReviewModel {
  final String userName;
  final String userAvatar;
  final int rating;
  final String comment;
  final String date;
  final String productName;
  final String productImage;
  final double productPrice;

  ReviewModel({
    required this.userName,
    required this.userAvatar,
    required this.rating,
    required this.comment,
    required this.date,
    required this.productName,
    required this.productImage,
    required this.productPrice,
  });
}

class ProductScreen extends StatefulWidget {
  final ProductModel product;
  const ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int _quantity = 1;
  int _selectedColorIndex = 0;

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartProvider>();
    final fav = context.watch<FavoriteProvider>();
    final isFav = fav.isFavorite(widget.product.id);

    // LOGIKA FILTER: Menggunakan toLowerCase() agar tidak sensitif terhadap huruf kapital
    final List<ReviewModel> productReviews = dummyReviews
        .whereType<ReviewModel>()
        .where((r) => r.productName.trim().toLowerCase() == widget.product.name.trim().toLowerCase())
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderImage(),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTitleRow(),
                      const SizedBox(height: 8),
                      _buildPrice(),
                      const SizedBox(height: 8),
                      _buildRatingSummary(),
                      const SizedBox(height: 16),
                      _buildDescription(),
                      
                      const SizedBox(height: 32),
                      
                      // --- SECTION REVIEWS ---
                      const Text(
                        "Reviews",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      const SizedBox(height: 16),
                      
                      if (productReviews.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text("No reviews yet for this product.", 
                            style: TextStyle(color: Colors.grey, fontSize: 14)),
                        )
                      else
                        ...[
                          ...productReviews.take(3).map((review) => _buildReviewCard(review)),
                          const SizedBox(height: 8),
                          _buildViewAllButton(),
                        ],

                      const SizedBox(height: 120), // Spasi agar tidak tertutup tombol Add to Cart
                    ],
                  ),
                ),
              ],
            ),
          ),
          _buildBottomNavigationBar(fav, isFav, cart),
        ],
      ),
    );
  }

  // Desain Kartu Review yang disesuaikan dengan MyReviewsScreen
  Widget _buildReviewCard(ReviewModel r) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(r.userName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Text(r.date, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(5, (index) {
              return Icon(
                Icons.star,
                size: 16,
                color: index < r.rating ? Colors.amber : Colors.grey.shade300,
              );
            }),
          ),
          const SizedBox(height: 12),
          Text(
            r.comment,
            style: const TextStyle(fontSize: 13, color: Colors.black54, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildViewAllButton() {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => RatingScreen(product: widget.product)),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text('See All Reviews', 
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        ),
      ),
    );
  }

  // --- WIDGET HELPER ---

  Widget _buildHeaderImage() {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 400,
          child: Image.asset(widget.product.imagePath, fit: BoxFit.cover),
        ),
        Positioned(
          top: 50,
          left: 20,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            onPressed: () => Navigator.pop(context),
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              fixedSize: const Size(45, 45),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(widget.product.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        _buildQuantitySelector(),
      ],
    );
  }

  Widget _buildQuantitySelector() {
    return Row(
      children: [
        _qtyBtn(Icons.add, () => setState(() => _quantity++)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text('$_quantity', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        _qtyBtn(Icons.remove, () {
          if (_quantity > 1) setState(() => _quantity--);
        }),
      ],
    );
  }

  Widget _qtyBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18),
      ),
    );
  }

  Widget _buildPrice() {
    return Text('\$ ${(widget.product.price * _quantity).toStringAsFixed(2)}',
        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold));
  }

  Widget _buildRatingSummary() {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.amber, size: 20),
        const SizedBox(width: 5),
        Text('${widget.product.rating}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(width: 8),
        Text('(${widget.product.reviewCount} reviews)', style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildDescription() {
    return Text(
      widget.product.description,
      style: const TextStyle(fontSize: 14, color: Colors.grey, height: 1.6),
    );
  }

  Widget _buildBottomNavigationBar(FavoriteProvider fav, bool isFav, CartProvider cart) {
    return Positioned(
      bottom: 0, left: 0, right: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 35),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => fav.toggleFavorite(widget.product),
              child: Container(
                width: 55, height: 55,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(isFav ? Icons.bookmark : Icons.bookmark_border, color: Colors.black),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  cart.addToCart(widget.product, widget.product.colors[_selectedColorIndex]);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added to cart!'), duration: Duration(seconds: 1)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text('Add to cart', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}