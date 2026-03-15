import 'package:flutter/material.dart';
import 'package:flutter_warungnya_warga_net/features/order/models/order_model.dart';
import 'package:go_router/go_router.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER: KODE ORDER
            Text(
              order.orderNumber,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 6),

            /// TANGGAL ORDER (langsung pakai string)
            Text(
              order.createdAtFormatted,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),

            const SizedBox(height: 12),

            /// INFO ORDER
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _infoRow(
                    'Ekspedisi',
                    '${order.courier.code} - ${order.courier.service}',
                  ),
                  const SizedBox(height: 8),
                  _infoRow(
                    'Total',
                    'Rp ${_formatCurrency(order.totalAmount)}',
                    bold: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            /// BUTTON DETAIL
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  context.push('/orders/detail/${order.id}');
                },
                child: const Text('Lihat Detail'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _infoRow(String label, String value, {bool bold = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: bold ? FontWeight.w600 : FontWeight.normal,
            fontSize: 13,
          ),
        ),
      ],
    ),
  );
}

String _formatCurrency(int value) {
  return value.toString().replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (match) => '.',
  );
}
