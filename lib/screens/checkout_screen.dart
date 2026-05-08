import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'success_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // Data shipping (nanti bisa dibuat form edit)
  String _name = 'Bruno Fernandes';
  String _address = '25 rue Robert Latouche, Nice, 06200, Côte D\'azur, France';

  // Payment options
  int _selectedPayment = 0;
  final List<Map<String, dynamic>> _payments = [
    {
      'logo': 'assets/images/logo/pay.png',
      'label': '**** **** **** 3947',
    },
  ];

  // Delivery options
  int _selectedDelivery = 0;
  final List<Map<String, dynamic>> _deliveries = [
    {
      'logo': 'assets/images/logo/kurir.png',
      'label': 'Fast (2-3days)',
      'price': 5.0,
    },
  ];

  bool _isLoading = false;

  double get _deliveryCost =>
      (_deliveries[_selectedDelivery]['price'] as double);

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final total = cart.totalPrice + _deliveryCost;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ──────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 6)
                        ],
                      ),
                      child: const Icon(Icons.chevron_left, size: 24),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Check out',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 36),
                ],
              ),
            ),

            // ── Body scrollable ──────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // ── 1. Shipping Address ──────────────────
                    _SectionHeader(
                      title: 'Shipping address',
                      onEdit: () => _showEditAddressDialog(context),
                    ),
                    const SizedBox(height: 10),
                    _WhiteCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          const Divider(height: 16),
                          Text(
                            _address,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                height: 1.5),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ── 2. Payment ───────────────────────────
                    _SectionHeader(
                      title: 'Payment',
                      onEdit: () {},
                    ),
                    const SizedBox(height: 10),
                    ..._payments.asMap().entries.map((e) {
                      final i = e.key;
                      final p = e.value;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedPayment = i),
                        child: _WhiteCard(
                          selected: _selectedPayment == i,
                          child: Row(
                            children: [
                              // Logo gambar payment
                              Container(
                                width: 52,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    p['logo'] as String,
                                    fit: BoxFit.contain,
                                    errorBuilder: (_, __, ___) => const Icon(
                                        Icons.credit_card,
                                        color: Colors.grey),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Text(
                                p['label'] as String,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1),
                              ),
                              const Spacer(),
                              if (_selectedPayment == i)
                                const Icon(Icons.check_circle,
                                    color: Colors.black, size: 20),
                            ],
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 20),

                    // ── 3. Delivery Method ───────────────────
                    _SectionHeader(
                      title: 'Delivery method',
                      onEdit: () {},
                    ),
                    const SizedBox(height: 10),
                    ..._deliveries.asMap().entries.map((e) {
                      final i = e.key;
                      final d = e.value;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedDelivery = i),
                        child: _WhiteCard(
                          selected: _selectedDelivery == i,
                          child: Row(
                            children: [
                              // Logo kurir dari assets
                              Container(
                                width: 60,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Colors.grey.shade200),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    d['logo'] as String,
                                    fit: BoxFit.contain,
                                    errorBuilder: (_, __, ___) => const Icon(
                                        Icons.local_shipping_outlined,
                                        color: Colors.grey),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Text(
                                d['label'] as String,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              const Spacer(),
                              Text(
                                '\$ ${(d['price'] as double).toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                              const SizedBox(width: 8),
                              if (_selectedDelivery == i)
                                const Icon(Icons.check_circle,
                                    color: Colors.black, size: 20),
                            ],
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 28),

                    // ── 4. Order Summary ─────────────────────
                    _summaryRow('Order',
                        '\$ ${cart.totalPrice.toStringAsFixed(2)}'),
                    const SizedBox(height: 8),
                    _summaryRow('Delivery',
                        '\$ ${_deliveryCost.toStringAsFixed(2)}'),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Divider(color: Colors.grey.shade200),
                    ),
                    _summaryRow(
                      'Total',
                      '\$ ${total.toStringAsFixed(2)}',
                      bold: true,
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // ── Submit Button ────────────────────────────────
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
              child: ElevatedButton(
                onPressed: _isLoading ? null : () => _submitOrder(context, cart),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  disabledBackgroundColor: Colors.grey.shade400,
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Submit order',
                        style:
                            TextStyle(color: Colors.white, fontSize: 16),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Submit order dengan loading indicator ──────────────────
  Future<void> _submitOrder(BuildContext context, CartProvider cart) async {
    setState(() => _isLoading = true);

    // Simulasi proses order (misal: kirim ke server)
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    setState(() => _isLoading = false);

    cart.clearCart();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const SuccessScreen()),
      (route) => false,
    );
  }

  // ── Dialog edit alamat ─────────────────────────────────────
  void _showEditAddressDialog(BuildContext context) {
    final nameCtrl = TextEditingController(text: _name);
    final addressCtrl = TextEditingController(text: _address);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(
            20, 20, 20, MediaQuery.of(ctx).viewInsets.bottom + 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Edit Shipping Address',
                style:
                    TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: nameCtrl,
              decoration: InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: addressCtrl,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Alamat',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _name = nameCtrl.text;
                    _address = addressCtrl.text;
                  });
                  Navigator.pop(ctx);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Simpan',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            color: bold ? Colors.black : Colors.grey,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: bold ? 17 : 15,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

// ── Widget helper: Section header ──────────────────────────────
class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onEdit;

  const _SectionHeader({required this.title, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold)),
        GestureDetector(
          onTap: onEdit,
          child: const Icon(Icons.edit_outlined, size: 20, color: Colors.grey),
        ),
      ],
    );
  }
}

// ── Widget helper: White card container ────────────────────────
class _WhiteCard extends StatelessWidget {
  final Widget child;
  final bool selected;

  const _WhiteCard({required this.child, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: selected ? Colors.black : Colors.grey.shade200,
          width: selected ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
          ),
        ],
      ),
      child: child,
    );
  }
}