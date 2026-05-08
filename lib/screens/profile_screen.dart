import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';
import 'order_screen.dart';
import 'shipping_address_screen.dart';
import 'payment_method_screen.dart';
import 'my_reviews_screen.dart';
import 'setting_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ── Header title ──────────────────────────────
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text('Profile',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),

              // ── Avatar + nama + email ─────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.grey.shade200,
                      child: const Icon(Icons.person,
                          size: 40, color: Colors.grey),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(profile.name,
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(profile.email,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 13)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // ── Menu items ────────────────────────────────
              _MenuItem(
                icon: Icons.shopping_bag_outlined,
                title: 'My orders',
                subtitle: 'Already have 10 orders',
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const OrderScreen())),
              ),
              _MenuItem(
                icon: Icons.location_on_outlined,
                title: 'Shipping Addresses',
                subtitle: '${profile.addresses.length} Addresses',
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const ShippingAddressScreen())),
              ),
              _MenuItem(
                icon: Icons.credit_card_outlined,
                title: 'Payment Method',
                subtitle: 'You have ${profile.cards.length} cards',
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const PaymentMethodScreen())),
              ),
              _MenuItem(
                icon: Icons.star_outline,
                title: 'My reviews',
                subtitle: 'Reviews for 5 items',
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const MyReviewsScreen())),
              ),
              _MenuItem(
                icon: Icons.settings_outlined,
                title: 'Setting',
                subtitle: 'Notification, Password, FAQ, Contact',
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SettingScreen())),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Colors.grey.shade100, width: 1)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 24, color: Colors.black87),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 2),
                  Text(subtitle,
                      style: const TextStyle(
                          fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}