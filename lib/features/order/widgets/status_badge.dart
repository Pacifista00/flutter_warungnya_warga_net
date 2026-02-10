import 'package:flutter/material.dart';
import '../../../core/constant/order_status.dart';

class StatusBadge extends StatelessWidget {
  final OrderStatus status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      OrderStatus.unpaid => Colors.red,
      OrderStatus.packed => Colors.orange,
      OrderStatus.shipped => Colors.blue,
      OrderStatus.completed => Colors.green,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.name.toUpperCase(),
        style: TextStyle(color: color, fontSize: 11),
      ),
    );
  }
}
