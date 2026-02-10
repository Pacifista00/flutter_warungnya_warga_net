import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_warungnya_warga_net/core/constant/order_status.dart';
import 'section_container.dart';

class OrderStatusSection extends StatelessWidget {
  const OrderStatusSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pesanan Saya',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _OrderItem(
                  icon: Icons.wallet_outlined,
                  label: 'Belum Bayar',
                  status: OrderStatus.unpaid,
                ),
              ),
              Expanded(
                child: _OrderItem(
                  icon: Icons.inventory_2_outlined,
                  label: 'Dikemas',
                  status: OrderStatus.packed,
                ),
              ),
              Expanded(
                child: _OrderItem(
                  icon: Icons.local_shipping_outlined,
                  label: 'Dikirim',
                  status: OrderStatus.shipped,
                ),
              ),
              Expanded(
                child: _OrderItem(
                  icon: Icons.check_circle_outline,
                  label: 'Selesai',
                  status: OrderStatus.completed,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OrderItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final OrderStatus status;

  const _OrderItem({
    required this.icon,
    required this.label,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        context.push('/orders/${status.name}');
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 28),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
