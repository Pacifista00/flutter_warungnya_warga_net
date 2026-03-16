import 'package:flutter/material.dart';

class OrderStatusBadge extends StatelessWidget {
  final String status;

  const OrderStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color bgColor = Colors.grey.shade200;
    Color textColor = Colors.grey.shade800;
    String label = status;

    switch (status.toLowerCase()) {
      /// ORDER STATUS
      case 'created':
        label = 'Dibuat';
        break;

      case 'pending':
        label = 'Menunggu Pembayaran';
        bgColor = Colors.orange.shade100;
        textColor = Colors.orange.shade800;
        break;

      case 'processing':
        label = 'Diproses';
        bgColor = Colors.blue.shade100;
        textColor = Colors.blue.shade800;
        break;

      case 'packed':
        label = 'Dikemas';
        bgColor = Colors.blue.shade100;
        textColor = Colors.blue.shade800;
        break;

      case 'completed':
        label = 'Selesai';
        bgColor = Colors.green.shade100;
        textColor = Colors.green.shade800;
        break;

      case 'cancelled':
        label = 'Dibatalkan';
        bgColor = Colors.red.shade100;
        textColor = Colors.red.shade800;
        break;

      case 'returned':
        label = 'Dikembalikan';
        bgColor = Colors.red.shade100;
        textColor = Colors.red.shade800;
        break;

      case 'disposed':
        label = 'Dimusnahkan';
        bgColor = Colors.red.shade100;
        textColor = Colors.red.shade800;
        break;

      /// SHIPPING STATUS
      case 'allocated':
        label = 'Kurir Ditugaskan';
        bgColor = Colors.blue.shade100;
        textColor = Colors.blue.shade800;
        break;

      case 'picking_up':
        label = 'Kurir Menuju Pickup';
        bgColor = Colors.purple.shade100;
        textColor = Colors.purple.shade800;
        break;

      case 'picked':
        label = 'Paket Diambil Kurir';
        bgColor = Colors.purple.shade100;
        textColor = Colors.purple.shade800;
        break;

      case 'dropping_off':
        label = 'Dalam Pengiriman';
        bgColor = Colors.purple.shade100;
        textColor = Colors.purple.shade800;
        break;

      case 'on_hold':
        label = 'Pengiriman Tertahan';
        bgColor = Colors.orange.shade100;
        textColor = Colors.orange.shade800;
        break;

      case 'return_in_transit':
        label = 'Retur Dalam Perjalanan';
        bgColor = Colors.red.shade100;
        textColor = Colors.red.shade800;
        break;

      case 'delivered':
        label = 'Terkirim';
        bgColor = Colors.green.shade100;
        textColor = Colors.green.shade800;
        break;

      case 'courier_not_found':
        label = 'Kurir Tidak Ditemukan';
        bgColor = Colors.red.shade100;
        textColor = Colors.red.shade800;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}
