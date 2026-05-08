import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';
import '../models/order_model.dart';

class ShippingAddressScreen extends StatelessWidget {
  const ShippingAddressScreen({super.key});

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
        title: const Text('Shipping address',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
            itemCount: profile.addresses.length,
            itemBuilder: (_, i) {
              final addr = profile.addresses[i];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: addr.isDefault
                        ? Colors.black
                        : Colors.grey.shade200,
                    width: addr.isDefault ? 1.5 : 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => profile.setDefaultAddress(i),
                          child: Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(4),
                                  color: addr.isDefault
                                      ? Colors.black
                                      : Colors.transparent,
                                  border: Border.all(
                                      color: addr.isDefault
                                          ? Colors.black
                                          : Colors.grey),
                                ),
                                child: addr.isDefault
                                    ? const Icon(Icons.check,
                                        size: 14, color: Colors.white)
                                    : null,
                              ),
                              const SizedBox(width: 8),
                              const Text('Use as the shipping address',
                                  style: TextStyle(fontSize: 13)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 16),
                    Text(addr.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(height: 6),
                    Text(
                      '${addr.address}, ${addr.zipcode}, ${addr.country}',
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          height: 1.5),
                    ),
                  ],
                ),
              );
            },
          ),
          // FAB add address
          Positioned(
            bottom: 24,
            right: 20,
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const AddShippingAddressScreen())),
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

// ── Add Shipping Address Screen ────────────────────────────────
class AddShippingAddressScreen extends StatefulWidget {
  const AddShippingAddressScreen({super.key});

  @override
  State<AddShippingAddressScreen> createState() =>
      _AddShippingAddressScreenState();
}

class _AddShippingAddressScreenState
    extends State<AddShippingAddressScreen> {
  final _nameCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _zipcodeCtrl = TextEditingController();
  String _country = 'USA';
  String _city = 'New York';

  final _countries = ['USA', 'France', 'Indonesia', 'UK', 'Japan'];
  final _cities = ['New York', 'Paris', 'Jakarta', 'London', 'Tokyo'];

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
        title: const Text('Add shipping address',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildField(_nameCtrl, 'Full name'),
            const SizedBox(height: 14),
            _buildField(_addressCtrl, 'Address'),
            const SizedBox(height: 14),
            _buildField(_zipcodeCtrl, 'Zipcode (Postal Code)',
                keyboardType: TextInputType.number),
            const SizedBox(height: 14),
            _buildDropdown('Country', _country, _countries,
                (v) => setState(() => _country = v!)),
            const SizedBox(height: 14),
            _buildDropdown('City', _city, _cities,
                (v) => setState(() => _city = v!)),
            const SizedBox(height: 14),
            _buildDropdown('District', 'Select District', ['Select District'],
                (v) {}),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (_nameCtrl.text.isEmpty || _addressCtrl.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Mohon isi semua field')),
                  );
                  return;
                }
                profile.addAddress(ShippingAddress(
                  name: _nameCtrl.text,
                  address: _addressCtrl.text,
                  zipcode: _zipcodeCtrl.text,
                  country: _country,
                  city: _city,
                ));
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text('Save address',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController ctrl, String label,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: ctrl,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 13, color: Colors.grey),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      ),
    );
  }

  Widget _buildDropdown(String label, String value, List<String> items,
      ValueChanged<String?> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: Text(label,
              style: const TextStyle(fontSize: 13, color: Colors.grey)),
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}