import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/order_model.dart';
import '../services/order_service.dart';

import '../widgets/info_box.dart';
import '../widgets/key_value_row.dart';
import '../widgets/product_item.dart';
import '../widgets/section_header.dart';
import '../widgets/status_badge_detail.dart';

class OrderDetailPage extends StatefulWidget {
  final String orderCode;

  const OrderDetailPage({super.key, required this.orderCode});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  late Future<OrderModel> futureOrder;

  @override
  void initState() {
    super.initState();
    futureOrder = OrderService().getOrder(widget.orderCode);
  }

  String formatCurrency(int value) {
    return "Rp${value.toString()}";
  }

  String paymentMessage(String status) {
    switch (status) {
      case "paid":
        return "Pembayaran telah diterima. Pesanan Anda sedang kami proses.";
      case "pending":
        return "Menunggu pembayaran Anda.";
      case "expired":
        return "Pembayaran telah kadaluarsa.";
      default:
        return "Status pembayaran tidak diketahui.";
    }
  }

  Color paymentColor(String status) {
    switch (status) {
      case "paid":
        return Colors.green;
      case "pending":
        return Colors.orange;
      case "expired":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pesanan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go("/profile");
          },
        ),
      ),
      body: FutureBuilder<OrderModel>(
        future: futureOrder,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // if (snapshot.hasError) {
          //   return const Center(child: Text("Gagal memuat pesanan"));
          // }
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

          final order = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// HEADER
                Text(
                  'Order #${order.orderNumber}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Dibuat pada ${order.createdAtFormatted}',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),

                const SizedBox(height: 16),

                /// INFO BOX
                InfoBox(
                  icon: Icons.info,
                  color: paymentColor(order.paymentStatus),
                  text: paymentMessage(order.paymentStatus),
                ),

                const SizedBox(height: 20),

                /// STATUS
                const SectionHeader(title: 'Status Pesanan'),
                const SizedBox(height: 8),
                StatusBadgeDetail(text: order.paymentStatus),

                const SizedBox(height: 24),

                /// SHIPPING
                const SectionHeader(
                  title: 'Informasi Pengiriman',
                  subtitle:
                      'Detail metode pengiriman yang Anda pilih untuk pesanan ini.',
                ),

                const SizedBox(height: 12),

                KeyValueRow(
                  label: 'Kurir',
                  value:
                      '${order.courier.code.toUpperCase()} - ${order.courier.service}',
                ),

                KeyValueRow(
                  label: 'Biaya Pengiriman',
                  value: formatCurrency(order.shippingCost),
                ),

                const SizedBox(height: 24),

                /// PRODUCT
                const SectionHeader(
                  title: 'Daftar Produk',
                  subtitle:
                      'Berikut adalah produk yang Anda pesan beserta jumlah dan harga.',
                ),

                const SizedBox(height: 12),

                Column(
                  children:
                      order.items.map((item) {
                        return ProductItem(
                          name: item.productName,
                          imageUrl: item.imageUrl,
                          quantity: item.quantity,
                          price: item.unitPrice,
                        );
                      }).toList(),
                ),

                const SizedBox(height: 24),

                /// PAYMENT SUMMARY
                const SectionHeader(
                  title: 'Ringkasan Pembayaran',
                  subtitle: 'Rincian total biaya yang perlu Anda bayarkan.',
                ),

                const SizedBox(height: 12),

                KeyValueRow(
                  label: 'Subtotal Produk',
                  value: formatCurrency(order.subtotal),
                ),

                KeyValueRow(
                  label: 'Ongkos Kirim',
                  value: formatCurrency(order.shippingCost),
                ),

                if (order.voucherDiscount > 0)
                  KeyValueRow(
                    label: 'Diskon Voucher',
                    value: "- ${formatCurrency(order.voucherDiscount)}",
                  ),

                if (order.pointsDiscount > 0)
                  KeyValueRow(
                    label: 'Diskon Poin',
                    value: "- ${formatCurrency(order.pointsDiscount)}",
                  ),

                const Divider(height: 24),

                KeyValueRow(
                  label: 'Total Pembayaran',
                  value: formatCurrency(order.totalAmount),
                  bold: true,
                ),

                const SizedBox(height: 32),

                /// BUTTON BACK
                // Center(
                //   child: OutlinedButton(
                //     onPressed: () => context.go("/"),
                //     child: const Text('Kembali'),
                //   ),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
