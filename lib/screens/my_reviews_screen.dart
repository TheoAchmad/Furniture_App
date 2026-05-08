import 'package:flutter/material.dart';
import '../data/dummy_data.dart';

class MyReviewsScreen extends StatelessWidget {
  const MyReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('My reviews',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: dummyReviews.length,
        itemBuilder: (_, i) {
          final r = dummyReviews[i];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.04), blurRadius: 6)
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product info
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: Image.asset(r.productImage,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                                color: Colors.grey.shade100,
                                child: const Icon(Icons.image_outlined,
                                    color: Colors.grey))),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(r.productName,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                        Text('\$ ${r.productPrice.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 13)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Stars + date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: List.generate(
                          5,
                          (j) => Icon(Icons.star,
                              size: 16,
                              color: j < r.rating.round()
                                  ? Colors.amber
                                  : Colors.grey.shade300)),
                    ),
                    Text(r.date,
                        style: const TextStyle(
                            color: Colors.grey, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(r.comment,
                    style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        height: 1.5)),
              ],
            ),
          );
        },
      ),
    );
  }
}