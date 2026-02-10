import 'package:flutter/material.dart';
import '../widgets/info_box.dart';
import '../widgets/key_value_row.dart';
import '../widgets/product_item.dart';
import '../widgets/section_header.dart';
import '../widgets/status_badge_detail.dart';

class OrderDetailPage extends StatelessWidget {
  final String orderCode;

  const OrderDetailPage({super.key, required this.orderCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Pesanan')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER
            Text(
              'Order #$orderCode',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Dibuat pada 17 Jan 2026 13:48',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),

            const SizedBox(height: 16),

            /// INFO BOX
            const InfoBox(
              icon: Icons.check_circle,
              color: Colors.green,
              text:
                  'Pembayaran telah diterima. Pesanan Anda sedang kami proses.',
            ),

            const SizedBox(height: 20),

            /// STATUS
            const SectionHeader(title: 'Status Pesanan'),
            const SizedBox(height: 8),
            const StatusBadgeDetail(text: 'Dibayar'),

            const SizedBox(height: 24),

            /// SHIPPING
            const SectionHeader(
              title: 'Informasi Pengiriman',
              subtitle:
                  'Detail metode pengiriman yang Anda pilih untuk pesanan ini.',
            ),
            const SizedBox(height: 12),
            const KeyValueRow(label: 'Kurir', value: 'JNE – YES'),
            const KeyValueRow(label: 'Estimasi Pengiriman', value: '- hari'),
            const KeyValueRow(label: 'Biaya Pengiriman', value: 'Rp44.000'),

            const SizedBox(height: 24),

            /// PRODUCT
            const SectionHeader(
              title: 'Daftar Produk',
              subtitle:
                  'Berikut adalah produk yang Anda pesan beserta jumlah dan harga.',
            ),
            const SizedBox(height: 12),
            const ProductItem(),

            const SizedBox(height: 24),

            /// PAYMENT SUMMARY
            const SectionHeader(
              title: 'Ringkasan Pembayaran',
              subtitle: 'Rincian total biaya yang perlu Anda bayarkan.',
            ),
            const SizedBox(height: 12),
            const KeyValueRow(label: 'Subtotal Produk', value: 'Rp100.000'),
            const KeyValueRow(label: 'Ongkos Kirim', value: 'Rp44.000'),
            const Divider(height: 24),
            const KeyValueRow(
              label: 'Total Pembayaran',
              value: 'Rp144.000',
              bold: true,
            ),

            const SizedBox(height: 32),

            Center(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Kembali ke Daftar Pesanan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
