import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';
import '../models/order_model.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Payment method',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
            itemCount: profile.cards.length,
            itemBuilder: (_, i) {
              final card = profile.cards[i];
              return _PaymentCardWidget(
                card: card,
                onSetDefault: () => profile.setDefaultCard(i),
              );
            },
          ),
          Positioned(
            bottom: 24,
            right: 20,
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const AddPaymentScreen())),
              child: Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 10)
                  ],
                ),
                child: const Icon(Icons.add, size: 28),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentCardWidget extends StatelessWidget {
  final PaymentCard card;
  final VoidCallback onSetDefault;

  const _PaymentCardWidget(
      {required this.card, required this.onSetDefault});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          // Visual Kartu (Background Gambar)
          Container(
            width: double.infinity,
            height: 200,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage(
                  card.isDefault
                      ? 'assets/images/logo/cardpay1.png'
                      : 'assets/images/logo/cardpay2.png',
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end, 
              children: [
                // Nomor Kartu
                Text(
                  card.cardNumber,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 4),
                ),
                const SizedBox(height: 25), 
                // Hanya menampilkan Expiry Date di pojok kanan bawah
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    card.expiry,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
          // Checkbox Default
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: GestureDetector(
              onTap: onSetDefault,
              child: Row(
                children: [
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: card.isDefault ? Colors.black : Colors.transparent,
                      border: Border.all(
                          color: card.isDefault ? Colors.black : Colors.grey),
                    ),
                    child: card.isDefault
                        ? const Icon(Icons.check, size: 16, color: Colors.white)
                        : null,
                  ),
                  const SizedBox(width: 10),
                  const Text('Use as default payment method',
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Add Payment Screen ────────────────────────────────────────
class AddPaymentScreen extends StatefulWidget {
  const AddPaymentScreen({super.key});

  @override
  State<AddPaymentScreen> createState() => _AddPaymentScreenState();
}

class _AddPaymentScreenState extends State<AddPaymentScreen> {
  final _holderCtrl = TextEditingController();
  final _numberCtrl = TextEditingController();
  final _cvvCtrl = TextEditingController();
  final _expiryCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final profile = context.read<ProfileProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Add payment method',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Preview Kartu Baru
            Container(
              width: double.infinity,
              height: 200,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage('assets/images/logo/cardpay1.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('* * * * * * * * * * * * XXXX',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          letterSpacing: 4)),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _holderCtrl.text.isEmpty ? 'NAME SURNAME' : _holderCtrl.text.toUpperCase(),
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      Text(
                        _expiryCtrl.text.isEmpty ? 'MM/YY' : _expiryCtrl.text,
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildField(_holderCtrl, 'CardHolder Name', 'Ex: Bruno Pham', onChanged: (_) => setState(() {})),
            const SizedBox(height: 16),
            _buildField(_numberCtrl, 'Card Number', '**** **** **** 3456', 
                keyboardType: TextInputType.number, onChanged: (_) => setState(() {})),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildField(_cvvCtrl, 'CVV', 'Ex: 123', keyboardType: TextInputType.number)),
                const SizedBox(width: 16),
                Expanded(child: _buildField(_expiryCtrl, 'Expiration Date', 'MM/YY', onChanged: (_) => setState(() {}))),
              ],
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                profile.addCard(PaymentCard(
                  logoAsset: 'assets/images/logo/cardpay1.png',
                  cardNumber: '**** **** **** ${_numberCtrl.text.length >= 4 ? _numberCtrl.text.substring(_numberCtrl.text.length - 4) : 'XXXX'}',
                  cardHolder: _holderCtrl.text.isEmpty ? 'Card Holder' : _holderCtrl.text,
                  expiry: _expiryCtrl.text.isEmpty ? 'XX/XX' : _expiryCtrl.text,
                ));
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 54),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text('Add new card',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(
    TextEditingController ctrl,
    String label,
    String hint, {
    TextInputType keyboardType = TextInputType.text,
    Function(String)? onChanged,
  }) {
    return TextField(
      controller: ctrl,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: const TextStyle(fontSize: 14, color: Colors.grey),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}