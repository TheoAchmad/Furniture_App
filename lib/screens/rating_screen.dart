import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../data/dummy_data.dart';

class RatingScreen extends StatefulWidget {
  final ProductModel product;
  const RatingScreen({super.key, required this.product});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  int _myRating = 0;
  final _reviewCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Rating & Review',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Product summary
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: Image.asset(widget.product.imagePath,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                  color: Colors.grey.shade100,
                                  child: const Icon(Icons.image_outlined))),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.product.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.amber, size: 16),
                              const SizedBox(width: 4),
                              Text('${widget.product.rating}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Text(
                              '${widget.product.reviewCount} reviews',
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 13)),
                        ],
                      ),
                    ],
                  ),
                  const Divider(height: 30),

                  // Reviews list
                  ...dummyReviews.map((r) => _ReviewTile(review: r)),

                  // Write review section
                  const SizedBox(height: 16),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Tulis Review',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                  const SizedBox(height: 10),
                  // Star rating input
                  Row(
                    children: List.generate(
                      5,
                      (i) => GestureDetector(
                        onTap: () => setState(() => _myRating = i + 1),
                        child: Icon(
                          i < _myRating ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _reviewCtrl,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Tulis ulasan Anda...',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Colors.grey.shade300)),
                      contentPadding: const EdgeInsets.all(14),
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
          // Write review button
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
            child: ElevatedButton(
              onPressed: () {
                if (_myRating == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Pilih rating terlebih dahulu')),
                  );
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Review berhasil dikirim!'),
                      backgroundColor: Colors.green),
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text('Write a review',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewTile extends StatelessWidget {
  final dynamic review;
  const _ReviewTile({required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.grey.shade200,
                    child: Text(
                      review.userName[0],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(review.userName,
                      style: const TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
              Text(review.date,
                  style: const TextStyle(
                      color: Colors.grey, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: List.generate(
                5,
                (j) => Icon(Icons.star,
                    size: 16,
                    color: j < review.rating.round()
                        ? Colors.amber
                        : Colors.grey.shade300)),
          ),
          const SizedBox(height: 6),
          Text(review.comment,
              style: const TextStyle(
                  fontSize: 13, color: Colors.grey, height: 1.5)),
          const Divider(height: 20),
        ],
      ),
    );
  }
}