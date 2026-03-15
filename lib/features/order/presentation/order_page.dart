import 'package:flutter/material.dart';
import 'package:flutter_warungnya_warga_net/features/order/models/order_model.dart';
import 'package:flutter_warungnya_warga_net/features/order/services/order_service.dart';
import '../../../core/constant/order_status.dart';
import '../widgets/order_card.dart';

class OrderListPage extends StatefulWidget {
  final OrderStatus status;

  const OrderListPage({super.key, required this.status});

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  late Future<List<OrderModel>> futureOrders;
  String _statusToString(OrderStatus status) {
    switch (status) {
      case OrderStatus.created:
        return 'created';
      case OrderStatus.packed:
        return 'packed';
      case OrderStatus.shipped:
        return 'shipped';
      case OrderStatus.completed:
        return 'completed';
    }
  }

  @override
  void initState() {
    super.initState();
    // kirim parameter status ke backend
    futureOrders = OrderService().getMyOrders(
      status: _statusToString(widget.status),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titleFromStatus(widget.status))),
      body: FutureBuilder<List<OrderModel>>(
        future: futureOrders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Gagal memuat pesanan:\n${snapshot.error}',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Gagal memuat pesanan"));
          }

          final orders = snapshot.data!;

          if (orders.isEmpty) {
            return const Center(child: Text('Belum ada pesanan'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return OrderCard(order: order);
            },
          );
        },
      ),
    );
  }

  String _titleFromStatus(OrderStatus status) {
    switch (status) {
      case OrderStatus.created:
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
