import 'package:flutter/material.dart';
import 'home_screen.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Gambar sukses dari assets
              Image.asset(
                'assets/images/logo/sukses.png',
                width: 300,
                height: 300,
                errorBuilder: (_, __, ___) => Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.chair_outlined,
                      size: 70, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 16),

              // Centang hijau
              // Container(
              //   width: 48,
              //   height: 48,
              //   decoration: const BoxDecoration(
              //     color: Color(0xFF4CAF50),
              //     shape: BoxShape.circle,
              //   ),
              //   child: const Icon(Icons.check, color: Colors.white, size: 28),
              // ),
              const SizedBox(height: 28),

              const Text(
                'SUCCESS!',
                style:
                    TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'Your order will be delivered soon.\nThank you for choosing our app!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey, fontSize: 14, height: 1.6),
              ),

              const Spacer(),

              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),  
                child: const Text('Track your orders',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                  (route) => false,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: const Text('Back to home',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}