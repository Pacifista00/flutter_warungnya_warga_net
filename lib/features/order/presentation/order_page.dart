import 'package:flutter/material.dart';
import '../../../core/constant/order_status.dart';
import '../models/order_model.dart';
import '../widgets/order_card.dart';

final List<Map<String, dynamic>> dummyOrders = [
  {
    "id": "ORD-001",
    "title": "Paket Kimia Dasar",
    "date": "12 Feb 2026",
    "status": "Selesai",
    "price": 150000,
  },
  {
    "id": "ORD-002",
    "title": "Voucher Praktikum",
    "date": "14 Feb 2026",
    "status": "Diproses",
    "price": 75000,
  },
];

class OrderListPage extends StatelessWidget {
  final OrderStatus status;

  const OrderListPage({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final orders =
        _dummyOrders.where((order) => order.status == status).toList();

    return Scaffold(
      appBar: AppBar(title: Text(_titleFromStatus(status))),
      body:
          orders.isEmpty
              ? const Center(child: Text('Belum ada pesanan'))
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return OrderCard(order: orders[index]);
                },
              ),
    );
  }

  String _titleFromStatus(OrderStatus status) {
    switch (status) {
      case OrderStatus.unpaid:
        return 'Belum Bayar';
      case OrderStatus.packed:
        return 'Dikemas';
      case OrderStatus.shipped:
        return 'Dikirim';
      case OrderStatus.completed:
        return 'Selesai';
    }
  }
}

/// DATA DUMMY (sementara)
final List<Order> _dummyOrders = [
  Order(
    code: 'ORD-001',
    date: DateTime.now().subtract(const Duration(hours: 2)),
    expedition: 'JNE',
    total: 150000,
    status: OrderStatus.packed,
  ),
  Order(
    code: 'ORD-002',
    date: DateTime.now().subtract(const Duration(days: 1)),
    expedition: 'SiCepat',
    total: 275000,
    status: OrderStatus.packed,
  ),
  Order(
    code: 'ORD-003',
    date: DateTime.now().subtract(const Duration(days: 3)),
    expedition: 'J&T',
    total: 99000,
    status: OrderStatus.shipped,
  ),
];
