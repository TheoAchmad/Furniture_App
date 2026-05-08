import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/order_model.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 3, vsync: this);
  }

  List<OrderModel> _filtered(String status) =>
      dummyOrders.where((o) => o.status == status).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('My orders',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabCtrl,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: const [
            Tab(text: 'Delivered'),
            Tab(text: 'Processing'),
            Tab(text: 'Canceled'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: [
          _OrderList(orders: _filtered('Delivered')),
          _OrderList(orders: _filtered('Processing')),
          _OrderList(orders: _filtered('Canceled')),
        ],
      ),
    );
  }
}

class _OrderList extends StatelessWidget {
  final List<OrderModel> orders;
  const _OrderList({required this.orders});

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return const Center(
        child: Text('Tidak ada pesanan', style: TextStyle(color: Colors.grey)),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (_, i) => _OrderCard(order: orders[i]),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final OrderModel order;
  const _OrderCard({required this.order});

  Color get _statusColor {
    switch (order.status) {
      case 'Delivered': return const Color(0xFF4CAF50);
      case 'Processing': return Colors.orange;
      case 'Canceled': return Colors.red;
      default: return Colors.grey;
    }
  }

  IconData get _statusIcon {
    switch (order.status) {
      case 'Processing': return Icons.access_time;
      default: return Icons.circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Order ${order.orderNo}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 13)),
              Text(order.date,
                  style: const TextStyle(
                      color: Colors.grey, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text('Quantity: ',
                  style: TextStyle(
                      color: Colors.grey.shade600, fontSize: 13)),
              Text('${order.quantity < 10 ? '0' : ''}${order.quantity}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 13)),
              const SizedBox(width: 20),
              Text('Total Amount: ',
                  style: TextStyle(
                      color: Colors.grey.shade600, fontSize: 13)),
              Text('\$ ${order.totalAmount.toStringAsFixed(0)}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  minimumSize: Size.zero,
                ),
                child: const Text('Detail',
                    style: TextStyle(color: Colors.white, fontSize: 13)),
              ),
              const Spacer(),
              if (order.status == 'Processing')
                Icon(_statusIcon, size: 14, color: _statusColor),
              const SizedBox(width: 4),
              Text(
                order.status,
                style: TextStyle(
                    color: _statusColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }
}