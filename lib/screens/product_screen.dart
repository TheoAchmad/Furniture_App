import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../providers/cart_provider.dart';
import '../providers/favorite_provider.dart';
import 'cart_screen.dart';

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
    final colors = widget.product.colors;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image dengan back button
                Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 380,
                      child: Image.asset(
                        widget.product.imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: Colors.grey.shade100,
                          child: const Icon(Icons.image_outlined,
                              size: 80, color: Colors.grey),
                        ),
                      ),
                    ),
                    // Back button
                    Positioned(
                      top: 50,
                      left: 16,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.chevron_left, size: 28),
                        ),
                      ),
                    ),
                    // Color Selector di sisi kiri
                    Positioned(
                      left: 16,
                      top: 120,
                      child: Column(
                        children: List.generate(colors.length, (i) {
                          final color = Color(
                              int.parse(colors[i].replaceAll('#', '0xFF')));
                          final isSelected = i == _selectedColorIndex;
                          return GestureDetector(
                            onTap: () =>
                                setState(() => _selectedColorIndex = i),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.black
                                      : Colors.transparent,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26, blurRadius: 4)
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),

                // Product Info
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nama + Quantity
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.product.name,
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          // Quantity control
                          Row(
                            children: [
                              _qtyBtn(Icons.add,
                                  () => setState(() => _quantity++)),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Text('${_quantity < 10 ? '0' : ''}$_quantity',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ),
                              _qtyBtn(Icons.remove, () {
                                if (_quantity > 1)
                                  setState(() => _quantity--);
                              }),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Harga
                      Text(
                        '\$ ${(widget.product.price * _quantity).toStringAsFixed(0)}',
                        style: const TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      // Rating
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.product.rating}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '  (${widget.product.reviewCount} reviews)',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Deskripsi
                      Text(
                        widget.product.description,
                        style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                            height: 1.6),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Buttons
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
              color: Colors.white,
              child: Row(
                children: [
                  // Favorite button
                  GestureDetector(
                    onTap: () => fav.toggleFavorite(widget.product),
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        isFav ? Icons.bookmark : Icons.bookmark_border,
                        color: isFav ? Colors.black : Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Add to cart
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        cart.addToCart(
                          widget.product,
                          widget.product.colors[_selectedColorIndex],
                        );
                        // Tambahkan sesuai quantity
                        for (int i = 1; i < _quantity; i++) {
                          cart.increaseQuantity(widget.product.id);
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${widget.product.name} ditambahkan ke keranjang'),
                            duration: const Duration(seconds: 2),
                            action: SnackBarAction(
                              label: 'Lihat',
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const CartScreen()),
                              ),
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      child: const Text(
                        'Add to cart',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _qtyBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 16),
      ),
    );
  }
}